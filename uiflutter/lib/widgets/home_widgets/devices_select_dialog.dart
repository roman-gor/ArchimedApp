import 'package:flutter/material.dart';
import 'package:uiflutter/widgets/home_widgets/uncolored_button_widget.dart';

import '../../l10n/app_localizations.dart';

class DevicesSelectDialog extends StatelessWidget {
  const DevicesSelectDialog({super.key});

  @override
  Widget build(BuildContext context) {
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
                  itemCount: 1000,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text('Устройство $index'),
                      onTap: () {
                        print('Выбрано устройство $index');
                        Navigator.of(context).pop();
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
                        text: AppLocalizations.of(context)!.close,
                        onPressed: () {}
                    )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
