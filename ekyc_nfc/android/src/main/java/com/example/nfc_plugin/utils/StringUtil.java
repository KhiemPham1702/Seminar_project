package com.example.nfc_plugin.utils;

public final class StringUtil {
    private static final char[] HEX_ARRAY = "0123456789ABCDEF".toCharArray();
    private static final String TAG = StringUtil.class.getName();

    public StringUtil() {
    }

    public static String bytesToHex(byte[] bytes) {
        char[] hexChars = new char[bytes.length * 2];

        for(int j = 0; j < bytes.length; ++j) {
            int v = bytes[j] & 255;
            hexChars[j * 2] = HEX_ARRAY[v >>> 4];
            hexChars[j * 2 + 1] = HEX_ARRAY[v & 15];
        }

        return new String(hexChars);
    }

    public static byte[] hexToByte(String str) {
        int length = str.length() / 2;
        byte[] bArr = new byte[length];

        for(int i = 0; i < length; ++i) {
            int i2 = i * 2;
            bArr[i] = (byte)Integer.parseInt(str.substring(i2, i2 + 2), 16);
        }

        return bArr;
    }

    public static String hexToASCII(String str) {
        StringBuilder sb = new StringBuilder();

        int i2;
        for(int i = 0; i < str.length(); i = i2) {
            i2 = i + 2;
            sb.append((char)Integer.parseInt(str.substring(i, i2), 16));
        }

        return sb.toString();
    }

    public static String hexToUTF8(String str) throws Exception {
        return new String(hexToByte(str), "UTF-8");
    }

    public static String cutTLVString(String str, String str2) {
        if (str2 == null) {
            return null;
        } else {
            int indexOf = str.indexOf(str2) + str2.length();
            return str.substring(indexOf, indexOf + 2);
        }
    }

    public static int indexOfTagWithLength(String str, String str2) {
        return str2 == null ? -1 : str.indexOf(str2) + str2.length() + 2;
    }
}

