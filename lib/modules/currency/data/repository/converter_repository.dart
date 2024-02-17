import 'package:currency/core/error/exceptions.dart';
import 'package:currency/core/error/failure.dart';
import 'package:currency/modules/currency/data/datasource/converter_remote_data_source.dart';
import 'package:currency/modules/currency/data/model/currency_model.dart';
import 'package:currency/modules/currency/domain/repository/base_converter_repository.dart';
import 'package:currency/modules/currency/domain/usecase/conver_usecase.dart';
import 'package:dartz/dartz.dart';

class ConverterRepository extends BaseConverterRepository {
  final BaseConverterRemoteDataSource baseConverterRemoteDataSource;
  ConverterRepository(this.baseConverterRemoteDataSource);
  @override
  Future<Either<Failure, Currency>> getAmount(
      ConvertParameters parameters) async {
    final result = await baseConverterRemoteDataSource.getAmount(parameters);
    try {
      return Right(result);
    } on ServerExceptions catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }
}
