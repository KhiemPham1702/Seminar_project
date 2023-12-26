import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nfc_plugin/nfc_plugin.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String nfcData =
      'Press Scan button and place the card in the scanning position';
  String dialogText = 'Scanning...(Hold the card in the scanning position)';

  bool isScanning = false;

  String textFieldValue1 = '';
  String textFieldValue2 = '';
  String textFieldValue3 = '';

  String successMessage = '';
  Map<Object?, Object?>? successResult;
  String errorText = '';
  Image? imageAvatar;

  void initState() {
    super.initState();
    textFieldValue1 = '066202014790';
    textFieldValue2 = '020217';
    textFieldValue3 = '270217';
    NfcPlugin.nfcProgressChannel
        .receiveBroadcastStream()
        .listen((dynamic event) {
      setState(() {
        dialogText = event;
        if (Navigator.of(context).canPop()) {
          // Nếu hộp thoại đang hiển thị, cập nhật nội dung của nó
          Navigator.of(context).pop();
          showNfcDialog(context);
        }
      });
    });
  }

  void showNfcDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(dialogText),
              SizedBox(height: 16),
              CircularProgressIndicator(),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Thêm 3 text input
              TextField(
                onChanged: (value) {
                  textFieldValue1 = value;
                },
                controller: TextEditingController(text: textFieldValue1),
              ),

              TextField(
                onChanged: (value) {
                  textFieldValue2 = value;
                },
                controller: TextEditingController(text: textFieldValue2),
              ),

              TextField(
                onChanged: (value) {
                  textFieldValue3 = value;
                },
                controller: TextEditingController(text: textFieldValue3),
              ),

              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    successMessage = '';
                    imageAvatar = null;
                    nfcData = '';
                    dialogText =
                        'Scanning...(Hold the card in the scanning position)';
                  });
                  showNfcDialog(context);
                  NfcPlugin plugin = NfcPlugin();
                  Map<dynamic, dynamic>? re = await plugin.sendDataToNative(
                      textFieldValue1, textFieldValue2, textFieldValue3);
                  Navigator.of(context).pop();
                  if (re != null) {
                    setState(() {
                      successResult = re['nfcResult'];
                      successResult?.forEach((key, value) {
                        successMessage += '$key: $value\n';
                      });

                      Uint8List? bytes = re['photo'];
                      if (bytes != null) {
                        imageAvatar = Image.memory(bytes);
                      } else {
                        imageAvatar = null;
                      }
                    });
                  }
                },
                child: Text('NFC Scans'),
              ),

              // Hiển thị dữ liệu NFC
              if (imageAvatar != null)
                Container(
                  width: 200, // Đặt chiều rộng của ảnh
                  height: 200, // Đặt chiều cao của ảnh
                  child: imageAvatar!,
                ),
              Text('${successMessage != '' ? successMessage : nfcData}\n'),
            ],
          ),
        ),
      ),
    );
  }
}
