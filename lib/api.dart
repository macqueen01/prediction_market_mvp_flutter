// Api backend address settings

import 'dart:convert';

import 'package:http/http.dart';
import 'package:perdiction_market_mvp/Entities/PredictionMarketEntities.dart';
import 'package:perdiction_market_mvp/Entities/SnapshotEntity.dart';

class Api {
  static const String url = '';

  static const String browseMarketsUrl = '$url/api/markets/browse';

  Future<List<PredictionMarketMenuEntity>> fetchMarkets() async {
    try {
      final url = Uri.parse(browseMarketsUrl);
      final response = await get(url);

      List<PredictionMarketMenuEntity> markets = [];
      print(jsonDecode(utf8.decode(response.bodyBytes)));
      for (var market in jsonDecode(utf8.decode(response.bodyBytes))) {
        markets.add(PredictionMarketMenuEntity.fromJSON(market));
      }
      return markets;
    } catch (e) {
      print(e);
      return [];
    }
  }

  static const String browseSnapshotsUrl = '$url/api/snapshots';
  /*
  Future<SnapshotsEntity> fetchSnapshots(
      int marketId, String snapshotType) async {
    try {
      Response response = await Dio().get(browseSnapshotsUrl +
          '?market_id=$marketId&snapshot_type=$snapshotType');
      return SnapshotsEntity.fromJSON(response.data);
    } catch (e) {
      print(e);
      return SnapshotsEntity(entirePeriodSnapshots: []);
    }
  }

  static const String buySharesUrl = '$url/api/buy-shares';

  Future<bool> buyShares(int marketId, int amount, int shareType) async {
    try {
      Response response = await Dio().post(buySharesUrl, data: {
        'market_id': marketId,
        'amount': amount,
        'position_index': shareType
      });
      return response.data['success'];
    } catch (e) {
      print(e);
      return false;
    }
  }

  static const String sellSharesUrl = '$url/api/sell-shares';

  Future<bool> sellShares(int marketId, int amount, int shareType) async {
    try {
      Response response = await Dio().post(sellSharesUrl, data: {
        'market_id': marketId,
        'amount': amount,
        'position_index': shareType
      });
      return response.data['success'];
    } catch (e) {
      print(e);
      return false;
    }
  }

  static const String fetchPortfoliosUrl = '$url/api/portfolios';
  */
}
