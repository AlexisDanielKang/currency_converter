import 'dart:convert';
import 'package:http/http.dart' as http;

class CurrencyService {
  Future<double> convert(double value, String toCurrency) async {
    final url = Uri.parse("https://api.exchangerate-api.com/v4/latest/BRL");

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception("Error searching for a quote.");
    }

    final data = jsonDecode(response.body);

    final rate = data["rates"][toCurrency];

    if (rate == null) {
      throw Exception("Invalid money");
    }

    return value * rate;
  }
}