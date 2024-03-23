import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:currency/core/usecase/base_use_case.dart';
import 'package:currency/core/utilis/db_helpet.dart';
import 'package:currency/core/utilis/enums.dart';
import 'package:currency/modules/currency/data/model/currency_model.dart';
import 'package:currency/modules/currency/data/model/gold_model.dart';
import 'package:currency/modules/currency/domain/usecase/conver_usecase.dart';
import 'package:currency/modules/currency/domain/usecase/get_gold_price_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'currency_event.dart';
part 'currency_state.dart';

class CurrencyBloc extends Bloc<CurrencyEvent, CurrencyState> {
  ConvertUseCase convertUseCase;
  GetGoldPriceUseCase getGoldPriceUseCase;
  CurrencyBloc(this.convertUseCase, this.getGoldPriceUseCase)
      : super(CurrencyState()) {
    on<GetAmountEvent>(_geConvert);
    on<GetGoldPriceEvent>(_getGoldPrice);
  }

  FutureOr<void> _geConvert(
      GetAmountEvent event, Emitter<CurrencyState> emit) async {
    final result = await convertUseCase(ConvertParameters(
        from: event.from, to: event.to, amount: event.amount));
    result.fold((l) => emit(state.copyWith(getAmountState: RequestState.error)),
        (r) {
      DBHelper.dbHelper.insertRecord(
        from: event.from,
        to: event.to,
        date: "convert",
        amount: event.amount,
        difference: r.difference.toStringAsFixed(2),
      );
      emit(state.copyWith(
          getAmountState: RequestState.loaded, amountResponse: r));
    });
  }

  FutureOr<void> _getGoldPrice(
      GetGoldPriceEvent event, Emitter<CurrencyState> emit) async {
    final result = await getGoldPriceUseCase(const NoParameters());
    result.fold(
        (l) => emit(state.copyWith(getGoldPriceState: RequestState.error)),
        (r) {
      emit(state.copyWith(
          getGoldPriceState: RequestState.loaded, goldPriceResponse: r));
    });
  }
}
