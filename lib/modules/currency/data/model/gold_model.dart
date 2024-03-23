class GoldModel {
  final int timestamp;
  final String metal;
  final String currency;
  final String exchange;
  final String symbol;
  final int openTime;
  final double price;
  final double ch;
  final double ask;
  final double bid;
  final double priceGram24k;
  final double priceGram22k;
  final double priceGram21k;
  final double priceGram20k;
  final double priceGram18k;
  final double priceGram16k;
  final double priceGram14k;
  final double priceGram10k;

  GoldModel(
      {required this.timestamp,
      required this.metal,
      required this.currency,
      required this.exchange,
      required this.symbol,
      required this.openTime,
      required this.price,
      required this.ch,
      required this.ask,
      required this.bid,
      required this.priceGram24k,
      required this.priceGram22k,
      required this.priceGram21k,
      required this.priceGram20k,
      required this.priceGram18k,
      required this.priceGram16k,
      required this.priceGram14k,
      required this.priceGram10k});
  factory GoldModel.fromJson({required Map<String, dynamic> data}) {
    return GoldModel(
      timestamp: data['timestamp'],
      metal: data['metal'],
      currency: data['currency'],
      exchange: data['exchange'],
      symbol: data['symbol'],
      openTime: data['open_time'],
      price: data['price'],
      ch: data['ch'],
      ask: data['ask'],
      bid: data['bid'],
      priceGram24k: data['price_gram_24k'],
      priceGram22k: data['price_gram_22k'],
      priceGram21k: data['price_gram_21k'],
      priceGram20k: data['price_gram_20k'],
      priceGram18k: data['price_gram_18k'],
      priceGram16k: data['price_gram_16k'],
      priceGram14k: data['price_gram_14k'],
      priceGram10k: data['price_gram_10k'],
    );
  }
}
