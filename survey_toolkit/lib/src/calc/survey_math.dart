import 'dart:math';

class LatitudeDeparture {
  final double latitude;
  final double departure;

  const LatitudeDeparture({required this.latitude, required this.departure});

  LatitudeDeparture copyWith({double? latitude, double? departure}) {
    return LatitudeDeparture(
      latitude: latitude ?? this.latitude,
      departure: departure ?? this.departure,
    );
  }

  @override
  String toString() => 'LatitudeDeparture(latitude: $latitude, departure: $departure)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LatitudeDeparture &&
          runtimeType == other.runtimeType &&
          latitude == other.latitude &&
          departure == other.departure;

  @override
  int get hashCode => latitude.hashCode ^ departure.hashCode;
}

class CoordinateSolution {
  final LatitudeDeparture latitudeDeparture;
  final double easting;
  final double northing;

  const CoordinateSolution({
    required this.latitudeDeparture,
    required this.easting,
    required this.northing,
  });

  @override
  String toString() =>
      'CoordinateSolution(latitudeDeparture: $latitudeDeparture, easting: $easting, northing: $northing)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CoordinateSolution &&
          runtimeType == other.runtimeType &&
          latitudeDeparture == other.latitudeDeparture &&
          easting == other.easting &&
          northing == other.northing;

  @override
  int get hashCode => latitudeDeparture.hashCode ^ easting.hashCode ^ northing.hashCode;
}

class TraverseLineInput {
  final double distance;
  final double bearingDeg;

  const TraverseLineInput({required this.distance, required this.bearingDeg});

  @override
  String toString() => 'TraverseLineInput(distance: $distance, bearingDeg: $bearingDeg)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TraverseLineInput &&
          runtimeType == other.runtimeType &&
          distance == other.distance &&
          bearingDeg == other.bearingDeg;

  @override
  int get hashCode => distance.hashCode ^ bearingDeg.hashCode;
}

class TraverseLineResult {
  final TraverseLineInput input;
  final double latitude;
  final double departure;

  const TraverseLineResult({
    required this.input,
    required this.latitude,
    required this.departure,
  });

  @override
  String toString() =>
      'TraverseLineResult(input: $input, latitude: $latitude, departure: $departure)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TraverseLineResult &&
          runtimeType == other.runtimeType &&
          input == other.input &&
          latitude == other.latitude &&
          departure == other.departure;

  @override
  int get hashCode => input.hashCode ^ latitude.hashCode ^ departure.hashCode;
}

class TraverseAnalysis {
  final List<TraverseLineResult> lines;
  final double totalDistance;
  final double sumLatitude;
  final double sumDeparture;
  final double linearMisclose;
  final double? accuracyRatio;
  final List<LatitudeDeparture> bowditchCorrections;
  final List<LatitudeDeparture> transitCorrections;

  const TraverseAnalysis({
    required this.lines,
    required this.totalDistance,
    required this.sumLatitude,
    required this.sumDeparture,
    required this.linearMisclose,
    required this.accuracyRatio,
    required this.bowditchCorrections,
    required this.transitCorrections,
  });

  @override
  String toString() =>
      'TraverseAnalysis(totalDistance: $totalDistance, sumLatitude: $sumLatitude, sumDeparture: $sumDeparture, linearMisclose: $linearMisclose, accuracyRatio: $accuracyRatio)';
}

class AreaPoint {
  final double easting;
  final double northing;

  const AreaPoint({required this.easting, required this.northing});

  @override
  String toString() => 'AreaPoint(easting: $easting, northing: $northing)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AreaPoint && runtimeType == other.runtimeType && easting == other.easting && northing == other.northing;

  @override
  int get hashCode => easting.hashCode ^ northing.hashCode;
}

class CircleResult {
  final double centerEasting;
  final double centerNorthing;
  final double radius;

  const CircleResult({
    required this.centerEasting,
    required this.centerNorthing,
    required this.radius,
  });

  @override
  String toString() => 'CircleResult(centerEasting: $centerEasting, centerNorthing: $centerNorthing, radius: $radius)';
}

class IntersectionResult {
  final double easting;
  final double northing;
  final double distance1;
  final double distance2;

  const IntersectionResult({
    required this.easting,
    required this.northing,
    required this.distance1,
    required this.distance2,
  });

  @override
  String toString() => 'IntersectionResult(easting: $easting, northing: $northing, distance1: $distance1, distance2: $distance2)';
}

class ResectionResult {
  final double easting;
  final double northing;
  final List<double> residuals;

  const ResectionResult({
    required this.easting,
    required this.northing,
    required this.residuals,
  });

  @override
  String toString() => 'ResectionResult(easting: $easting, northing: $northing, residuals: $residuals)';
}

class MissingLinesResult {
  final double distance1;
  final double distance2;
  final double bearing1;
  final double bearing2;

  const MissingLinesResult({
    required this.distance1,
    required this.distance2,
    required this.bearing1,
    required this.bearing2,
  });

  @override
  String toString() =>
      'MissingLinesResult(distance1: $distance1, distance2: $distance2, bearing1: $bearing1, bearing2: $bearing2)';
}

class LevelingResult {
  final double elevation;
  final double backsight;
  final double foresight;
  final double heightOfInstrument;

  const LevelingResult({
    required this.elevation,
    required this.backsight,
    required this.foresight,
    required this.heightOfInstrument,
  });

  @override
  String toString() =>
      'LevelingResult(elevation: $elevation, backsight: $backsight, foresight: $foresight, heightOfInstrument: $heightOfInstrument)';
}

class SecantsResult {
  final List<double> offsets;
  final List<double> distances;
  final double totalArea;

  const SecantsResult({
    required this.offsets,
    required this.distances,
    required this.totalArea,
  });

  @override
  String toString() => 'SecantsResult(offsets: $offsets, distances: $distances, totalArea: $totalArea)';
}

double normalizeBearing(double degrees) {
  return ((degrees % 360.0) + 360.0) % 360.0;
}

String formatValue(double value, {int decimals = 3}) {
  return value.toStringAsFixed(decimals);
}

String formatBearing(double value, {int decimals = 2}) {
  return normalizeBearing(value).toStringAsFixed(decimals);
}

String wcbToQuadrantBearing(double bearingDeg) {
  final b = normalizeBearing(bearingDeg);
  if (b <= 90.0) {
    return 'N ${formatBearing(b)}° E';
  } else if (b <= 180.0) {
    return 'S ${formatBearing(180.0 - b)}° E';
  } else if (b <= 270.0) {
    return 'S ${formatBearing(b - 180.0)}° W';
  } else {
    return 'N ${formatBearing(360.0 - b)}° W';
  }
}

double quadrantBearingToWcb(String prefix, double angleDeg, String suffix) {
  final ns = prefix.trim().toUpperCase();
  final ew = suffix.trim().toUpperCase();
  final angle = angleDeg.clamp(0.0, 90.0);

  double wcb;
  if (ns == 'N' && ew == 'E') {
    wcb = angle;
  } else if (ns == 'S' && ew == 'E') {
    wcb = 180.0 - angle;
  } else if (ns == 'S' && ew == 'W') {
    wcb = 180.0 + angle;
  } else if (ns == 'N' && ew == 'W') {
    wcb = 360.0 - angle;
  } else {
    wcb = angle;
  }
  return normalizeBearing(wcb);
}

double internalAngleFromBearings(double firstBearingDeg, double secondBearingDeg) {
  final diff = (normalizeBearing(secondBearingDeg) - normalizeBearing(firstBearingDeg)).abs();
  return diff > 180.0 ? 360.0 - diff : diff;
}

double bearingFromKnownAndInternal(double knownBearingDeg, double internalAngleDeg, bool turnRight) {
  return normalizeBearing(turnRight ? knownBearingDeg + internalAngleDeg : knownBearingDeg - internalAngleDeg);
}

LatitudeDeparture latitudeDeparture(double distance, double bearingDeg) {
  final radians = normalizeBearing(bearingDeg) * pi / 180.0;
  final latitude = distance * cos(radians);
  final departure = distance * sin(radians);
  return LatitudeDeparture(latitude: latitude, departure: departure);
}

CoordinateSolution coordinateFromStart(double startEasting, double startNorthing, double distance, double bearingDeg) {
  final ld = latitudeDeparture(distance, bearingDeg);
  return CoordinateSolution(
    latitudeDeparture: ld,
    easting: startEasting + ld.departure,
    northing: startNorthing + ld.latitude,
  );
}

double distanceBetweenCoordinates(double startEasting, double startNorthing, double endEasting, double endNorthing) {
  final deltaE = endEasting - startEasting;
  final deltaN = endNorthing - startNorthing;
  return sqrt(deltaE * deltaE + deltaN * deltaN);
}

double bearingBetweenCoordinates(double startEasting, double startNorthing, double endEasting, double endNorthing) {
  final deltaE = endEasting - startEasting;
  final deltaN = endNorthing - startNorthing;
  final radians = atan2(deltaE, deltaN);
  return normalizeBearing(radians * 180.0 / pi);
}

double linearMisclose(double sumLatitude, double sumDeparture) {
  return sqrt(sumLatitude * sumLatitude + sumDeparture * sumDeparture);
}

double? traverseAccuracyRatio(double totalDistance, double linearMisclose) {
  return linearMisclose <= 0.0 ? null : totalDistance / linearMisclose;
}

TraverseAnalysis analyzeTraverse(List<TraverseLineInput> lines) {
  final results = lines.map((input) {
    final ld = latitudeDeparture(input.distance, input.bearingDeg);
    return TraverseLineResult(input: input, latitude: ld.latitude, departure: ld.departure);
  }).toList();

  final totalDistance = results.fold<double>(0.0, (sum, r) => sum + r.input.distance);
  final sumLatitude = results.fold<double>(0.0, (sum, r) => sum + r.latitude);
  final sumDeparture = results.fold<double>(0.0, (sum, r) => sum + r.departure);
  final misclose = linearMisclose(sumLatitude, sumDeparture);
  final accuracyRatio = traverseAccuracyRatio(totalDistance, misclose);

  final bowditchCorrections = totalDistance > 0.0
      ? results.map((r) {
          return LatitudeDeparture(
            latitude: -sumLatitude * (r.input.distance / totalDistance),
            departure: -sumDeparture * (r.input.distance / totalDistance),
          );
        }).toList()
      : results.map((_) => const LatitudeDeparture(latitude: 0.0, departure: 0.0)).toList();

  final totalAbsLatitude = results.fold<double>(0.0, (sum, r) => sum + r.latitude.abs());
  final totalAbsDeparture = results.fold<double>(0.0, (sum, r) => sum + r.departure.abs());

  final transitCorrections = results.map((r) {
    return LatitudeDeparture(
      latitude: totalAbsLatitude > 0.0 ? -sumLatitude * (r.latitude.abs() / totalAbsLatitude) : 0.0,
      departure: totalAbsDeparture > 0.0 ? -sumDeparture * (r.departure.abs() / totalAbsDeparture) : 0.0,
    );
  }).toList();

  return TraverseAnalysis(
    lines: results,
    totalDistance: totalDistance,
    sumLatitude: sumLatitude,
    sumDeparture: sumDeparture,
    linearMisclose: misclose,
    accuracyRatio: accuracyRatio,
    bowditchCorrections: bowditchCorrections,
    transitCorrections: transitCorrections,
  );
}

double areaByCoordinates(List<AreaPoint> points) {
  if (points.length < 3) return 0.0;
  double area = 0.0;
  for (int i = 0; i < points.length; i++) {
    final j = (i + 1) % points.length;
    area += points[i].easting * points[j].northing;
    area -= points[j].easting * points[i].northing;
  }
  return (area / 2.0).abs();
}

CircleResult centerOfCircle(AreaPoint p1, AreaPoint p2, AreaPoint p3) {
  final a = p2.easting - p1.easting;
  final b = p2.northing - p1.northing;
  final c = p3.easting - p1.easting;
  final d = p3.northing - p1.northing;

  final e = a * (p1.easting + p2.easting) + b * (p1.northing + p2.northing);
  final f = c * (p1.easting + p3.easting) + d * (p1.northing + p3.northing);
  final g = 2.0 * (a * (p3.northing - p2.northing) - b * (p3.easting - p2.easting));

  if (g == 0.0) {
    return CircleResult(centerEasting: 0.0, centerNorthing: 0.0, radius: 0.0);
  }

  final centerEasting = (d * e - b * f) / g;
  final centerNorthing = (a * f - c * e) / g;
  final radius = sqrt((p1.easting - centerEasting) * (p1.easting - centerEasting) +
      (p1.northing - centerNorthing) * (p1.northing - centerNorthing));

  return CircleResult(centerEasting: centerEasting, centerNorthing: centerNorthing, radius: radius);
}

IntersectionResult intersection(
  AreaPoint p1, double bearing1,
  AreaPoint p2, double bearing2,
) {
  final b1 = normalizeBearing(bearing1) * pi / 180.0;
  final b2 = normalizeBearing(bearing2) * pi / 180.0;

  final cot1 = 1.0 / tan(b1);
  final cot2 = 1.0 / tan(b2);

  final denominator = cot2 - cot1;
  if (denominator.abs() < 1e-10) {
    return IntersectionResult(easting: 0.0, northing: 0.0, distance1: 0.0, distance2: 0.0);
  }

  final easting = (p2.easting * cot2 - p1.easting * cot1 + p1.northing - p2.northing) / denominator;
  final northing = (p2.northing * tan(b2) - p1.northing * tan(b1) + p1.easting - p2.easting) / (tan(b2) - tan(b1));

  final distance1 = distanceBetweenCoordinates(p1.easting, p1.northing, easting, northing);
  final distance2 = distanceBetweenCoordinates(p2.easting, p2.northing, easting, northing);

  return IntersectionResult(easting: easting, northing: northing, distance1: distance1, distance2: distance2);
}

ResectionResult resection(List<AreaPoint> knownPoints, List<double> observedAngles) {
  if (knownPoints.length < 3 || observedAngles.length < 3) {
    return ResectionResult(easting: 0.0, northing: 0.0, residuals: []);
  }

  double bestEasting = knownPoints.fold<double>(0.0, (sum, p) => sum + p.easting) / knownPoints.length;
  double bestNorthing = knownPoints.fold<double>(0.0, (sum, p) => sum + p.northing) / knownPoints.length;

  for (int iter = 0; iter < 10; iter++) {
    double sumX = 0, sumY = 0, sumW = 0;
    final residuals = <double>[];

    for (int i = 0; i < knownPoints.length; i++) {
      final p = knownPoints[i];
      final dx = p.easting - bestEasting;
      final dy = p.northing - bestNorthing;
      final dist = sqrt(dx * dx + dy * dy);
      if (dist < 1e-10) continue;

      final calcBearing = atan2(dx, dy) * 180.0 / pi;
      final obsBearing = normalizeBearing(calcBearing + observedAngles[i]);
      final diff = normalizeBearing(obsBearing - calcBearing);
      residuals.add(diff);

      final weight = 1.0 / (dist * dist);
      sumX += weight * p.easting;
      sumY += weight * p.northing;
      sumW += weight;
    }

    if (sumW > 0) {
      bestEasting = sumX / sumW;
      bestNorthing = sumY / sumW;
    }
  }

  final finalResiduals = <double>[];
  for (int i = 0; i < knownPoints.length; i++) {
    final p = knownPoints[i];
    final dx = p.easting - bestEasting;
    final dy = p.northing - bestNorthing;
    final calcBearing = atan2(dx, dy) * 180.0 / pi;
    final obsBearing = normalizeBearing(calcBearing + observedAngles[i]);
    finalResiduals.add(normalizeBearing(obsBearing - calcBearing));
  }

  return ResectionResult(easting: bestEasting, northing: bestNorthing, residuals: finalResiduals);
}

MissingLinesResult twoMissingLines(
  AreaPoint start, AreaPoint end,
  double bearing1, double bearing2,
) {
  final b1 = normalizeBearing(bearing1) * pi / 180.0;
  final b2 = normalizeBearing(bearing2) * pi / 180.0;

  final dx = end.easting - start.easting;
  final dy = end.northing - start.northing;

  final sinB1 = sin(b1);
  final cosB1 = cos(b1);
  final sinB2 = sin(b2);
  final cosB2 = cos(b2);

  final denominator = sinB1 * cosB2 - cosB1 * sinB2;
  if (denominator.abs() < 1e-10) {
    return const MissingLinesResult(distance1: 0.0, distance2: 0.0, bearing1: 0.0, bearing2: 0.0);
  }

  final distance1 = (dx * cosB2 - dy * sinB2) / denominator;
  final distance2 = (dx * cosB1 - dy * sinB1) / denominator;

  return MissingLinesResult(
    distance1: distance1.abs(),
    distance2: distance2.abs(),
    bearing1: bearing1,
    bearing2: bearing2,
  );
}

LevelingResult levelingSurvey({
  required double benchmarkElevation,
  required double backsight,
  required double foresight,
}) {
  final heightOfInstrument = benchmarkElevation + backsight;
  final elevation = heightOfInstrument - foresight;
  return LevelingResult(
    elevation: elevation,
    backsight: backsight,
    foresight: foresight,
    heightOfInstrument: heightOfInstrument,
  );
}

SecantsResult secantsEqualWidth({
  required double baseline,
  required int numSections,
  required List<double> offsets,
}) {
  if (offsets.length != numSections + 1) {
    return const SecantsResult(offsets: [], distances: [], totalArea: 0.0);
  }

  final sectionWidth = baseline / numSections;
  final distances = List.generate(numSections + 1, (i) => i * sectionWidth);
  double totalArea = 0.0;

  for (int i = 0; i < numSections; i++) {
    totalArea += (offsets[i] + offsets[i + 1]) / 2.0 * sectionWidth;
  }

  return SecantsResult(offsets: offsets, distances: distances, totalArea: totalArea.abs());
}

SecantsResult secantsNonEqualWidth({
  required List<double> distances,
  required List<double> offsets,
}) {
  if (distances.length != offsets.length || distances.length < 2) {
    return const SecantsResult(offsets: [], distances: [], totalArea: 0.0);
  }

  double totalArea = 0.0;
  for (int i = 0; i < distances.length - 1; i++) {
    final width = distances[i + 1] - distances[i];
    totalArea += (offsets[i] + offsets[i + 1]) / 2.0 * width;
  }

  return SecantsResult(offsets: offsets, distances: distances, totalArea: totalArea.abs());
}

AreaPoint centerPoint(List<AreaPoint> points) {
  if (points.isEmpty) return const AreaPoint(easting: 0.0, northing: 0.0);
  final sumE = points.fold<double>(0.0, (sum, p) => sum + p.easting);
  final sumN = points.fold<double>(0.0, (sum, p) => sum + p.northing);
  return AreaPoint(easting: sumE / points.length, northing: sumN / points.length);
}