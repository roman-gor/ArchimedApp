import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../states/bluetooth/bluetooth_states.dart';

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
      color: Theme.of(context).colorScheme.surface,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
        side: BorderSide(color: Colors.grey, width: 1),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onItemClick,
        child: SizedBox(
          width: 346,
          height: 70,
          child: Align(
            alignment: Alignment.center,
            child: Row(
              spacing: 8,
              children: [
                SizedBox(width: 8),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8,
                  children: [
                    Text(
                      device.peripheral.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      device.peripheral.uuid,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withAlpha(180),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                if (selectedDeviceId == device.peripheral.uuid) ...[
                  Text(
                    AppLocalizations.of(context)!.connected,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withAlpha(180),
                    ),
                  ),
                  const Icon(Icons.check_circle, color: Colors.green, size: 28),
                ],
                SizedBox(width: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
