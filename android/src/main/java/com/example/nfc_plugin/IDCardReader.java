package com.example.nfc_plugin;

import android.nfc.tech.IsoDep;
import android.util.Base64;
import android.util.Log;

import com.example.mobile_seminar_project.model.CardResult;
import com.example.mobile_seminar_project.model.ResultCode;
import com.htc.sdk.eidparser.ICaoReaderParser;
import com.htc.sdk.model.IDCardDetail;

import net.sf.scuba.smartcards.CardService;

public class IDCardReader {
    private static final String TAG = IDCardReader.class.getSimpleName();

    public IDCardReader() {
    }


//    public com.htc.sdk.model.CardResult readData(CardService card, String cccdId, boolean hashCheck, boolean chipCheck, boolean activeCheck) {
//        return (new ICaoReaderParser()).readData(com.htc.sdk.scuba.smartcards.CardService.getInstance(card), cccdId, hashCheck, chipCheck, activeCheck);
//    }

    public Object readData(IsoDep isoDep, String cccdId, boolean hashCheck, boolean chipCheck, boolean activeCheck) {
        try {
            CardService cardService = CardService.getInstance(isoDep);
            return (new ICaoReaderParser()).readData(com.htc.sdk.scuba.smartcards.CardService.getInstance(cardService), cccdId, hashCheck, chipCheck, activeCheck);
        } catch (Exception var7) {
            var7.printStackTrace();
            Log.e(TAG, "Error", var7);
            CardResult rs = new CardResult();
            rs.setCode(ResultCode.CANNOT_OPEN_DEVICE);
            return rs;
        }
    }

    public IDCardDetail parseCardDetail(CardResult cardResult) {
        if ((cardResult == null || cardResult.getCode() != ResultCode.SUCCESS) && cardResult.getCode() != ResultCode.SUCCESS_WITH_WARNING) {
            return null;
        } else {
            byte[] allData = cardResult.getData();
            String allDatabase64 = Base64.encodeToString(allData, 0);
            Log.d(TAG, "doInBackground: " + allDatabase64);
            return (new ICaoReaderParser()).parseFromBytes(allData);
        }
    }

    private String padLeftZeros(String inputString, int length) {
        if (inputString.length() >= length) {
            return inputString;
        } else {
            StringBuilder sb = new StringBuilder();

            while(sb.length() < length - inputString.length()) {
                sb.append('0');
            }

            sb.append(inputString);
            return sb.toString();
        }
    }
}