import 'package:convert_money/currency/currency_controller.dart';
import 'package:convert_money/currency/currency_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("CurrencyController", () {
    test("Conversion updates result", () async {
      final CurrencyController controller =
      CurrencyController(CurrencyService());

      await controller.convert("10", "USD");

      expect(controller.result.isNotEmpty, true);
    });

    test("Invalid input returns an error.", () async {
      final CurrencyController controller =
      CurrencyController(CurrencyService());

      await controller.convert("abc", "USD");

      expect(controller.result, "Error");
    });

    test("Loading status works", () async {
      final CurrencyController controller =
      CurrencyController(CurrencyService());

      final Future<void> future = controller.convert("10", "USD");

      expect(controller.isLoading, true);

      await future;

      expect(controller.isLoading, false);
    });
  });
}