import 'package:currency/core/error/failure.dart';
import 'package:currency/modules/currency/data/model/currency_model.dart';
import 'package:currency/modules/currency/data/model/gold_model.dart';
import 'package:currency/modules/currency/domain/usecase/conver_usecase.dart';
import 'package:dartz/dartz.dart';

abstract class BaseConverterRepository {
  Future<Either<Failure, Currency>> getAmount(ConvertParameters parameters);
  Future<Either<Failure, GoldModel>> getGoldPrice();
}
