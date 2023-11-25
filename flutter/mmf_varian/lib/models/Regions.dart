import 'dart:math';

import 'package:mmf_varian/models/Linear_acc.dart';

class Region {
  final String region;
  final List<int> fractions;
  final int fractionsTime;
  final List<LinearAccType> CanUse;

  Region(
      {required this.region,
      required this.fractions,
      required this.fractionsTime,
      required this.CanUse});
}

class Craniospinal extends Region {
  Craniospinal()
      : super(
            region: 'Craniospinal',
            fractions: <int>[13, 17, 20, 30],
            fractionsTime: 30,
            CanUse: <LinearAccType>[LinearAccType.trueBeam]);
}

class Breast extends Region {
  Breast()
      : super(
            region: 'Breast',
            fractions: <int>[15, 19, 25, 30],
            fractionsTime: 12,
            CanUse: <LinearAccType>[
              LinearAccType.clinac1,
              LinearAccType.vitalBeam,
              LinearAccType.trueBeam
            ]);
}

class BreastSpecial extends Region {
  BreastSpecial()
      : super(
            region: 'BreastSpecial',
            fractions: <int>[15, 19, 25, 30],
            fractionsTime: 20,
            CanUse: <LinearAccType>[LinearAccType.trueBeam]);
}

class HeadAndNeck extends Region {
  HeadAndNeck()
      : super(
            region: 'HeadAndNeck',
            fractions: <int>[5, 10, 15, 25, 30, 33, 35],
            fractionsTime: 12,
            CanUse: <LinearAccType>[
              LinearAccType.vitalBeam,
              LinearAccType.trueBeam
            ]);
}

class Abdomen extends Region {
  Abdomen()
      : super(
            region: 'Abdomen',
            fractions: <int>[1, 3, 5, 8, 10, 12, 15, 18, 20, 30],
            fractionsTime: 12,
            CanUse: <LinearAccType>[
              LinearAccType.vitalBeam,
              LinearAccType.trueBeam
            ]);
}

class Pelvis extends Region {
  Pelvis()
      : super(
            region: 'Pelvis',
            fractions: <int>[1, 3, 5, 10, 10, 15, 22, 23, 25, 28, 35],
            fractionsTime: 12,
            CanUse: <LinearAccType>[
              LinearAccType.vitalBeam,
              LinearAccType.trueBeam
            ]);
}

class Crane extends Region {
  Crane()
      : super(
            region: 'Crane',
            fractions: <int>[1, 5, 10, 13, 25, 30],
            fractionsTime: 10,
            CanUse: <LinearAccType>[
              LinearAccType.vitalBeam,
              LinearAccType.trueBeam
            ]);
}

class Lung extends Region {
  Lung()
      : super(
            region: 'Lung',
            fractions: <int>[1, 5, 10, 15, 20, 25, 30, 33],
            fractionsTime: 12,
            CanUse: <LinearAccType>[
              LinearAccType.vitalBeam,
              LinearAccType.trueBeam
            ]);
}

class LungSpecial extends Region {
  LungSpecial()
      : super(
            region: 'LungSpecial',
            fractions: <int>[3, 5, 8],
            fractionsTime: 15,
            CanUse: <LinearAccType>[
              LinearAccType.vitalBeam,
              LinearAccType.trueBeam
            ]);
}

class WholeBrain extends Region {
  WholeBrain()
      : super(
            region: 'WholeBrain',
            fractions: <int>[5, 10, 12],
            fractionsTime: 10,
            CanUse: <LinearAccType>[
              LinearAccType.vitalBeam,
              LinearAccType.clinac1
            ]);
}
