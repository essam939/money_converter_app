part of 'currency_bloc.dart';

@immutable
class CurrencyState extends Equatable {
  final RequestState getAmountState;
  final Currency? amountResponse;

  const CurrencyState(
      {this.getAmountState = RequestState.loading, this.amountResponse});

  @override
  List<Object?> get props => [
        getAmountState,
        amountResponse,
      ];
  CurrencyState copyWith(
      {RequestState? getAmountState, Currency? amountResponse}) {
    return CurrencyState(
      getAmountState: getAmountState ?? this.getAmountState,
      amountResponse: amountResponse ?? this.amountResponse,
    );
  }
}
