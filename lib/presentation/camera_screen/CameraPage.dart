import 'package:flutter/material.dart';
import 'package:flutter_mrz_scanner/flutter_mrz_scanner.dart';
import 'package:khim_s_application8/core/app_export.dart';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  bool isParsed = false;
  MRZController? controller;
  bool isFlashlightOn = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(alignment: Alignment.center, children: [
        MRZScanner(
          withOverlay: true,
          onControllerCreated: onControllerCreated,
        ),
        Positioned(
            top: MediaQuery.of(context).size.height * 0.25,
            child: Text('Scan back of document',
                style: TextStyle(
                  fontFamily: 'Quicksand-SemiBold',
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ))),
        Positioned(
            top: MediaQuery.of(context).size.height * 0.55,
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
          bottom: MediaQuery.of(context).size.height * 0.03,
          right: MediaQuery.of(context).size.height * 0.03,
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
        'Birthdate': result.birthDate.toString(),
        'Expiry date': result.expiryDate.toString(),
        'ID': result.personalNumber,
      };

      controller?.stopPreview();

      Get.toNamed(
        AppRoutes.nfcIntroScreen,
        arguments: re,
      );
    };

    controller.startPreview();
  }
}
