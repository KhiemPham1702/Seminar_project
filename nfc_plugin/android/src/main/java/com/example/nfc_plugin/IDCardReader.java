package com.example.nfc_plugin;

import android.nfc.tech.IsoDep;
import android.util.Base64;
import android.util.Log;

import com.example.nfc_plugin.model.CardResult;

import com.example.nfc_plugin.model.IDCardDetail;
import com.example.nfc_plugin.model.ResultCode;
import com.htc.sdk.scuba.smartcards.CardService;


public class IDCardReader {
    private static final String TAG = IDCardReader.class.getSimpleName();

    public IDCardReader() {
    }

    public Object readData(IsoDep isoDep, String cccdId, boolean hashCheck, boolean chipCheck, boolean activeCheck) {
        try {
            CardService cardService = CardService.getInstance(isoDep);
            return (new ICaoReaderParser()).readData(cardService, cccdId, hashCheck, chipCheck, activeCheck);
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
            return (new ICaoReaderParser()).parseFromBytes(allData);
        }
    }
}
