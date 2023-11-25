import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:mmf_varian/models/Patient.dart';

class Event extends ChangeNotifier {
  final DateFormat formatter = DateFormat('Hm');
  Event(
      {this.description,
      this.color,
      required this.start,
      required this.end,
      required this.patient});

  /// The title of the [Event].
  String get title =>
      "${patient.name}\t${formatter.format(start)}-${formatter.format(end)}, ${patient.region.region}}";

  /// The description of the [Event].
  final String? description;

  /// The color of the [Event] tile.
  final Color? color;
  DateTime start;

  DateTime end;

  final Patient patient;

  void notify() {
    notifyListeners();
  }
}
