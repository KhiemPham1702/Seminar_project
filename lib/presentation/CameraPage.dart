import 'package:flutter/material.dart';
import 'package:flutter_mrz_scanner/flutter_mrz_scanner.dart';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  bool isParsed = false;
  MRZController? controller;
  bool isFlashlightOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(alignment: Alignment.center, children: [
        MRZScanner(
          withOverlay: true,
          onControllerCreated: onControllerCreated,
        ),
        Positioned(
            top: MediaQuery.of(context).size.height *
                0.25, // Khoảng cách từ bottom
            child: Text('Scan back of document',
                style: TextStyle(
                  fontFamily: 'Quicksand-SemiBold',
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ))),
        Positioned(
            top: MediaQuery.of(context).size.height * 0.52,
            child: Transform.scale(
              scaleX: MediaQuery.of(context).size.width / 20.0,
              scaleY: MediaQuery.of(context).size.height / 210.0,
              child: IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.white,
                  size: 24,
                ),
                onPressed: () {
                  return;
                },
              ),
            )),
        Positioned(
          bottom: MediaQuery.of(context).size.height *
              0.03, // Khoảng cách từ bottom
          right:
              MediaQuery.of(context).size.height * 0.03, // Khoảng cách từ right
          child: IconButton(
            icon: Icon(
              isFlashlightOn ? Icons.flashlight_on : Icons.flashlight_off,
              color: Colors.white,
            ),
            onPressed: () {
              if (isFlashlightOn) {
                controller?.flashlightOff();
              } else {
                controller?.flashlightOn();
              }
              setState(() {
                isFlashlightOn = !isFlashlightOn;
              });
            },
          ),
        ),
        Positioned(
          bottom: MediaQuery.of(context).size.height * 0.03,
          left: MediaQuery.of(context).size.height * 0.03,
          child: IconButton(
            icon: Icon(Icons.keyboard),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ]),
    );
  }

  @override
  void dispose() {
    controller?.stopPreview();
    super.dispose();
  }

  void onControllerCreated(MRZController controller) {
    this.controller = controller;
    controller.onParsed = (result) async {
      if (isParsed) {
        return;
      }
      isParsed = true;
      Map<String, dynamic>? re = {
        'Birthdate': result.birthDate,
        'Expiry date': result.expiryDate,
        'ID': result.personalNumber,
      };
      Navigator.pop(context, re);
    };
    controller.onError = (error) => print(error);

    controller.startPreview();
  }
}
