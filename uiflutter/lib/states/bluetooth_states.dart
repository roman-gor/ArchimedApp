import 'package:freezed_annotation/freezed_annotation.dart';
part 'bluetooth_states.freezed.dart';
part 'bluetooth_states.g.dart';

enum SensorType {
  @JsonValue('HEART_PULSE') heartPulse,
  @JsonValue('CURRENT_STRENGTH') currentStrength,
  @JsonValue('AMBIENT_TEMPERATURE') ambientTemperature,
  @JsonValue('EXTERNAL_TEMPERATURE') externalTemperature,
  @JsonValue('EXTERNAL_ANALOG_CONNECTOR') externalAnalogConnector,
  @JsonValue('LIGHT_HIGH_SENSITIVE') lightHighSensitive,
  @JsonValue('LIGHT_MEDIUM_SENSITIVE') lightMediumSensitive,
  @JsonValue('LIGHT_LOW_SENSITIVE') lightLowSensitive,
  @JsonValue('CONDUCTIVITY_HIGH_SENSITIVE') conductivityHighSensitive,
  @JsonValue('CONDUCTIVITY_MEDIUM_SENSITIVE') conductivityMediumSensitive,
  @JsonValue('CONDUCTIVITY_LOW_SENSITIVE') conductivityLowSensitive,
  @JsonValue('COMMON_ANALOG') commonAnalog,
  @JsonValue('ACCELEROMETER_2G') accelerometer2g,
  @JsonValue('ACCELEROMETER_4G') accelerometer4g,
  @JsonValue('ACCELEROMETER_8G') accelerometer8g,
  @JsonValue('MAGNETIC_FIELD') magneticField,
  @JsonValue('AIR_PRESSURE') airPressure,
  @JsonValue('VOLTAGE_2V') voltage2v,
  @JsonValue('VOLTAGE_5V') voltage5v,
  @JsonValue('VOLTAGE_10V') voltage10v,
  @JsonValue('VOLTAGE_15V') voltage15v,
  @JsonValue('VOLTAGE_30V') voltage30v,
  @JsonValue('EXTERNAL_TEMPERATURE_NTC') externalTemperatureNtc,
  @JsonValue('CHLORIDE_ION') chlorideIon,
  @JsonValue('NITRATE_ION') nitrateIon,
  @JsonValue('BLOOD_PRESSURE_MAIN') bloodPressureMain,
  @JsonValue('BODY_TEMPERATURE') bodyTemperature,
  @JsonValue('RESPIRATORY_RATE') respiratoryRate,
  @JsonValue('HUMIDITY') humidity,
  @JsonValue('PH_SENSOR') phSensor,
  @JsonValue('TURBIDITY') turbidity,
  @JsonValue('TURBIDITY_SEC') turbiditySec,
  @JsonValue('UNKNOWN') unknown,
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
  const factory DisconnectReason.peripheralDisconnected() = _PeripheralDisconnected;
  const factory DisconnectReason.centralDisconnected() = _CentralDisconnected;
  const factory DisconnectReason.failed() = _Failed;
  const factory DisconnectReason.l2CapFailure() = _L2CapFailure;
  const factory DisconnectReason.timeout() = _Timeout;
  const factory DisconnectReason.linkManagerProtocolTimeout() = _LinkManagerProtocolTimeout;
  const factory DisconnectReason.unknownDevice() = _UnknownDevice;
  const factory DisconnectReason.cancelled() = _Cancelled;
  const factory DisconnectReason.connectionLimitReached() = _ConnectionLimitReached;
  const factory DisconnectReason.encryptionTimedOut() = _EncryptionTimedOut;
  const factory DisconnectReason.unknown({required int code}) = _Unknown;

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