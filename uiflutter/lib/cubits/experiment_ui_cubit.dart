import 'dart:async';
import 'package:bloc/bloc.dart';

import '../states/bluetooth/bluetooth_states.dart';
import '../states/bluetooth/sensor_types.dart';
import 'bluetooth_cubit.dart';

class ExperimentUiCubit extends Cubit<ExperimentUiState> {
  final BluetoothCubit _bluetoothCubit;
  final bool _isOnlineData;
  late final StreamSubscription _subscription;

  ExperimentUiCubit({
    required BluetoothCubit bluetoothCubit,
    required bool isOnlineData,
  })  : _bluetoothCubit = bluetoothCubit,
        _isOnlineData = isOnlineData,
        super(_mapToUiState(bluetoothCubit.state, isOnlineData)) {

    _subscription = _bluetoothCubit.stream.listen((bluetoothState) {
      emit(_mapToUiState(bluetoothState, _isOnlineData));
    });
  }

  static ExperimentUiState _mapToUiState(BluetoothDeviceState? state, bool isOnline) {
    if (state?.isExperimentDataLoading ?? true) {
      return const ExperimentUiState(isLoading: true);
    }

    final experimentData = state?.experimentData ?? ExperimentsData();
    final experimentOnlineData = state?.experimentOnlineData ?? ExperimentOnlineData();
    final statusDeviceData = state?.statusDeviceData ?? StatusDeviceData();

    final activeSensors = isOnline
        ? experimentOnlineData.sensorsData.keys.toList()
        : experimentData.activeSensors;

    final actualSensor = state?.selectedSensor ??
        (activeSensors.isNotEmpty ? activeSensors.first : SensorType.unknown);

    return ExperimentUiState(
      isLoading: false,
      sensorsData: isOnline ? experimentOnlineData.sensorsData : experimentData.sensorsData,
      activeSensors: activeSensors,
      actualSensor: actualSensor,
      sampleRate: isOnline ? statusDeviceData.lastSamplesRates : experimentData.sampleRate,
      samplesCount: isOnline ? statusDeviceData.lastSamplesCount : experimentData.samplesCount,
    );
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}

class ExperimentUiState {
  final bool isLoading;
  final dynamic sensorsData;
  final List<SensorType> activeSensors;
  final SensorType actualSensor;
  final Rates? sampleRate;
  final Samples? samplesCount;

  const ExperimentUiState({
    this.isLoading = true,
    this.sensorsData,
    this.activeSensors = const [],
    this.actualSensor = SensorType.unknown,
    this.sampleRate = Rates.rate10PerSec,
    this.samplesCount = Samples.samples100
  });
}
