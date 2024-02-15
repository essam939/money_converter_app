part of 'currency_bloc.dart';

@immutable
abstract class CurrencyEvent extends Equatable{
  const CurrencyEvent();
  @override
  List<Object> get props => [];
}
class GetAmountEvent extends CurrencyEvent{
final  String from;
final String to;
final String amount;
  const GetAmountEvent({required this.from,required this.to,required this.amount});
  @override
  List<Object> get props => [from,to,amount];
}
