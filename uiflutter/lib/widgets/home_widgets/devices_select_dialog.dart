import 'package:flutter/material.dart';
import 'package:uiflutter/widgets/home_widgets/uncolored_button_widget.dart';

import '../../l10n/app_localizations.dart';
import '../../states/bluetooth_states.dart';

class DevicesSelectDialog extends StatelessWidget {
  const DevicesSelectDialog({
    super.key,
    required this.availableDevices,
    required this.selectedDeviceId,
    required this.selectedDeviceType,
    required this.onDeviceClick,
    required this.onCloseDialog
  });

  final Map<String, EnhancedBluetoothPeripheral> availableDevices;
  final String? selectedDeviceId;
  final DeviceType? selectedDeviceType;
  final void Function(String) onDeviceClick;
  final VoidCallback onCloseDialog;

  @override
  Widget build(BuildContext context) {

    final devicesList = availableDevices.entries.toList();

    return Dialog(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SizedBox(
        width: 400,
        height: MediaQuery.of(context).size.height * 0.8,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                AppLocalizations.of(context)!.available_devices,
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: devicesList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final deviceEntry = devicesList[index];
                    return _deviceItemView(
                        context,
                        device: deviceEntry.value,
                        onItemClick: () {
                          onDeviceClick(deviceEntry.key);
                        }
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: SizedBox(
                    width: 120,
                    height: 40,
                    child: UncoloredButtonWidget(
                        text: AppLocalizations.of(context)!.close,
                        onPressed: onCloseDialog
                    )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _deviceItemView(BuildContext context, {
    required EnhancedBluetoothPeripheral device,
    required VoidCallback onItemClick
  }) {
    return Card(
        color: Theme.of(context).colorScheme.surface,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
          side: BorderSide(
            color: Colors.grey,
            width: 1,
          ),
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
                                color: Theme.of(context).colorScheme.onSurface
                            )),
                        Text(
                            device.peripheral.uuid,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).colorScheme.onSurface.withAlpha(180)
                            )),
                      ],
                    ),
                    Spacer(),
                    if (selectedDeviceId == device.peripheral.uuid) ...[
                      Text(
                        AppLocalizations.of(context)!.connected,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).colorScheme.onSurface.withAlpha(180)
                        ),),
                      const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 28,
                      ),
                    ],
                    SizedBox(width: 8),
                  ],
                ),
              )
          ),
        )
    );
  }
}
