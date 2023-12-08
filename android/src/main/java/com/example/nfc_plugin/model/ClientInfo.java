package com.example.nfc_plugin.model;

public class ClientInfo {
    private String osName = "";
    private String deviceName = "";
    private String mSdkVersionName = "";
    private String deviceType = "";
    private int mSdkVersionCode = 0;

    public ClientInfo(String deviceName, String mSdkVersionName, int mSdkVersionCode) {
        this.deviceName = deviceName;
        this.mSdkVersionName = mSdkVersionName;
        this.mSdkVersionCode = mSdkVersionCode;
    }

    public byte[] getData() {
        return null;
    }

    public String getOsName() {
        return this.osName;
    }

    void setOsName(String osName) {
        this.osName = osName;
    }

    public String getDeviceName() {
        return this.deviceName;
    }

    void setDeviceName(String deviceName) {
        this.deviceName = deviceName;
    }

    public String getSdkVersionName() {
        return this.mSdkVersionName;
    }

    void setSdkVersionName(String sdkVersionName) {
        this.mSdkVersionName = sdkVersionName;
    }

    public int getSdkVersionCode() {
        return this.mSdkVersionCode;
    }

    void setSdkVersionCode(int sdkVersionCode) {
        this.mSdkVersionCode = sdkVersionCode;
    }

    public String getDeviceType() {
        return this.deviceType;
    }

    public void setDeviceType(String deviceType) {
        this.deviceType = deviceType;
    }
}

