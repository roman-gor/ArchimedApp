import 'package:uiflutter/l10n/app_localizations.dart';
import 'package:uiflutter/states/bluetooth/bluetooth_states.dart';

extension SensorTypeLocal on SensorType {
  String getName(AppLocalizations locale) {
    return switch(this) {
      SensorType.heartPulse => locale.heart_pulse,
      SensorType.currentStrength => locale.current_strength,
      SensorType.ambientTemperature => locale.ambient_temperature,
      SensorType.externalTemperature => locale.external_temperature,
      SensorType.externalAnalogConnector => locale.external_analog_connector,
      SensorType.lightHighSensitive => locale.illuminance,
      SensorType.lightMediumSensitive => locale.illuminance,
      SensorType.lightLowSensitive => locale.illuminance,
      SensorType.conductivityHighSensitive => locale.conductivity,
      SensorType.conductivityMediumSensitive => locale.conductivity,
      SensorType.conductivityLowSensitive => locale.conductivity,
      SensorType.commonAnalog => locale.common_analog,
      SensorType.accelerometer2g => locale.accelerometer,
      SensorType.accelerometer4g => locale.accelerometer,
      SensorType.accelerometer8g => locale.accelerometer,
      SensorType.magneticField => locale.magnetic_field,
      SensorType.airPressure => locale.air_pressure,
      SensorType.voltage2v => locale.voltage,
      SensorType.voltage5v => locale.voltage,
      SensorType.voltage10v => locale.voltage,
      SensorType.voltage15v => locale.voltage,
      SensorType.voltage30v => locale.voltage,
      SensorType.externalTemperatureNtc => locale.external_temperature_ntc,
      SensorType.chlorideIon => locale.chloride_ion,
      SensorType.nitrateIon => locale.nitrate_ion,
      SensorType.bloodPressureMain => locale.blood_pressure_main,
      SensorType.bodyTemperature => locale.body_temperature,
      SensorType.respiratoryRate => locale.respiratory_rate,
      SensorType.humidity => locale.humidity,
      SensorType.phSensor => locale.ph_sensor,
      SensorType.turbidity => locale.turbidity,
      SensorType.colorimetric => locale.turbidity,
      SensorType.unknown => locale.unknown,
    };
  }
}

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

extension SamplesLocal on Samples {
  int get count =>
      switch(this) {
        Samples.samples10 => 10,
        Samples.samples100 => 100,
        Samples.samples1000 => 1000,
        Samples.samples10000 => 10000,
      };
}

extension RatesLocal on Rates {
  double get count =>
      switch(this) {
        Rates.rate1PerSec => 1,
        Rates.rate10PerSec => 10,
        Rates.rate100PerSec => 100,
        Rates.rate20000PerSec => 20000,
        Rates.rate1PerMin => 0.016
      };
}
