package com.example.nfc_plugin;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.app.AlertDialog;
import android.app.PendingIntent;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.IntentFilter;
import android.graphics.Bitmap;
import android.nfc.NfcAdapter;
import android.nfc.Tag;
import android.nfc.tech.IsoDep;
import android.os.AsyncTask;
import android.os.Bundle;
import android.os.Handler;
import android.provider.Settings;
import android.text.TextUtils;
import android.util.Log;
import android.view.MenuItem;


import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

public class NfcReaderActivity extends Activity {
    private static final String TAG = NfcReaderActivity.class.getSimpleName();
    private static final int NFC_READ_STATE_WAITING = 1;
    private static final int NFC_READ_STATE_READING = 2;
    private static final int NFC_READ_STATE_DONE = 3;

    AlertDialog alertDialog;
    Handler mHandler;
    Runnable mRestartNfcRunnable;
    private static NfcCheckCallback nfcCallback;


    public static void startActivity(Context context, NfcCheckCallback callback) {
        nfcCallback = callback;
        Intent intent = new Intent(context, NfcReaderActivity.class);
        intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        context.startActivity(intent);
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        initComponents();

        mHandler = new Handler();
    }

    @Override
    protected void onResume() {
        super.onResume();
        startNfc();
    }

    @Override
    protected void onPause() {
        super.onPause();
        stopNfc();
    }


    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            case android.R.id.home:
                this.finish();
                return true;
        }
        return false;
    }

    private void startNfc() {
        NfcAdapter adapter = NfcAdapter.getDefaultAdapter(this);
        Log.d(TAG, "startNfc: " + adapter);
        if (alertDialog != null) {
            alertDialog.dismiss();
            alertDialog = null;
        }
        if (adapter == null) {
            // NFC is not available for device
            setNfcUiState(NFC_READ_STATE_WAITING, "Thiết bị không hỗ trợ NFC");
            Map<String, String> ttcnMap = new HashMap<>();
            ttcnMap.put("Error","Thiết bị không hỗ trợ NFC");
            nfcCallback.onNfcCheckDone(ttcnMap, null);
            finish();
            return;
        }
        if (!adapter.isEnabled()) {
            // NFC is available for device but not enabled
            setNfcUiState(NFC_READ_STATE_WAITING, "");
            alertDialog = new AlertDialog.Builder(this)
                    .setTitle("Chưa bật NFC")
                    .setMessage("Vui lòng bật NFC trong Settings để tiếp tục")
                    .setCancelable(false)
                    .setPositiveButton("Cài đặt", new DialogInterface.OnClickListener() {
                        @Override
                        public void onClick(DialogInterface dialogInterface, int i) {
                            Intent intent = new Intent(Settings.ACTION_NFC_SETTINGS);
                            startActivity(intent);
                        }
                    })
                    .setNegativeButton("Bỏ qua", new DialogInterface.OnClickListener() {
                        @Override
                        public void onClick(DialogInterface dialogInterface, int i) {
                            finish();
                        }
                    }).create();
            alertDialog.show();
        }
        else {
            Intent intent = new Intent(getApplicationContext(), this.getClass());
            intent.setFlags(Intent.FLAG_ACTIVITY_SINGLE_TOP);
            PendingIntent pendingIntent = PendingIntent.getActivity(this, 0,
                    intent, PendingIntent.FLAG_MUTABLE);

            IntentFilter[] filters = new IntentFilter[]{
                    new IntentFilter(NfcAdapter.ACTION_TECH_DISCOVERED),
                    new IntentFilter(NfcAdapter.ACTION_NDEF_DISCOVERED),
                    new IntentFilter(NfcAdapter.ACTION_TAG_DISCOVERED),
            };
            String[][] filter = new String[][]{new String[]{IsoDep.class.getName()}};
            adapter.enableForegroundDispatch(this, pendingIntent, filters, filter);
        }
    }

    private void stopNfc() {
        NfcAdapter adapter = NfcAdapter.getDefaultAdapter(this);
        Log.d(TAG, "stopNfc: " + adapter);
        if (adapter != null) {
            try {
                adapter.disableForegroundDispatch(this);
            } catch (Exception e) {
                e.printStackTrace();
            }
            setNfcUiState(NFC_READ_STATE_WAITING, "");
        }
    }

    void restartNfc() {
        if (mRestartNfcRunnable != null) {
            mHandler.removeCallbacks(mRestartNfcRunnable);
        }
        mRestartNfcRunnable = () -> {
            stopNfc();
            startNfc();
        };
        mHandler.postDelayed(mRestartNfcRunnable, 3000);
    }


    private void initComponents() {
        setNfcUiState(NFC_READ_STATE_WAITING, "");
    }

    private void setNfcUiState(int state, String message) {
//        TextView txt_v = (TextView) findViewById(R.id.lbl_nfc_status);
//        txt_v.setText(message);
    }

    @Override
    public void onNewIntent(Intent intent) {
        super.onNewIntent(intent);
        Log.d(TAG, "onNewIntent: " + intent.toUri(0));
        if (NfcAdapter.ACTION_TECH_DISCOVERED.equals(intent.getAction())) {
            Tag tag = intent.getExtras().getParcelable(NfcAdapter.EXTRA_TAG);
            Log.d(TAG, "onNewIntent: TAGS " + TextUtils.join("\n", tag.getTechList()));
            if (Arrays.asList(tag.getTechList()).contains(IsoDep.class.getName())) {
                new ReadTask(IsoDep.get(tag), nfcCallback).execute();
            }
        }
    }

    private class ReadTask extends AsyncTask<Void, String, Exception> {
        private IsoDep isoDep;
        private NfcCheckCallback nfcCheckCallback;

        private ReadTask(IsoDep isoDep, NfcCheckCallback checkCallback) {
            this.isoDep = isoDep;
            nfcCheckCallback = checkCallback;
        }

        private com.htc.sdk.model.IDCardDetail citizenInfo = new com.htc.sdk.model.IDCardDetail();
        CardResult mCardResult;

        @Override
        protected void onPreExecute() {
            super.onPreExecute();
            setNfcUiState(NFC_READ_STATE_READING, "Đang đọc thẻ CCCD....");
            nfcCheckCallback.onProgress("Đang đọc thẻ CCCD....");
        }

        @SuppressLint("NewApi")
        @Override
        protected Exception doInBackground(Void... params) {
            try {
                publishProgress("Đang giao tiếp NFC....");
                IDCardReader rd = new IDCardReader();
                ClientScanInfo sessionScanInfo = ClientScanInfo.getInstance();
                String cccdId = sessionScanInfo.get_idNumber();
                String birthDate = sessionScanInfo.get_birthDate();
                String expirationDate = sessionScanInfo.get_expirationDate();

                mCardResult = (CardResult) rd.readData(isoDep, cccdId, true, true,true);
                CardResult result = mCardResult;
                if (result != null && (result.getCode() == ResultCode.SUCCESS || result.getCode() == ResultCode.SUCCESS_WITH_WARNING)) {
                    citizenInfo = rd.parseCardDetail(result);
                }
                else
                {
                    switch (mCardResult.getCode()) {
                        case CANNOT_OPEN_DEVICE:
                            Log.d(TAG, "CANNOT_OPEN_DEVICE");
                        case CARD_NOT_FOUND:
                            Log.d(TAG, "CANNOT_OPEN_DEVICE");
                        case WRONG_CCCDID:
                            Log.d(TAG, "WRONG_ID_INFO");
                        default:
                            Log.d(TAG, "Failed. Please try again");
                    }
                    return null;
                }
                Log.d(TAG, "Read data result code: " + result.getCode() +
                        "; Hash Checking: " + result.getHashCheck() +
                        "; Chip Authentication: " + result.getChipCheck() +
                        "; Activate Authentication: " + result.getActiveCheck());
            } catch (Exception e) {
                return e;
            }
            return null;
        }


        private void display_ket_qua_doc_nfc() {
            Bitmap cccd_face = citizenInfo.getPhoto();
            Map<String, String> ttcnMap = new HashMap<>();

            ttcnMap.put("Số CCCD", citizenInfo.getCitizenPid());
            ttcnMap.put("Họ tên", citizenInfo.getFullName());
            ttcnMap.put("Ngày sinh", citizenInfo.getBirthDate());
            ttcnMap.put("Giới tính", citizenInfo.getGender());
            ttcnMap.put("Ngày cấp", citizenInfo.getDateProvide());
            ttcnMap.put("Ngày hết hạn", citizenInfo.getOutOfDate());
            ttcnMap.put("Dân tộc", citizenInfo.getEthnic());
            ttcnMap.put("Quốc tịch", citizenInfo.getNationality());
            ttcnMap.put("Tôn giáo", citizenInfo.getReligion());
            ttcnMap.put("Quê quán", citizenInfo.getHomeTown());
            ttcnMap.put("Địa chỉ", citizenInfo.getRegPlaceAddress());
            ttcnMap.put("Đặc điểm nhận dạng", citizenInfo.getIdentifyCharacteristics());
            ttcnMap.put("Tên Cha", citizenInfo.getFatherName());
            ttcnMap.put("Tên mẹ", citizenInfo.getMotherName());

            if (nfcCheckCallback != null) {
                nfcCheckCallback.onNfcCheckDone(ttcnMap, cccd_face);
            }
            finish();
        }


        @Override
        protected void onProgressUpdate(String... values) {
            super.onProgressUpdate(values);
            setNfcUiState(NFC_READ_STATE_READING, values[0]);
        }

        @Override
        protected void onPostExecute(Exception result) {
            if (result == null) {
                if (mCardResult != null && (mCardResult.getCode() == ResultCode.SUCCESS ||
                        mCardResult.getCode() == ResultCode.SUCCESS_WITH_WARNING)) {
                    ClientScanInfo sessionScanInfo = ClientScanInfo.getInstance();
                    sessionScanInfo.setCardResult(mCardResult);
                    setNfcUiState(NFC_READ_STATE_DONE, "Đã đọc xong thông tin thẻ");
                    display_ket_qua_doc_nfc();
                    return;
                }
                String message = "";
                switch (mCardResult.getCode()) {
                    case UNKNOWN: {
                        message = "Có lỗi xảy ra. Vui lòng thử lại.";
                        break;
                    }
                    case WRONG_CCCDID: {
                        message = "Sai số căn cước công dân";
                        break;
                    }
                    case CANNOT_OPEN_DEVICE: {
                        message = "Không thể đọc được thiết bị";
                        break;
                    }
                    case CARD_LOST_CONNECTION: {
                        message = "Mất kết nối.";
                        break;
                    }
                }
                setNfcUiState(NFC_READ_STATE_WAITING, "Lỗi đọc thẻ : " + message);
                Map<String, String> ttcnMap = new HashMap<>();
                ttcnMap.put("Error", "Lỗi đọc thẻ. \n" + message);
                nfcCheckCallback.onNfcCheckDone(ttcnMap, null);
                finish();
            } else {
                result.printStackTrace();
                setNfcUiState(NFC_READ_STATE_WAITING, "Lỗi đọc thẻ (Post Execute): " + result.getMessage());
                Map<String, String> ttcnMap = new HashMap<>();
                ttcnMap.put("Error", "Lỗi đọc thẻ");
                nfcCheckCallback.onNfcCheckDone(ttcnMap, null);
                finish();
            }
        }

    }
}