part of 'currency_bloc.dart';

@immutable
abstract class CurrencyEvent {}

class GetAmountEvent extends CurrencyEvent {
  final String from;
  final String to;
  final String amount;
  GetAmountEvent({required this.from, required this.to, required this.amount});
}
