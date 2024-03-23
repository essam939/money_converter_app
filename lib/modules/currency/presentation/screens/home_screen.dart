import 'package:cached_network_image/cached_network_image.dart';
import 'package:currency/core/services/services_locator.dart';
import 'package:currency/core/utilis/enums.dart';
import 'package:currency/modules/currency/presentation/controller/currency_bloc.dart';
import 'package:currency/modules/currency/presentation/screens/history_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController amountController = TextEditingController(text: "1");
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  CurrencyData firstCurrency = listCurrency[0];
  CurrencyData secondCurrency = listCurrency[1];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Amount Row
              Row(
                children: [
                  const Text(
                    "Amount",
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Form(
                      key: formKey,
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onSaved: (val) => amountController.text = val!,
                        controller: amountController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Enter Amount",
                          contentPadding: const EdgeInsets.all(15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              // Select Currency
              Row(
                children: [
                  Expanded(
                    child: _buildCurrencyDropdown(firstCurrency, (value) {
                      setState(() {
                        firstCurrency = value!;
                      });
                    }),
                  ),
                  const SizedBox(width: 10),
                  Icon(
                    Icons.arrow_forward,
                    size: 30,
                    color: Theme.of(context).primaryColor.withOpacity(0.9),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildCurrencyDropdown(secondCurrency, (value) {
                      setState(() {
                        secondCurrency = value!;
                      });
                    }),
                  ),
                ],
              ),
              // Future Builder
              BlocBuilder<CurrencyBloc, CurrencyState>(
                bloc: sl<CurrencyBloc>(),
                builder: (context, state) {
                  if (state.getAmountState == RequestState.error) {
                    return const Center(child: Icon(Icons.error));
                  } else if (state.getAmountState == RequestState.loaded) {
                    return Container(
                      height: 100,
                      width: 400,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text(
                          "${state.amountResponse!.difference}",
                          style: const TextStyle(fontSize: 50, color: Colors.white),
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              const SizedBox(height: 20),
              // Convert Button
              _buildButton("Convert", () async {
                sl<CurrencyBloc>().add(GetAmountEvent(
                  from: firstCurrency.name,
                  to: secondCurrency.name,
                  amount: amountController.text,
                ));
              }),
              const SizedBox(height: 15),
              _buildButton("Show History", () async {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const HistoryPage()));
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCurrencyDropdown(CurrencyData currency, void Function(CurrencyData?) onChanged) {
    return DropdownButton<CurrencyData>(
      isExpanded: true,
      value: currency,
      icon: const Icon(Icons.arrow_drop_down_circle_outlined),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: onChanged,
      items: listCurrency.map<DropdownMenuItem<CurrencyData>>((value) {
        return DropdownMenuItem<CurrencyData>(
          value: value,
          child: Row(
            children: [
              CachedNetworkImage(
                imageUrl: value.flag,
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              const SizedBox(width: 5),
              Text(value.name),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildButton(String text, void Function() onPressed) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.all(15),
              textStyle: const TextStyle(fontSize: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: onPressed,
            child: Text(text),
          ),
        ),
      ],
    );
  }
}

class CurrencyData {
  final String name;
  final String flag;

  CurrencyData({required this.name, required this.flag});
}

final List<CurrencyData> listCurrency = <CurrencyData>[
  CurrencyData(name: "USD", flag: "https://flagcdn.com/16x12/us.png"),
  CurrencyData(name: "EGP", flag: "https://flagcdn.com/16x12/eg.png"),
  CurrencyData(name: "KWD", flag: "https://flagcdn.com/16x12/kw.png"),
  CurrencyData(name: "AED", flag: "https://flagcdn.com/16x12/ae.png"),
  CurrencyData(name: "SAR", flag: "https://flagcdn.com/16x12/sa.png"),
];
