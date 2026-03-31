import 'package:uiflutter/l10n/app_localizations.dart';
import '../states/bluetooth/sensor_types.dart';

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

extension SensorTypeGroup on SensorType {
  List<SensorType> get sensorsGroup {
    if(SensorType.lightSensorGroup.contains(this)) {
      return SensorType.lightSensorGroup;
    } else if (SensorType.voltageSensorGroup.contains(this)) {
      return SensorType.voltageSensorGroup;
    } else if (SensorType.accelerometerSensorGroup.contains(this)) {
      return SensorType.accelerometerSensorGroup;
    } else if (SensorType.conductivitySensorGroup.contains(this)) {
      return SensorType.conductivitySensorGroup;
    }
    return [];
  }
}

extension SensorTypeFormat on SensorType {
  SensorType get format {
    if(SensorType.lightSensorGroup.contains(this)) {
      return SensorType.lightLowSensitive;
    } else if (SensorType.voltageSensorGroup.contains(this)) {
      return SensorType.voltage2v;
    } else if (SensorType.accelerometerSensorGroup.contains(this)) {
      return SensorType.accelerometer2g;
    } else if (SensorType.conductivitySensorGroup.contains(this)) {
      return SensorType.conductivityLowSensitive;
    }
    return this;
  }
}
