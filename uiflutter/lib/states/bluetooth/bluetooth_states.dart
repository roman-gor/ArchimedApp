import 'package:freezed_annotation/freezed_annotation.dart';
part 'bluetooth_states.freezed.dart';
part 'bluetooth_states.g.dart';

enum SensorType {
  @JsonValue('HEART_PULSE') heartPulse(MeasureUnits.beatsPerMin),
  @JsonValue('CURRENT_STRENGTH') currentStrength(MeasureUnits.amps),
  @JsonValue('AMBIENT_TEMPERATURE') ambientTemperature(MeasureUnits.celsius),
  @JsonValue('EXTERNAL_TEMPERATURE') externalTemperature(MeasureUnits.celsius),
  @JsonValue('EXTERNAL_ANALOG_CONNECTOR') externalAnalogConnector(MeasureUnits.volts),
  @JsonValue('LIGHT_HIGH_SENSITIVE') lightHighSensitive(MeasureUnits.lux),
  @JsonValue('LIGHT_MEDIUM_SENSITIVE') lightMediumSensitive(MeasureUnits.lux),
  @JsonValue('LIGHT_LOW_SENSITIVE') lightLowSensitive(MeasureUnits.klx),
  @JsonValue('CONDUCTIVITY_HIGH_SENSITIVE') conductivityHighSensitive(MeasureUnits.microSiemens),
  @JsonValue('CONDUCTIVITY_MEDIUM_SENSITIVE') conductivityMediumSensitive(MeasureUnits.microSiemens),
  @JsonValue('CONDUCTIVITY_LOW_SENSITIVE') conductivityLowSensitive(MeasureUnits.milliSiemens),
  @JsonValue('COMMON_ANALOG') commonAnalog(MeasureUnits.bits),
  @JsonValue('ACCELEROMETER_2G') accelerometer2g(MeasureUnits.gForce),
  @JsonValue('ACCELEROMETER_4G') accelerometer4g(MeasureUnits.gForce),
  @JsonValue('ACCELEROMETER_8G') accelerometer8g(MeasureUnits.gForce),
  @JsonValue('MAGNETIC_FIELD') magneticField(MeasureUnits.milliTesla),
  @JsonValue('AIR_PRESSURE') airPressure(MeasureUnits.kiloPascal),
  @JsonValue('VOLTAGE_2V') voltage2v(MeasureUnits.volts),
  @JsonValue('VOLTAGE_5V') voltage5v(MeasureUnits.volts),
  @JsonValue('VOLTAGE_10V') voltage10v(MeasureUnits.volts),
  @JsonValue('VOLTAGE_15V') voltage15v(MeasureUnits.volts),
  @JsonValue('VOLTAGE_30V') voltage30v(MeasureUnits.volts),
  @JsonValue('EXTERNAL_TEMPERATURE_NTC') externalTemperatureNtc(MeasureUnits.celsius),
  @JsonValue('CHLORIDE_ION') chlorideIon(MeasureUnits.milliVolts),
  @JsonValue('NITRATE_ION') nitrateIon(MeasureUnits.milliVolts),
  @JsonValue('BLOOD_PRESSURE_MAIN') bloodPressureMain(MeasureUnits.mmHg),
  @JsonValue('BODY_TEMPERATURE') bodyTemperature(MeasureUnits.celsius),
  @JsonValue('RESPIRATORY_RATE') respiratoryRate(MeasureUnits.celsius),
  @JsonValue('HUMIDITY') humidity(MeasureUnits.percent),
  @JsonValue('PH_SENSOR') phSensor(MeasureUnits.microSiemens),
  @JsonValue('TURBIDITY') turbidity(MeasureUnits.ntu),
  @JsonValue('TURBIDITY_SEC') turbiditySec(MeasureUnits.ntu),
  @JsonValue('UNKNOWN') unknown(MeasureUnits.nothing);
  
  const SensorType(this.unit);
  final MeasureUnits unit;
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
