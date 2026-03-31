import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../extensions/build_context_local.dart';
import '../../states/bluetooth/sensor_types.dart';

class ChartWidget extends StatefulWidget {
  const ChartWidget({
    super.key,
    required this.sensorsData,
    required this.currentSensor,
  });

  final Map<SensorType, List<double>> sensorsData;
  final SensorType currentSensor;

  @override
  State<StatefulWidget> createState() => ChartWidgetState();
}

class ChartWidgetState extends State<ChartWidget> {
  double? _minX;
  double? _maxX;

  final double _defaultViewWindow = 20.0;

  @override
  Widget build(BuildContext context) {
    final rawData =
        widget.sensorsData[widget.currentSensor] ?? [];
    final parsedLines = parseSensorData(
      rawData,
      widget.currentSensor.valueAmount,
    );

    final double absoluteMaxX = parsedLines.isEmpty || parsedLines[0].isEmpty
        ? 1.0
        : parsedLines[0].last.x;

    double currentMinX =
        _minX ?? (absoluteMaxX - _defaultViewWindow).clamp(0.0, absoluteMaxX);
    double currentMaxX = _maxX ?? absoluteMaxX;

    if (currentMaxX <= currentMinX) currentMaxX = currentMinX + 1.0;

    final double minY = widget.currentSensor.minValue;
    final double maxY = widget.currentSensor.maxValue;

    double horizontalInterval = ((currentMaxX - currentMinX) / 5)
        .clamp(1.0, double.infinity)
        .ceilToDouble();
    double verticalInterval = ((maxY - minY) / 5).clamp(0.1, double.infinity);

    return LineChart(
        LineChartData(
          clipData: const FlClipData.all(),
          minX: currentMinX,
          maxX: currentMaxX,
          minY: minY,
          maxY: maxY,
          backgroundColor: Colors.transparent,
          gridData: FlGridData(
            show: true,
            drawVerticalLine: true,
            horizontalInterval: verticalInterval,
            verticalInterval: horizontalInterval,
            getDrawingHorizontalLine: (value) => FlLine(
              color: context.colors.onSecondaryContainer.withValues(
                alpha: 0.25,
              ),
              strokeWidth: 1,
            ),
            getDrawingVerticalLine: (value) => FlLine(
              color: context.colors.onSecondaryContainer.withValues(
                alpha: 0.25,
              ),
              strokeWidth: 1,
            ),
          ),
          titlesData: FlTitlesData(
            show: true,
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 35,
                interval: horizontalInterval,
                getTitlesWidget: (value, meta) {
                  if (value % horizontalInterval != 0) {
                    return const SizedBox.shrink();
                  }
                  if (value == currentMinX) return const SizedBox.shrink();
                  return Padding(
                    padding: EdgeInsets.only(top: context.dimens.paddingMedium),
                    child: Text(
                      value.toInt().toString(),
                      style: TextStyle(
                        color: context.colors.onSecondaryContainer,
                        fontSize: 10,
                      ),
                    ),
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                interval: verticalInterval,
                getTitlesWidget: (value, meta) {
                  if (value == minY || value == maxY) {
                    return const SizedBox.shrink();
                  }
                  return Padding(
                    padding: EdgeInsets.only(
                      right: context.dimens.paddingMedium,
                    ),
                    child: Text(
                      value.toStringAsFixed(1),
                      style: TextStyle(
                        color: context.colors.onSecondaryContainer,
                        fontSize: 10,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          lineBarsData: List.generate(parsedLines.length, (index) {
            return LineChartBarData(
              spots: parsedLines[index],
              isCurved: true,
              barWidth: 2,
              isStrokeCapRound: true,
              color: widget.currentSensor.color,
              dotData: const FlDotData(show: false),
            );
          }),
          borderData: FlBorderData(
            show: true,
            border: Border.all(
              color: context.colors.onSecondaryContainer.withValues(
                alpha: 0.25,
              ),
              width: 1,
            ),
          ),
          lineTouchData: buildLineTouchData(
            currentMinX,
            currentMaxX,
            absoluteMaxX,
          ),
        ),
      );
  }

  LineTouchData buildLineTouchData(
    double currentMinX,
    double currentMaxX,
    double absoluteMaxX,
  ) {
    return LineTouchData(
      handleBuiltInTouches: true,
      touchCallback: (FlTouchEvent event, LineTouchResponse? touchResponse) {
        if (event is FlPanUpdateEvent) {
          setState(() {
            const double sensitivity = 0.05;

            double delta = -event.details.delta.dx * sensitivity;

            double newMinX = currentMinX + delta;
            double newMaxX = currentMaxX + delta;
            double windowSize = currentMaxX - currentMinX;

            if (newMinX < 0) {
              newMinX = 0;
              newMaxX = windowSize;
            }

            if (newMaxX >= absoluteMaxX) {
              _minX = null;
              _maxX = null;
              return;
            }

            _minX = newMinX;
            _maxX = newMaxX;
          });
        }
      },
      touchTooltipData: LineTouchTooltipData(
        tooltipBorderRadius: BorderRadius.all(
            Radius.circular(context.dimens.borderRadius)
        ),
        tooltipPadding: EdgeInsets.all(context.dimens.paddingMedium),
        getTooltipColor: (_) {
          return context.colors.surface;
        }
      )
    );
  }

  List<List<FlSpot>> parseSensorData(List<num> rawData, int valuesCount) {
    if (valuesCount <= 0 || rawData.isEmpty) return [];

    List<List<FlSpot>> lines = List.generate(valuesCount, (_) => []);

    for (int i = 0; i < rawData.length; i += valuesCount) {
      if (i + valuesCount <= rawData.length) {
        int pointIndex = i ~/ valuesCount;

        for (int j = 0; j < valuesCount; j++) {
          lines[j].add(
            FlSpot(
              pointIndex.toDouble(),
              (rawData[i + j].toDouble() * 100).roundToDouble() / 100,
            ),
          );
        }
      }
    }
    return lines;
  }
}
