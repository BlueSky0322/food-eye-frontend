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
// const apiURL = "https://192.168.1.110:45455";
const apiURL = "http://foodeyeapiv2-1.us-east-1.elasticbeanstalk.com";
// const apiURL = "https://bigsagemouse80.conveyor.cloud";
