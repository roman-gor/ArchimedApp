import 'package:flutter/cupertino.dart';
import 'package:uiflutter/extensions/build_context_local.dart';

import '../states/bluetooth/sensor_types.dart';

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
      case SensorType.colorimetric: return context.strings.colorimetric;
      case SensorType.unknown: return context.strings.unknown;
      case SensorType.gps: return context.strings.gps;
    }
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
