import 'package:flutter/material.dart';
import 'package:uiflutter/extensions/build_context_local.dart';
import 'package:uiflutter/states/bluetooth/bluetooth_states.dart';

import '../../extensions/device_type_name.dart';

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
      height: 44,
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 1),
                    if (currentDevice != null) ...[
                      currentDevice!.connectedState.maybeWhen(
                        connected: () => Row(
                          spacing: 8,
                          children: [
                            const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 24,
                            ),
                            Text(
                              selectedDeviceType?.getName(context) ?? 
                                  DeviceType.unknown.getName(context),
                              style: TextStyle(
                                color: context.colors.onSurface,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(
                              Icons.format_list_bulleted_rounded,
                              color: context.colors.onSurface,
                              size: 24,
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
          style: TextStyle(color: context.colors.onSurface, fontSize: 16),
        ),
      ],
    );
  }

  Row _disconnectedDevice(BuildContext context) {
    return Row(
      spacing: context.dimens.paddingMedium,
      children: [
        Icon(
          Icons.bluetooth_disabled,
          color: context.colors.onTertiary,
          size: 24,
        ),
        Text(
          context.strings.not_connected,
          style: TextStyle(
            color: context.colors.onSurfaceVariant,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
