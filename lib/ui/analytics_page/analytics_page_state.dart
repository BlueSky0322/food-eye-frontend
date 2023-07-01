import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../utils/http_utils.dart';

class AnalyticsPageState extends ChangeNotifier {
  final BuildContext context;

  AnalyticsPageState(this.context);

  final client = Client();

  Future<void> fetchWeatherForecast() async {
    print("enter method");
    const request = "${emulatorURL}/WeatherForecast";

    final response = await client.get(Uri.parse(request));
    print("After resposne object");
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      print("[DEBUG]" + result.toString());
      return result;
    } else {
      print('API call failed with status code: ${response.statusCode}');
    }
  }
}
