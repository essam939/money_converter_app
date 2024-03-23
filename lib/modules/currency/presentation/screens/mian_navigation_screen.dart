import 'package:currency/modules/currency/presentation/screens/gold_screen.dart';
import 'package:currency/modules/currency/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';

class MainNavigationScreen extends StatelessWidget {
  const MainNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
    child: Scaffold(
      appBar: AppBar(
        title: const Text('Currency Converter App'),
        centerTitle: true,
        bottom: const TabBar(
          tabs: [
            Tab(
             text: 'Currencies',
            ),
            Tab(
              text: 'Gold Price',
            ),
          ]
        ),
      ),
      body: const TabBarView(
        children: [
          HomeScreen(),
          GoldScreen(),
        ]
      )
    ));
  }
}
