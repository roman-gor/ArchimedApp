import '../l10n/app_localizations.dart';
import '../states/bluetooth/sensor_types.dart';

extension DeviceTypeName on DeviceType {
  String getName(AppLocalizations locale) {
    return switch(this) {
      DeviceType.ecology => locale.ecology,
      DeviceType.physics => locale.physics,
      DeviceType.biology => locale.biology,
      DeviceType.physiology => locale.physiology,
      DeviceType.unknown => locale.unknown,
    };
  }
}
