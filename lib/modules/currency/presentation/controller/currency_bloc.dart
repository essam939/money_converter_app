import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:currency/core/utilis/enums.dart';
import 'package:currency/modules/currency/domain/usecase/conver_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'currency_event.dart';
part 'currency_state.dart';

class CurrencyBloc extends Bloc<CurrencyEvent, CurrencyState> {
  ConvertUseCase convertUseCase;
  CurrencyBloc(this.convertUseCase) : super(CurrencyState()) {
    on<GetAmountEvent>(_geConvert);
  }

  FutureOr<void> _geConvert(
      GetAmountEvent event, Emitter<CurrencyState> emit) async {
    final result = await convertUseCase(ConvertParameters(
        from: int.parse(event.from),
        to: int.parse(event.to),
        amount: int.parse(event.amount)));
    result.fold((l) => emit(state.copyWith(getAmountState: RequestState.error)),
        (r) => emit(state.copyWith(getAmountState: RequestState.loaded)));
  }
}
