import 'package:bloc/bloc.dart';
import 'package:uiflutter/extensions/sensor_type_extensions.dart';

import '../states/bluetooth/sensor_types.dart';

class ExperimentSettingsCubit extends Cubit<ExperimentSettings> {
  ExperimentSettingsCubit() : super(ExperimentSettings());
  
  void setSensors(SensorType newSensor) {
    final currentSensors = List<SensorType>.from(state.sensors);
    
    final isExactlySelected = currentSensors.contains(newSensor);
    
    currentSensors.removeWhere((sensor) => sensor.format == newSensor.format);

    if (!isExactlySelected) {
      currentSensors.add(newSensor);
    }
    
    emit(state.copyWith(sensors: currentSensors));
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
