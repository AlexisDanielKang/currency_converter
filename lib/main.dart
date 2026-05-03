import 'package:flutter/material.dart';
import 'currency/currency_service.dart';
import 'currency/currency_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ConverterPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ConverterPage extends StatefulWidget {
  const ConverterPage({super.key});

  @override
  State<ConverterPage> createState() => _ConverterPageState();
}

class _ConverterPageState extends State<ConverterPage> {
  final TextEditingController controllerText = TextEditingController();

  final CurrencyController controller =
  CurrencyController(CurrencyService());

  String currency = "USD";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Currency converter"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controllerText,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Value in BRL",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            DropdownButton<String>(
              value: currency,
              isExpanded: true,
              items: ["USD", "EUR"]
                  .map((String e) => DropdownMenuItem<String>(
                value: e,
                child: Text(e),
              ))
                  .toList(),
              onChanged: (String? value) {
                setState(() {
                  currency = value!;
                });
              },
            ),

            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: () async {
                setState(() {}); // mostra loading

                await controller.convert(
                  controllerText.text,
                  currency,
                );

                setState(() {});
              },
              child: const Text("Convert"),
            ),

            const SizedBox(height: 20),

            if (controller.isLoading)
              const Center(child: CircularProgressIndicator()),

            const SizedBox(height: 20),

            Text(
              "Result: ${controller.result}",
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}