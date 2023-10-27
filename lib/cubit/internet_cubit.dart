import 'dart:async';

import 'package:bloc_proj/Constants/enums.dart';
import 'package:bloc_proj/cubit/internet_state.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InternetCubit extends Cubit<InternetState> {
  final Connectivity connectivity;
  late StreamSubscription connectivitystreamSubscription;
  InternetCubit({required this.connectivity}) : super(InternetLoading()) {
    monitorInternetConnection();
  }

  StreamSubscription<ConnectivityResult> monitorInternetConnection() {
    return connectivitystreamSubscription =
      connectivity.onConnectivityChanged.listen((connectivityResult) {
    if (connectivityResult == ConnectivityResult.wifi) {
      emitInternetConnected(Connectiontypes.Wifi);
    } else if (connectivityResult == ConnectivityResult.mobile) {
      emitInternetDisconnected(Connectiontypes.Mobile);
    } else if (connectivityResult == ConnectivityResult.none) {
      emit(InternDisconnected());
    }
  });
  }

  void emitInternetConnected(Connectiontypes _connectiontypes) =>
      emit(InternetConnected(connectiontypes: _connectiontypes));

  void emitInternetDisconnected(Connectiontypes mobile) =>
      emit(InternDisconnected());

  @override
  Future<void> close() {
    connectivitystreamSubscription.cancel();
    return super.close();
  }
}
