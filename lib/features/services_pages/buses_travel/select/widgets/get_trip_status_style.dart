import 'package:flutter/material.dart';

String getTripStatusText(String status) {
  switch (status) {
    case '2':
      return 'وصلت';
    case '3':
      return 'معتمدة';
    default:
      return 'لدى الإنطلاق';
  }
}

Color getTripStatusColor(String status) {
  switch (status) {
    case '2':
      return const Color(0xFF46C469);
    case '3':
      return const Color(0xFF46C469);
    default:
      return Colors.orangeAccent;
  }
}

String getTripStatusIcon(String status) {
  switch (status) {
    case '2':
      return 'assets/svg/bus_status/done.svg';
    case '3':
      return 'assets/svg/bus_status/done.svg';
    default:
      return 'assets/svg/bus_status/waiting.svg';
  }
}
