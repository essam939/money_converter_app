class Currency {
  final num difference;

  Currency({
    required this.difference,
  });

  factory Currency.fromJson({required Map<String, dynamic> data}) {
    return Currency(
      difference: data["conversion_result"]??0,
    );
  }
}

class CurrencyDB {
  final String difference;
  final String id;
  final String date;
  final String amount;
  final String from;
  final String to;

  CurrencyDB({
    required this.difference,
    required this.id,
    required this.date,
    required this.amount,
    required this.from,
    required this.to,
  });

  factory CurrencyDB.fromJSON({required Map<String, dynamic> data}) {
    return CurrencyDB(
      difference: data["difference"],
      date: data["date"],
      id: "${data["id"]}",
      from: data["fromCurrency"],
      to: data["toCurrency"],
      amount: data["amount"],
    );
  }
}
