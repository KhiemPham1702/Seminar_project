package com.example.nfc_plugin.model;

import android.util.Base64;

import java.nio.ByteBuffer;

public class CardResult {
    private ResultCode code;
    private CheckingCode hashCheck;
    private CheckingCode chipCheck;
    private CheckingCode activeCheck;
    private ByteBuffer[] DgAll;
    private byte[] SOD;
    private byte[] AllData;

    public CardResult() {
        this.code = ResultCode.UNKNOWN;
        this.hashCheck = CheckingCode.NOT_CHECK;
        this.chipCheck = CheckingCode.NOT_CHECK;
        this.activeCheck = CheckingCode.NOT_CHECK;
        this.DgAll = new ByteBuffer[16];
        this.SOD = null;
        this.AllData = null;
    }

    public ResultCode getCode() {
        return this.code;
    }

    public void setCode(ResultCode code) {
        this.code = code;
    }

    public CheckingCode getHashCheck() {
        return this.hashCheck;
    }

    public void setHashCheck(CheckingCode hashCheck) {
        this.hashCheck = hashCheck;
    }

    public CheckingCode getChipCheck() {
        return this.chipCheck;
    }

    public void setChipCheck(CheckingCode chipCheck) {
        this.chipCheck = chipCheck;
    }

    public CheckingCode getActiveCheck() {
        return this.activeCheck;
    }

    public void setActiveCheck(CheckingCode activeCheck) {
        this.activeCheck = activeCheck;
    }

    public byte[] getDG(int DataGroup) {
        return DataGroup >= 1 && DataGroup <= this.DgAll.length && this.DgAll[DataGroup - 1] != null ? this.DgAll[DataGroup - 1].array() : null;
    }

    public void setDG(int DataGroup, byte[] DGData) {
        if (DataGroup >= 1 && DataGroup <= this.DgAll.length) {
            this.DgAll[DataGroup - 1] = ByteBuffer.allocate(DGData.length);
            this.DgAll[DataGroup - 1].put(DGData);
        }

    }

    public byte[] getSOD() {
        return this.SOD;
    }

    public void setSOD(byte[] SOD) {
        this.SOD = SOD;
    }

    public void buildData() {
        try {
            if (this.SOD == null) {
                return;
            }

            int Length = 68;
            Length += this.SOD.length;
            ByteBuffer[] var2 = this.DgAll;
            int SodLength = var2.length;

            for(int var4 = 0; var4 < SodLength; ++var4) {
                ByteBuffer bf = var2[var4];
                if (bf != null) {
                    Length += bf.array().length;
                }
            }

            ByteBuffer allBuffer = ByteBuffer.allocate(Length);
            SodLength = this.SOD.length;
            byte[] SodHeaderByte = new byte[]{(byte)(SodLength >> 24 & 255), (byte)(SodLength >> 16 & 255), (byte)(SodLength >> 8 & 255), (byte)(SodLength >> 0 & 255)};
            allBuffer.put(SodHeaderByte);
            allBuffer.put(this.SOD);

            for(int i = 0; i < this.DgAll.length; ++i) {
                ByteBuffer buff = this.DgAll[i];
                int length = 0;
                if (buff != null) {
                    length = buff.array().length;
                }

                byte[] headerByte = new byte[]{(byte)(length >> 24 & 255), (byte)(length >> 16 & 255), (byte)(length >> 8 & 255), (byte)(length >> 0 & 255)};
                allBuffer.put(headerByte);
                if (buff != null) {
                    allBuffer.put(buff.array());
                }
            }

            this.AllData = allBuffer.array();
        } catch (Exception var9) {
            var9.printStackTrace();
        }

    }

    public byte[] getData() {
        if (this.AllData == null) {
            this.buildData();
        }

        return this.AllData;
    }

    public String getBase64DG(int dataGroup) {
        byte[] data = this.getDG(dataGroup);
        return data != null ? Base64.encodeToString(data, 0) : null;
    }

    public String getBase64SOD() {
        byte[] sod = this.getSOD();
        return sod != null ? Base64.encodeToString(sod, 0) : null;
    }

    public String getBase64Data() {
        byte[] allData = this.getData();
        return allData != null ? Base64.encodeToString(allData, 0) : null;
    }
}
