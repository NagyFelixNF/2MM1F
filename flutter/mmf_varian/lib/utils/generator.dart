import 'dart:math';

import 'package:mmf_varian/models/Patient.dart';
import 'package:mmf_varian/models/Regions.dart';
import 'package:random_name_generator/random_name_generator.dart';

class PatientGenerator {
  PatientGenerator._();

  static Region GetRandomRegion() {
    Random random = Random();
    int i = random.nextInt(100) + 1;
    if (i == 1) {
      return Craniospinal();
    } else if (1 < i && i <= 26) {
      return Breast();
    } else if (27 <= i && i <= 31) {
      return BreastSpecial();
    } else if (32 <= i && i <= 42) {
      return HeadAndNeck();
    } else if (43 <= i && i <= 53) {
      return Abdomen();
    } else if (54 <= i && i <= 72) {
      return Pelvis();
    } else if (73 <= i && i <= 77) {
      return Crane();
    } else if (78 <= i && i <= 90) {
      return Lung();
    } else if (91 <= i && i <= 95) {
      return LungSpecial();
    } else {
      return WholeBrain();
    }
  }

  static List<Patient> GeneratePatient(int number) {
    final _random = Random();
    var randomNames = RandomNames(Zone.us);

    var patients = <Patient>[];
    for (var i = 0; i <= number; i++) {
      var Region = GetRandomRegion();
      var newPatient = Patient(
          name: randomNames.fullName(),
          region: Region,
          fractionNumber:
              Region.fractions[_random.nextInt(Region.fractions.length)],
          fractionTime: Region.fractionsTime);
      patients.add(newPatient);
    }
    return patients;
  }
}
