import 'package:currency/core/error/failure.dart';
import 'package:currency/core/usecase/base_use_case.dart';
import 'package:currency/modules/currency/data/model/gold_model.dart';
import 'package:currency/modules/currency/domain/repository/base_converter_repository.dart';
import 'package:dartz/dartz.dart';

class GetGoldPriceUseCase extends BaseUseCase<GoldModel, NoParameters> {
  final BaseConverterRepository baseConverterRepository;
  GetGoldPriceUseCase(this.baseConverterRepository);
  @override
  Future<Either<Failure, GoldModel>> call(NoParameters parameters) async {
    return await baseConverterRepository.getGoldPrice();
  }
}
