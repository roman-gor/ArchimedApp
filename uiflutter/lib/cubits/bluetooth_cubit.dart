import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:uiflutter/states/bluetooth/bluetooth_states.dart';
import 'package:uiflutter/utils/method_channel_commands.dart';

import '../states/bluetooth/bluetooth_ui_event.dart';
import '../states/bluetooth/sensor_types.dart';

class BluetoothCubit extends Cubit<BluetoothDeviceState?> {

  final _logger = Logger();
  static const EventChannel _eventChannel = EventChannel('com.gorman.archimed/events');
  static const MethodChannel _methodChannel = MethodChannel('com.gorman.archimed/methods');
  
  bool isDeviceConnected = false;

  StreamSubscription? _subscription;

  BluetoothCubit() : super(null) {
    _initStream();
  }

  void _initStream() {
    _subscription = _eventChannel.receiveBroadcastStream().listen((event) {
      final jsonMap = jsonDecode(event as String);
      var newState = BluetoothDeviceState.fromJson(jsonMap);
      if (state?.selectedSensor != null) {
        newState = newState.copyWith(selectedSensor: state!.selectedSensor);
      }
      emit(newState); 
    }, onError: (error) {
      _logger.e("EventChannel error: $error");
    });
  }

  Future<void> sendCommand(BluetoothUiEvent event) async {
    try {
      await _methodChannel.invokeMethod(
          MethodChannelCommands.onUiEvent.name,
          <String, String>{"command": jsonEncode(event.toJson())}
      );
    } on PlatformException catch (e) {
      _logger.e("Method Channel error: ${e.message}");
    }
  }
  
  void observeConnectionState(DeviceConnectionState? state, VoidCallback onShowToast) {
    isDeviceConnected = false;
    state?.maybeWhen(
      connected: () => isDeviceConnected = true,
      disconnected: (reason) {
        isDeviceConnected = false;
        reason?.maybeWhen(
          unknown: (code) { if (code == 147) { onShowToast(); } },
          orElse: () {},
        );
      },
      orElse: () { isDeviceConnected = false; },
    );
  }
  
  void selectSensor(SensorType newSensor) {
    emit(state?.copyWith(selectedSensor: newSensor));
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
