import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uiflutter/states/bluetooth/bluetooth_states.dart';
part 'bluetooth_ui_event.freezed.dart';
part 'bluetooth_ui_event.g.dart';

@Freezed(unionKey: 'type')
sealed class BluetoothUiEvent with _$BluetoothUiEvent {
  @FreezedUnionValue("on_start_scan") const factory BluetoothUiEvent.onStartScan() = _OnStartScan;
  @FreezedUnionValue("on_stop_scan") const factory BluetoothUiEvent.onStopScan() = _OnStopScan;
  @FreezedUnionValue("on_send_command") const factory BluetoothUiEvent.onSendCommand(DeviceCommand command) = _OnSendCommand;
  @FreezedUnionValue("on_connect") const factory BluetoothUiEvent.onConnect(String? uuid) = _OnConnect;
  @FreezedUnionValue("on_disconnect") const factory BluetoothUiEvent.onDisconnect(String? uuid) = _OnDisconnect;

  factory BluetoothUiEvent.fromJson(Map<String, dynamic> json) =>
      _$BluetoothUiEventFromJson(json);
}

@Freezed(unionKey: 'type')
sealed class DeviceCommand with _$DeviceCommand {
  @FreezedUnionValue("get_status") const factory DeviceCommand.getStatus() = _GetStatus;
  @FreezedUnionValue("start_default_logging") const factory DeviceCommand.startDefaultLogging() = _StartDefaultLogging;
  @FreezedUnionValue("start_logging") const factory DeviceCommand.startLogging(
        @JsonKey(name: "sensors") List<SensorType> sensors,
        @JsonKey(name: "sample_rate") Rates sampleRate,
        @JsonKey(name: "sample_count") Samples sampleCount,
        @JsonKey(name: "should_calibrate") bool shouldCalibrate
      ) = _StartLogging;
  @FreezedUnionValue("stop_logging") const factory DeviceCommand.stopLogging() = _StopLogging;
  @FreezedUnionValue("get_all_sensors_id") const factory DeviceCommand.getAllSensorsId() = _GetAllSensorsId;
  @FreezedUnionValue("get_sensors_values") const factory DeviceCommand.getSensorsValues() = _GetSensorsValues;
  @FreezedUnionValue("get_experiments_list") const factory DeviceCommand.getExperimentsList() = _GetExperimentsList;
  @FreezedUnionValue("get_experiment_data") const factory DeviceCommand.getExperimentData(
        @JsonKey(name: "experiment_number") int experimentNumber
      ) = _GetExperimentData;
  @FreezedUnionValue("send_next_data_package") const factory DeviceCommand.sendNextDataPackage() = _SendNextDataPackage;
  @FreezedUnionValue("resend_prev_data_package") const factory DeviceCommand.resendPrevDataPackage() = _ResendPrevDataPackage;
  @FreezedUnionValue("clear_device_memory") const factory DeviceCommand.clearDeviceMemory() = _ClearDeviceMemory;
  @FreezedUnionValue("terminate_downloading") const factory DeviceCommand.terminateDownloading() = _TerminateDownloading;
  @FreezedUnionValue("delete_last_recording") const factory DeviceCommand.deleteLastRecording() = _DeleteLastRecording;
  @FreezedUnionValue("set_current_time") const factory DeviceCommand.setCurrentDateTime() = _SetCurrentDateTime;
  @FreezedUnionValue("get_external_sensors_data") const factory DeviceCommand.getExternalSensorsData() = _GetExternalSensorsData;

  factory DeviceCommand.fromJson(Map<String, dynamic> json) =>
      _$DeviceCommandFromJson(json);
}
