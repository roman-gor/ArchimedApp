import 'package:flutter/material.dart';
import 'package:uiflutter/extensions/build_context_local.dart';
import 'package:uiflutter/states/bluetooth/bluetooth_states.dart';

import '../../extensions/device_type_name.dart';
import '../../states/bluetooth/sensor_types.dart';

class DeviceStatusWidget extends StatelessWidget {
  const DeviceStatusWidget({
    super.key,
    required this.onListClick,
    required this.selectedDeviceType,
    required this.currentDevice,
  });

  final VoidCallback? onListClick;
  final DeviceType? selectedDeviceType;
  final EnhancedBluetoothPeripheral? currentDevice;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.dimens.sizeLarge,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(context.dimens.paddingMedium),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(36.0),
              color: context.colors.surface,
            ),
            child: InkWell(
              onTap: onListClick,
              child: Align(
                alignment: Alignment.center,
                child: Row(
                  spacing: context.dimens.paddingMedium,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 1),
                    if (currentDevice != null) ...[
                      currentDevice!.connectedState.maybeWhen(
                        connected: () => Row(
                          spacing: context.dimens.paddingMedium,
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: context.dimens.sizeExtraSmall,
                            ),
                            Text(
                              selectedDeviceType?.getName(context) ?? 
                                  DeviceType.unknown.getName(context),
                              style: context.textStyle.bodyLarge?.copyWith(
                                color: context.colors.onSurface,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(width: context.dimens.paddingSmall),
                            Icon(
                              Icons.format_list_bulleted_rounded,
                              color: context.colors.onSurface,
                              size: context.dimens.sizeExtraSmall,
                            ),
                          ],
                        ),
                        connecting: () => _loadingConnectionWidget(
                          context,
                          context.strings.connecting,
                        ),
                        disconnecting: () => _loadingConnectionWidget(
                          context,
                          context.strings.disconnecting,
                        ),
                        orElse: () => _disconnectedDevice(context),
                      ),
                    ] else ...[
                      _disconnectedDevice(context),
                    ],
                    const SizedBox(width: 1),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row _loadingConnectionWidget(BuildContext context, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: context.dimens.paddingMedium,
      children: [
        SizedBox(
          height: 18,
          width: 18,
          child: CircularProgressIndicator(
            color: context.colors.onSurface,
            strokeWidth: 2,
          ),
        ),
        SizedBox(width: 4),
        Text(
          title,
          style: context.textStyle.bodyLarge?.copyWith(
            color: context.colors.onSurface,
          ),
        ),
        const SizedBox(width: 1,)
      ],
    );
  }

  Row _disconnectedDevice(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: context.dimens.paddingMedium,
      children: [
        Icon(
          Icons.bluetooth_disabled,
          color: context.colors.onTertiary,
          size: context.dimens.sizeExtraSmall,
        ),
        Text(
          context.strings.not_connected,
          style: context.textStyle.bodyLarge?.copyWith(
            color: context.colors.onSurface,
          ),
        ),
        const SizedBox(width: 1,)
      ],
    );
  }
}
