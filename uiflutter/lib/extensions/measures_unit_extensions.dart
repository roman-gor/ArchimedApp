import 'package:flutter/material.dart';
import '../states/bluetooth/sensor_types.dart';
import 'build_context_local.dart';

extension MeasureUnitsLocal on MeasureUnits {
  String getName(BuildContext context) {
    switch (this) {
      case MeasureUnits.ntu: return context.strings.unit_ntu;
      case MeasureUnits.beatsPerMin: return context.strings.unit_beats_per_min;
      case MeasureUnits.amps: return context.strings.unit_milliamps;
      case MeasureUnits.celsius: return context.strings.unit_celsius;
      case MeasureUnits.volts: return context.strings.unit_volts;
      case MeasureUnits.milliVolts: return context.strings.unit_millivolts;
      case MeasureUnits.lux: return context.strings.unit_lux;
      case MeasureUnits.klx: return context.strings.unit_klx;
      case MeasureUnits.microSiemens: return context.strings.unit_microsiemens;
      case MeasureUnits.milliSiemens: return context.strings.unit_millisiemens;
      case MeasureUnits.bits: return context.strings.unit_bits;
      case MeasureUnits.gForce: return context.strings.unit_g_force;
      case MeasureUnits.milliTesla: return context.strings.unit_millitesla;
      case MeasureUnits.kiloPascal: return context.strings.unit_kilopascal;
      case MeasureUnits.mmHg: return context.strings.unit_mm_hg;
      case MeasureUnits.percent: return context.strings.unit_percent;
      case MeasureUnits.nothing: return context.strings.unit_nothing;
    }
  }
}
