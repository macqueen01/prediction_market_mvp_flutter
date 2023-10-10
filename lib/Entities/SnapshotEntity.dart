import 'dart:math';

class SingleSnapshotEntity {
  double timestamp;
  double positiveProbability;
  double negativeProbability;

  SingleSnapshotEntity({
    required this.timestamp,
    required this.positiveProbability,
    required this.negativeProbability,
  });
}

List<SingleSnapshotEntity> getEntirePeriodSnapshotsTest() {
  List<SingleSnapshotEntity> entirePeriodSnapshots = [];

  for (int i = 0; i < 60; i++) {
    entirePeriodSnapshots.add(SingleSnapshotEntity(
        timestamp: DateTime.now().millisecondsSinceEpoch / 1000 + 5 * i,
        positiveProbability: Random().nextDouble(),
        negativeProbability: 1 - Random().nextDouble()));
  }
  return entirePeriodSnapshots;
}

SnapshotsEntity getSnapshotsTest() {
  return SnapshotsEntity(entirePeriodSnapshots: getEntirePeriodSnapshotsTest());
}

class SnapshotsEntity {
  String type = 'entirePeriod';

  List<SingleSnapshotEntity> entirePeriodSnapshots = [];
  double? oldestTimestamp;
  double? latestTimestamp;

  get duration => oldestTimestamp! - latestTimestamp!;

  SnapshotsEntity({
    required this.entirePeriodSnapshots,
  }) {
    entirePeriodSnapshots.sort((a, b) => a.timestamp.compareTo(b.timestamp));
    latestTimestamp = entirePeriodSnapshots.last.timestamp;
    oldestTimestamp = entirePeriodSnapshots.first.timestamp;
  }

  SnapshotsEntity.fromJSON(Map<String, dynamic> json) {
    type = json['snapshot_type'];

    if (type == 'entire_period') {
      entirePeriodSnapshots = [];
      json['oldest_timestamp'] != null
          ? oldestTimestamp = json['oldest_timestamp']
          : oldestTimestamp = null;
      json['latest_timestamp'] != null
          ? latestTimestamp = json['latest_timestamp']
          : latestTimestamp = null;
      json['entirePeriodSnapshots'].forEach((snapshot) {
        entirePeriodSnapshots.add(SingleSnapshotEntity(
            timestamp: snapshot['timestamp'],
            positiveProbability: snapshot['positive_probability'],
            negativeProbability: snapshot['negative_probability']));
      });
    }
  }
}

DateTime secondTimestampToDatetime(double timestamp) {
  return DateTime.fromMillisecondsSinceEpoch((timestamp * 1000).round());
}

Duration secondMillisecondToDuration(double timestamp) {
  return Duration(milliseconds: (timestamp * 1000).round());
}
