package com.example.nfc_plugin.model;

public enum ResultCode {
    UNKNOWN,
    SUCCESS,
    SUCCESS_WITH_WARNING,
    CANNOT_OPEN_DEVICE,
    CARD_NOT_FOUND,
    WRONG_CCCDID,
    CARD_LOST_CONNECTION;

    private ResultCode() {
    }
}

