import 'package:cached_network_image/cached_network_image.dart';
import 'package:currency/core/services/services_locator.dart';
import 'package:currency/core/utilis/enums.dart';
import 'package:currency/modules/currency/presentation/controller/currency_bloc.dart';
import 'package:currency/modules/currency/presentation/screens/history_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<CurrencyData> listCurrency = <CurrencyData>[
  CurrencyData(name: "USD", flag: "https://flagcdn.com/16x12/us.png"),
  CurrencyData(name: "AED", flag: "https://flagcdn.com/16x12/ua.png"),
  CurrencyData(name: "EGP", flag: "https://flagcdn.com/16x12/eg.png"),
  CurrencyData(name: "SAR", flag: "https://flagcdn.com/16x12/sr.png"),
];

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController amountController = TextEditingController(text: "1");

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  CurrencyData firstCurrency = listCurrency.first;
  CurrencyData secondCurrency = listCurrency[1];
  @override
  Widget build(BuildContext context) {
    ButtonStyle outLineButtonStyle = OutlinedButton.styleFrom(
      padding: const EdgeInsets.all(15),
      textStyle: Theme.of(context)
          .textTheme
          .titleMedium
          ?.merge(const TextStyle(fontSize: 18)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Currency Convertor"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Amount Row
              Row(
                children: [
                  Text(
                    "Amount",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.merge(const TextStyle(fontSize: 20)),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Form(
                      key: formKey,
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onSaved: (val) {
                          amountController.text = val!;
                        },
                        controller: amountController,
                        style: Theme.of(context).textTheme.titleLarge?.merge(
                              const TextStyle(fontSize: 18),
                            ),
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
                      child: DropdownButton<CurrencyData>(
                    isExpanded: true,
                    value: firstCurrency,
                    icon: const Icon(Icons.arrow_drop_down_circle_outlined),
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (CurrencyData? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        firstCurrency = value!;
                      });
                    },
                    items: listCurrency.map<DropdownMenuItem<CurrencyData>>((CurrencyData value) {
                      return DropdownMenuItem<CurrencyData>(
                        value: value,
                        child: Row(
                          children: [
                            CachedNetworkImage(
                              imageUrl: value.flag,
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                           const SizedBox(width: 5,),
                            Text(value.name)
                          ],
                        ),
                      );
                    }).toList(),
                  )),
                  const SizedBox(width: 10),
                  Column(
                    children: [
                      Icon(
                        Icons.compare_arrows,
                        size: 35,
                        color: Theme.of(context).primaryColor.withOpacity(0.9),
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                      child: DropdownButton<CurrencyData>(
                    isExpanded: true,
                    value: secondCurrency,
                    icon: const Icon(Icons.arrow_drop_down_circle_outlined),
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (CurrencyData? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        secondCurrency = value!;
                      });
                    },
                    items: listCurrency.map<DropdownMenuItem<CurrencyData>>((CurrencyData value) {
                      return DropdownMenuItem<CurrencyData>(
                        value: value,
                        child: Row(
                          children: [
                            CachedNetworkImage(
                              imageUrl: value.flag,
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(value.name)
                          ],
                        ),
                      );
                    }).toList(),
                  ))
                ],
              ),
              // Future Builder
              BlocBuilder<CurrencyBloc, CurrencyState>(
                bloc: sl<CurrencyBloc>(),
                builder: (context, state) {
                  if (state.getAmountState == RequestState.error) {
                    return Center(
                      child: Icon(Icons.error),
                    );
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
                          style: TextStyle(fontSize: 50, color: Colors.white),
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
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: outLineButtonStyle,
                      onPressed: () async {
                        sl<CurrencyBloc>().add(GetAmountEvent(
                            from: firstCurrency.name,
                            to: secondCurrency.name,
                            amount: amountController.text));
                      },
                      child: const Text("Convert"),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: outLineButtonStyle,
                      onPressed: () async {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => HistoryPage()));
                      },
                      child: const Text("Show History"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CurrencyData {
  String name;
  String flag;
  CurrencyData({required this.name, required this.flag});
}
