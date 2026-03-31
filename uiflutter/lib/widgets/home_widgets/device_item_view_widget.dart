import 'package:flutter/material.dart';

import '../../extensions/build_context_local.dart';
import '../../states/bluetooth/bluetooth_states.dart';
import 'loading_connection_widget.dart';

class DeviceItemViewWidget extends StatelessWidget {
  const DeviceItemViewWidget({
    super.key,
    required this.device,
    required this.onItemClick,
    required this.selectedDeviceId,
  });

  final EnhancedBluetoothPeripheral device;
  final String? selectedDeviceId;
  final VoidCallback onItemClick;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: context.colors.surface,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(context.dimens.borderRadius),
        side: BorderSide(color: Colors.grey, width: 1),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onItemClick,
        child: SizedBox(
          width: 346,
          height: 70,
          child: Row(
            spacing: 8,
            children: [
              SizedBox(width: context.dimens.paddingMedium),
              Expanded(
                child: Text(
                  device.peripheral.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.textStyle.bodyLarge?.copyWith(
                      color: context.colors.onSurface
                  ),
                ),
              ),
              observingConnectionState(device, context),
              SizedBox(width: context.dimens.paddingMedium),
            ],
          ),
        ),
      ),
    );
  }

  Widget observingConnectionState(
      EnhancedBluetoothPeripheral device,
      BuildContext context,
      ) {
    return device.connectedState.maybeWhen(
      connected: () => Row(
        spacing: context.dimens.paddingMedium,
        children: [
          Text(
            context.strings.connected,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: context.colors.onSurface.withValues(alpha: context.opacities.high),
            ),
          ),
          Icon(Icons.check_circle, color: Colors.green, size: 28),
        ],
      ),
      connecting: () =>
          LoadingConnectionWidget(title: context.strings.connecting),
      disconnecting: () =>
          LoadingConnectionWidget(title: context.strings.disconnecting),
      orElse: () => SizedBox.shrink(),
    );
  }
}
