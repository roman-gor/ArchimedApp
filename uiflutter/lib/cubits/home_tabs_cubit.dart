import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class HomeTabsCubit extends Cubit<HomeTabs> {
  HomeTabsCubit() : super(HomeTabs.main);

  void switchTab(HomeTabs tab) {
    if (state != tab) {
      emit(tab);
    }
  }
}

enum HomeTabs {
  main(Icons.science_rounded),
  materials(Icons.book_rounded),
  devicesInfo(Icons.list_alt_rounded),
  settings(Icons.settings_rounded);

  const HomeTabs(this.icon);

  final IconData icon;
}
