import 'currency_service.dart';

class CurrencyController {
  final CurrencyService service;

  CurrencyController(this.service);

  String result = "";
  bool isLoading = false;

  Future<void> convert(String input, String currency) async {
    isLoading = true;

    try {
      final double value = double.parse(input);
      final double converted = await service.convert(value, currency);

      result = converted.toStringAsFixed(2);
    } catch (e) {
      result = "Error";
    }

    isLoading = false;
  }
}