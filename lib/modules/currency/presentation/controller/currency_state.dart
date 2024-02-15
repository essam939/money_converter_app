part of 'currency_bloc.dart';

class CurrencyState extends Equatable {
  final RequestState getAmountState;
  const CurrencyState({this.getAmountState = RequestState.loading});
  @override
  List<Object?> get props => [getAmountState];
  CurrencyState copyWith({
    RequestState? getAmountState,
  }) {
    return CurrencyState(
      getAmountState: getAmountState ?? this.getAmountState,
    );
  }
}
