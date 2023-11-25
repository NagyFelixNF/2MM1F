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

  Booking(this.start, this.patient, this.accel) {
    length = patient.fractionTime;
    finish = start.add(Duration(minutes: length));
  }

  @override
  String toString() {
    return "${patient.name}(${patient.fractionTime} min fraction), ${accel.name}: $start - $finish\n";
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

  void createBookings() {
    for (var i = 0; i < patients.length; i++) {
      Accel accel = findAccelerator(patients[i]);
      DateTime start;
      if (i == 0)
        start = DateTime(2023, 11, 27, 8);
      else
        start = bookings[i - 1].finish;
      if (start.hour > 17) {
        start = start.add(Duration(days: 1));
        start = DateTime(start.year, start.month, start.day, 8);
      }
      if (start.weekday >= 6) {
        start = start.add(Duration(days: 7 - (start.weekday - 1)));
      }
      Booking booking = Booking(start, patients[i], accel);
      bookings.add(booking);
    }

    // for (var patient in patients) {
    //   Accel accel = findAccelerator(patient);
    //   bookings.add(Booking())
    //   bookings.add(Booking(DateTime.now(), 30, patient, accel));
    // }
  }

  DateTime findTimeSlot(Patient patient, Accel accel) {
    DateTime result = DateTime(2023, 11, 27, 8);

    if (bookings.length < 1) {
      bookings.add(Booking(DateTime(2023, 11, 27, 8), patient, accel));
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

  void createBooking(Patient patient) {
    Accel accel = findAccelerator(patient);
    var values = bookings.where((element) => element.accel.name == accel.name);
    accel.occupiedTime =
        values.map((element) => element.length).reduce((a, b) => a + b);
    //create booking with patient and accelerator for the first time slot available

    // for (var i = 0; i < bookings.length - 1; i++) {
    //   check_two_times_is_before(bookings[i].start, bookings[i + 1].finish);
    // }
    // This doesn't check all the times and doesn't return the first window...
    // bookings.firstWhere((element) => element.finish
    //     .add(Duration(minutes: patient.fractionTime))
    //     .isBefore(element.start));
    //This doesn't check for the next element...

    findTimeSlot(patient, accel);

    //check_two_times_is_before()
    //bookings.firstWhere((element) => element.finish+patient.fractionTime)

    //return first where ( element.finish time + length ) is smaller than start_time, and
    // element.start_time is bigger than smart_time
  }

  void check_two_times_is_before(DateTime start, DateTime finish) {
    if (start.isAfter(finish)) {
      Duration diff = finish.difference(start);
      final minutes = diff.inMinutes;
      print('$minutes minutes');
    }
  }

  //Done I think
  Accel findAccelerator(Patient patient) {
    //return the accelerator the patient can be assigned to

    int min_occupancy =
        accelerators.map((element) => element.occupiedTime).reduce(min);
    Accel selected_acc = accelerators.firstWhere((element) =>
        patient.region.CanUse.contains(element.type) &&
        element.occupiedTime == min_occupancy);

    //= accelerators.firstWhere((element){patient.region.CanUse.contains})
    //return the first accelerator which has the least amount of assigned time
    //and is available for the patient

    return selected_acc;
  }

  void sortBookingsByDate(List<Booking> Bookings) {
    Bookings.sort((a, b) => a.start.compareTo(b.start));
  }
}
