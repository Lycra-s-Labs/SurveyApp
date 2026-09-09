import 'package:flutter_test/flutter_test.dart';
import 'package:geoc/src/calc/survey_math.dart';

void main() {
  group('dmsToDecimalDegrees', () {
    test('converts DDD.MMSS bearings', () {
      expect(dmsToDecimalDegrees('52.3015'), closeTo(52.5041666667, 1e-10));
      expect(dmsToDecimalDegrees('310.1545'), closeTo(310.2625, 1e-10));
    });

    test('rejects invalid minutes and seconds', () {
      expect(() => dmsToDecimalDegrees('52.5960'), throwsFormatException);
      expect(() => dmsToDecimalDegrees('52.3065'), throwsFormatException);
    });

    test('rejects invalid degree range and nonzero 360 bearings', () {
      expect(() => dmsToDecimalDegrees('361.0000'), throwsFormatException);
      expect(() => dmsToDecimalDegrees('360.0001'), throwsFormatException);
    });

    test('accepts a zero-padded zero bearing and 360 degrees', () {
      expect(dmsToDecimalDegrees('0.0000'), 0.0);
      expect(dmsToDecimalDegrees('360.0000'), 360.0);
    });
  });
}
