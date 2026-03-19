// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get app_name => 'INTlab';

  @override
  String get available_devices => 'Доступные устройства';

  @override
  String get start => 'Начать';

  @override
  String get close => 'Закрыть';

  @override
  String get allow_bluetooth_desc => 'Разрешить Bluetooth и подключить мультидатчик?';

  @override
  String get back => 'Назад';

  @override
  String get allow => 'Разрешить';

  @override
  String get repeat => 'Повторить';

  @override
  String get device_not_connected => 'Не подключено';

  @override
  String get permissions_denied => 'Разрешения на работу Bluetooth не были получены';

  @override
  String get connected => 'Подключено';
}
