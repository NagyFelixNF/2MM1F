import 'dart:core';
import 'Regions.dart';

class Patient {
  final String name;
  final Region region;
  final int fractionNumber;
  final int fractionTime;

  Patient(
      {required this.name,
      required this.region,
      required this.fractionNumber,
      required this.fractionTime});

  @override
  String toString() {
    return "[$name, ${region.region}, $fractionNumber, $fractionTime]\n";
  }
}


/*páciens adatai
//név
//súly
//kor
//nem
//van-e ismert betegsége?
//szed e gyógyszert
//volt e már kezelésen
//kezelés állapota
//mozgó vagy fekvő beteg
//milyen szervével van baja? */