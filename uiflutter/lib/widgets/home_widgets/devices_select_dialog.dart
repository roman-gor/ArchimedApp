import 'package:flutter/material.dart';
import 'package:uiflutter/extensions/build_context_local.dart';
import 'package:uiflutter/widgets/home_widgets/loading_connection_widget.dart';
import 'package:uiflutter/widgets/home_widgets/uncolored_button_widget.dart';

import '../../states/bluetooth/bluetooth_states.dart';

class DevicesSelectDialog extends StatelessWidget {
  const DevicesSelectDialog({
    super.key,
    required this.availableDevices,
    required this.onDeviceClick,
    required this.onCloseDialog,
  });

  final Map<String, EnhancedBluetoothPeripheral> availableDevices;

  final void Function(String) onDeviceClick;
  final VoidCallback onCloseDialog;

  @override
  Widget build(BuildContext context) {
    final devicesList = availableDevices.entries.toList();

    return Dialog(
      backgroundColor: context.colors.secondary,
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
                context.strings.available_devices,
                style: TextStyle(fontSize: 16, color: context.colors.onSurface),
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
                      },
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
                    text: context.strings.close,
                    onPressed: onCloseDialog,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _deviceItemView(
    BuildContext context, {
    required EnhancedBluetoothPeripheral device,
    required VoidCallback onItemClick,
  }) {
    return Card(
      color: context.colors.surface,
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
          child: Row(
            spacing: 8,
            children: [
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  device.peripheral.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: context.colors.onSurface,
                  ),
                ),
              ),
              observingConnectionState(device, context),
              SizedBox(width: 8),
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
        spacing: 8,
        children: [
          Text(
            context.strings.connected,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: context.colors.onSurface.withAlpha(180),
            ),
          ),
          const Icon(Icons.check_circle, color: Colors.green, size: 28),
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
