package com.gorman.bluetooth.constants

/**
 * A complete registry of supported hardware sensors for the device Archimedes.
 * @property id The decimal identifier (ID) of the sensor.
 * @property multiplier The multiplier (bit value).
 * @property measureUnit The physical unit of measurement ([MeasureUnit]) in which this sensor operates.
 * @property valuesCount The amount of values sending from device.
 * @property minValue The minimal value of sensor.
 * @property maxValue The maximum value of sensor.
 **/
enum class SensorType(
    val id: Byte,
    val multiplier: Double,
    val measureUnit: MeasureUnit,
    val valuesCount: Int,
    val minValue: Double,
    val maxValue: Double
) {
    HEART_PULSE(22, 1.0, MeasureUnit.BEATS_PER_MIN, 2, 0.0, 300.0),
    CURRENT_STRENGTH(28, 0.1, MeasureUnit.AMPS, 1, 0.0, 1000.0),
    AMBIENT_TEMPERATURE(30, 0.1, MeasureUnit.CELSIUS, 1, -25.0, 65.0),
    EXTERNAL_TEMPERATURE(51, 0.01, MeasureUnit.CELSIUS, 1, -55.0, 185.0),
    EXTERNAL_ANALOG_CONNECTOR(52, 0.001, MeasureUnit.VOLTS, 1, 0.0, 5.0),
    LIGHT_HIGH_SENSITIVE(53, 10.0, MeasureUnit.LUX, 1, 0.0, 180000.0),
    LIGHT_MEDIUM_SENSITIVE(54, 10.0, MeasureUnit.LUX, 1, 0.0, 20000.0),
    LIGHT_LOW_SENSITIVE(55, 10.0, MeasureUnit.KLX, 1, 0.0, 1000.0),
    CONDUCTIVITY_HIGH_SENSITIVE(56, 0.1, MeasureUnit.MICROSIEMENS, 1, 0.0, 200.0),
    CONDUCTIVITY_MEDIUM_SENSITIVE(57, 1.0, MeasureUnit.MICROSIEMENS, 1, 0.0, 2000.0),
    CONDUCTIVITY_LOW_SENSITIVE(58, 0.01, MeasureUnit.MILLISIEMENS, 1, 0.0, 30.0),
    COMMON_ANALOG(75, 1.0, MeasureUnit.BITS, 1, 0.0, 65535.0),
    ACCELEROMETER_2G(59, 0.001, MeasureUnit.G_FORCE, 3, -2.2, 2.2),
    ACCELEROMETER_4G(60, 0.001, MeasureUnit.G_FORCE, 3, -4.4, 4.4),
    ACCELEROMETER_8G(35, 0.001, MeasureUnit.G_FORCE, 3, -8.8, 8.8),
    MAGNETIC_FIELD(61, 0.01, MeasureUnit.MILLITESLA, 3, -180.0, 180.0),
    AIR_PRESSURE(62, 0.1, MeasureUnit.KILOPASCAL, 1, 0.0, 770.0),
    VOLTAGE_2V(63, 0.01, MeasureUnit.VOLTS, 1, -2.2, 2.2),
    VOLTAGE_5V(64, 0.01, MeasureUnit.VOLTS, 1, -5.5, 5.5),
    VOLTAGE_10V(65, 0.01, MeasureUnit.VOLTS, 1, -11.0, 11.0),
    VOLTAGE_15V(66, 0.01, MeasureUnit.VOLTS, 1, -17.0, 17.0),
    VOLTAGE_30V(67, 0.01, MeasureUnit.VOLTS, 1, -33.0, 33.0),
    EXTERNAL_TEMPERATURE_NTC(74, 0.1, MeasureUnit.CELSIUS, 1, -30.0, 130.0),
    CHLORIDE_ION(72, 0.1, MeasureUnit.MILLIVOLTS, 1, -1100.0, 1100.0),
    NITRATE_ION(73, 0.1, MeasureUnit.MILLIVOLTS, 1, -1100.0, 1100.0),
    BLOOD_PRESSURE_MAIN(79, 0.0, MeasureUnit.MM_HG, 1, 0.0, 300.0),
    BODY_TEMPERATURE(70, 0.01, MeasureUnit.CELSIUS, 1, 25.0, 45.0),
    RESPIRATORY_RATE(71, 0.1, MeasureUnit.MM_HG, 2, 0.0, 10000.0),
    HUMIDITY(6, 0.1, MeasureUnit.PERCENT, 1, 0.0, 100.0),
    GPS(7, 1.0, MeasureUnit.NOTHING, 2, -200.0, 200.0),
    PH_SENSOR(2, 0.01, MeasureUnit.MICROSIEMENS, 1, 0.0, 14.0),
    TURBIDITY(14, 1.0, MeasureUnit.NTU, 1, 0.0, 200.0),
    COLORIMETRIC(31, 0.1, MeasureUnit.PERCENT, 3, 0.0, 620.0),
    UNKNOWN(-1, 1.0, MeasureUnit.NOTHING, 1, -10000.0, 10000.0)
}

fun Byte.getSensorTypeFromId(): SensorType {
    return SensorType.entries.firstOrNull { it.id == this } ?: SensorType.UNKNOWN
}

/**
 * Enumeration of physical measurement units supported by the device's sensors.
 **/
enum class MeasureUnit {
    NTU,
    BEATS_PER_MIN,
    AMPS,
    CELSIUS,
    VOLTS,
    MILLIVOLTS,
    LUX,
    KLX,
    MICROSIEMENS,
    MILLISIEMENS,
    BITS,
    G_FORCE,
    MILLITESLA,
    KILOPASCAL,
    MM_HG,
    PERCENT,
    NOTHING
}

/**
 * Create 2-bit mask to enable necessary sensors.
 * @param availableDeviceSensors List of available device sensors.
 * @return 2 byte ByteArray.
 */
fun List<SensorType>.createSensorsMask(availableDeviceSensors: List<Byte>): ByteArray {
    val maskInt = availableDeviceSensors.foldIndexed(0) { index, acc, sensorId ->
        val isNeeded = this.any { it.id == sensorId }
        if (isNeeded) acc or (1 shl index) else acc
    }

    return byteArrayOf(
        ((maskInt shr 8) and 0xFF).toByte(),
        (maskInt and 0xFF).toByte()
    )
}

/**
 * Decodes a 2-byte mask from the device back into a list of sensors.
 * @param availableDeviceSensors An array of 16 sensor IDs received from the device (GetSensorsIds).
 * @return A list of recognized sensors from the SensorType enum.
 */
fun Short.toSensorsList(availableDeviceSensors: List<Byte>): List<SensorType> {
    val maskInt = this.toInt() and 0xFFFF
    val availableSensorsRange = 0..15

    return availableSensorsRange
        .filter { index -> (maskInt and (1 shl index)) != 0 }
        .mapNotNull { index ->
            val sensorId = availableDeviceSensors.getOrNull(index)
            SensorType.entries.find { it.id == sensorId }
        }
}

/**
 * Parses a byte array into a list of sensor values.
 * Combines pairs of bytes into 16-bit signed integers.
 * @return A list of integer values representing sensor data.
 */
fun ByteArray.getSensorsValues(): List<Short> =
    this.toList()
        .chunked(2)
        .filter { it.size == 2 }
        .map { (high, low) ->
            val msb = high.toInt() and 0xFF
            val lsb = low.toInt() and 0xFF
            ((msb shl 8) or lsb).toShort()
        }

/**
 * Splits a continuous raw data array into separate lists for each sensor,
 * while multiplying the values by their respective factor (multiplier).
 * @param activeSensors A list of enabled sensors (decoded from the Packet 0 mask).
 * @param expectedSamples Optional: the number of data points from Packet 0 used to trim trailing "garbage" zeros.
 */
fun List<Short>.toChartData(
    activeSensors: List<SensorType>,
    expectedSamples: Short? = null
): Map<SensorType, List<Double>> {
    val totalSamples = expectedSamples?.toInt() ?: this.size
    if (activeSensors.isEmpty() || this.isEmpty() || totalSamples <= 0) return emptyMap()

    val frameSize = activeSensors.sumOf { it.valuesCount }

    val expectedValues = expectedSamples?.let { it.toInt() * frameSize } ?: this.size

    val actualSize = minOf(expectedValues, this.size)

    val resultMap = activeSensors.associateWith { mutableListOf<Double>() }

    this.take(actualSize)
        .chunked(frameSize)
        .forEach { frame ->
            if (frame.size < frameSize) return@forEach

            var cursor = 0

            activeSensors.forEach { sensor ->
                val count = sensor.valuesCount
                val rawData = frame.subList(cursor, cursor + count)
                val processedValues = processValues(rawData, sensor)
                cursor += count
                resultMap[sensor]?.addAll(processedValues)
            }
        }

    return resultMap
}

fun processValues(
    rawData: List<Short>,
    sensor: SensorType
): List<Double> {
    val minValue = sensor.minValue
    val maxValue = sensor.maxValue

    val processedValues = rawData.map {
        val processedValue =
            if (sensor == SensorType.CURRENT_STRENGTH) it.toInt() - 32750 else it.toInt()
        val roundedValue = processedValue * sensor.multiplier
        if (roundedValue in minValue..maxValue) {
            roundedValue
        } else {
            if (roundedValue < minValue) minValue else maxValue
        }
    }
    return processedValues
}
