import 'package:currency/core/services/services_locator.dart';
import 'package:currency/core/utilis/enums.dart';
import 'package:currency/modules/currency/data/model/gold_model.dart';
import 'package:currency/modules/currency/presentation/controller/currency_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'widgets/gold_chart.dart';

class GoldScreen extends StatefulWidget {
  const GoldScreen({super.key});

  @override
  State<GoldScreen> createState() => _GoldScreenState();
}

class _GoldScreenState extends State<GoldScreen> {
  late RefreshController _refreshController;
  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController();
    fetchData();
  }

  fetchData() {
    sl<CurrencyBloc>().add(GetGoldPriceEvent());
    _refreshController.refreshCompleted();
  }

  @override
  void dispose() {
    super.dispose();
    _refreshController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<CurrencyBloc, CurrencyState>(
          bloc: sl<CurrencyBloc>(),
          builder: (context, state) {
            if (state.getGoldPriceState == RequestState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state.getGoldPriceState == RequestState.error) {
              return const Center(
                child: Text("Something went wrong"),
              );
            }
            if (state.getGoldPriceState == RequestState.loaded) {
              var goldModel = state.goldPriceResponse!;
              return SmartRefresher(
                  enablePullUp: false,
                  enablePullDown: true,
                  onRefresh: fetchData,
                  controller: _refreshController,
                  child: ListView(children: [
                    GoldPriceItem(
                      title: "24",
                      price: goldModel.priceGram24k,
                    ),
                    GoldPriceItem(
                      title: "22",
                      price: goldModel.priceGram22k,
                    ),
                    GoldPriceItem(
                      title: "21",
                      price: goldModel.priceGram21k,
                    ),
                    GoldPriceItem(
                      title: "20",
                      price: goldModel.priceGram20k,
                    ),
                    GoldPriceItem(
                      title: "18",
                      price: goldModel.priceGram18k,
                    ),
                    GoldPriceItem(
                      title: "16",
                      price: goldModel.priceGram16k,
                    ),
                    GoldPriceItem(
                      title: "14",
                      price: goldModel.priceGram14k,
                    ),
                    GoldPriceItem(
                      title: "10",
                      price: goldModel.priceGram10k,
                    ),
                  ]));
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}

class GoldPriceItem extends StatelessWidget {
  final String title;
  final double price;
  const GoldPriceItem({super.key, required this.title, required this.price});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey.shade300,),
          borderRadius: BorderRadius.circular(20),
        ),
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network("https://cdn-icons-png.flaticon.com/512/199/199541.png",width: 30,height: 30,),
            const SizedBox(width: 10),
            Text("Gold Type ${title}k",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
          ],
        ),
        trailing: Text("$price EGP",style: TextStyle(color: Colors.green.shade700,fontWeight: FontWeight.bold,fontSize: 14),),
      ),
    );
  }
}
