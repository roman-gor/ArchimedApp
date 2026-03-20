import 'package:flutter/cupertino.dart';
import 'package:uiflutter/extensions/build_context_local.dart';
import 'package:uiflutter/states/bluetooth/bluetooth_states.dart';

extension SensorTypeLocal on SensorType {
  String getName(BuildContext context) {
    switch(this) {
      case SensorType.heartPulse: return context.strings.heart_pulse;
      case SensorType.currentStrength: return context.strings.current_strength;
      case SensorType.ambientTemperature: return context.strings.ambient_temperature;
      case SensorType.externalTemperature: return context.strings.external_temperature;
      case SensorType.externalAnalogConnector: return context.strings.external_analog_connector;
      case SensorType.lightHighSensitive: return context.strings.light_high_sensetive;
      case SensorType.lightMediumSensitive: return context.strings.light_medium_sensetive;
      case SensorType.lightLowSensitive: return context.strings.light_low_sensetive;
      case SensorType.conductivityHighSensitive: return context.strings.conductivity_high_sensetive;
      case SensorType.conductivityMediumSensitive: return context.strings.conductivity_medium_sensetive;
      case SensorType.conductivityLowSensitive: return context.strings.conductivity_low_sensetive;
      case SensorType.commonAnalog: return context.strings.common_analog;
      case SensorType.accelerometer2g: return context.strings.accelerometer_2g;
      case SensorType.accelerometer4g: return context.strings.accelerometer_4g;
      case SensorType.accelerometer8g: return context.strings.accelerometer_8g;
      case SensorType.magneticField: return context.strings.magnetic_field;
      case SensorType.airPressure: return context.strings.air_pressure;
      case SensorType.voltage2v: return context.strings.voltage_2v;
      case SensorType.voltage5v: return context.strings.voltage_5v;
      case SensorType.voltage10v: return context.strings.voltage_10v;
      case SensorType.voltage15v: return context.strings.voltage_15v;
      case SensorType.voltage30v: return context.strings.voltage_30v;
      case SensorType.externalTemperatureNtc: return context.strings.external_temperature_ntc;
      case SensorType.chlorideIon: return context.strings.chloride_ion;
      case SensorType.nitrateIon: return context.strings.nitrate_ion;
      case SensorType.bloodPressureMain: return context.strings.blood_pressure_main;
      case SensorType.bodyTemperature: return context.strings.body_temperature;
      case SensorType.respiratoryRate: return context.strings.respiratory_rate;
      case SensorType.humidity: return context.strings.humidity;
      case SensorType.phSensor: return context.strings.ph_sensor;
      case SensorType.turbidity: return context.strings.turbidity;
      case SensorType.turbiditySec: return context.strings.turbidity;
      case SensorType.unknown: return context.strings.unknown;
    }
  }
}

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
