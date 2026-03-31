import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

enum SensorType {
  @JsonValue('HEART_PULSE') heartPulse(
    unit: MeasureUnits.beatsPerMin,
    imagePath: "assets/images/ic_heart_pulse.svg",
    color: Color(0xFF0AE7D9),
    minValue: 0.0,
    maxValue: 300.0,
    valueAmount: 2,
  ),
  @JsonValue('CURRENT_STRENGTH') currentStrength(
    unit: MeasureUnits.amps,
    imagePath: "assets/images/ic_current_strength.svg",
    color: Color(0xFFC28BCB),
    minValue: 0.0,
    maxValue: 1000.0,
    valueAmount: 1,
  ),
  @JsonValue('AMBIENT_TEMPERATURE') ambientTemperature(
    unit: MeasureUnits.celsius,
    imagePath: "assets/images/ic_ambient_temp_light.svg",
    color: Color(0xFF71BE63),
    minValue: -25.0,
    maxValue: 65.0,
    valueAmount: 1,
  ),
  @JsonValue('EXTERNAL_TEMPERATURE') externalTemperature(
    unit: MeasureUnits.celsius,
    imagePath: "assets/images/ic_temp_probe.svg",
    color: Color(0xFFDD6A00),
    minValue: -55.0,
    maxValue: 185.0,
    valueAmount: 1,
  ),
  @JsonValue('EXTERNAL_ANALOG_CONNECTOR') externalAnalogConnector(
    unit: MeasureUnits.volts,
    imagePath: "assets/images/ic_external.svg",
    color: Color(0xFF4E5B7D),
    minValue: 0.0,
    maxValue: 5.0,
    valueAmount: 1,
  ),
  @JsonValue('LIGHT_HIGH_SENSITIVE') lightHighSensitive(
    unit: MeasureUnits.lux,
    imagePath: "assets/images/ic_illumination.svg",
    color: Color(0xFFFFB800),
    minValue: 0.0,
    maxValue: 180000.0,
    valueAmount: 1,
  ),
  @JsonValue('LIGHT_MEDIUM_SENSITIVE') lightMediumSensitive(
    unit: MeasureUnits.lux,
    imagePath: "assets/images/ic_illumination.svg",
    color: Color(0xFFFFB800),
    minValue: 0.0,
    maxValue: 20000.0,
    valueAmount: 1,
  ),
  @JsonValue('LIGHT_LOW_SENSITIVE') lightLowSensitive(
    unit: MeasureUnits.klx,
    imagePath: "assets/images/ic_illumination.svg",
    color: Color(0xFFFFB800),
    minValue: 0.0,
    maxValue: 1000.0,
    valueAmount: 1,
  ),
  @JsonValue('CONDUCTIVITY_HIGH_SENSITIVE') conductivityHighSensitive(
    unit: MeasureUnits.microSiemens,
    imagePath: "assets/images/ic_conductivity.svg",
    color: Color(0xFFE360F9),
    minValue: 0.0,
    maxValue: 200.0,
    valueAmount: 1,
  ),
  @JsonValue('CONDUCTIVITY_MEDIUM_SENSITIVE') conductivityMediumSensitive(
    unit: MeasureUnits.microSiemens,
    imagePath: "assets/images/ic_conductivity.svg",
    color: Color(0xFFE360F9),
    minValue: 0.0,
    maxValue: 2000.0,
    valueAmount: 1,
  ),
  @JsonValue('CONDUCTIVITY_LOW_SENSITIVE') conductivityLowSensitive(
    unit: MeasureUnits.milliSiemens,
    imagePath: "assets/images/ic_conductivity.svg",
    color: Color(0xFFE360F9),
    minValue: 0.0,
    maxValue: 30.0,
    valueAmount: 1,
  ),
  @JsonValue('COMMON_ANALOG') commonAnalog(
    unit: MeasureUnits.bits,
    imagePath: "assets/images/ic_gps.svg",
    color: Color(0xFF2E1F84),
    minValue: 0.0,
    maxValue: 65535.0,
    valueAmount: 1,
  ),
  @JsonValue('ACCELEROMETER_2G') accelerometer2g(
    unit: MeasureUnits.gForce,
    imagePath: "assets/images/ic_accelerometer.svg",
    color: Color(0xFF0075FF),
    minValue: -2.2,
    maxValue: 2.2,
    valueAmount: 3,
  ),
  @JsonValue('ACCELEROMETER_4G') accelerometer4g(
    unit: MeasureUnits.gForce,
    imagePath: "assets/images/ic_accelerometer.svg",
    color: Color(0xFF0075FF),
    minValue: -4.4,
    maxValue: 4.4,
    valueAmount: 3,
  ),
  @JsonValue('ACCELEROMETER_8G') accelerometer8g(
    unit: MeasureUnits.gForce,
    imagePath: "assets/images/ic_accelerometer.svg",
    color: Color(0xFF0075FF),
    minValue: -8.8,
    maxValue: 8.8,
    valueAmount: 3,
  ),
  @JsonValue('MAGNETIC_FIELD') magneticField(
    unit: MeasureUnits.milliTesla,
    imagePath: "assets/images/ic_magnetic_field.svg",
    color: Color(0xFF9F3900),
    minValue: -180.0,
    maxValue: 180.0,
    valueAmount: 3,
  ),
  @JsonValue('AIR_PRESSURE') airPressure(
    unit: MeasureUnits.kiloPascal,
    imagePath: "assets/images/ic_air_pressure.svg",
    color: Color(0xFF4B629C),
    minValue: 0.0,
    maxValue: 770.0,
    valueAmount: 1,
  ),
  @JsonValue('VOLTAGE_2V') voltage2v(
    unit: MeasureUnits.volts,
    imagePath: "assets/images/ic_voltage.svg",
    color: Color(0xFFCCA43E),
    minValue: -2.2,
    maxValue: 2.2,
    valueAmount: 1,
  ),
  @JsonValue('VOLTAGE_5V') voltage5v(
    unit: MeasureUnits.volts,
    imagePath: "assets/images/ic_voltage.svg",
    color: Color(0xFFCCA43E),
    minValue: -5.5,
    maxValue: 5.5,
    valueAmount: 1,
  ),
  @JsonValue('VOLTAGE_10V') voltage10v(
    unit: MeasureUnits.volts,
    imagePath: "assets/images/ic_voltage.svg",
    color: Color(0xFFCCA43E),
    minValue: -11.0,
    maxValue: 11.0,
    valueAmount: 1,
  ),
  @JsonValue('VOLTAGE_15V') voltage15v(
    unit: MeasureUnits.volts,
    imagePath: "assets/images/ic_voltage.svg",
    color: Color(0xFFCCA43E),
    minValue: -17.0,
    maxValue: 17.0,
    valueAmount: 1,
  ),
  @JsonValue('VOLTAGE_30V') voltage30v(
    unit: MeasureUnits.volts,
    imagePath: "assets/images/ic_voltage.svg",
    color: Color(0xFFCCA43E),
    minValue: -33.0,
    maxValue: 33.0,
    valueAmount: 1,
  ),
  @JsonValue('EXTERNAL_TEMPERATURE_NTC') externalTemperatureNtc(
    unit: MeasureUnits.celsius,
    imagePath: "assets/images/ic_temp_high.svg",
    color: Color(0xFFFF6187),
    minValue: -30.0,
    maxValue: 130.0,
    valueAmount: 1,
  ),
  @JsonValue('CHLORIDE_ION') chlorideIon(
    unit: MeasureUnits.milliVolts,
    imagePath: "assets/images/ic_ion.svg",
    color: Color(0xFF859B69),
    minValue: -1100.0,
    maxValue: 1100.0,
    valueAmount: 1,
  ),
  @JsonValue('NITRATE_ION') nitrateIon(
    unit: MeasureUnits.milliVolts,
    imagePath: "assets/images/ic_ion.svg",
    color: Color(0xFF82A7A9),
    minValue: -1100.0,
    maxValue: 1100.0,
    valueAmount: 1,
  ),
  @JsonValue('BLOOD_PRESSURE_MAIN') bloodPressureMain(
    unit: MeasureUnits.mmHg,
    imagePath: "assets/images/ic_blood_pressure.svg",
    color: Color(0xFF009AA4),
    minValue: 0.0,
    maxValue: 300.0,
    valueAmount: 1,
  ),
  @JsonValue('BODY_TEMPERATURE') bodyTemperature(
    unit: MeasureUnits.celsius,
    imagePath: "assets/images/ic_body_temp.svg",
    color: Color(0xFFE2C6AD),
    minValue: 25.0,
    maxValue: 45.0,
    valueAmount: 1,
  ),
  @JsonValue('RESPIRATORY_RATE') respiratoryRate(
    unit: MeasureUnits.celsius,
    imagePath: "assets/images/ic_respiratory_rate.svg",
    color: Color(0xFF407F83),
    minValue: 0.0,
    maxValue: 10000.0,
    valueAmount: 2,
  ),
  @JsonValue('HUMIDITY') humidity(
    unit: MeasureUnits.percent,
    imagePath: "assets/images/ic_humidity.svg",
    color: Color(0xFF2CC5E7),
    minValue: 0.0,
    maxValue: 100.0,
    valueAmount: 1,
  ),
  @JsonValue('GPS') gps(
    unit: MeasureUnits.nothing,
    imagePath: "assets/images/ic_gps.svg",
    color: Color(0xFF2E1F84),
    minValue: 0.0,
    maxValue: 65535.0,
    valueAmount: 1,
  ),
  @JsonValue('PH_SENSOR') phSensor(
    unit: MeasureUnits.microSiemens,
    imagePath: "assets/images/ic_ph.svg",
    color: Color(0xFF7544FF),
    minValue: 0.0,
    maxValue: 14.0,
    valueAmount: 1,
  ),
  @JsonValue('TURBIDITY') turbidity(
    unit: MeasureUnits.ntu,
    imagePath: "assets/images/ic_turbidity.svg",
    color: Color(0xFF5ED5EF),
    minValue: 0.0,
    maxValue: 200.0,
    valueAmount: 1,
  ),
  @JsonValue('COLORIMETRIC') colorimetric(
    unit: MeasureUnits.percent,
    imagePath: "assets/images/ic_colors.svg",
    color: Color(0xFFC10058),
    minValue: 0.0,
    maxValue: 620.0,
    valueAmount: 3,
  ),
  @JsonValue('UNKNOWN') unknown(
    unit: MeasureUnits.nothing,
    imagePath: "",
    color: Colors.black,
    minValue: -10000.0,
    maxValue: 10000.0,
    valueAmount: 1,
  );

  const SensorType({
    required this.unit,
    required this.imagePath,
    required this.color,
    required this.minValue,
    required this.maxValue,
    required this.valueAmount,
  });

  final MeasureUnits unit;
  final String imagePath;
  final Color color;
  final double minValue;
  final double maxValue;
  final int valueAmount;

  static const lightSensorGroup = [
    SensorType.lightLowSensitive,
    SensorType.lightMediumSensitive,
    SensorType.lightHighSensitive
  ];
  static const voltageSensorGroup = [
    SensorType.voltage2v,
    SensorType.voltage5v,
    SensorType.voltage10v,
    SensorType.voltage15v,
    SensorType.voltage30v
  ];
  static const accelerometerSensorGroup = [
    SensorType.accelerometer2g,
    SensorType.accelerometer4g,
    SensorType.accelerometer8g
  ];
  static const conductivitySensorGroup = [
    SensorType.conductivityLowSensitive,
    SensorType.conductivityMediumSensitive,
    SensorType.conductivityHighSensitive
  ];
}

enum MeasureUnits {
  @JsonValue('NTU') ntu,
  @JsonValue('BEATS_PER_MIN') beatsPerMin,
  @JsonValue('AMPS') amps,
  @JsonValue('CELSIUS') celsius,
  @JsonValue('VOLTS') volts,
  @JsonValue('MILLIVOLTS') milliVolts,
  @JsonValue('LUX') lux,
  @JsonValue('KLX') klx,
  @JsonValue('MICROSIEMENS') microSiemens,
  @JsonValue('MILLISIEMENS') milliSiemens,
  @JsonValue('BITS') bits,
  @JsonValue('G_FORCE') gForce,
  @JsonValue('MILLITESLA') milliTesla,
  @JsonValue('KILOPASCAL') kiloPascal,
  @JsonValue('MM_HG') mmHg,
  @JsonValue('PERCENT') percent,
  @JsonValue('NOTHING') nothing
}

enum DeviceType {
  @JsonValue('ECOLOGY') ecology,
  @JsonValue('PHYSICS') physics,
  @JsonValue('BIOLOGY') biology,
  @JsonValue('PHYSIOLOGY') physiology,
  @JsonValue('UNKNOWN') unknown,
}

enum Rates {
  @JsonValue('RATE_1_PER_SEC') rate1PerSec,
  @JsonValue('RATE_10_PER_SEC') rate10PerSec,
  @JsonValue('RATE_100_PER_SEC') rate100PerSec,
  @JsonValue('RATE_20000_PER_SEC') rate20000PerSec,
}

enum Samples {
  @JsonValue('SAMPLES_10') samples10,
  @JsonValue('SAMPLES_100') samples100,
  @JsonValue('SAMPLES_1000') samples1000,
  @JsonValue('SAMPLES_10000') samples10000,
}
