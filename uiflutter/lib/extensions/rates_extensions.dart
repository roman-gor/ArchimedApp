import '../states/bluetooth/sensor_types.dart';

extension RatesLocal on Rates {
  double get count =>
      switch(this) {
        Rates.rate1PerSec => 1,
        Rates.rate10PerSec => 10,
        Rates.rate100PerSec => 100,
        Rates.rate20000PerSec => 20000
      };
}

extension RateFromInt on int {
  Rates get rateType =>
      switch(this) {
        1 => Rates.rate1PerSec,
        10 => Rates.rate10PerSec,
        100 => Rates.rate100PerSec,
        20000 => Rates.rate20000PerSec,
        _ => Rates.rate10PerSec
      };
}
