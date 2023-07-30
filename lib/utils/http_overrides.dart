import 'dart:io';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

const emulatorURL = "https://10.0.2.2:44317";
// const usbDebugURL = "https://192.168.1.100:45455";
const usbDebugURL = "https://bigsagemouse80.conveyor.cloud";
