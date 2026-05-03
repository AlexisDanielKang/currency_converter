import 'package:flutter/material.dart';
import 'currency/currency_service.dart';
import 'currency/currency_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ConverterPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ConverterPage extends StatefulWidget {
  @override
  _ConverterPageState createState() => _ConverterPageState();
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
        title: Text("Currency converter"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controllerText,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Value in BRL",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 16),

            DropdownButton<String>(
              value: currency,
              isExpanded: true,
              items: ["USD", "EUR"]
                  .map((e) => DropdownMenuItem(
                value: e,
                child: Text(e),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  currency = value!;
                });
              },
            ),

            SizedBox(height: 16),

            ElevatedButton(
              onPressed: () async {
                await controller.convert(
                  controllerText.text,
                  currency,
                );

                setState(() {});
              },
              child: Text("Convert"),
            ),

            SizedBox(height: 20),

            if (controller.isLoading)
              CircularProgressIndicator(),

            SizedBox(height: 20),

            Text(
              "Result: ${controller.result}",
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}