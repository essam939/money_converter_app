import 'package:currency/modules/currency/data/datasource/converter_remote_data_source.dart';
import 'package:currency/modules/currency/data/repository/converter_repository.dart';
import 'package:currency/modules/currency/domain/repository/base_converter_repository.dart';
import 'package:currency/modules/currency/domain/usecase/conver_usecase.dart';
import 'package:currency/modules/currency/domain/usecase/get_gold_price_usecase.dart';
import 'package:currency/modules/currency/presentation/controller/currency_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

class ServicesLocator {
  void init() {
    // bloc
    sl.registerLazySingleton(() => CurrencyBloc(sl(),sl()));
    // use cases
    sl.registerLazySingleton(() => ConvertUseCase(sl()));
    sl.registerLazySingleton(() => GetGoldPriceUseCase(sl()));
    // Repository
    sl.registerLazySingleton<BaseConverterRepository>(
        () => ConverterRepository(sl()));
    // data source
    sl.registerLazySingleton<BaseConverterRemoteDataSource>(
        () => ConverterRemoteDataSource());
  }
}
