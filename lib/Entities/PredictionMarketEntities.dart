class PredictionMarketMenuEntity {
  late int marketId;
  late String title;
  late String description;
  late String image;
  late DateTime startTime;
  late DateTime endTime;
  late bool is_resolved;

  PoolStateEntity? poolState;

  PredictionMarketMenuEntity({
    required this.marketId,
    required this.title,
    required this.description,
    required this.image,
    required this.startTime,
    required this.endTime,
    required this.is_resolved,
    this.poolState,
  });

  PredictionMarketMenuEntity.fromJSON(Map<String, dynamic> json) {
    marketId = json['id'];
    title = json['title'];
    description = json['description'];
    image = json['thumbnail'] != null
        ? json['thumbnail']
        : 'https://mockingjae-test-bucket.s3.amazonaws.com/assets/splash_logo.png';
    startTime = DateTime.parse(json['start_date']);
    endTime = DateTime.parse(json['end_date']);
    is_resolved = json['is_resolved'];
    poolState = PoolStateEntity(
        marketId: marketId,
        positiveShares: json['pool_state']['positive_shares'],
        negativeShares: json['pool_state']['negative_shares'],
        positiveSharesAtLastUpdate: json['past_pool_state']['positive_shares'],
        negativeSharesAtLastUpdate: json['past_pool_state']['negative_shares']);
  }
}

class PoolStateEntity {
  int marketId;
  double positiveShares;
  double negativeShares;

  late double positiveProbability;
  late double negativeProbability;

  double positiveSharesAtLastUpdate;
  double negativeSharesAtLastUpdate;

  late double recentPositiveProbabilityChange;
  late double recentNegativeProbabilityChange;

  PoolStateEntity({
    required this.marketId,
    required this.positiveShares,
    required this.negativeShares,
    required this.positiveSharesAtLastUpdate,
    required this.negativeSharesAtLastUpdate,
  }) {
    positiveProbability = positiveShares / (positiveShares + negativeShares);
    negativeProbability = negativeShares / (positiveShares + negativeShares);

    double lastPositiveProbability = positiveSharesAtLastUpdate /
        (positiveSharesAtLastUpdate + negativeSharesAtLastUpdate);
    double lastNegativeProbability = negativeSharesAtLastUpdate /
        (positiveSharesAtLastUpdate + negativeSharesAtLastUpdate);

    recentPositiveProbabilityChange =
        positiveProbability - lastPositiveProbability;

    recentNegativeProbabilityChange =
        negativeProbability - lastNegativeProbability;
  }
}
