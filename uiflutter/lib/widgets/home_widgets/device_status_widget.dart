import 'package:flutter/material.dart';
import 'package:uiflutter/extensions/build_context_local.dart';
import 'package:uiflutter/states/bluetooth/bluetooth_states.dart';
import 'package:uiflutter/widgets/home_widgets/disconnected_device_widget.dart';
import 'package:uiflutter/widgets/home_widgets/loading_connection_widget.dart';

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
    final device = currentDevice;
    
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
                    if (device != null) ...[
                      device.connectedState.maybeWhen(
                        connected: () => Row(
                          spacing: 8,
                          children: [
                            const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 24,
                            ),
                            Text(
                              selectedDeviceType?.getName(context.strings) ?? 
                                  DeviceType.unknown.getName(context.strings),
                              style: TextStyle(
                                color: context.colors.onSurface,
                                fontSize: 16,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(width: 4),
                            Icon(
                              Icons.format_list_bulleted_rounded,
                              color: context.colors.onSurface,
                              size: 24,
                            ),
                          ],
                        ),
                        connecting: () => LoadingConnectionWidget(
                          title: context.strings.connecting,
                        ),
                        disconnecting: () => LoadingConnectionWidget(
                          title: context.strings.disconnecting,
                        ),
                        orElse: () => DisconnectedDeviceWidget(),
                      ),
                    ] else ...[
                      DisconnectedDeviceWidget(),
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
}
