
# eKYC with NFC (Base on ReadID Ready - epassportnfc plugin)

### Author

Group 13<br>
Pham Phung Gia khiem - 20521459 - 2052159@gm.uit.edu.vn<br>
Lu Dinh Long - 20521565 - 20521565@gm.uit.edu.vn

### Project Name

eKYC with NFC

### System requirements

Dart SDK Version 2.18.0 or greater.<br>
Flutter SDK Version 3.3.0 or greater.

### To run project

Run command "flutter pub get" to import all the packages in pubspec.yaml<br>
Run command "flutter run" in terminal at path on file source of project to run project

### Check the UI of the entire app

Check the UI of all the app screens from a single place by setting up the 'initialRoute'  to AppNavigation in the AppRoutes.dart file.

### Application structure

```
.
├── android                         - It contains files required to run the application on an Android platform.
├── assets                          - It contains all images and fonts of your application.
├── ios                             - It contains files required to run the application on an iOS platform.
├── lib                             - Most important folder in the application, used to write most of the Dart code..
    ├── main.dart                   - Starting point of the application
    ├── core
    │   ├── app_export.dart         - It contains commonly used file imports
    │   ├── constants               - It contains all constants classes
    │   ├── errors                  - It contains error handling classes                  
    │   ├── network                 - It contains network-related classes
    │   └── utils                   - It contains common files and utilities of the application
    ├── data
    │   ├── apiClient               - It contains API calling methods 
    │   ├── models                  - It contains request/response models 
    │   └── repository              - Network repository
    ├── localization                - It contains localization classes
    ├── presentation                - It contains widgets of the screens with their controllers and the models of the whole application.
    ├── routes                      - It contains all the routes of the application
    └── theme                       - It contains app theme and decoration classes
    └── widgets                     - It contains all custom widget classes
```

### Libraries and tools used

- get - State management
  https://pub.dev/packages/get
- connectivity_plus - For status of network connectivity
  https://pub.dev/packages/connectivity_plus
- shared_preferences - Provide persistent storage for simple data
  https://pub.dev/packages/shared_preferences
- cached_network_image - For storing internet image into cache
  https://pub.dev/packages/cached_network_image
- epassportnfc - Provides information about NFC
  https://pub.dev/packages/epassportnfc
- ReadID Me - Provides information about NFC
  https://play.google.com/store/apps/details?id=nl.innovalor.nfciddocshowcase&hl=vi&gl=US

### Github link
https://github.com/KhiemPham1702/Seminar_project
