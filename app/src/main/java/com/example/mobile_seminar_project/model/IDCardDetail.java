package com.example.mobile_seminar_project.model;

import android.graphics.Bitmap;

public class IDCardDetail {
    private String birthDate;
    private String citizenPid;
    private String dateProvide;
    private String ethnic;
    private String fatherName;
    private String fullName;
    private String gender;
    private String homeTown;
    private String husBandName;
    private String identifyCharacteristics;
    private String motherName;
    private String nationality;
    private String oldIdentify;
    private String outOfDate;
    private Bitmap photo;
    private String photoBase64;
    private String regPlaceAddress;
    private String religion;
    private String wifeName;
    private boolean chipAuth = false;
    private String chipAuthMessage = "";
    private boolean cscaAuth = false;
    private String cscaAuthMessage = "";
    private String sodBase64 = "";


    public IDCardDetail() {
    }

    public IDCardDetail(String str, String str2, String str3, String str4, String str5, String str6, String str7, String str8, String str9, String str10, String str11, String str12, String str13, String str14, String str15, String str16, String str17, String str18, Bitmap bitmap) {
        String str19 = str13;

        this.citizenPid = str;
        this.fullName = str2;
        this.birthDate = str3;
        this.gender = str4;
        this.nationality = str5;
        this.ethnic = str6;
        this.religion = str7;
        this.homeTown = str8;
        this.regPlaceAddress = str9;
        this.identifyCharacteristics = str10;
        this.dateProvide = str11;
        this.outOfDate = str12;
        this.fatherName = str19;
        this.motherName = str14;
        this.wifeName = str15;
        this.husBandName = str16;
        this.oldIdentify = str17;
        this.photoBase64 = str18;
        this.photo = bitmap;
    }

    public boolean isValid() {
        if (this.citizenPid == null || this.citizenPid.length() != 12) {
            return false;
        }

        if (this.birthDate == null || this.birthDate.length() != 10) {
            return false;
        }

        if (this.outOfDate == null || this.outOfDate.length() != 10) {
            return false;
        }
        return true;
    }

    public final String getCitizenPid() {
        return this.citizenPid;
    }

    public final void setCitizenPid(String str) {
        this.citizenPid = str;
    }

    public final String getFullName() {
        return this.fullName;
    }

    public final void setFullName(String str) {
        this.fullName = str;
    }

    public final String getBirthDate() {
        return this.birthDate;
    }

    public final void setBirthDate(String str) {
        this.birthDate = str;
    }

    public final String getGender() {
        return this.gender;
    }

    public final void setGender(String str) {
        this.gender = str;
    }

    public final String getNationality() {
        return this.nationality;
    }

    public final void setNationality(String str) {
        this.nationality = str;
    }

    public final String getEthnic() {
        return this.ethnic;
    }

    public final void setEthnic(String str) {
        this.ethnic = str;
    }

    public final String getReligion() {
        return this.religion;
    }

    public final void setReligion(String str) {
        this.religion = str;
    }

    public final String getHomeTown() {
        return this.homeTown;
    }

    public final void setHomeTown(String str) {
        this.homeTown = str;
    }

    public final String getRegPlaceAddress() {
        return this.regPlaceAddress;
    }

    public final void setRegPlaceAddress(String str) {
        this.regPlaceAddress = str;
    }

    public final String getIdentifyCharacteristics() {
        return this.identifyCharacteristics;
    }

    public final void setIdentifyCharacteristics(String str) {
        this.identifyCharacteristics = str;
    }

    public final String getDateProvide() {
        return this.dateProvide;
    }

    public final void setDateProvide(String str) {
        this.dateProvide = str;
    }

    public final String getOutOfDate() {
        return this.outOfDate;
    }

    public final void setOutOfDate(String str) {
        this.outOfDate = str;
    }

    public final String getFatherName() {
        return this.fatherName;
    }


    public final void setFatherName(String str) {
        this.fatherName = str;
    }

    public final String getMotherName() {
        return this.motherName;
    }

    public final void setMotherName(String str) {
        this.motherName = str;
    }

    public final String getWifeName() {
        return this.wifeName;
    }

    public final void setWifeName(String str) {
        this.wifeName = str;
    }

    public final String getHusBandName() {
        return this.husBandName;
    }

    public final void setHusBandName(String str) {
        this.husBandName = str;
    }

    public final String getOldIdentify() {
        return this.oldIdentify;
    }

    public final void setOldIdentify(String str) {
        this.oldIdentify = str;
    }

    public final String getPhotoBase64() {
        return this.photoBase64;
    }

    public final void setPhotoBase64(String str) {
        this.photoBase64 = str;
    }

    public final Bitmap getPhoto() {
        return this.photo;
    }

    public final void setPhoto(Bitmap bitmap) {
        this.photo = bitmap;
    }

    public final boolean getChipAuth() {
        return this.chipAuth;
    }

    public final void setChipAuth(boolean b) {
        this.chipAuth = b;
    }

    public final String getChipAuthMessage() {
        return this.chipAuthMessage;
    }

    public final void setChipAuthMessage(String ms) {
        this.chipAuthMessage = ms;
    }

    public final boolean getCscaAuth() {
        return this.cscaAuth;
    }

    public final void setCscaAuth(boolean b) {
        this.cscaAuth = b;
    }

    public final String getCscaAuthMessage() {
        return this.cscaAuthMessage;
    }

    public final void setCscaAuthMessage(String msg) {
        this.cscaAuthMessage = msg;
    }

    public final String getSodBase64() {
        return this.sodBase64;
    }

    public final void setSodBase64(String msg) {
        this.sodBase64 = msg;
    }
}