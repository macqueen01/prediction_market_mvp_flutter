class PredictionMarketMenuEntity {
  int marketId;
  String title;
  String description;
  String image;
  DateTime startTime;
  DateTime endTime;
  bool is_resolved;

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
    positiveProbability =
        positiveShares / (positiveShares + negativeShares);
    negativeProbability =
        negativeShares / (positiveShares + negativeShares);

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
