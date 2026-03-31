import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:uiflutter/states/bluetooth/bluetooth_states.dart';
import 'package:uiflutter/utils/method_channel_commands.dart';

import '../states/bluetooth/bluetooth_ui_event.dart';

class BluetoothCubit extends Cubit<BluetoothDeviceState?> {

  final _logger = Logger();
  static const EventChannel _eventChannel = EventChannel('com.gorman.archimed/events');
  static const MethodChannel _methodChannel = MethodChannel('com.gorman.archimed/methods');

  StreamSubscription? _subscription;

  BluetoothCubit() : super(null) {
    _initStream();
  }

  void _initStream() {
    _subscription = _eventChannel.receiveBroadcastStream().listen((event) {
      final jsonMap = jsonDecode(event as String);
      final newState = BluetoothDeviceState.fromJson(jsonMap);
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

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
