import 'package:currency/core/error/exceptions.dart';
import 'package:currency/core/network/api_constance.dart';
import 'package:currency/core/network/error_message_model.dart';
import 'package:currency/modules/currency/data/model/currency_model.dart';
import 'package:currency/modules/currency/domain/usecase/conver_usecase.dart';
import 'package:dio/dio.dart';

abstract class BaseConverterRemoteDataSource {
  Future<Currency> getAmount(ConvertParameters parameters);
}

class ConverterRemoteDataSource extends BaseConverterRemoteDataSource {
  @override
  Future<Currency> getAmount(ConvertParameters parameters) async {
    final response = await Dio().get(ApiConstance.baseUrl, queryParameters: {
      "from": parameters.from,
      "to": parameters.to,
      "amount": parameters.amount,
      "access_key": ApiConstance.apiKey
    });
    if (response.statusCode == 200) {
      return Currency.fromJson(data: response.data);
    } else {
      throw ServerExceptions(
          errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }
}
