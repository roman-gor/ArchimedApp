import 'package:uiflutter/l10n/app_localizations.dart';
import '../states/bluetooth/sensor_types.dart';

extension MeasureUnitsLocal on MeasureUnits {
  String getName(AppLocalizations locale) {
    return switch (this) {
       MeasureUnits.ntu => locale.unit_ntu,
       MeasureUnits.beatsPerMin => locale.unit_beats_per_min,
       MeasureUnits.amps => locale.unit_milliamps,
       MeasureUnits.celsius => locale.unit_celsius,
       MeasureUnits.volts => locale.unit_volts,
       MeasureUnits.milliVolts => locale.unit_millivolts,
       MeasureUnits.lux => locale.unit_lux,
       MeasureUnits.klx => locale.unit_klx,
       MeasureUnits.microSiemens => locale.unit_microsiemens,
       MeasureUnits.milliSiemens => locale.unit_millisiemens,
       MeasureUnits.bits => locale.unit_bits,
       MeasureUnits.gForce => locale.unit_g_force,
       MeasureUnits.milliTesla => locale.unit_millitesla,
       MeasureUnits.kiloPascal => locale.unit_kilopascal,
       MeasureUnits.mmHg => locale.unit_mm_hg,
       MeasureUnits.percent => locale.unit_percent,
       MeasureUnits.nothing => locale.unit_nothing,
    };
  }
}
