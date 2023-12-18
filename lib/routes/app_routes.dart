import 'package:get/get.dart';
import 'package:khim_s_application8/presentation/app_navigation_screen/app_navigation_screen.dart';
import 'package:khim_s_application8/presentation/app_navigation_screen/binding/app_navigation_binding.dart';
import 'package:khim_s_application8/presentation/camera_screen/CameraPage.dart';
import 'package:khim_s_application8/presentation/camera_screen/binding/camera_binding.dart';
import 'package:khim_s_application8/presentation/data_screen/binding/data_binding.dart';
import 'package:khim_s_application8/presentation/data_screen/data_screen.dart';
import 'package:khim_s_application8/presentation/mrz_intro_screen/binding/mrz_intro_binding.dart';
import 'package:khim_s_application8/presentation/mrz_intro_screen/mrz_intro_screen.dart';
import 'package:khim_s_application8/presentation/nfc_instruction_screen/binding/nfc_instruction_binding.dart';
import 'package:khim_s_application8/presentation/nfc_instruction_screen/nfc_instruction_screen.dart';
import 'package:khim_s_application8/presentation/nfc_intro_screen/binding/nfc_intro_binding.dart';
import 'package:khim_s_application8/presentation/nfc_intro_screen/nfc_intro_screen.dart';
import 'package:khim_s_application8/presentation/start_screen/binding/start_binding.dart';
import 'package:khim_s_application8/presentation/start_screen/start_screen.dart';

class AppRoutes {
  static const String startScreen = '/start_screen';

  static const String mrzIntroScreen = '/mrz_intro_screen';

  static const String nfcIntroScreen = '/nfc_intro_screen';

  static const String nfcInstructionScreen = '/nfc_instruction_screen';

  static const String dataScreen = '/data_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static const String initialRoute = '/initialRoute';

  static const String cameraScreen = '/camera_screen';

  static List<GetPage> pages = [
    GetPage(
      name: cameraScreen,
      page: () => CameraPage(),
      bindings: [
        CameraBinding(),
      ],
    ),
    GetPage(
      name: startScreen,
      page: () => StartScreen(),
      bindings: [
        StartBinding(),
      ],
    ),
    GetPage(
      name: mrzIntroScreen,
      page: () => MrzIntroScreen(),
      bindings: [
        MrzIntroBinding(),
      ],
    ),
    GetPage(
      name: nfcIntroScreen,
      page: () => NfcIntroScreen(),
      bindings: [
        NfcIntroBinding(),
      ],
    ),
    GetPage(
      name: nfcInstructionScreen,
      page: () => NfcInstructionScreen(),
      bindings: [
        NfcInstructionBinding(),
      ],
    ),
    GetPage(
      name: dataScreen,
      page: () => DataScreen(),
      bindings: [
        DataBinding(),
      ],
    ),
    GetPage(
      name: appNavigationScreen,
      page: () => AppNavigationScreen(),
      bindings: [
        AppNavigationBinding(),
      ],
    ),
    GetPage(
      name: initialRoute,
      page: () => DataScreen(),
      bindings: [
        DataBinding(),
      ],
    ),
  ];
}
