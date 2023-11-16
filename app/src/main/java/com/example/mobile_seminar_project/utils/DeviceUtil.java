package com.example.mobile_seminar_project.utils;

import android.content.res.Resources;
import android.os.Build;

public final class DeviceUtil {
    private DeviceUtil() {
        throw new UnsupportedOperationException("can't instantiate me...");
    }

    public static String getSDKVersionName() {
        return Build.VERSION.RELEASE;
    }

    public static int getSDKVersionCode() {
        return Build.VERSION.SDK_INT;
    }

    public static String getManufacturer() {
        return Build.MANUFACTURER;
    }

    public static String getModel() {
        String model = Build.MODEL;
        if (model != null) {
            model = model.trim().replaceAll("\\s*", "");
        } else {
            model = "";
        }

        return model;
    }

    public static boolean isTablet() {
        return (Resources.getSystem().getConfiguration().screenLayout & 15) >= 3;
    }
}
