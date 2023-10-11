class SinglePortfolioEntity {
  late int portfolioId;
  late int marketId;
  late String marketTitle;
  late String marketImage;
  late double currentPrice;
  late double averagePurchasePrice;
  late double numberOfShares;
  // late String shareType;
  late int shareTypeInt;
  late double netBenefitInPercent;
  late double netBenefit;
  late double maxFutureResolveValuePerShare;
  late double minFutureResolveValuePerShare;
  late double currentProbability;

  SinglePortfolioEntity({
    required this.portfolioId,
    required this.marketId,
    required this.marketTitle,
    required this.marketImage,
    required this.currentPrice,
    required this.averagePurchasePrice,
    required this.numberOfShares,
    // required this.shareType,
    required this.shareTypeInt,
    required this.netBenefitInPercent,
    required this.netBenefit,
    required this.maxFutureResolveValuePerShare,
    required this.minFutureResolveValuePerShare,
    required this.currentProbability,
  });

  SinglePortfolioEntity.fromJSON(Map<String, dynamic> json) {
    portfolioId = json['id'];
    marketId = json['market_id'];
    marketTitle = json['market_title'];
    marketImage = json['market_image'];
    currentProbability = json['probability_of_share_type'];
    currentPrice = json['current_price'];
    averagePurchasePrice = json['average_purchase_price'];
    numberOfShares = json['num_shares'];
    // shareType = json['share_type'];
    shareTypeInt = json['position_index'];
    maxFutureResolveValuePerShare = json['max_future_resolve_value_per_share'];
    minFutureResolveValuePerShare = json['min_future_resolve_value_per_share'];

    netBenefit = currentPrice - averagePurchasePrice;
    netBenefitInPercent = double.parse(
        (((currentPrice - averagePurchasePrice) / averagePurchasePrice) * 100)
            .toStringAsFixed(2));
  }
}

class PortfoliosEntity {
  // portfolioByMarketId should look like
  // {
  //   0: {
  //     0: SinglePortfolioEntity,
  //     1: SinglePortfolioEntity,
  //     2: SinglePortfolioEntity,
  //   },
  //   1: {
  //     0: SinglePortfolioEntity,
  //     1: SinglePortfolioEntity, ...
  //   } ...
  // }

  Map<int, Map<int, SinglePortfolioEntity>> portfoliosByMarketId = {};
  double usableCash = 0;

  PortfoliosEntity({this.portfoliosByMarketId = const {}, this.usableCash = 0});

  PortfoliosEntity.fromJSON(Map<String, dynamic> json) {
    Map<int, Map<int, SinglePortfolioEntity>> portfolios = {};
    json['portfolios'].forEach((key, value) {
      Map<int, SinglePortfolioEntity> sub_portfolios = {};
      value.forEach((sub_key, sub_value) {
        sub_portfolios[sub_key] = SinglePortfolioEntity.fromJSON(sub_value);
      });
      portfolios[int.parse(key)] = sub_portfolios;
    });

    this.portfoliosByMarketId = portfolios;
    this.usableCash = json['usable_cash'];
  }

  double getTotalNetBenefit() {
    if (portfoliosByMarketId.length == 0) {
      return 0;
    }

    double totalNetBenefit = 0;

    portfoliosByMarketId.forEach((key, value) {
      value.forEach((sub_key, sub_value) {
        totalNetBenefit += sub_value.netBenefit;
      });
    });

    return totalNetBenefit;
  }

  double getTotalNetBenefitInPercent() {
    return double.parse(((getTotalNetBenefit() / getTotalInvestment()) * 100)
        .toStringAsFixed(2));
  }

  double getTotalInvestment() {
    if (portfoliosByMarketId.length == 0) {
      return 0;
    }

    double totalInvestment = 0;

    portfoliosByMarketId.forEach((key, value) {
      value.forEach((sub_key, sub_value) {
        totalInvestment += sub_value.averagePurchasePrice;
      });
    });

    return totalInvestment;
  }

  double getEntireAssetValue() {
    return this.usableCash + getTotalInvestment() + getTotalNetBenefit();
  }
}

SinglePortfolioEntity getSinglePortfolioTest() {
  return SinglePortfolioEntity(
    portfolioId: 0,
    marketId: 0,
    marketTitle: '2024년 대한민국 제 22대 총선에서 다수당이 될 정당은 민주당인가?',
    marketImage: 'https://picsum.photos/250?image=9',
    currentPrice: 12345,
    averagePurchasePrice: 12345,
    numberOfShares: 12345,
    // shareType: 'positive',
    shareTypeInt: 0,
    netBenefit: -12234,
    netBenefitInPercent: -12.3,
    maxFutureResolveValuePerShare: 1000,
    minFutureResolveValuePerShare: 0,
    currentProbability: 0.5,
  );
}

PortfoliosEntity getPortfoliosTest() {
  return PortfoliosEntity(portfoliosByMarketId: {
    0: {
      0: getSinglePortfolioTest(),
      1: getSinglePortfolioTest(),
      2: getSinglePortfolioTest(),
    },
    1: {
      0: getSinglePortfolioTest(),
      1: getSinglePortfolioTest(),
      2: getSinglePortfolioTest(),
    },
    2: {
      0: getSinglePortfolioTest(),
      1: getSinglePortfolioTest(),
      2: getSinglePortfolioTest(),
    },
  });
}
