import 'package:convert_money/currency/currency_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final CurrencyService service = CurrencyService();

  group("CurrencyService", () {
    test("Basic BRL to USD conversion", () async {
      final double result = await service.convert(10, "USD");
      expect(result > 0, true);
    });

    test("Zero value returns zero", () async {
      final double result = await service.convert(0, "USD");
      expect(result, 0);
    });

    test("Invalid currency throws exception.", () async {
      expect(() => service.convert(10, "ABC"), throwsException);
    });

    test("Negative values still convert", () async {
      final double result = await service.convert(-10, "USD");
      expect(result < 0, true);
    });
  });
}