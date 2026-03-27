import 'package:flutter/material.dart';
import 'package:uiflutter/extensions/sensor_type_extensions.dart';

import '../../extensions/build_context_local.dart';
import '../../extensions/measures_unit_extensions.dart';
import '../../states/bluetooth/sensor_types.dart';

class TableWidget extends StatelessWidget {
  const TableWidget({super.key, required this.sensorsData});

  final Map<SensorType, List<double>> sensorsData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(context.dimens.paddingLarge),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Table(
            columnWidths: _getColumnWidths(),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: _parsedSensorsData(context),
          ),
        ),
      ),
    );
  }

  Map<int, TableColumnWidth> _getColumnWidths() {
    Map<int, TableColumnWidth> columnWidths = {};
    final rawLength = sensorsData.length;
    for (int i = 1; i <= rawLength; i++) {
      columnWidths[i] = const MaxColumnWidth(
        FixedColumnWidth(120),
        IntrinsicColumnWidth(),
      );
    }
    columnWidths[0] = FixedColumnWidth(60);
    return columnWidths;
  }

  List<TableRow> _parsedSensorsData(BuildContext context) {
    List<TableRow> tableRows = [];

    final activeSensors = sensorsData.keys;
    if (activeSensors.isEmpty) return tableRows;

    List<Widget> headerCells = [
      Center(
        child: Padding(
          padding: EdgeInsets.all(context.dimens.paddingMedium),
          child: Text('№', style: context.textStyle.titleSmall),
        ),
      )
    ];
    for (var sensor in activeSensors) {
      headerCells.add(
        Center(
          child: Padding(
            padding: EdgeInsets.all(context.dimens.paddingMedium),
            child: Text(
              sensor.getName(context),
              style: context.textStyle.titleSmall,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ),
      );
    }
    tableRows.add(
      TableRow(
        decoration: BoxDecoration(
          color: context.colors.primary.withValues(alpha: 0.1),
        ),
        children: headerCells,
      ),
    );
    int totalSamples = 0;
    final firstSensor = activeSensors.first;
    if (sensorsData.containsKey(firstSensor)) {
      totalSamples =
          sensorsData[firstSensor]!.length ~/
          firstSensor.valueAmount;
    }
    for (int i = 0; i < totalSamples; i++) {
      List<Widget> rowCells = [
        Center(
          child: Padding(
            padding: EdgeInsets.all(context.dimens.paddingMedium),
            child: Text(
              '${i + 1}', 
              overflow: TextOverflow.ellipsis, 
              maxLines: 1,
              style: context.textStyle.titleSmall,),
          ),
        ),
      ];

      for (var sensor in activeSensors) {
        final rawData = sensorsData[sensor] ?? [];
        final valuesCount = sensor.valueAmount;
        String cellText = '-';

        cellText = defineCellText(i, valuesCount, rawData, cellText);
        
        rowCells.add(
          Center(
            child: Padding(
              padding: EdgeInsets.all(context.dimens.paddingMedium),
              child: Text(
                "$cellText ${sensor.unit.getName(context)}",
                style: context.textStyle.titleSmall,
              ),
            ),
          ),
        );
      }
      tableRows.add(TableRow(children: rowCells));
    }
    return tableRows;
  }

  String defineCellText(int i, int valuesCount, List<double> rawData, String cellText) {
    if (i * valuesCount < rawData.length) {
      if (valuesCount == 1) {
        cellText = rawData[i].toStringAsFixed(2);
      } else {
        List<String> axes = [];
        for (int j = 0; j < valuesCount; j++) {
          if (i * valuesCount + j < rawData.length) {
            axes.add(rawData[i * valuesCount + j].toStringAsFixed(2));
          }
        }
        cellText = axes.join(' | ');
      }
    }
    return cellText;
  }
}
