package com.example.nfc_plugin.utils;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.text.TextUtils;
import android.util.Base64;

import java.io.ByteArrayOutputStream;

public class Base64Util {
    public Base64Util() {
    }

    public static String convertBitmapToBase64(Bitmap bitmap) {
        if (bitmap == null) {
            return null;
        } else {
            ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
            bitmap.compress(Bitmap.CompressFormat.PNG, 100, byteArrayOutputStream);
            byte[] byteArray = byteArrayOutputStream.toByteArray();
            return "data:image/png;base64," + Base64.encodeToString(byteArray, 0);
        }
    }

    public static Bitmap convertBase64ToBitmap(String b64) {
        if (TextUtils.isEmpty(b64)) {
            return null;
        } else {
            String base64String = b64;
            if (b64.startsWith("data:image") && b64.split(",").length > 1) {
                base64String = b64.split(",")[1];
            }

            byte[] decodedString = Base64.decode(base64String, 0);
            return BitmapFactory.decodeByteArray(decodedString, 0, decodedString.length);
        }
    }
}

