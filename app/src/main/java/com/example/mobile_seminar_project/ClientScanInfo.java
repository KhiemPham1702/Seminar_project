package com.example.mobile_seminar_project;

import android.graphics.Bitmap;

import com.example.mobile_seminar_project.model.CardResult;


public class ClientScanInfo {
    private String _idNumber;
    private String _birthDate;
    private String _expirationDate;
    private byte[] _portraitByte;
    private Bitmap _portraitBitmap;

    private CardResult cardResult;

    public CardResult getCardResult() {
        return cardResult;
    }

    public void setCardResult(CardResult cardResult) {
        this.cardResult = cardResult;
    }

    public static volatile ClientScanInfo INSTANCE = null;
    private ClientScanInfo(){}
    public static ClientScanInfo getInstance() {
        if (INSTANCE == null) {
            INSTANCE = new ClientScanInfo();
        }
        return(INSTANCE);
    }
    public void resetSession(){
        ClientScanInfo instance = getInstance();
        instance.set_idNumber(null);
        instance.set_portraitBitmap(null);
        instance.set_portraitByte(null);
    }

    public String get_idNumber() {
        return _idNumber;
    }

    public void set_idNumber(String _idNumber) {
        this._idNumber = _idNumber;
    }

    public String get_birthDate() {
        return _birthDate;
    }

    public void set_birthDate(String _birthDate) {
        this._birthDate = _birthDate;
    }

    public String get_expirationDate() {
        return _expirationDate;
    }

    public void set_expirationDate(String _expirationDate) {
        this._expirationDate = _expirationDate;
    }

    public byte[] get_portraitByte() {
        return _portraitByte;
    }

    public void set_portraitByte(byte[] _portraitByte) {
        this._portraitByte = _portraitByte;
    }

    public Bitmap get_portraitBitmap() {
        return _portraitBitmap;
    }

    public void set_portraitBitmap(Bitmap _portraitBitmap) {
        this._portraitBitmap = _portraitBitmap;
    }


}
