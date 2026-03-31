import 'package:flutter/material.dart';
import 'package:uiflutter/extensions/build_context_local.dart';
import 'package:uiflutter/widgets/home_widgets/device_item_view_widget.dart';
import 'package:uiflutter/widgets/home_widgets/uncolored_button_widget.dart';

import '../../navigation/navigator_local.dart';
import '../../states/bluetooth/bluetooth_states.dart';

class DevicesSelectDialog extends StatelessWidget {
  const DevicesSelectDialog({
    super.key,
    required this.availableDevices,
    required this.onDeviceClick, 
    required this.selectedDeviceId, 
    required this.selectedDeviceType,
  });

  final Map<String, EnhancedBluetoothPeripheral> availableDevices;
  final String? selectedDeviceId;
  final DeviceType? selectedDeviceType;
  final void Function(String) onDeviceClick;

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
          padding: EdgeInsets.all(context.dimens.paddingLarge),
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
                    return DeviceItemViewWidget(
                        selectedDeviceId: selectedDeviceId,
                        device: deviceEntry.value,
                        onItemClick: () {
                          onDeviceClick(deviceEntry.key);
                        }
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(context.dimens.paddingMedium),
                child: SizedBox(
                  width: 120,
                  height: 40,
                  child: UncoloredButtonWidget(
                    text: context.strings.close,
                    onPressed: () => NavigatorLocal.goBack()
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }    
}
