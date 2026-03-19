// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bluetooth_states.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConnectingImpl _$$ConnectingImplFromJson(Map<String, dynamic> json) =>
    _$ConnectingImpl($type: json['type'] as String?);

Map<String, dynamic> _$$ConnectingImplToJson(_$ConnectingImpl instance) =>
    <String, dynamic>{'type': instance.$type};

_$ConnectedImpl _$$ConnectedImplFromJson(Map<String, dynamic> json) =>
    _$ConnectedImpl($type: json['type'] as String?);

Map<String, dynamic> _$$ConnectedImplToJson(_$ConnectedImpl instance) =>
    <String, dynamic>{'type': instance.$type};

_$DisconnectingImpl _$$DisconnectingImplFromJson(Map<String, dynamic> json) =>
    _$DisconnectingImpl($type: json['type'] as String?);

Map<String, dynamic> _$$DisconnectingImplToJson(_$DisconnectingImpl instance) =>
    <String, dynamic>{'type': instance.$type};

_$DisconnectedImpl _$$DisconnectedImplFromJson(Map<String, dynamic> json) =>
    _$DisconnectedImpl(
      reason: json['reason'] == null
          ? null
          : DisconnectReason.fromJson(json['reason'] as Map<String, dynamic>),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$DisconnectedImplToJson(_$DisconnectedImpl instance) =>
    <String, dynamic>{'reason': instance.reason, 'type': instance.$type};

_$PeripheralDisconnectedImpl _$$PeripheralDisconnectedImplFromJson(
  Map<String, dynamic> json,
) => _$PeripheralDisconnectedImpl($type: json['type'] as String?);

Map<String, dynamic> _$$PeripheralDisconnectedImplToJson(
  _$PeripheralDisconnectedImpl instance,
) => <String, dynamic>{'type': instance.$type};

_$CentralDisconnectedImpl _$$CentralDisconnectedImplFromJson(
  Map<String, dynamic> json,
) => _$CentralDisconnectedImpl($type: json['type'] as String?);

Map<String, dynamic> _$$CentralDisconnectedImplToJson(
  _$CentralDisconnectedImpl instance,
) => <String, dynamic>{'type': instance.$type};

_$FailedImpl _$$FailedImplFromJson(Map<String, dynamic> json) =>
    _$FailedImpl($type: json['type'] as String?);

Map<String, dynamic> _$$FailedImplToJson(_$FailedImpl instance) =>
    <String, dynamic>{'type': instance.$type};

_$L2CapFailureImpl _$$L2CapFailureImplFromJson(Map<String, dynamic> json) =>
    _$L2CapFailureImpl($type: json['type'] as String?);

Map<String, dynamic> _$$L2CapFailureImplToJson(_$L2CapFailureImpl instance) =>
    <String, dynamic>{'type': instance.$type};

_$TimeoutImpl _$$TimeoutImplFromJson(Map<String, dynamic> json) =>
    _$TimeoutImpl($type: json['type'] as String?);

Map<String, dynamic> _$$TimeoutImplToJson(_$TimeoutImpl instance) =>
    <String, dynamic>{'type': instance.$type};

_$LinkManagerProtocolTimeoutImpl _$$LinkManagerProtocolTimeoutImplFromJson(
  Map<String, dynamic> json,
) => _$LinkManagerProtocolTimeoutImpl($type: json['type'] as String?);

Map<String, dynamic> _$$LinkManagerProtocolTimeoutImplToJson(
  _$LinkManagerProtocolTimeoutImpl instance,
) => <String, dynamic>{'type': instance.$type};

_$UnknownDeviceImpl _$$UnknownDeviceImplFromJson(Map<String, dynamic> json) =>
    _$UnknownDeviceImpl($type: json['type'] as String?);

Map<String, dynamic> _$$UnknownDeviceImplToJson(_$UnknownDeviceImpl instance) =>
    <String, dynamic>{'type': instance.$type};

_$CancelledImpl _$$CancelledImplFromJson(Map<String, dynamic> json) =>
    _$CancelledImpl($type: json['type'] as String?);

Map<String, dynamic> _$$CancelledImplToJson(_$CancelledImpl instance) =>
    <String, dynamic>{'type': instance.$type};

_$ConnectionLimitReachedImpl _$$ConnectionLimitReachedImplFromJson(
  Map<String, dynamic> json,
) => _$ConnectionLimitReachedImpl($type: json['type'] as String?);

Map<String, dynamic> _$$ConnectionLimitReachedImplToJson(
  _$ConnectionLimitReachedImpl instance,
) => <String, dynamic>{'type': instance.$type};

_$EncryptionTimedOutImpl _$$EncryptionTimedOutImplFromJson(
  Map<String, dynamic> json,
) => _$EncryptionTimedOutImpl($type: json['type'] as String?);

Map<String, dynamic> _$$EncryptionTimedOutImplToJson(
  _$EncryptionTimedOutImpl instance,
) => <String, dynamic>{'type': instance.$type};

_$UnknownImpl _$$UnknownImplFromJson(Map<String, dynamic> json) =>
    _$UnknownImpl(
      code: (json['code'] as num).toInt(),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$UnknownImplToJson(_$UnknownImpl instance) =>
    <String, dynamic>{'code': instance.code, 'type': instance.$type};

_$ExperimentOnlineDataImpl _$$ExperimentOnlineDataImplFromJson(
  Map<String, dynamic> json,
) => _$ExperimentOnlineDataImpl();

Map<String, dynamic> _$$ExperimentOnlineDataImplToJson(
  _$ExperimentOnlineDataImpl instance,
) => <String, dynamic>{};

_$ExperimentsDataImpl _$$ExperimentsDataImplFromJson(
  Map<String, dynamic> json,
) => _$ExperimentsDataImpl(
  experimentNumber: (json['experimentNumber'] as num?)?.toInt() ?? 0,
  sensorsData:
      (json['sensorsData'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(
          k,
          (e as List<dynamic>).map((e) => (e as num).toDouble()).toList(),
        ),
      ) ??
      const {},
  sampleRate: $enumDecodeNullable(_$RatesEnumMap, json['sampleRate']),
  samplesCount: $enumDecodeNullable(_$SamplesEnumMap, json['samplesCount']),
  experimentDateTime: json['experimentDateTime'] == null
      ? null
      : DateTime.parse(json['experimentDateTime'] as String),
  activeSensors:
      (json['activeSensors'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$SensorTypeEnumMap, e))
          .toList() ??
      const [],
);

Map<String, dynamic> _$$ExperimentsDataImplToJson(
  _$ExperimentsDataImpl instance,
) => <String, dynamic>{
  'experimentNumber': instance.experimentNumber,
  'sensorsData': instance.sensorsData,
  'sampleRate': _$RatesEnumMap[instance.sampleRate],
  'samplesCount': _$SamplesEnumMap[instance.samplesCount],
  'experimentDateTime': instance.experimentDateTime?.toIso8601String(),
  'activeSensors': instance.activeSensors
      .map((e) => _$SensorTypeEnumMap[e]!)
      .toList(),
};

const _$RatesEnumMap = {
  Rates.rate1PerMin: 'RATE_1_PER_MIN',
  Rates.rate1PerSec: 'RATE_1_PER_SEC',
  Rates.rate10PerSec: 'RATE_10_PER_SEC',
  Rates.rate100PerSec: 'RATE_100_PER_SEC',
  Rates.rate20000PerSec: 'RATE_20000_PER_SEC',
};

const _$SamplesEnumMap = {
  Samples.samples10: 'SAMPLES_10',
  Samples.samples100: 'SAMPLES_100',
  Samples.samples1000: 'SAMPLES_1000',
  Samples.samples10000: 'SAMPLES_10000',
};

const _$SensorTypeEnumMap = {
  SensorType.heartPulse: 'HEART_PULSE',
  SensorType.currentStrength: 'CURRENT_STRENGTH',
  SensorType.ambientTemperature: 'AMBIENT_TEMPERATURE',
  SensorType.externalTemperature: 'EXTERNAL_TEMPERATURE',
  SensorType.externalAnalogConnector: 'EXTERNAL_ANALOG_CONNECTOR',
  SensorType.lightHighSensitive: 'LIGHT_HIGH_SENSITIVE',
  SensorType.lightMediumSensitive: 'LIGHT_MEDIUM_SENSITIVE',
  SensorType.lightLowSensitive: 'LIGHT_LOW_SENSITIVE',
  SensorType.conductivityHighSensitive: 'CONDUCTIVITY_HIGH_SENSITIVE',
  SensorType.conductivityMediumSensitive: 'CONDUCTIVITY_MEDIUM_SENSITIVE',
  SensorType.conductivityLowSensitive: 'CONDUCTIVITY_LOW_SENSITIVE',
  SensorType.commonAnalog: 'COMMON_ANALOG',
  SensorType.accelerometer2g: 'ACCELEROMETER_2G',
  SensorType.accelerometer4g: 'ACCELEROMETER_4G',
  SensorType.accelerometer8g: 'ACCELEROMETER_8G',
  SensorType.magneticField: 'MAGNETIC_FIELD',
  SensorType.airPressure: 'AIR_PRESSURE',
  SensorType.voltage2v: 'VOLTAGE_2V',
  SensorType.voltage5v: 'VOLTAGE_5V',
  SensorType.voltage10v: 'VOLTAGE_10V',
  SensorType.voltage15v: 'VOLTAGE_15V',
  SensorType.voltage30v: 'VOLTAGE_30V',
  SensorType.externalTemperatureNtc: 'EXTERNAL_TEMPERATURE_NTC',
  SensorType.chlorideIon: 'CHLORIDE_ION',
  SensorType.nitrateIon: 'NITRATE_ION',
  SensorType.bloodPressureMain: 'BLOOD_PRESSURE_MAIN',
  SensorType.bodyTemperature: 'BODY_TEMPERATURE',
  SensorType.respiratoryRate: 'RESPIRATORY_RATE',
  SensorType.humidity: 'HUMIDITY',
  SensorType.phSensor: 'PH_SENSOR',
  SensorType.turbidity: 'TURBIDITY',
  SensorType.turbiditySec: 'TURBIDITY_SEC',
  SensorType.unknown: 'UNKNOWN',
};

_$StatusDeviceDataImpl _$$StatusDeviceDataImplFromJson(
  Map<String, dynamic> json,
) => _$StatusDeviceDataImpl(
  archimedesVersion:
      $enumDecodeNullable(_$DeviceTypeEnumMap, json['archimedesVersion']) ??
      DeviceType.unknown,
  experimentsInMemory: (json['experimentsInMemory'] as num?)?.toInt() ?? 0,
  lastUsedSensorsType:
      (json['lastUsedSensorsType'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$SensorTypeEnumMap, e))
          .toList() ??
      const [],
  lastSamplesRates: $enumDecodeNullable(
    _$RatesEnumMap,
    json['lastSamplesRates'],
  ),
  lastSamplesCount: $enumDecodeNullable(
    _$SamplesEnumMap,
    json['lastSamplesCount'],
  ),
  dateTime: json['dateTime'] == null
      ? null
      : DateTime.parse(json['dateTime'] as String),
  batteryLevel: (json['batteryLevel'] as num?)?.toInt() ?? 0,
  memoryUsed: (json['memoryUsed'] as num?)?.toInt() ?? 0,
  externalAnalogSensor: (json['externalAnalogSensor'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$StatusDeviceDataImplToJson(
  _$StatusDeviceDataImpl instance,
) => <String, dynamic>{
  'archimedesVersion': _$DeviceTypeEnumMap[instance.archimedesVersion]!,
  'experimentsInMemory': instance.experimentsInMemory,
  'lastUsedSensorsType': instance.lastUsedSensorsType
      .map((e) => _$SensorTypeEnumMap[e]!)
      .toList(),
  'lastSamplesRates': _$RatesEnumMap[instance.lastSamplesRates],
  'lastSamplesCount': _$SamplesEnumMap[instance.lastSamplesCount],
  'dateTime': instance.dateTime?.toIso8601String(),
  'batteryLevel': instance.batteryLevel,
  'memoryUsed': instance.memoryUsed,
  'externalAnalogSensor': instance.externalAnalogSensor,
};

const _$DeviceTypeEnumMap = {
  DeviceType.ecology: 'ECOLOGY',
  DeviceType.physics: 'PHYSICS',
  DeviceType.biology: 'BIOLOGY',
  DeviceType.physiology: 'PHYSIOLOGY',
  DeviceType.unknown: 'UNKNOWN',
};

_$EnhancedBluetoothPeripheralImpl _$$EnhancedBluetoothPeripheralImplFromJson(
  Map<String, dynamic> json,
) => _$EnhancedBluetoothPeripheralImpl(
  connected: json['connected'] as bool,
  connectedState: DeviceConnectionState.fromJson(
    json['connectedState'] as Map<String, dynamic>,
  ),
  peripheral: PeripheralDeviceState.fromJson(
    json['peripheral'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$$EnhancedBluetoothPeripheralImplToJson(
  _$EnhancedBluetoothPeripheralImpl instance,
) => <String, dynamic>{
  'connected': instance.connected,
  'connectedState': instance.connectedState,
  'peripheral': instance.peripheral,
};

_$PeripheralDeviceStateImpl _$$PeripheralDeviceStateImplFromJson(
  Map<String, dynamic> json,
) => _$PeripheralDeviceStateImpl(
  name: json['name'] as String,
  uuid: json['uuid'] as String,
);

Map<String, dynamic> _$$PeripheralDeviceStateImplToJson(
  _$PeripheralDeviceStateImpl instance,
) => <String, dynamic>{'name': instance.name, 'uuid': instance.uuid};

_$BluetoothDeviceStateImpl _$$BluetoothDeviceStateImplFromJson(
  Map<String, dynamic> json,
) => _$BluetoothDeviceStateImpl(
  devices:
      (json['devices'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(
          k,
          EnhancedBluetoothPeripheral.fromJson(e as Map<String, dynamic>),
        ),
      ) ??
      const {},
  isScanning: json['isScanning'] as bool?,
  selectedDeviceId: json['selectedDeviceId'] as String?,
  selectedDeviceType:
      $enumDecodeNullable(_$DeviceTypeEnumMap, json['selectedDeviceType']) ??
      DeviceType.unknown,
  statusDeviceData: json['statusDeviceData'] == null
      ? const StatusDeviceData()
      : StatusDeviceData.fromJson(
          json['statusDeviceData'] as Map<String, dynamic>,
        ),
  experimentsHistoryData:
      (json['experimentsHistoryData'] as List<dynamic>?)
          ?.map((e) => ExperimentsData.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  experimentOnlineData: json['experimentOnlineData'] == null
      ? const ExperimentOnlineData()
      : ExperimentOnlineData.fromJson(
          json['experimentOnlineData'] as Map<String, dynamic>,
        ),
  experimentData: json['experimentData'] == null
      ? const ExperimentsData()
      : ExperimentsData.fromJson(
          json['experimentData'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$$BluetoothDeviceStateImplToJson(
  _$BluetoothDeviceStateImpl instance,
) => <String, dynamic>{
  'devices': instance.devices,
  'isScanning': instance.isScanning,
  'selectedDeviceId': instance.selectedDeviceId,
  'selectedDeviceType': _$DeviceTypeEnumMap[instance.selectedDeviceType]!,
  'statusDeviceData': instance.statusDeviceData,
  'experimentsHistoryData': instance.experimentsHistoryData,
  'experimentOnlineData': instance.experimentOnlineData,
  'experimentData': instance.experimentData,
};
