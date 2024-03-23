part of 'currency_bloc.dart';

@immutable
class CurrencyState extends Equatable {
  final RequestState getAmountState;
  final RequestState getGoldPriceState;
  final Currency? amountResponse;
  final GoldModel? goldPriceResponse;

  const CurrencyState(
      {this.getAmountState = RequestState.loading,
      this.amountResponse,
      this.getGoldPriceState = RequestState.loading,
      this.goldPriceResponse});

  @override
  List<Object?> get props => [
        getAmountState,
        amountResponse,
        getGoldPriceState,
        goldPriceResponse,
      ];
  CurrencyState copyWith(
      {RequestState? getAmountState,
      Currency? amountResponse,
      RequestState? getGoldPriceState,
      GoldModel? goldPriceResponse}) {
    return CurrencyState(
      getAmountState: getAmountState ?? this.getAmountState,
      amountResponse: amountResponse ?? this.amountResponse,
      getGoldPriceState: getGoldPriceState ?? this.getGoldPriceState,
      goldPriceResponse: goldPriceResponse ?? this.goldPriceResponse,
    );
  }
}
