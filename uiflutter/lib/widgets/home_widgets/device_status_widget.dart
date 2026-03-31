import 'package:flutter/material.dart';
import 'package:uiflutter/extensions/build_context_local.dart';
import 'package:uiflutter/states/bluetooth/bluetooth_states.dart';

class DeviceStatusWidget extends StatelessWidget {
  const DeviceStatusWidget({
    super.key,
    required this.onListClick,
    required this.selectedDeviceId,
    required this.selectedDeviceType,
  });

  final VoidCallback? onListClick;
  final String? selectedDeviceId;
  final DeviceType? selectedDeviceType;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(36.0),
                color: context.colors.surface,
              ),
              child: InkWell(
                onTap: onListClick,
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    spacing: 8,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(width: 1),
                      if (selectedDeviceId != null) ...[
                        const Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 24,
                        ),
                        Text(
                          "Biology",
                          style: TextStyle(
                            color: context.colors.onSurface,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.format_list_bulleted_rounded,
                          color: context.colors.onSurface,
                          size: 24
                        )
                      ] else ...[
                        Icon(
                          Icons.sensors_off_rounded,
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
                      const SizedBox(width: 1),
                    ],
                  ),
                ),
              )
          )
        ],
      ),
    );
  }
}
