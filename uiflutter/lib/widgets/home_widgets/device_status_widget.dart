import 'package:flutter/material.dart';
import 'package:uiflutter/l10n/app_localizations.dart';
import 'package:uiflutter/widgets/home_widgets/icon_transparent_button_widget.dart';

class DeviceStatusWidget extends StatelessWidget {
  const DeviceStatusWidget({
    super.key,
    required this.isDeviceSelected,
    required this.onListClick
  });

  final bool isDeviceSelected;
  final VoidCallback? onListClick;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(36.0),
                color: Theme.of(context).colorScheme.surface,
              ),
              child: Align(
                alignment: Alignment.center,
                child: Row(
                  spacing: 8,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 1),
                    if (isDeviceSelected) ...[
                      const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 28,
                      ),
                      Text(
                        "Biology",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 16,
                        ),
                      ),
                      IconTransparentButton(
                        color: Theme.of(context).colorScheme.onSurface,
                        icon: Icons.format_list_bulleted_rounded,
                        onPressed: onListClick,
                      ),
                    ] else ...[
                      Icon(
                        Icons.sensors_off_rounded,
                        color: Theme.of(context).colorScheme.onTertiary,
                        size: 28,
                      ),
                      Text(
                        AppLocalizations.of(context)!.device_not_connected,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          fontSize: 16,
                        ),
                      ),
                      IconTransparentButton(
                        color: Theme.of(context).colorScheme.onSurface,
                        icon: Icons.format_list_bulleted_rounded,
                        onPressed: onListClick,
                      ),
                    ]
                  ],
                ),
              )
          )
        ],
      ),
    );
  }
}
