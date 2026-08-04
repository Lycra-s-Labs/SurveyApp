package com.danixdekaldgu4c2.surveyapps

import com.danixdekaldgu4c2.surveyapps.ui.analyzeTraverse
import com.danixdekaldgu4c2.surveyapps.ui.bearingFromKnownAndInternal
import com.danixdekaldgu4c2.surveyapps.ui.coordinateFromStart
import com.danixdekaldgu4c2.surveyapps.ui.distanceBetweenCoordinates
import com.danixdekaldgu4c2.surveyapps.ui.formatValue
import com.danixdekaldgu4c2.surveyapps.ui.internalAngleFromBearings
import com.danixdekaldgu4c2.surveyapps.ui.quadrantBearingToWcb
import com.danixdekaldgu4c2.surveyapps.ui.latitudeDeparture
import com.danixdekaldgu4c2.surveyapps.ui.wcbToQuadrantBearing
import com.danixdekaldgu4c2.surveyapps.ui.TraverseLineInput
import org.junit.Assert.assertEquals
import org.junit.Test

class SurveyMathTest {

    @Test
    fun bearingConversion_matchesReferenceQuadrants() {
        assertEquals("N 45.00° E", wcbToQuadrantBearing(45.0))
        assertEquals("S 45.00° E", wcbToQuadrantBearing(135.0))
        assertEquals("S 45.00° W", wcbToQuadrantBearing(225.0))
        assertEquals("N 45.00° W", wcbToQuadrantBearing(315.0))
    }

    @Test
    fun quadrantBearing_toWcb_matches_reference_convention() {
        assertEquals(20.0, quadrantBearingToWcb("N", 20.0, "E"), 1e-9)
        assertEquals(160.0, quadrantBearingToWcb("S", 20.0, "E"), 1e-9)
        assertEquals(200.0, quadrantBearingToWcb("S", 20.0, "W"), 1e-9)
        assertEquals(340.0, quadrantBearingToWcb("N", 20.0, "W"), 1e-9)
    }

    @Test
    fun internalAngle_uses_smaller_angle_between_bearings() {
        assertEquals(70.0, internalAngleFromBearings(30.0, 100.0), 1e-9)
        assertEquals(40.0, internalAngleFromBearings(350.0, 30.0), 1e-9)
    }

    @Test
    fun bearingFromKnown_andInternal_turnDirection_isApplied() {
        assertEquals(160.0, bearingFromKnownAndInternal(100.0, 60.0, turnRight = true), 1e-9)
        assertEquals(40.0, bearingFromKnownAndInternal(100.0, 60.0, turnRight = false), 1e-9)
    }

    @Test
    fun latitudeDeparture_matches_reference_trig_example() {
        val ld = latitudeDeparture(60.123, 30.0)
        assertEquals(52.068, ld.latitude, 0.001)
        assertEquals(30.062, ld.departure, 0.001)
    }

    @Test
    fun coordinateComputation_matchesReferenceFormula() {
        val solution = coordinateFromStart(500000.0, 300000.0, 60.123, 30.0)
        assertEquals(500030.062, solution.easting, 0.001)
        assertEquals(300052.068, solution.northing, 0.001)
    }

    @Test
    fun distanceBetweenCoordinates_matchesPythagoras() {
        assertEquals(5.0, distanceBetweenCoordinates(0.0, 0.0, 3.0, 4.0), 1e-9)
    }

    @Test
    fun traverseAnalysis_computes_misclose_and_corrections() {
        val analysis = analyzeTraverse(
            listOf(
                TraverseLineInput(60.123, 30.0),
                TraverseLineInput(80.326, 100.5)
            )
        )

        assertEquals(140.449, analysis.totalDistance, 0.001)
        assertEquals(37.430, analysis.sumLatitude, 0.01)
        assertEquals(109.044, analysis.sumDeparture, 0.01)
        assertEquals(115.284, analysis.linearMisclose, 0.01)
    }

    @Test
    fun formatValue_uses_us_decimal_separator() {
        assertEquals("12.346", formatValue(12.3456))
    }
}

