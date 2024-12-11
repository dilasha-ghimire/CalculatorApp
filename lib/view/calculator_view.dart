import 'package:flutter/material.dart';

class CalculatorView extends StatefulWidget {
  const CalculatorView({super.key});

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  List<String> calculatorSymbolList = [
    "C",
    "*",
    "/",
    "←",
    "1",
    "2",
    "3",
    "+",
    "4",
    "5",
    "6",
    "-",
    "7",
    "8",
    "9",
    "*",
    "%",
    "0",
    ".",
    "="
  ];

  final _inputController = TextEditingController();
  final key = GlobalKey<FormState>();

  double first = 0;
  double second = 0;
  String operation = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 50,
        centerTitle: true,
        title: const Text("Calculator App"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: key,
          child: Column(
            children: [
              TextFormField(
                controller: _inputController,
                textDirection: TextDirection.rtl,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 55.0),
                ),
                style: const TextStyle(fontSize: 72),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: calculatorSymbolList.length,
                  itemBuilder: (context, index) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 198, 212, 166),
                        foregroundColor: const Color.fromARGB(255, 132, 66, 66),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          String symbol = calculatorSymbolList[index];

                          if (symbol == "C") {
                            _inputController.text = "";
                            first = 0;
                            second = 0;
                            operation = "";
                          } else if (symbol == "←") {
                            if (_inputController.text.isNotEmpty) {
                              _inputController.text = _inputController.text
                                  .substring(
                                      0, _inputController.text.length - 1);
                            }
                          } else if (symbol == "=") {
                            try {
                              second = double.parse(_inputController.text);
                              if (operation == "+") {
                                _inputController.text =
                                    (first + second).toString();
                              } else if (operation == "-") {
                                _inputController.text =
                                    (first - second).toString();
                              } else if (operation == "*") {
                                _inputController.text =
                                    (first * second).toString();
                              } else if (operation == "/") {
                                if (second != 0) {
                                  _inputController.text =
                                      (first / second).toStringAsFixed(2);
                                } else {
                                  _inputController.text = "Error";
                                }
                              }
                              first = 0;
                              second = 0;
                              operation = "";
                            } catch (e) {
                              _inputController.text = "Error";
                            }
                          } else if (symbol == "%") {
                            try {
                              second = double.parse(_inputController.text);
                              _inputController.text =
                                  (first * (second / 100)).toString();
                            } catch (e) {
                              _inputController.text = "Error";
                            }
                          } else if ("+-*/".contains(symbol)) {
                            first = double.tryParse(_inputController.text) ?? 0;
                            operation = symbol;
                            _inputController.text = "";
                          } else {
                            _inputController.text += symbol;
                          }
                        });
                      },
                      child: Text(
                        calculatorSymbolList[index],
                        style: const TextStyle(fontSize: 40),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
