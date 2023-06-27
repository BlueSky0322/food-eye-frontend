import 'dart:convert';

import 'package:http/http.dart';

import '../utils/constants.dart';

class BarcodeLookupService {
  final client = Client();

  Future<String> lookupProductName({required String code}) async {
    if (code.isEmpty) {
      return "";
    }

    final request =
        "https://product-lookup-by-upc-or-ean.p.rapidapi.com/code/$code";
    final response = await client.get(Uri.parse(request), headers: {
      'X-RapidAPI-Key': rapidApiKey,
      'X-RapidAPI-Host': 'product-lookup-by-upc-or-ean.p.rapidapi.com'
    });

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      final productName = result['product']['name'];
      return productName;
    } else {
      return code;
    }
  }
}
