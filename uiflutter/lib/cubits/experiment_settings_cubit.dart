import 'package:bloc/bloc.dart';

import '../states/bluetooth/sensor_types.dart';

class ExperimentSettingsCubit extends Cubit<ExperimentSettings> {
  ExperimentSettingsCubit() : super(ExperimentSettings());
  
  void setSensors(SensorType sensorType) {
    final updatedSensors = List<SensorType>.from(state.sensors);

    if (!updatedSensors.contains(sensorType)) {
      updatedSensors.add(sensorType);
    } else {
      updatedSensors.remove(sensorType);
    }
    emit(state.copyWith(sensors: updatedSensors));
  }
  
  void setSamples(Samples samples) {
    emit(state.copyWith(samplesCount: samples));
  }
  
  void setRate(Rates rate) {
    emit(state.copyWith(sampleRate: rate));
  }
}

class ExperimentSettings {
  final List<SensorType> sensors;
  final Samples samplesCount;
  final Rates sampleRate;

  ExperimentSettings({
    this.sensors = const [],
    this.samplesCount = Samples.samples100,
    this.sampleRate = Rates.rate10PerSec,
  });

  ExperimentSettings copyWith({
    List<SensorType>? sensors,
    Samples? samplesCount,
    Rates? sampleRate,
  }) {
    return ExperimentSettings(
      sensors: sensors ?? this.sensors,
      samplesCount: samplesCount ?? this.samplesCount,
      sampleRate: sampleRate ?? this.sampleRate,
    );
  }
}
