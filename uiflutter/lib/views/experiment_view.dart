import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uiflutter/extensions/build_context_local.dart';
import 'package:uiflutter/states/bluetooth/bluetooth_ui_event.dart';

import '../data/bluetooth_cubit.dart';
import '../states/bluetooth/bluetooth_states.dart';

class ExperimentView extends StatefulWidget {
  const ExperimentView({super.key, required this.experimentId});

  final int experimentId;

  @override
  State<StatefulWidget> createState() => ExperimentViewState();
}

class ExperimentViewState extends State<ExperimentView> {
  late final BluetoothCubit _bluetoothCubit;

  @override
  void initState() {
    _bluetoothCubit = BluetoothCubit();
    _bluetoothCubit.sendCommand(
      BluetoothUiEvent.onSendCommand(
        DeviceCommand.getExperimentData(widget.experimentId),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _bluetoothCubit,
      child: Container(
        color: context.colors.secondary,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            bottom: false,
            top: false,
            child: BlocBuilder<BluetoothCubit, BluetoothDeviceState?>(
              builder: (context, bluetoothState) {
                final experimentData =
                    bluetoothState?.experimentData ?? ExperimentsData();
                final isExperimentLoading =
                    bluetoothState?.isExperimentLoading ?? true;
                if (isExperimentLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Padding(
                    padding: EdgeInsets.only(
                      left: context.dimens.paddingLarge,
                      right: context.dimens.paddingLarge,
                      bottom: context.dimens.paddingLarge,
                      top: context.dimens.paddingExtraLarge,
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Text(
                          "Experiment data: ${experimentData.activeSensors.length}",
                        )
                      ],
                    )
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
