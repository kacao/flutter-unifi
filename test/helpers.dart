import 'dart:io';
import 'package:dotenv/dotenv.dart' show load, env;
import 'package:unifi/unifi.dart' as unifi;

late unifi.Controller controller;

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) =>
              true; // add your localhost detection logic here if you want
  }
}

void start() {
  HttpOverrides.global = new MyHttpOverrides();
  String envFile = "../env/.env.test.local." + (env["SITE"] ?? "");
  load(envFile);
  final host = env['UNIFI_HOST'] ?? "";
  final port = env['UNIFI_PORT'] ?? "";
  final username = env['UNIFI_USERNAME'] ?? "";
  final password = env['UNIFI_PASSWORD'] ?? "";
  final siteId = env['UNIFI_SITE'] ?? "";
  controller = unifi.Controller(
      host: host,
      port: int.parse(port),
      username: username,
      password: password,
      siteId: siteId,
      isUnifiOs: true);
}

Future<void> end() async {
  controller.dispose();
}