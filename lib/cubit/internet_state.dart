//part of 'internet_cubit.dart';



import 'package:flutter/cupertino.dart';

import '../Constants/enums.dart';

@immutable
abstract class InternetState {}

class InternetLoading extends InternetState {}

class InternetConnected extends InternetState {
  final Connectiontypes connectiontypes;

  InternetConnected({required this.connectiontypes});

}

class InternDisconnected extends InternetState {}
