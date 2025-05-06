import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hijri/hijri_calendar.dart';

class DateCubit extends Cubit<String> {
  DateCubit() : super(_getHijriTimeString()) {
    startClock();
  }
  late Timer _timer;

  static String _getHijriTimeString() {
    HijriCalendar.setLocal('ar');
    final today = HijriCalendar.now();
    final weekday = today.dayWeName;
    final day = today.hDay;
    final monthName = today.longMonthName;
    final year = today.hYear;

    return '$weekday $day $monthName $year';
  }

  void startClock() {
    _timer = Timer.periodic(const Duration(minutes: 1), (_) {
      emit(_getHijriTimeString());
    });
  }

  @override
  Future<void> close() {
    _timer.cancel();
    return super.close();
  }
}
