import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_navigation_bar.freezed.dart';

@freezed
class HomeNavigationBarEvent with _$HomeNavigationBarEvent {
  const HomeNavigationBarEvent._();

  const factory HomeNavigationBarEvent.changed(int index) =
      HomeNavigationBarChanged;
}

@freezed
class HomeNavigationBarState with _$HomeNavigationBarState {
  const HomeNavigationBarState._();

  factory HomeNavigationBarState.change(int index, [int? key]) =
      HomeNavigationBarChange;
}

/// Навигация домашнего экрана
class HomeNavigationBarBloc
    extends Bloc<HomeNavigationBarEvent, HomeNavigationBarState> {
  HomeNavigationBarBloc() : super(HomeNavigationBarChange(0)) {
    on<HomeNavigationBarChanged>(_changed);
  }

  void _changed(HomeNavigationBarChanged event, Emitter emit) {
    final index = event.index;
    try {
      emit(HomeNavigationBarChange(index, Random().nextInt(99999)));
    } catch (exception) {
      rethrow;
    }
  }
}
