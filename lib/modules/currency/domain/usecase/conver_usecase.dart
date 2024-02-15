import 'package:currency/core/error/failure.dart';
import 'package:currency/core/usecase/base_use_case.dart';
import 'package:currency/modules/currency/data/model/currency_model.dart';
import 'package:currency/modules/currency/domain/repository/base_converter_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class ConvertUseCase extends BaseUseCase<Currency,ConvertParameters>{
  final BaseConverterRepository baseConverterRepository;
  ConvertUseCase(this.baseConverterRepository);
  @override
  Future<Either<Failure, Currency>> call(ConvertParameters parameters) async {
    return await baseConverterRepository.getAmount(parameters);
  }

}
class ConvertParameters extends Equatable {
  final int from;
  final int to;
  final int amount;

  const ConvertParameters({required this.from,required this.to,required this.amount});

  @override
  List<Object?> get props => [from,to,amount];
}