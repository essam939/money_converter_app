import 'package:currency/modules/currency/presentation/screens/history_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
   HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController amountController = TextEditingController();

   GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
        actions: [
        ],
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
                        onTap: () {
                          // controller.isConvert.value = false;
                          // controller.isPressed.value = false;
                        },
                        onChanged: (val) {
                        //  controller.isPressed.value = false;
                        },
                        // validator: (val) {
                        //   return (val!.isEmpty)
                        //       ? "Please Enter Amount"
                        //       : (val.isNum == false)
                        //       ? "Enter Numeric Value"
                        //       : null;
                        // },
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
                  // currencySelectButton(
                  //   controller: controller,
                  //   isFrom: true,
                  //   context: context,
                  // ),
                  const SizedBox(width: 10),
                  Column(
                    children: [
                      Text(
                        "",
                        style: Theme.of(context).textTheme.titleMedium?.merge(
                          const TextStyle(fontSize: 20),
                        ),
                      ),
                      Icon(
                        Icons.compare_arrows,
                        size: 35,
                        color: Theme.of(context).primaryColor.withOpacity(0.9),
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
                  // currencySelectButton(
                  //   controller: controller,
                  //   isFrom: false,
                  //   context: context,
                  // ),
                ],
              ),
              // Future Builder
              // Obx(
              //       () => (controller.isPressed.value)
              //       ? futureBuilder(context, controller)
              //       : Container(),
              // ),
              const SizedBox(height: 20),
              // Convert Button
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: outLineButtonStyle,
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          //controller.isConvert.value = true;
                        //  controller.convertButtonOnTap();
                        }
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
                      //  controller.isConvert.value = false;
                        Navigator.push(context, MaterialPageRoute(builder: (_)=>HistoryPage()));
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
