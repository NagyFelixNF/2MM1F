import 'package:flutter/material.dart';
import 'package:mmf_varian/models/Bookings.dart';

class StatProvider extends ChangeNotifier {
  StatProvider();
  String Stat = "a";

  void initGetCoverageForDays(DateTime day, String acceler, Bookings bookings) {
    var accel =
        bookings.accelerators.firstWhere((element) => element.name == acceler);
    var accelBookings = bookings.getAccelBookings(bookings.bookings, accel);
    var dayAccelBookings = bookings.getDayBookings(accelBookings, day);

    int sum = 0;
    if (dayAccelBookings.length > 0) {
      sum = dayAccelBookings
          .map((element) => element.length)
          .reduce((a, b) => a + b);

      int max = 600;

      double wo = sum / max * 100.0;
      Stat = 'Today Coverage: ${wo}% ${sum}/${max}';
    } else {
      Stat = '';
    }
  }

  void getCoverageForDays(DateTime day, String acceler, Bookings bookings) {
    var accel =
        bookings.accelerators.firstWhere((element) => element.name == acceler);
    var accelBookings = bookings.getAccelBookings(bookings.bookings, accel);
    var dayAccelBookings = bookings.getDayBookings(accelBookings, day);

    int sum = 0;
    if (dayAccelBookings.length > 0) {
      sum = dayAccelBookings
          .map((element) => element.length)
          .reduce((a, b) => a + b);

      int max = 600;

      double wo = sum / max * 100.0;
      Stat = 'Today Coverage: ${wo.toStringAsFixed(1)}% ${sum}/${max}';
    } else {
      Stat = '';
    }
    notifyListeners();
  }
}
