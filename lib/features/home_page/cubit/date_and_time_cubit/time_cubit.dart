import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

class TimeCubit extends Cubit<String> {
  TimeCubit() : super(_getCurrentTime()) {
    startClock();
  }
  late Timer _timer;
  static String _getCurrentTime() {
    final today = DateTime.now();
    final hour = today.hour;
    final min = today.minute.toString().padLeft(2, '0');
    final hour12 = hour % 12 == 0 ? 12 : hour % 12;
    final period = hour < 12 ? 'ص' : 'م';
    return '$hour12:$min $period';
  }

  void startClock() {
    _timer = Timer.periodic(const Duration(minutes: 1), (_) {
      emit(_getCurrentTime());
    });
  }

  @override
  Future<void> close() {
    _timer.cancel();
    return super.close();
  }
}
