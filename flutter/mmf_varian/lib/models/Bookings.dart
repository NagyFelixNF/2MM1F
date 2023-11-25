import 'dart:math';

import 'package:intl/intl.dart';
import 'package:mmf_varian/models/Linear_acc.dart';
import 'package:mmf_varian/models/Patient.dart';
import 'package:mmf_varian/utils/generator.dart';

class Booking {
  final DateTime start;
  DateTime finish = DateTime.now();
  int length = 0;
  final Patient patient;
  final Accel accel;
  final int currentTreatmentNumber;

  Booking(this.start, this.patient, this.accel, this.currentTreatmentNumber) {
    length = patient.fractionTime;
    finish = start.add(Duration(minutes: length));
  }

  @override
  String toString() {
    return "${patient.name}(${patient.region.region} region, ${patient.fractionTime} min fraction), ${accel.name}: $start - $finish\n";
  }
}

class Bookings {
  List<Booking> bookings = [];
  List<Patient> patients = PatientGenerator.GeneratePatient(1000);
  List<Accel> accelerators = [
    Accel(type: LinearAccType.vitalBeam, name: "VitalBeam1", isAvailable: true),
    Accel(type: LinearAccType.vitalBeam, name: "VitalBeam2", isAvailable: true),
    Accel(type: LinearAccType.trueBeam, name: "TrueBeam1", isAvailable: true),
    Accel(type: LinearAccType.trueBeam, name: "TrueBeam2", isAvailable: true),
    Accel(type: LinearAccType.clinac1, name: "Clinac", isAvailable: true),
  ];

  Bookings();

  // void createBookings() {
  //   for (var i = 0; i < patients.length; i++) {
  //     Accel accel = findAccelerator(patients[i]);

  //     List<Booking> values = [];
  //     if (bookings.isNotEmpty) {
  //       values = bookings
  //           .where((element) => element.accel.name == accel.name)
  //           .toList();
  //       if (values.isNotEmpty) {
  //         var mappedvalues = values.map((element) => element.length);
  //         accel.occupiedTime = mappedvalues.reduce((a, b) => a + b);
  //       }
  //     }
  //     DateTime start;
  //     if (values.isEmpty) {
  //       // There's no booking for the accelerator yet.
  //       start = DateTime(2023, 11, 27, 8);
  //     } else {
  //       //start = bookings[i - 1].finish;
  //       //There's already booking for the found accelerator
  //       start = values.last.finish; //!!!!!!!!!! BUG !!!!!!!!!!!!
  //       var days = <DateTime>{};
  //       values
  //           .forEach((element) => days.add(element.start)); //Unique days added

  //       var days_list = days.toList();

  //       days_list.sort();

  //       //Check unique days:
  //       bool breaks = false;
  //       for (var day in days_list) {
  //         var day_values =
  //             values.where((element) => isSameDay(element.start, day)).toList();
  //         //Check every relevant booking
  //         if (day_values.length > 1) {
  //           for (var k = 1; k < day_values.length; k++) {
  //             //Duration diff = finish.difference(start);
  //             Duration diff =
  //                 day_values[k].start.difference(day_values[k - 1].finish);
  //             if (diff.inMinutes > patients[i].fractionTime) {
  //               start = day_values[k - 1].finish;
  //               breaks = true;
  //               break;
  //             }
  //           }
  //         }
  //         if (breaks) break;
  //       }
  //       //This checks

  //       //find unique days in bookings
  //       //find a day where there is a free slot

  //       // findBookingsToday()
  //       //start = bookings.finish
  //       //if(booking[i+1].finish - booking[i].start > patient.fractionTime)
  //     }
  //     if (start.hour > 17) {
  //       start = start.add(Duration(days: 1));
  //       start = DateTime(start.year, start.month, start.day, 8);
  //     }
  //     if (start.weekday >= 6) {
  //       start = start.add(Duration(days: 7 - (start.weekday - 1)));
  //     }
  //     // for (var j = 1; j < patients[i].fractionNumber; j++) {
  //     //   start = start.add(Duration(days: 1));
  //     //   // if(values.any((element)=>element.start.isAtSameMomentAs(start))
  //     //   //   something;
  //     //   Booking b = Booking(start, patients[i], accel);
  //     //   bookings.add(b);
  //     // }

  //     Booking booking = Booking(start, patients[i], accel);
  //     bookings.add(booking);
  //   }
  // }

  void createBookings2() {
    for (var i = 0; i < patients.length; i++) {
      DateTime starting_day = DateTime.now().add(Duration(days: 1));
      starting_day = moveFromWeekend(starting_day);
      for (var j = 0; j < patients[i].fractionNumber; j++) {
        Accel accel = findAccelerator(patients[i], starting_day);
        var start = getFirstSlotStartTime(accel, starting_day, patients[i]);
        if (isWeekend(start)) {
          print(start);
        }
        patients[i].currentFractionNumber++;
        Booking booking = Booking(
            start, patients[i], accel, patients[i].currentFractionNumber);
        bookings.add(booking);
        starting_day = booking.start.add(Duration(days: 1));
        starting_day = moveFromWeekend(starting_day);
      }
    }
  }

  bool isWeekend(DateTime date) =>
      date.weekday == DateTime.saturday || date.weekday == DateTime.sunday;
  DateTime moveFromWeekend(DateTime date) {
    if (date.weekday == DateTime.saturday || date.weekday == DateTime.sunday) {
      return date
          .add(Duration(days: DateTime.daysPerWeek - (date.weekday - 1)));
    } else {
      return date;
    }
  }

  // Use only if there is already a booking for the day!
  List<Booking> findBookingsToday(int year, int month, int day) => bookings
      .where((element) =>
          element.start.year == year &&
          element.start.month == month &&
          element.start.day == day)
      .toList();

  bool isSameDay(DateTime date1, DateTime date2) =>
      date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;

  DateTime findTimeSlot(Patient patient, Accel accel) {
    DateTime result = DateTime(2023, 11, 27, 8);

    if (bookings.length < 1) {
      bookings.add(Booking(DateTime(2023, 11, 27, 8), patient, accel, 0));
    }
    for (var i = 0; i < bookings.length - 1; i++) {
      var booking = bookings[i];
      var nextBooking = bookings[i + 1];
      var endTime =
          booking.finish.add(Duration(minutes: booking.patient.fractionTime));

      if (endTime.isBefore(nextBooking.start)) {
        break;
      }
    }

    return result;
  }

  // void createBooking(Patient patient) {
  //   Accel accel = findAccelerator(patient);
  //   var values = bookings.where((element) => element.accel.name == accel.name);
  //   accel.occupiedTime =
  //       values.map((element) => element.length).reduce((a, b) => a + b);

  //   findTimeSlot(patient, accel);
  // }

  // void check_two_times_is_before(DateTime start, DateTime finish) {
  //   if (start.isAfter(finish)) {
  //     Duration diff = finish.difference(start);
  //     final minutes = diff.inMinutes;
  //     print('$minutes minutes');
  //   }
  // }

  //Done I think
  Accel findAccelerator(Patient patient, DateTime day) {
    //return the accelerator the patient can be assigned to

    // Accel selected_acc = accelerators.firstWhere((element) =>
    //     patient.region.CanUse.contains(element.type));
    var canUseAccelerators = accelerators
        .where((element) => patient.region.CanUse.contains(element.type))
        .toList();

    // int min_occupancy =
    //     canUseAccelerators.map((element) => element.occupiedTime).reduce(min);

    // Accel selected_acc = canUseAccelerators
    //     .firstWhere((element) => element.occupiedTime == min_occupancy);

    var occupied_times = {};

    for (var i = 0; i < canUseAccelerators.length; i++) {
      occupied_times[i] = occupiedTime(canUseAccelerators[i], day);
    }
    int min_idx = 0;
    for (var i = 0; i < canUseAccelerators.length; i++) {
      if (occupied_times[i] < occupied_times[min_idx]) min_idx = i;
    }

    Accel selected_acc = canUseAccelerators[min_idx];
    // List<int> occupied_times = [];
    // canUseAccelerators
    //     .forEach((element) => occupied_times.add(occupiedTime(element, day)));
    // int min_occupancy = occupied_times.reduce(min);

    // Accel selected_acc = canUseAccelerators
    //     .firstWhere((element) => occupiedTime(element, day) == min_occupancy);

    //occupiedTime(accel, day)
    //= accelerators.firstWhere((element){patient.region.CanUse.contains})
    //return the first accelerator which has the least amount of assigned time
    //and is available for the patient

    return selected_acc;
  }

  List<Booking> getAccelBookings(List<Booking> list, Accel accel) =>
      list.where((element) => element.accel.name == accel.name).toList();

  List<Booking> getDayBookings(List<Booking> list, DateTime day) =>
      list.where((element) => isSameDay(element.start, day)).toList();

  int occupiedTime(Accel accel, DateTime day) {
    //Returns the occupied time of the accelerator for the given day from the bookings.

    var accelBookings = getAccelBookings(bookings, accel);
    var dayAccelBookings = getDayBookings(accelBookings, day);

    //Sum of all relevant booking durations
    if (dayAccelBookings.length == 0) return 0;
    int result = dayAccelBookings
        .map((element) => element.length)
        .reduce((a, b) => a + b);
    return result;
  }

  DateTime getFirstSlotStartTime(Accel accel, DateTime day, Patient patient) {
    day = moveFromWeekend(day);
    var accelBookings = getAccelBookings(bookings, accel);
    var dayAccelBookings = getDayBookings(accelBookings, day);

    DateTime start;
    if (dayAccelBookings.length == 0) {
      start = DateTime(day.year, day.month, day.day, 8);
      moveFromWeekend(start);
      return start;
    }
    if (dayAccelBookings.length == 1) {
      start = dayAccelBookings.first.finish;
      return start;
    }
    if (dayAccelBookings.length > 1) {
      sortBookingsByDate(dayAccelBookings);

      for (var i = 0; i < dayAccelBookings.length - 1; i++) {
        var first = dayAccelBookings[i];
        var second = dayAccelBookings[i + 1];

        //Duration diff = day_values[k].start.difference(day_values[k - 1].finish);
        var diff = second.start.difference(first.finish).inMinutes;

        if (patient.fractionTime < diff) {
          return first.finish;
        }
      }
      var closing_hour = DateTime(day.year, day.month, day.day, 18);
      var diff =
          closing_hour.difference(dayAccelBookings.last.finish).inMinutes;
      if (diff > patient.fractionTime) {
        return dayAccelBookings.last.finish;
      }
    }
    var tomorrow = day.add(Duration(days: 1));
    return getFirstSlotStartTime(accel, tomorrow, patient);
  }

  void sortBookingsByDate(List<Booking> bookings) {
    bookings.sort((a, b) => a.start.compareTo(b.start));
  }
}
