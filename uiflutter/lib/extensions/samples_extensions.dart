import '../states/bluetooth/sensor_types.dart';

extension SamplesLocal on Samples {
  int get count =>
      switch(this) {
        Samples.samples10 => 10,
        Samples.samples100 => 100,
        Samples.samples1000 => 1000,
        Samples.samples10000 => 10000,
      };
}

extension SamplesFromInt on int {
  Samples get samplesType =>
      switch(this) {
        10 => Samples.samples10,
        100 => Samples.samples100,
        1000 => Samples.samples1000,
        10000 => Samples.samples10000,
        _ => Samples.samples10
      };
}
