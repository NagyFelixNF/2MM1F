enum LinearAccType { clinac1, vitalBeam, trueBeam }

class Accel {
  final LinearAccType type;
  // final DateTime starting_hour;
  // DateTime ending_hour = DateTime.now().add(const Duration(hours: 10));
  final String name;
  bool isAvailable;
  int occupiedTime = 0;

  Accel({required this.type, required this.name, required this.isAvailable});
}
