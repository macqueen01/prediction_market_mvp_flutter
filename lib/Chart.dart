import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:perdiction_market_mvp/Entities/SnapshotEntity.dart';


class DateChartView extends StatefulWidget {
  final SnapshotsEntity snapshots;
  const DateChartView({super.key, required this.snapshots});

  @override
  State<DateChartView> createState() => _ChartViewState();
}

class _ChartViewState extends State<DateChartView> {
  List<List<FlSpot>> SpottingTranslator(SnapshotsEntity snapshots) {
    List<FlSpot> positiveSpots = [];
    List<FlSpot> negativeSpots = [];

    double oldest = snapshots.oldestTimestamp!;
    double latest = snapshots.latestTimestamp!;
    double timeSpace = (latest - oldest) / 50;

    for (var snapshot in snapshots.entirePeriodSnapshots) {
      FlSpot negFlspot =
          FlSpot(snapshot.timestamp, snapshot.positiveProbability * 100);
      FlSpot posFlspot =
          FlSpot(snapshot.timestamp, snapshot.negativeProbability * 100);
      positiveSpots.add(posFlspot);
      negativeSpots.add(negFlspot);
    }

    return [positiveSpots, negativeSpots];
  }

  Widget Function(double, TitleMeta) PeriodTitleWidget(
      SnapshotsEntity snapshots) {
    Widget Function(double, TitleMeta) titleWidget = (v, m) => Text(
          '${v.toInt()}',
          style: const TextStyle(
            color: Color.fromARGB(255, 74, 74, 74),
            fontWeight: FontWeight.bold,
          ),
        );

    Map<int, List<dynamic>> timeIntervals = {};

    double oldest = snapshots.oldestTimestamp!;
    double latest = snapshots.latestTimestamp!;
    double timeSpace = (latest - oldest) / 60;

    while (oldest <= latest) {
      timeIntervals[oldest.round()] = [
        secondTimestampToDatetime(oldest),
        secondMillisecondToDuration(latest - oldest)
      ];
      oldest += timeSpace;
    }

    if (secondMillisecondToDuration(latest - oldest) <= const Duration(days: 4)) {
      titleWidget = (v, m) {
        String text = '';

        // TODO: Fix the interval detection... Should safely catch the interval!

        if (timeIntervals.containsKey(v)) {
          text = '${durationCalculation(timeIntervals[v]![1])}전';
        } else {
          return Container();
        }

        return Text(
          text,
          style: const TextStyle(
            color: Color.fromARGB(255, 74, 74, 74),
            fontWeight: FontWeight.bold,
          ),
        );
      };
    } else {
      titleWidget = (v, m) {
        String text = '';

        if (timeIntervals.containsKey(v)) {
          text =
              '${timeIntervals[v]![0]}년 ${timeIntervals[v]![0].month}.${timeIntervals[v]![0].day}';
        } else {
          return Container();
        }

        return Text(
          text,
          style: const TextStyle(
            color: Color.fromARGB(255, 74, 74, 74),
            fontWeight: FontWeight.bold,
          ),
        );
      };
    }

    return titleWidget;
  }

  String durationCalculation(Duration duration) {
    if (duration.inDays > 0) {
      return '${duration.inDays}일';
    } else if (duration.inHours > 0) {
      return '${duration.inHours}시간';
    } else if (duration.inMinutes > 0) {
      return '${duration.inMinutes}분';
    } else if (duration.inSeconds > 0) {
      return '${(duration.inMilliseconds / 1000).toStringAsFixed(2)}초';
    } else {
      return '0초';
    }
  }

  @override
  Widget build(BuildContext context) {
    List<List<FlSpot>> spotsPosNeg = SpottingTranslator(widget.snapshots);
    List<FlSpot> posSpots = spotsPosNeg[0];
    List<FlSpot> negSpots = spotsPosNeg[1];
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: CupertinoColors.systemBackground,
          ),
          child: LineChart(LineChartData(
              clipData: const FlClipData.vertical(),
              lineTouchData: LineTouchData(
                touchTooltipData: LineTouchTooltipData(
                    tooltipBgColor: const Color.fromARGB(0, 202, 202, 202),
                    tooltipPadding: const EdgeInsets.all(0),
                    getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                      return touchedBarSpots.map((barSpot) {
                        final flSpot = barSpot;
                        if (flSpot.x == 0 || flSpot.x == 50) {
                          return null;
                        }

                        String indicator = '';

                        if (barSpot.barIndex == 0) {
                          indicator = '그럴 것이다';
                        } else {
                          indicator = '아닐 것이다';
                        }

                        return LineTooltipItem(
                          '$indicator\n${flSpot.y.toStringAsFixed(2)}%',
                          const TextStyle(
                            color: Color.fromARGB(255, 74, 74, 74),
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }).toList();
                    }),
              ),
              titlesData: FlTitlesData(
                  show: true,
                  leftTitles:
                      const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles:
                      const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles:
                      const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: PeriodTitleWidget(widget.snapshots),
                  ))),
              gridData: FlGridData(
                show: true,
                drawVerticalLine: true,
                getDrawingHorizontalLine: (value) {
                  return const FlLine(
                    color: Color.fromARGB(255, 223, 223, 223),
                    strokeWidth: 2,
                  );
                },
                getDrawingVerticalLine: (value) {
                  return const FlLine(
                    color: Color.fromARGB(255, 223, 223, 223),
                    strokeWidth: 2,
                  );
                },
              ),
              borderData: FlBorderData(
                  show: false,
                  border: Border.all(
                    color: const Color.fromARGB(255, 147, 147, 147),
                    width: 2,
                  )),
              minX: widget.snapshots.oldestTimestamp!,
              maxX: widget.snapshots.latestTimestamp!,
              minY: 0,
              maxY: 100,
              lineBarsData: [
                LineChartBarData(
                  spots: posSpots,
                  isCurved: true,
                  gradient: const LinearGradient(colors: [
                    Color(0xFF446CF8),
                    Color.fromARGB(255, 119, 143, 233),
                  ]),
                  barWidth: 3,
                  isStrokeCapRound: true,
                  dotData: const FlDotData(show: false),
                  belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            const Color(0xFF446CF8).withOpacity(0.5),
                            const Color.fromARGB(255, 119, 143, 233)
                                .withOpacity(0.0),
                          ])),
                ),
                LineChartBarData(
                  spots: negSpots,
                  isCurved: true,
                  gradient: const LinearGradient(colors: [
                    Color(0xFFFF1C1C),
                    Color.fromARGB(255, 210, 83, 83),
                  ]),
                  barWidth: 3,
                  isStrokeCapRound: true,
                  dotData: const FlDotData(show: false),
                  belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            const Color(0xFFFF1C1C).withOpacity(0.5),
                            const Color.fromARGB(255, 210, 83, 83).withOpacity(0.0),
                          ])),
                )
              ])),
        ),
      ),
    );
  }
}
