// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get app_name => 'INTlab';

  @override
  String get available_devices => 'Available devices';

  @override
  String get start => 'Start';

  @override
  String get close => 'Close';

  @override
  String get allow_bluetooth_desc => 'Allow Bluetooth and connect multisensor?';

  @override
  String get back => 'Back';

  @override
  String get allow => 'Allow';

  @override
  String get repeat => 'Rescan';

  @override
  String get device_not_connected => 'Not connected';

  @override
  String get permissions_denied => 'Bluetooth permissions were denied';
}
