import 'dart:async';

import 'package:bloc_proj/Constants/enums.dart';
import 'package:bloc_proj/cubit/counter_state.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_proj/cubit/internet_state.dart';
import 'package:flutter/cupertino.dart';

import 'internet_cubit.dart';

//part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  final InternetCubit internetCubit;
  late StreamSubscription internetStreamSubscription;

  CounterCubit({required this.internetCubit})
      : super(CounterState(counterValue: 0, wasIncremented: false)) {
    internetStreamSubscription = internetCubit.listen((internetState) {
      if (internetState is InternetConnected &&
          internetState.connectiontypes == Connectiontypes.Wifi) {
        increment();
      } else if (internetState is InternetConnected &&
          internetState.connectiontypes == Connectiontypes.Mobile) {
        decrement();
      }
    });
  }

  void increment() => emit(
      CounterState(counterValue: state.counterValue + 1, wasIncremented: true));
  void decrement() => emit(CounterState(
      counterValue: state.counterValue - 1, wasIncremented: false));


  @override
  Future<void> close() {
    internetStreamSubscription.cancel();
    return super.close();
  }
}
