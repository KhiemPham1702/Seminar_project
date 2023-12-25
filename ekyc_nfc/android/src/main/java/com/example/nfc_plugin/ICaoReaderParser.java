package com.example.nfc_plugin;

import android.content.Context;
import android.graphics.Bitmap;
import android.os.Build;
import android.text.TextUtils;
import android.util.Log;

import androidx.annotation.RequiresApi;


import com.example.nfc_plugin.model.CardResult;
import com.example.nfc_plugin.model.CheckingCode;


import com.example.nfc_plugin.model.IDCardDetail;
import com.example.nfc_plugin.model.ResultCode;


import com.htc.sdk.eidparser.AccessKeySpec;
import com.htc.sdk.eidparser.IdCardService;
import com.htc.sdk.eidparser.JMRTDSecurityProvider;
import com.htc.sdk.eidparser.PACEKeySpec;
import com.htc.sdk.eidparser.ext.DG13File;
import com.htc.sdk.eidparser.ext.ImageUtil;
import com.htc.sdk.eidparser.protocol.AAResult;


import com.htc.sdk.scuba.smartcards.CardFileInputStream;
import com.htc.sdk.scuba.smartcards.CardService;


import org.apache.commons.io.IOUtil;
import org.bouncycastle.asn1.ASN1Encodable;
import org.bouncycastle.asn1.ASN1Integer;
import org.bouncycastle.asn1.DERSequence;
import org.jmrtd.Util;
import org.jmrtd.lds.ActiveAuthenticationInfo;
import org.jmrtd.lds.CardAccessFile;
import org.jmrtd.lds.ChipAuthenticationPublicKeyInfo;
import org.jmrtd.lds.PACEInfo;
import org.jmrtd.lds.SODFile;
import org.jmrtd.lds.SecurityInfo;
import org.jmrtd.lds.icao.DG14File;
import org.jmrtd.lds.icao.DG15File;
import org.jmrtd.lds.icao.DG1File;
import org.jmrtd.lds.icao.DG2File;
import org.jmrtd.lds.iso19794.FaceImageInfo;
import org.jmrtd.lds.iso19794.FaceInfo;

import java.io.ByteArrayInputStream;
import java.io.DataInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigInteger;
import java.nio.ByteBuffer;
import java.security.MessageDigest;
import java.security.PublicKey;
import java.security.SecureRandom;
import java.security.Signature;
import java.security.interfaces.ECPublicKey;
import java.security.interfaces.RSAPublicKey;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Base64;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import javax.crypto.Cipher;

public class ICaoReaderParser {
    private static final boolean _localDecode = true;
    private static final String TAG = ICaoReaderParser.class.getSimpleName();
    private CardService _card = null;
    private IdCardService _service = null;
    private String _cccdId = "";
    private CardResult _result = null;
    private DG14File _dgSecurityInfoFile = null;
    private DG15File _dgPublicKeyFile = null;
    private SODFile _sodFile = null;
    private IDCardDetail _citizenInfo = new IDCardDetail();
    private Bitmap _faceBitmap = null;
    private String _faceBase64 = "";

    public ICaoReaderParser() {
    }

    @RequiresApi(
            api = 26
    )
    public CardResult readData(CardService card, String cccdId, boolean hashCheck, boolean chipCheck, boolean activeCheck) {
        this._result = new CardResult();
        if (!TextUtils.isEmpty(cccdId) && cccdId.length() == 12) {
            try {
                Log.d(TAG, "Open card service...");
                card.open();
                this._card = card;
            } catch (Exception var10) {
                this._result.setCode(ResultCode.CANNOT_OPEN_DEVICE);
                Log.d(TAG, "Exception: " + var10.getMessage());
                return this._result;
            }

            try {
                Log.d(TAG, "Open passport service...");
                IdCardService service = new IdCardService(card, 256, 223, false, false);
                service.open();
                this._service = service;
            } catch (Exception var9) {
                this._result.setCode(ResultCode.CARD_NOT_FOUND);
                this.closeALl();
                Log.d(TAG, "Exception: " + var9.getMessage());
                return this._result;
            }

            this._cccdId = cccdId;
            ResultCode paceCode = this.doPACE();
            this._result.setCode(paceCode);
            if (this._result.getCode() != ResultCode.SUCCESS) {
                this.closeALl();
                return this._result;
            } else {
                ResultCode readDgCode = this.readAllDataGroups(hashCheck);
                if (readDgCode != ResultCode.SUCCESS) {
                    return this._result;
                } else {
                    ResultCode actAuthenCode;
                    if (chipCheck) {
                        actAuthenCode = this.chipAuthentication();
                        if (actAuthenCode != ResultCode.SUCCESS) {
                            this._result.setChipCheck(CheckingCode.FAILED);
                        } else {
                            this._result.setChipCheck(CheckingCode.PASS);
                        }
                    }

                    if (activeCheck) {
                        actAuthenCode = this.activeAuthentication();
                        if (actAuthenCode != ResultCode.SUCCESS) {
                            this._result.setActiveCheck(CheckingCode.FAILED);
                        } else {
                            this._result.setActiveCheck(CheckingCode.PASS);
                        }
                    }

                    this.closeALl();
                    return this._result;
                }
            }
        } else {
            this._result.setCode(ResultCode.WRONG_CCCDID);
            return this._result;
        }
    }

    @RequiresApi(
            api = 26
    )
    private void processData(int BlokCount, InputStream Data) {
        try {
            switch (BlokCount) {
                case 0:
                    this._sodFile = new SODFile(Data);
                    break;
                case 1:
                    new DG1File(Data);
                    break;
                case 2:
                    DG2File dgFaceImageFile = new DG2File(Data);
                    List<FaceImageInfo> allFaceImageInfos = new ArrayList();
                    List<FaceInfo> faceInfos = dgFaceImageFile.getFaceInfos();
                    Iterator var13 = faceInfos.iterator();

                    while(var13.hasNext()) {
                        FaceInfo faceInfo = (FaceInfo)var13.next();
                        allFaceImageInfos.addAll(faceInfo.getFaceImageInfos());
                    }

                    if (!allFaceImageInfos.isEmpty()) {
                        FaceImageInfo faceImageInfo = (FaceImageInfo)allFaceImageInfos.iterator().next();
                        int imageLength = faceImageInfo.getImageLength();
                        DataInputStream dataInputStream = new DataInputStream(faceImageInfo.getImageInputStream());
                        byte[] buffer = new byte[imageLength];
                        dataInputStream.readFully(buffer, 0, imageLength);
                        InputStream inputStream = new ByteArrayInputStream(buffer, 0, imageLength);
                        this._faceBitmap = ImageUtil.decodeImage((Context)null, faceImageInfo.getMimeType(), inputStream);
                        this._faceBase64 = Base64.getEncoder().encodeToString(buffer);
                        this._citizenInfo.setPhoto(this._faceBitmap);
                        this._citizenInfo.setPhotoBase64(this._faceBase64);
                    }
                    break;
                case 13:
                    byte[] dg13Bytes = IOUtil.toByteArray(Data);
                    DG13File dgPersonDetailFile = new DG13File(dg13Bytes);
                    com.htc.sdk.model.IDCardDetail citizenInfo = new com.htc.sdk.model.IDCardDetail();
                    citizenInfo = dgPersonDetailFile.readContent();
                    this._citizenInfo = new IDCardDetail(citizenInfo.getCitizenPid(), citizenInfo.getFullName(), citizenInfo.getBirthDate(), citizenInfo.getGender(), citizenInfo.getNationality(), citizenInfo.getEthnic(),citizenInfo.getReligion(), citizenInfo.getHomeTown(), citizenInfo.getRegPlaceAddress(), citizenInfo.getIdentifyCharacteristics(),citizenInfo.getDateProvide(),citizenInfo.getBirthDate(),citizenInfo.getFatherName(),citizenInfo.getMotherName(),citizenInfo.getWifeName(),citizenInfo.getHusBandName(),citizenInfo.getOldIdentify(),citizenInfo.getPhotoBase64(),citizenInfo.getPhoto());
                    if (this._faceBitmap != null) {
                        this._citizenInfo.setPhoto(this._faceBitmap);
                    }

                    if (this._faceBase64.length() > 0) {
                        this._citizenInfo.setPhotoBase64(this._faceBase64);
                    }
            }
        } catch (Exception var12) {
            var12.printStackTrace();
        }

    }

    public IDCardDetail parseFromBytes(byte[] allData) {
        this._citizenInfo = new IDCardDetail();
        int offset = 0;

        for(int blockCount = 0; offset < allData.length; ++blockCount) {
            ByteBuffer buffLengh = ByteBuffer.wrap(allData, offset, 4);
            int length = buffLengh.getInt();
            offset += 4;
            ByteBuffer buff = ByteBuffer.allocate(length);
            buff.put(allData, offset, length);
            offset += length;
            this.processData(blockCount, new ByteArrayInputStream(buff.array()));
        }

        return this._citizenInfo;
    }

    private ResultCode doPACE() {
        try {
            Log.d(TAG, "Start Pace...!");
            CardAccessFile cardAccessFile = new CardAccessFile(this._service.getInputStream((short)284));
            Collection<SecurityInfo> securityInfoCollection = cardAccessFile.getSecurityInfos();
            int Startpos = this._cccdId.length() - 6;
            String can = this._cccdId.substring(Startpos).trim();
            PACEKeySpec paceKey = PACEKeySpec.createCANKey(can);
            Iterator var6 = securityInfoCollection.iterator();

            while(var6.hasNext()) {
                SecurityInfo securityInfo = (SecurityInfo)var6.next();
                if (securityInfo instanceof PACEInfo) {
                    PACEInfo paceInfo = (PACEInfo)securityInfo;
                    this._service.doPACE((AccessKeySpec) paceKey, paceInfo.getObjectIdentifier(), PACEInfo.toParameterSpec(paceInfo.getParameterId()), (BigInteger)null);
                    Log.w(TAG, "Pace successful!");
                    this._service.sendSelectApplet(true);
                    return ResultCode.SUCCESS;
                }
            }
        } catch (Exception var9) {
            Log.w(TAG, var9);
            return ResultCode.CARD_LOST_CONNECTION;
        }

        return ResultCode.WRONG_CCCDID;
    }

    private ResultCode readAllDataGroups(boolean hashCheck) {
        try {
            this._result.setCode(ResultCode.SUCCESS);
            if (hashCheck) {
                this._result.setHashCheck(CheckingCode.PASS);
            }

            Log.d(TAG, "Read all available data groups:");
            CardFileInputStream sodIn = this._service.getInputStream((short)285);
            this._sodFile = new SODFile(sodIn);
            this._result.setSOD(this._sodFile.getEncoded());
            MessageDigest digest = MessageDigest.getInstance(this._sodFile.getDigestAlgorithm());
            Map<Integer, byte[]> dataHashes = this._sodFile.getDataGroupHashes();
            Iterator var5 = dataHashes.keySet().iterator();

            while(var5.hasNext()) {
                Integer item = (Integer)var5.next();
                if (((byte[])dataHashes.get(item)).length > 0) {
                    Log.d(TAG, "Found hash of Data Group: " + item + "; ");
                    CardFileInputStream cfInputStream = null;
                    byte[] dgHashValue = null;

                    try {
                        if (item != 3) {
                            Log.w(TAG, "Ignore DataGroup 3 (Is FingerPrint - cannot read)!");
                            cfInputStream = this._service.getInputStream((short)(257 + item - 1));
                        }
                    } catch (Exception var10) {
                        Log.e(TAG, "Error", var10);
                    }

                    if (cfInputStream == null) {
                        Log.w(TAG, String.format("Cannot read Data Groupd: %d, ignore!", item));
                    } else {
                        switch (item) {
                            case 1:
                                this._result.setDG(1, IOUtil.toByteArray(cfInputStream));
                                if (hashCheck) {
                                    dgHashValue = digest.digest(this._result.getDG(1));
                                }
                                break;
                            case 2:
                                this._result.setDG(2, IOUtil.toByteArray(cfInputStream));
                                if (hashCheck) {
                                    dgHashValue = digest.digest(this._result.getDG(2));
                                }
                            case 3:
                            default:
                                break;
                            case 4:
                                this._result.setDG(4, IOUtil.toByteArray(cfInputStream));
                                if (hashCheck) {
                                    dgHashValue = digest.digest(this._result.getDG(4));
                                }
                                break;
                            case 5:
                                this._result.setDG(5, IOUtil.toByteArray(cfInputStream));
                                if (hashCheck) {
                                    dgHashValue = digest.digest(this._result.getDG(5));
                                }
                                break;
                            case 6:
                                this._result.setDG(6, IOUtil.toByteArray(cfInputStream));
                                if (hashCheck) {
                                    dgHashValue = digest.digest(this._result.getDG(6));
                                }
                                break;
                            case 7:
                                this._result.setDG(7, IOUtil.toByteArray(cfInputStream));
                                if (hashCheck) {
                                    dgHashValue = digest.digest(this._result.getDG(7));
                                }
                                break;
                            case 8:
                                this._result.setDG(8, IOUtil.toByteArray(cfInputStream));
                                if (hashCheck) {
                                    dgHashValue = digest.digest(this._result.getDG(8));
                                }
                                break;
                            case 9:
                                this._result.setDG(9, IOUtil.toByteArray(cfInputStream));
                                if (hashCheck) {
                                    dgHashValue = digest.digest(this._result.getDG(9));
                                }
                                break;
                            case 10:
                                this._result.setDG(10, IOUtil.toByteArray(cfInputStream));
                                if (hashCheck) {
                                    dgHashValue = digest.digest(this._result.getDG(10));
                                }
                                break;
                            case 11:
                                this._result.setDG(11, IOUtil.toByteArray(cfInputStream));
                                if (hashCheck) {
                                    dgHashValue = digest.digest(this._result.getDG(11));
                                }
                                break;
                            case 12:
                                this._result.setDG(12, IOUtil.toByteArray(cfInputStream));
                                if (hashCheck) {
                                    dgHashValue = digest.digest(this._result.getDG(12));
                                }
                                break;
                            case 13:
                                this._result.setDG(13, IOUtil.toByteArray(cfInputStream));
                                if (hashCheck) {
                                    dgHashValue = digest.digest(this._result.getDG(13));
                                }
                                break;
                            case 14:
                                this._dgSecurityInfoFile = new DG14File(cfInputStream);
                                this._result.setDG(14, this._dgSecurityInfoFile.getEncoded());
                                if (hashCheck) {
                                    dgHashValue = digest.digest(this._result.getDG(14));
                                }
                                break;
                            case 15:
                                this._dgPublicKeyFile = new DG15File(cfInputStream);
                                this._result.setDG(15, this._dgPublicKeyFile.getEncoded());
                                if (hashCheck) {
                                    dgHashValue = digest.digest(this._result.getDG(15));
                                }
                                break;
                            case 16:
                                this._result.setDG(16, IOUtil.toByteArray(cfInputStream));
                                if (hashCheck) {
                                    dgHashValue = digest.digest(this._result.getDG(16));
                                }
                        }

                        boolean hashOK = Arrays.equals(dgHashValue, (byte[])dataHashes.get(item));
                        Log.d(TAG, String.format("Check Hash Data Group: %d is %s: ", item, hashOK ? "VALID" : "FAILED!"));
                        if (!hashOK) {
                            this._result.setCode(ResultCode.SUCCESS_WITH_WARNING);
                            this._result.setHashCheck(CheckingCode.FAILED);
                        }
                    }
                }
            }
        } catch (Exception var11) {
            Log.e(TAG, "Error", var11);
            this._result.setCode(ResultCode.CARD_LOST_CONNECTION);
        }

        return this._result.getCode();
    }

    private ResultCode chipAuthentication() {
        try {
            Log.d(TAG, "Start Chip Authentication...");
            Collection<SecurityInfo> dg14FileSecurityInfos = this._dgSecurityInfoFile.getSecurityInfos();
            Iterator var2 = dg14FileSecurityInfos.iterator();

            while(var2.hasNext()) {
                SecurityInfo securityInfo = (SecurityInfo)var2.next();
                if (securityInfo instanceof ChipAuthenticationPublicKeyInfo) {
                    ChipAuthenticationPublicKeyInfo publicKeyInfo = (ChipAuthenticationPublicKeyInfo)securityInfo;
                    BigInteger keyId = publicKeyInfo.getKeyId();
                    PublicKey publicKey = publicKeyInfo.getSubjectPublicKey();
                    String oid = publicKeyInfo.getObjectIdentifier();
                    this._service.doEACCA(keyId, "0.4.0.127.0.7.2.2.3.2.4", oid, publicKey);
                    Log.d(TAG, "Chip Authentication: Success");
                    return ResultCode.SUCCESS;
                }
            }
        } catch (Exception var8) {
            Log.e(TAG, "Error", var8);
            this._result.setCode(ResultCode.CARD_LOST_CONNECTION);
            return ResultCode.CARD_LOST_CONNECTION;
        }

        System.out.println("Chip Authentication: Failed");
        this._result.setCode(ResultCode.SUCCESS_WITH_WARNING);
        return ResultCode.SUCCESS_WITH_WARNING;
    }

    private boolean verifyAA(PublicKey publicKey, String digestAlgorithm, String signatureAlgorithm, byte[] challenge, byte[] response) {
        try {
            String pubKeyAlgorithm = publicKey.getAlgorithm();
            if ("RSA".equals(pubKeyAlgorithm)) {
                Log.w(TAG, "Unexpected algorithms for RSA AA: digest algorithm = " + digestAlgorithm + ", signature algorithm = " + signatureAlgorithm);
                MessageDigest rsaAADigest = MessageDigest.getInstance(digestAlgorithm);
                Signature rsaAASignature = Signature.getInstance(signatureAlgorithm, JMRTDSecurityProvider.getSpongyCastleProvider());
                RSAPublicKey rsaPublicKey = (RSAPublicKey)publicKey;
                Cipher rsaAACipher = Cipher.getInstance("RSA/NONE/NoPadding");
                rsaAACipher.init(2, rsaPublicKey);
                rsaAASignature.initVerify(rsaPublicKey);
                int digestLength = rsaAADigest.getDigestLength();
                if (digestLength != 20) {
                    return false;
                } else {
                    byte[] plaintext = rsaAACipher.doFinal(response);
                    byte[] m1 = Util.recoverMessage(digestLength, plaintext);
                    rsaAASignature.update(m1);
                    rsaAASignature.update(challenge);
                    boolean bResult = rsaAASignature.verify(response);
                    Log.e(TAG, "Verify Active Auth: " + bResult);
                    return bResult;
                }
            } else if (!"EC".equals(pubKeyAlgorithm) && !"ECDSA".equals(pubKeyAlgorithm)) {
                Log.e(TAG, "Unsupported AA public key type " + publicKey.toString());
                return false;
            } else {
                Signature ecdsaAASignature = Signature.getInstance("SHA256withECDSA", JMRTDSecurityProvider.getSpongyCastleProvider());
                MessageDigest ecdsaAADigest = MessageDigest.getInstance("SHA-256");
                ECPublicKey ecdsaPublicKey = (ECPublicKey)publicKey;
                if (ecdsaAASignature == null || signatureAlgorithm != null && !signatureAlgorithm.equals(ecdsaAASignature.getAlgorithm())) {
                    Log.w(TAG, "Re-initializing ecdsaAASignature with signature algorithm " + signatureAlgorithm);
                    ecdsaAASignature = Signature.getInstance(signatureAlgorithm);
                }

                if (ecdsaAADigest == null || digestAlgorithm != null && !digestAlgorithm.equals(ecdsaAADigest.getAlgorithm())) {
                    Log.w(TAG, "Re-initializing ecdsaAADigest with digest algorithm " + digestAlgorithm);
                    ecdsaAADigest = MessageDigest.getInstance(digestAlgorithm);
                }

                ecdsaAASignature.initVerify(ecdsaPublicKey);
                if (response.length % 2 != 0) {
                    Log.w(TAG, "Active Authentication response is not of even length");
                }

                int l = response.length / 2;
                BigInteger r = Util.os2i(response, 0, l);
                BigInteger s = Util.os2i(response, l, l);
                ecdsaAASignature.update(challenge);

                try {
                    DERSequence asn1Sequence = new DERSequence(new ASN1Encodable[]{new ASN1Integer(r), new ASN1Integer(s)});
                    return ecdsaAASignature.verify(asn1Sequence.getEncoded());
                } catch (IOException var15) {
                    Log.e(TAG, "Unexpected exception during AA signature verification with ECDSA");
                    return false;
                }
            }
        } catch (Exception var16) {
            Log.e(TAG, "Error", var16);
            return false;
        }
    }

    @RequiresApi(
            api = 26
    )
    private ResultCode activeAuthentication() {
        try {
            Log.d(TAG, "Start Active Authentication...");
            PublicKey pubKey = this._dgPublicKeyFile.getPublicKey();
            String pubKeyAlgorithm = pubKey.getAlgorithm();
            String digestAlgorithm = "SHA1";
            String signatureAlgorithm = "SHA1WithRSA/ISO9796-2";
            if ("EC".equals(pubKeyAlgorithm) || "ECDSA".equals(pubKeyAlgorithm)) {
                ArrayList<ActiveAuthenticationInfo> activeAuthenticationInfoList = new ArrayList();
                Collection<SecurityInfo> dg14FileSecurityInfos = this._dgSecurityInfoFile.getSecurityInfos();
                Iterator var7 = dg14FileSecurityInfos.iterator();

                while(true) {
                    if (!var7.hasNext()) {
                        int activeAuthenticationInfoCount = activeAuthenticationInfoList.size();
                        if (activeAuthenticationInfoCount < 1) {
                            Log.e(TAG, "Not found active authentication info in EF.DG14");
                            this._result.setCode(ResultCode.SUCCESS_WITH_WARNING);
                            return ResultCode.SUCCESS_WITH_WARNING;
                        }

                        if (activeAuthenticationInfoCount > 1) {
                            Log.d(TAG, "Found activeAuthenticationInfoCount in EF.DG14, expected 1.");
                        }

                        ActiveAuthenticationInfo activeAuthenticationInfo = (ActiveAuthenticationInfo)activeAuthenticationInfoList.get(0);
                        String signatureAlgorithmOID = activeAuthenticationInfo.getSignatureAlgorithmOID();
                        signatureAlgorithm = ActiveAuthenticationInfo.lookupMnemonicByOID(signatureAlgorithmOID);
                        digestAlgorithm = Util.inferDigestAlgorithmFromSignatureAlgorithm(signatureAlgorithm);
                        break;
                    }

                    SecurityInfo securityInfo = (SecurityInfo)var7.next();
                    if (securityInfo instanceof ActiveAuthenticationInfo) {
                        activeAuthenticationInfoList.add((ActiveAuthenticationInfo)securityInfo);
                    }
                }
            }

            int challengeLength = 8;
            byte[] challenge = new byte[challengeLength];
            SecureRandom.getInstanceStrong().nextBytes(challenge);
            AAResult aaResult = this._service.doAA(pubKey, this._sodFile.getDigestAlgorithm(), this._sodFile.getSignerInfoDigestAlgorithm(), challenge);
            if (this.verifyAA(pubKey, digestAlgorithm, signatureAlgorithm, challenge, aaResult.getResponse())) {
                Log.d(TAG, "Active Authentication: succeeded");
                return ResultCode.SUCCESS;
            }

            Log.d(TAG, "Active Authentication: Failed");
        } catch (Exception var10) {
            Log.e(TAG, "Error", var10);
            this._result.setCode(ResultCode.CARD_LOST_CONNECTION);
            return ResultCode.CARD_LOST_CONNECTION;
        }

        this._result.setCode(ResultCode.SUCCESS_WITH_WARNING);
        return this._result.getCode();
    }

    private void closeALl() {
        try {
            if (this._service != null) {
                this._service.close();
            }
        } catch (Exception var3) {
            Log.d(TAG, "Exception: " + var3.getMessage());
        }

        try {
            if (this._card != null) {
                this._card.close();
            }
        } catch (Exception var2) {
            Log.d(TAG, "Exception: " + var2.getMessage());
        }

    }
}

