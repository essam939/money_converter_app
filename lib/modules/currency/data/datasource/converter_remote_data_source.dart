import 'package:currency/core/error/exceptions.dart';
import 'package:currency/core/network/api_constance.dart';
import 'package:currency/core/network/error_message_model.dart';
import 'package:currency/modules/currency/data/model/currency_model.dart';
import 'package:currency/modules/currency/data/model/gold_model.dart';
import 'package:currency/modules/currency/domain/usecase/conver_usecase.dart';
import 'package:dio/dio.dart';

abstract class BaseConverterRemoteDataSource {
  Future<Currency> getAmount(ConvertParameters parameters);
  Future<GoldModel> getGoldPrice();
}

class ConverterRemoteDataSource extends BaseConverterRemoteDataSource {
  @override
  Future<Currency> getAmount(ConvertParameters parameters) async {
    final response = await Dio().get(
        "https://v6.exchangerate-api.com/v6/${ApiConstance.apiKey}${ApiConstance.compare}${parameters.from}/${parameters.to}/${parameters.amount}");
    if (response.statusCode == 200) {
      return Currency.fromJson(data: response.data);
    } else {
      throw ServerExceptions(
          errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<GoldModel> getGoldPrice() async {
    final response = await Dio().get(ApiConstance.getGoldPrice,
        options: Options(headers: {
          "x-access-token": ApiConstance.goldToken,
        }));
    if (response.statusCode == 200) {
      return GoldModel.fromJson(data: response.data);
    } else {
      throw ServerExceptions(
          errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }
}
