@file:Suppress("unused")

package com.danixdekaldgu4c2.surveyapps.ui

import java.util.Locale
import kotlin.math.abs
import kotlin.math.cos
import kotlin.math.pow
import kotlin.math.sin
import kotlin.math.sqrt

data class LatitudeDeparture(
    val latitude: Double,
    val departure: Double
)

data class CoordinateSolution(
    val latitudeDeparture: LatitudeDeparture,
    val easting: Double,
    val northing: Double
)

data class TraverseLineInput(
    val distance: Double,
    val bearingDeg: Double
)

data class TraverseLineResult(
    val input: TraverseLineInput,
    val latitude: Double,
    val departure: Double
)

data class TraverseAnalysis(
    val lines: List<TraverseLineResult>,
    val totalDistance: Double,
    val sumLatitude: Double,
    val sumDeparture: Double,
    val linearMisclose: Double,
    val accuracyRatio: Double?,
    val bowditchCorrections: List<LatitudeDeparture>,
    val transitCorrections: List<LatitudeDeparture>
)

fun normalizeBearing(degrees: Double): Double = ((degrees % 360.0) + 360.0) % 360.0

fun formatValue(value: Double, decimals: Int = 3): String =
    String.format(Locale.US, "%.${decimals}f", value)

fun formatBearing(value: Double, decimals: Int = 2): String =
    String.format(Locale.US, "%.${decimals}f", normalizeBearing(value))

fun wcbToQuadrantBearing(bearingDeg: Double): String {
    val b = normalizeBearing(bearingDeg)
    return when {
        b <= 90.0 -> "N ${formatBearing(b)}° E"
        b <= 180.0 -> "S ${formatBearing(180.0 - b)}° E"
        b <= 270.0 -> "S ${formatBearing(b - 180.0)}° W"
        else -> "N ${formatBearing(360.0 - b)}° W"
    }
}

fun quadrantBearingToWcb(prefix: String, angleDeg: Double, suffix: String): Double {
    val ns = prefix.trim().uppercase(Locale.US)
    val ew = suffix.trim().uppercase(Locale.US)
    val angle = angleDeg.coerceAtLeast(0.0)

    return normalizeBearing(
        when {
            ns == "N" && ew == "E" -> angle
            ns == "S" && ew == "E" -> 180.0 - angle
            ns == "S" && ew == "W" -> 180.0 + angle
            ns == "N" && ew == "W" -> 360.0 - angle
            else -> angle
        }
    )
}

fun internalAngleFromBearings(firstBearingDeg: Double, secondBearingDeg: Double): Double {
    val diff = abs(normalizeBearing(secondBearingDeg) - normalizeBearing(firstBearingDeg))
    return if (diff > 180.0) 360.0 - diff else diff
}

fun bearingFromKnownAndInternal(
    knownBearingDeg: Double,
    internalAngleDeg: Double,
    turnRight: Boolean
): Double = normalizeBearing(
    if (turnRight) knownBearingDeg + internalAngleDeg else knownBearingDeg - internalAngleDeg
)

fun latitudeDeparture(distance: Double, bearingDeg: Double): LatitudeDeparture {
    val radians = Math.toRadians(normalizeBearing(bearingDeg))
    val latitude = distance * cos(radians)
    val departure = distance * sin(radians)
    return LatitudeDeparture(latitude = latitude, departure = departure)
}

fun coordinateFromStart(
    startEasting: Double,
    startNorthing: Double,
    distance: Double,
    bearingDeg: Double
): CoordinateSolution {
    val ld = latitudeDeparture(distance, bearingDeg)
    return CoordinateSolution(
        latitudeDeparture = ld,
        easting = startEasting + ld.departure,
        northing = startNorthing + ld.latitude
    )
}

fun distanceBetweenCoordinates(
    startEasting: Double,
    startNorthing: Double,
    endEasting: Double,
    endNorthing: Double
): Double {
    val deltaE = endEasting - startEasting
    val deltaN = endNorthing - startNorthing
    return sqrt(deltaE.pow(2) + deltaN.pow(2))
}

fun linearMisclose(sumLatitude: Double, sumDeparture: Double): Double =
    sqrt(sumLatitude.pow(2) + sumDeparture.pow(2))

fun traverseAccuracyRatio(totalDistance: Double, linearMisclose: Double): Double? =
    if (linearMisclose <= 0.0) null else totalDistance / linearMisclose

fun analyzeTraverse(lines: List<TraverseLineInput>): TraverseAnalysis {
    val results = lines.map {
        val ld = latitudeDeparture(it.distance, it.bearingDeg)
        TraverseLineResult(
            input = it,
            latitude = ld.latitude,
            departure = ld.departure
        )
    }

    val totalDistance = results.sumOf { it.input.distance }
    val sumLatitude = results.sumOf { it.latitude }
    val sumDeparture = results.sumOf { it.departure }
    val misclose = linearMisclose(sumLatitude, sumDeparture)
    val accuracyRatio = traverseAccuracyRatio(totalDistance, misclose)

    val bowditchCorrections = if (totalDistance > 0.0) {
        results.map {
            LatitudeDeparture(
                latitude = -sumLatitude * (it.input.distance / totalDistance),
                departure = -sumDeparture * (it.input.distance / totalDistance)
            )
        }
    } else {
        results.map { LatitudeDeparture(0.0, 0.0) }
    }

    val totalAbsLatitude = results.sumOf { abs(it.latitude) }
    val totalAbsDeparture = results.sumOf { abs(it.departure) }
    val transitCorrections = results.map {
        LatitudeDeparture(
            latitude = if (totalAbsLatitude > 0.0) -sumLatitude * (abs(it.latitude) / totalAbsLatitude) else 0.0,
            departure = if (totalAbsDeparture > 0.0) -sumDeparture * (abs(it.departure) / totalAbsDeparture) else 0.0
        )
    }

    return TraverseAnalysis(
        lines = results,
        totalDistance = totalDistance,
        sumLatitude = sumLatitude,
        sumDeparture = sumDeparture,
        linearMisclose = misclose,
        accuracyRatio = accuracyRatio,
        bowditchCorrections = bowditchCorrections,
        transitCorrections = transitCorrections
    )
}

