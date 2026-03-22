import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'bluetooth_states.freezed.dart';
part 'bluetooth_states.g.dart';

enum SensorType {
  @JsonValue('HEART_PULSE') heartPulse(
    unit: MeasureUnits.beatsPerMin,
    imagePath: "assets/images/ic_heart_pulse.svg",
    color: Color(0xFF0AE7D9)
  ),
  @JsonValue('CURRENT_STRENGTH') currentStrength(
    unit: MeasureUnits.amps,
    imagePath: "assets/images/ic_current_strength.svg",
    color: Color(0xFFC28BCB)
  ),
  @JsonValue('AMBIENT_TEMPERATURE') ambientTemperature(
    unit: MeasureUnits.celsius,
    imagePath: "assets/images/ic_ambient_temp_light.svg",
    color: Color(0xFF71BE63)
  ),
  @JsonValue('EXTERNAL_TEMPERATURE') externalTemperature(
    unit: MeasureUnits.celsius,
    imagePath: "assets/images/ic_temp_high.svg",
    color: Color(0xFFDD6A00)
  ),
  @JsonValue('EXTERNAL_ANALOG_CONNECTOR') externalAnalogConnector(
    unit: MeasureUnits.volts,
    imagePath: "assets/images/ic_external.svg",
    color: Color(0xFF4E5B7D)
  ),
  @JsonValue('LIGHT_HIGH_SENSITIVE') lightHighSensitive(
    unit: MeasureUnits.lux,
    imagePath: "assets/images/ic_illumination",
    color: Color(0xFFFFB800)
  ),
  @JsonValue('LIGHT_MEDIUM_SENSITIVE') lightMediumSensitive(
    unit: MeasureUnits.lux,
    imagePath: "assets/image/ic_illumination.svg",
    color: Color(0xFFFFB800)
  ),
  @JsonValue('LIGHT_LOW_SENSITIVE') lightLowSensitive(
    unit: MeasureUnits.klx,
    imagePath: "assets/image/ic_illumination.svg",
    color: Color(0xFFFFB800)
  ),
  @JsonValue('CONDUCTIVITY_HIGH_SENSITIVE') conductivityHighSensitive(
    unit: MeasureUnits.microSiemens,
    imagePath: "assets/images/ic_conductivity.svg",
    color: Color(0xFFE360F9)
  ),
  @JsonValue('CONDUCTIVITY_MEDIUM_SENSITIVE') conductivityMediumSensitive(
    unit: MeasureUnits.microSiemens,
    imagePath: "assets/images/ic_conductivity.svg",
    color: Color(0xFFE360F9)
  ),
  @JsonValue('CONDUCTIVITY_LOW_SENSITIVE') conductivityLowSensitive(
    unit: MeasureUnits.milliSiemens,
    imagePath: "assets/images/ic_conductivity.svg",
    color: Color(0xFFE360F9),
  ),
  @JsonValue('COMMON_ANALOG') commonAnalog(
    unit: MeasureUnits.bits,
    imagePath: "assets/images/ic_gps.svg",
    color: Color(0xFF2E1F84)
  ),
  @JsonValue('ACCELEROMETER_2G') accelerometer2g(
    unit: MeasureUnits.gForce,
    imagePath: "assets/images_ic_accelerometer.svg",
    color: Color(0xFF0075FF),
  ),
  @JsonValue('ACCELEROMETER_4G') accelerometer4g(
    unit: MeasureUnits.gForce,
    imagePath: "assets/images_ic_accelerometer.svg",
    color: Color(0xFF0075FF),
  ),
  @JsonValue('ACCELEROMETER_8G') accelerometer8g(
    unit: MeasureUnits.gForce,
    imagePath: "assets/images_ic_accelerometer.svg",
    color: Color(0xFF0075FF),
  ),
  @JsonValue('MAGNETIC_FIELD') magneticField(
    unit: MeasureUnits.milliTesla,
    imagePath: "assets/images/ic_magnetic_field.svg",
    color: Color(0xFF9F3900)
  ),
  @JsonValue('AIR_PRESSURE') airPressure(
    unit: MeasureUnits.kiloPascal,
    imagePath: "assets/images/ic_air_pressure.svg",
    color: Color(0xFF4B629C)
  ),
  @JsonValue('VOLTAGE_2V') voltage2v(
    unit: MeasureUnits.volts,
    imagePath: "assets/images/ic_voltage.svg",
    color: Color(0xFFCCA43E),
  ),
  @JsonValue('VOLTAGE_5V') voltage5v(
    unit: MeasureUnits.volts,
    imagePath: "assets/images/ic_voltage.svg",
    color: Color(0xFFCCA43E),
  ),
  @JsonValue('VOLTAGE_10V') voltage10v(
    unit: MeasureUnits.volts,
    imagePath: "assets/images/ic_voltage.svg",
    color: Color(0xFFCCA43E),
  ),
  @JsonValue('VOLTAGE_15V') voltage15v(
    unit: MeasureUnits.volts,
    imagePath: "assets/images/ic_voltage.svg",
    color: Color(0xFFCCA43E),
  ),
  @JsonValue('VOLTAGE_30V') voltage30v(
    unit: MeasureUnits.volts,
    imagePath: "assets/images/ic_voltage.svg",
    color: Color(0xFFCCA43E),
  ),
  @JsonValue('EXTERNAL_TEMPERATURE_NTC') externalTemperatureNtc(
    unit: MeasureUnits.celsius,
    imagePath: "assets/images/ic_temp_probe.svg",
    color: Color(0xFFFF6187)
  ),
  @JsonValue('CHLORIDE_ION') chlorideIon(
    unit: MeasureUnits.milliVolts,
    imagePath: "assets/images/ic_ion.svg",
    color: Color(0xFF859B69)
  ),
  @JsonValue('NITRATE_ION') nitrateIon(
    unit: MeasureUnits.milliVolts,
    imagePath: "assets/images/ic_ion.svg",
    color: Color(0xFF82A7A9)
  ),
  @JsonValue('BLOOD_PRESSURE_MAIN') bloodPressureMain(
    unit: MeasureUnits.mmHg,
    imagePath: "assets/images/ic_blood_pressure.svg",
    color: Color(0xFF009AA4)
  ),
  @JsonValue('BODY_TEMPERATURE') bodyTemperature(
    unit: MeasureUnits.celsius,
    imagePath: "assets/images/ic_body_temp.svg",
    color: Color(0xFFE2C6AD)
  ),
  @JsonValue('RESPIRATORY_RATE') respiratoryRate(
    unit: MeasureUnits.celsius,
    imagePath: "assets/images/ic_respiratory_rate.svg",
    color: Color(0xFF407F83)
  ),
  @JsonValue('HUMIDITY') humidity(
    unit: MeasureUnits.percent,
    imagePath: "assets/images/ic_humidity.svg",
    color: Color(0xFF2CC5E7)
  ),
  @JsonValue('PH_SENSOR') phSensor(
    unit: MeasureUnits.microSiemens,
    imagePath: "assets/images/ic_ph.svg",
    color: Color(0xFF7544FF)
  ),
  @JsonValue('TURBIDITY') turbidity(
    unit: MeasureUnits.ntu,
    imagePath: "assets/images/ic_turbidity.svg",
    color: Color(0xFF5ED5EF)
  ),
  @JsonValue('COLORIMETRIC') colorimetric(
    unit: MeasureUnits.percent,
    imagePath: "assets/images/ic_colors.svg",
    color: Color(0xFFC10058)
  ),
  @JsonValue('UNKNOWN') unknown(
    unit: MeasureUnits.nothing,
    imagePath: "",
    color: Colors.black
  );

  const SensorType({
    required this.unit,
    required this.imagePath,
    required this.color
  });

  final MeasureUnits unit;
  final String imagePath;
  final Color color;
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
  @JsonValue('RATE_1_PER_MIN') rate1PerMin,
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

@Freezed(unionKey: 'type')
sealed class DeviceConnectionState with _$DeviceConnectionState {
  const factory DeviceConnectionState.connecting() = _Connecting;
  const factory DeviceConnectionState.connected() = _Connected;
  const factory DeviceConnectionState.disconnecting() = _Disconnecting;
  const factory DeviceConnectionState.disconnected({
    DisconnectReason? reason,
  }) = _Disconnected;

  factory DeviceConnectionState.fromJson(Map<String, dynamic> json) =>
      _$DeviceConnectionStateFromJson(json);
}

@Freezed(unionKey: 'type')
sealed class DisconnectReason with _$DisconnectReason {
  @FreezedUnionValue("peripheral_disconnected")
  const factory DisconnectReason.peripheralDisconnected() = _PeripheralDisconnected;
  @FreezedUnionValue("failed")
  const factory DisconnectReason.failed() = _Failed;
  @FreezedUnionValue("timeout")
  const factory DisconnectReason.timeout() = _Timeout;
  @FreezedUnionValue("unknown_device")
  const factory DisconnectReason.unknownDevice() = _UnknownDevice;
  @FreezedUnionValue("cancelled")
  const factory DisconnectReason.cancelled() = _Cancelled;
  @FreezedUnionValue("not_connected")
  const factory DisconnectReason.notConnected() = _NotConnected;
  @FreezedUnionValue("unknown")
  const factory DisconnectReason.unknown({
    @JsonKey(name: "code") required int code
  }) = _Unknown;

  factory DisconnectReason.fromJson(Map<String, dynamic> json) =>
      _$DisconnectReasonFromJson(json);
}

@freezed
class ExperimentOnlineData with _$ExperimentOnlineData {
  const factory ExperimentOnlineData() = _ExperimentOnlineData;
  factory ExperimentOnlineData.fromJson(Map<String, dynamic> json) => _$ExperimentOnlineDataFromJson(json);
}

@freezed
class ExperimentsData with _$ExperimentsData {
  const factory ExperimentsData({
    @Default(0) int experimentNumber,
    @Default({}) Map<String, List<double>> sensorsData,
    Rates? sampleRate,
    Samples? samplesCount,
    DateTime? experimentDateTime,
    @Default([]) List<SensorType> activeSensors,
  }) = _ExperimentsData;

  factory ExperimentsData.fromJson(Map<String, dynamic> json) =>
      _$ExperimentsDataFromJson(json);
}

@freezed
class StatusDeviceData with _$StatusDeviceData {
  const factory StatusDeviceData({
    @Default(DeviceType.unknown) DeviceType archimedesVersion,
    @Default(0) int experimentsInMemory,
    @Default([]) List<SensorType> lastUsedSensorsType,
    Rates? lastSamplesRates,
    Samples? lastSamplesCount,
    DateTime? dateTime,
    @Default(0) int batteryLevel,
    @Default(0) int memoryUsed,
    @Default(0) int externalAnalogSensor,
  }) = _StatusDeviceData;

  factory StatusDeviceData.fromJson(Map<String, dynamic> json) =>
      _$StatusDeviceDataFromJson(json);
}

@freezed
class EnhancedBluetoothPeripheral with _$EnhancedBluetoothPeripheral {
  factory EnhancedBluetoothPeripheral({
    required bool connected,
    required DeviceConnectionState connectedState,
    required PeripheralDeviceState peripheral,
  }) = _EnhancedBluetoothPeripheral;
  factory EnhancedBluetoothPeripheral.fromJson(Map<String, dynamic> json) =>
      _$EnhancedBluetoothPeripheralFromJson(json);
}

@freezed
class PeripheralDeviceState with _$PeripheralDeviceState {
  factory PeripheralDeviceState({
    required String name,
    required String uuid,
  }) = _PeripheralDeviceState;
  factory PeripheralDeviceState.fromJson(Map<String, dynamic> json) =>
      _$PeripheralDeviceStateFromJson(json);
}

@freezed
class BluetoothDeviceState with _$BluetoothDeviceState {
  const factory BluetoothDeviceState({
    @Default({}) Map<String, EnhancedBluetoothPeripheral> devices,
    bool? isScanning,
    String? selectedDeviceId,
    @Default(DeviceType.unknown) DeviceType selectedDeviceType,
    @Default(StatusDeviceData()) StatusDeviceData statusDeviceData,
    @Default([]) List<ExperimentsData> experimentsHistoryData,
    @Default(ExperimentOnlineData()) ExperimentOnlineData experimentOnlineData,
    @Default(ExperimentsData()) ExperimentsData experimentData,
  }) = _BluetoothDeviceState;

  factory BluetoothDeviceState.fromJson(Map<String, dynamic> json) =>
      _$BluetoothDeviceStateFromJson(json);
}
