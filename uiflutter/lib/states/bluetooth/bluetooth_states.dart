import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uiflutter/states/bluetooth/sensor_types.dart';
part 'bluetooth_states.freezed.dart';
part 'bluetooth_states.g.dart';

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
  const factory ExperimentOnlineData({
    @Default({}) Map<SensorType, List<double>> sensorsData,
    @Default(0) int currentSample
  }) = _ExperimentOnlineData;
  
  factory ExperimentOnlineData.fromJson(Map<String, dynamic> json) => _$ExperimentOnlineDataFromJson(json);
}

@freezed
class ExperimentsData with _$ExperimentsData {
  const factory ExperimentsData({
    @Default(0) int experimentNumber,
    @Default({}) Map<SensorType, List<double>> sensorsData,
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
    @Default([]) List<SensorType> availableDeviceSensors,
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
    @Default(false) bool isScanning,
    @Default(false) bool isExperimentsHistoryLoading,
    @Default(false) bool isExperimentDataLoading,
    @Default(false) bool isOnlineDataLoading,
    String? selectedDeviceId,
    SensorType? selectedSensor,
    @Default(DeviceType.unknown) DeviceType selectedDeviceType,
    @Default(StatusDeviceData()) StatusDeviceData statusDeviceData,
    @Default([]) List<ExperimentsData> experimentsHistoryData,
    @Default(ExperimentOnlineData()) ExperimentOnlineData experimentOnlineData,
    @Default(ExperimentsData()) ExperimentsData experimentData,
  }) = _BluetoothDeviceState;

  factory BluetoothDeviceState.fromJson(Map<String, dynamic> json) =>
      _$BluetoothDeviceStateFromJson(json);
}
