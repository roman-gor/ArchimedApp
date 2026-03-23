import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uiflutter/extensions/build_context_local.dart';
import 'package:uiflutter/extensions/device_type_name.dart';
import 'package:uiflutter/utils/date_time_parse.dart';

import '../../states/bluetooth/bluetooth_states.dart';

class ManagingBlockWidget extends StatelessWidget {
  const ManagingBlockWidget({
    super.key,
    required this.isDeviceConnected,
    required this.isExperimentLoading,
    required this.deviceType,
    required this.experimentsHistoryList,
    required this.onExperimentClick
  });

  final bool isDeviceConnected;
  final bool isExperimentLoading;
  final DeviceType? deviceType;
  final List<ExperimentsData>? experimentsHistoryList;
  final void Function(int) onExperimentClick;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(context.dimens.paddingLarge),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(context.dimens.borderRadius),
          color: context.colors.surface,
        ),
        child: Stack(
          children: [
            if (isExperimentLoading) ...[
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 80),
                  child: CircularProgressIndicator(
                    color: context.colors.onSurface,
                  ),
                )
              )
            ] else if (isDeviceConnected) ...[
              _historyWidget(context)
            ] else ...[
              _placeholderWidget()
            ],
            Align(
                alignment: Alignment.bottomRight,
                child: SizedBox(
                  width: 90,
                  height: 42,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDeviceConnected
                          ? context.colors.primary
                          : Colors.grey,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    child: Text(
                      context.strings.start,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
            )
          ],
        )
    );
  }
  
  Widget _placeholderWidget() {
    return Align(
      alignment: Alignment.center,
      child: SvgPicture.asset('assets/images/main_image.svg'),
    );
  }

  Widget _historyWidget(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        reverse: true,
        padding: const EdgeInsets.only(top: 0, bottom: 80),
        itemCount: experimentsHistoryList?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          final experimentEntry = experimentsHistoryList?[index] 
              ?? ExperimentsData();
          return _historyItemWidget(
              context: context,
              experiment: experimentEntry
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: 20,
            child: Align(
                alignment: Alignment.center,
                child: Divider(
                  color: context.colors.onSurface
                      .withValues(alpha: context.opacities.low),
                  height: 1,
                  thickness: 1,
                )
            ),
          );
        },
      ),
    );
  }

  Widget _historyItemWidget({
    required BuildContext context,
    required ExperimentsData experiment
  }) {
    final dateString = dateTimeToString(
        "dd MMM , HH:mm",
        experiment.experimentDateTime ?? DateTime.now(),
        Localizations.localeOf(context).languageCode
    );

    final double iconWidth = 44.0;
    final double spacing = context.dimens.paddingMedium;

    return SizedBox(
        height: 44,
        child: InkWell(
            onTap: () { onExperimentClick(experiment.experimentNumber); },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: context.dimens.paddingMedium,
              children: [
                SizedBox(width: 4,),
                Text(
                  deviceType?.getName(context) ?? "Device",
                  style: TextStyle(
                      fontSize: 16,
                      color: context.colors.onSurface
                  ),
                ),
                SizedBox(width: context.dimens.paddingLarge,),
                Text(
                  dateString,
                  style: TextStyle(
                      fontSize: 14,
                      color: context.colors.onSurface.withValues(
                          alpha: context.opacities.medium
                      )
                  ),
                ),
                SizedBox(width: context.dimens.paddingLarge,),
                Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final double availableWidth = constraints.maxWidth;

                        int maxItems = ((availableWidth + spacing) / (iconWidth + spacing)).floor();

                        if (maxItems < 1) return const SizedBox.shrink();

                        int totalSensors = experiment.activeSensors.length;
                        List<Widget> sensorWidgets = [];

                        if (totalSensors <= maxItems) {
                          sensorWidgets = experiment.activeSensors.map((sensor) {
                            return _sensorIcon(context: context, path: sensor.imagePath);
                          }).toList();
                        } else {
                          int visibleSensors = maxItems - 1;
                          int hiddenCount = totalSensors - visibleSensors;
                          sensorWidgets = experiment.activeSensors.take(visibleSensors).map((sensor) {
                            return _sensorIcon(context: context, path: sensor.imagePath);
                          }).toList();
                          sensorWidgets.add(
                              _sensorIconPlaceholderWidget(context, "$hiddenCount")
                          );
                        }

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          spacing: spacing,
                          children: sensorWidgets,
                        );
                      },
                    )
                ),
                RotatedBox(
                    quarterTurns: 2,
                    child: Icon(
                      Icons.arrow_back_ios_rounded,
                      color: context.colors.secondaryContainer
                          .withValues(alpha: context.opacities.medium),
                      size: 20,
                    )
                ),
                SizedBox(width: 4,)
              ],
            )
        )
    );
  }
  
  Widget _sensorIcon({
    required BuildContext context,
    required String path
  }) {
    return SizedBox(
      height: 44,
      width: 44,
      child: Align(
        alignment: Alignment.center,
        child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.colors.primary.withValues(alpha: context.opacities.low)
            ),
            padding: EdgeInsets.all(context.dimens.paddingMedium),
            child: SvgPicture.asset(path),
        ),
      )
    );
  }

  Widget _sensorIconPlaceholderWidget(BuildContext context, String size) {
    return SizedBox(
        height: 40,
        width: 40,
        child: Align(
          alignment: Alignment.center,
          child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.colors.surface,
                border: Border.all(
                  color: context.colors.primary.withValues(alpha: context.opacities.low),
                  width: 1.0,
                ),
              ),
              child: Center(
                child: Text(
                  "+$size",
                  style: TextStyle(
                      fontSize: 14,
                      color: context.colors.onSurface
                  ),
                ),
              )
          ),
        )
    );
  }
}
