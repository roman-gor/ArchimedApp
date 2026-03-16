package com.gorman.bluetooth.constants

import com.gorman.archimed.shared.MR
import dev.icerock.moko.resources.desc.Resource
import dev.icerock.moko.resources.desc.StringDesc

/**
 * A complete registry of supported hardware sensors for the device Archimedes.
 * @property id The decimal identifier (ID) of the sensor.
 * @property multiplier The multiplier (bit value).
 * @property measureUnit The physical unit of measurement ([MeasureUnit]) in which this sensor operates.
 **/
enum class SensorType(
    val id: Byte,
    val multiplier: Double,
    val measureUnit: MeasureUnit,
    val valuesCount: Int
) {
    HEART_PULSE(22, 1.0, MeasureUnit.BEATS_PER_MIN, 2),
    CURRENT_STRENGTH(28, 0.1, MeasureUnit.AMPS, 1),
    AMBIENT_TEMPERATURE(30, 0.1, MeasureUnit.CELSIUS, 1),
    EXTERNAL_TEMPERATURE(51, 0.01, MeasureUnit.CELSIUS, 1),
    EXTERNAL_ANALOG_CONNECTOR(52, 0.001, MeasureUnit.VOLTS, 1),
    LIGHT_HIGH_SENSITIVE(53, 0.1, MeasureUnit.LUX, 1),
    LIGHT_MEDIUM_SENSITIVE(54, 1.0, MeasureUnit.LUX, 1),
    LIGHT_LOW_SENSITIVE(55, 0.01, MeasureUnit.KLX, 1),
    CONDUCTIVITY_HIGH_SENSITIVE(56, 0.1, MeasureUnit.MICROSIEMENS, 1),
    CONDUCTIVITY_MEDIUM_SENSITIVE(57, 1.0, MeasureUnit.MICROSIEMENS, 1),
    CONDUCTIVITY_LOW_SENSITIVE(58, 0.01, MeasureUnit.MILLISIEMENS, 1),
    COMMON_ANALOG(75, 1.0, MeasureUnit.BITS, 1),
    ACCELEROMETER_2G(59, 0.01, MeasureUnit.G_FORCE, 3),
    ACCELEROMETER_4G(60, 0.01, MeasureUnit.G_FORCE, 3),
    ACCELEROMETER_8G(35, 0.01, MeasureUnit.G_FORCE, 3),
    MAGNETIC_FIELD(61, 0.01, MeasureUnit.MILLITESLA, 3),
    AIR_PRESSURE(62, 0.1, MeasureUnit.KILOPASCAL, 1),
    VOLTAGE_2V(63, 0.001, MeasureUnit.VOLTS, 1),
    VOLTAGE_5V(64, 0.001, MeasureUnit.VOLTS, 1),
    VOLTAGE_10V(65, 0.001, MeasureUnit.VOLTS, 1),
    VOLTAGE_15V(66, 0.001, MeasureUnit.VOLTS, 1),
    VOLTAGE_30V(67, 0.01, MeasureUnit.VOLTS, 1),
    EXTERNAL_TEMPERATURE_NTC(74, 0.1, MeasureUnit.CELSIUS, 1),
    CHLORIDE_ION(72, 0.1, MeasureUnit.MILLIVOLTS, 1),
    NITRATE_ION(73, 0.1, MeasureUnit.MILLIVOLTS, 1),
    BLOOD_PRESSURE_MAIN(79, 0.0, MeasureUnit.NOTHING, 1),
    BODY_TEMPERATURE(70, 0.01, MeasureUnit.CELSIUS, 1),
    RESPIRATORY_RATE(71, 0.1, MeasureUnit.MM_HG, 2),
    HUMIDITY(6, 0.1, MeasureUnit.PERCENT, 1),
    PH_SENSOR(2, 1.0, MeasureUnit.MICROSIEMENS, 1),
    TURBIDITY(14, 0.1, MeasureUnit.NTU, 1),
    TURBIDITY_SEC(31, 0.1, MeasureUnit.NTU, 1),
    UNKNOWN(-1, 1.0, MeasureUnit.NOTHING, 1);

    companion object {
        fun getFullSensors(deviceType: DeviceType): List<SensorType> = when (deviceType) {
            DeviceType.ECOLOGY -> listOf(
                PH_SENSOR,
                TURBIDITY,
                HUMIDITY,
                LIGHT_MEDIUM_SENSITIVE,
                EXTERNAL_ANALOG_CONNECTOR,
                AMBIENT_TEMPERATURE,
                EXTERNAL_TEMPERATURE
            )
            DeviceType.PHYSICS -> listOf(
                VOLTAGE_15V,
                AIR_PRESSURE,
                CURRENT_STRENGTH,
                ACCELEROMETER_4G,
                MAGNETIC_FIELD,
                EXTERNAL_ANALOG_CONNECTOR,
                AMBIENT_TEMPERATURE,
                EXTERNAL_TEMPERATURE
            )
            DeviceType.BIOLOGY -> listOf(
                PH_SENSOR,
                ACCELEROMETER_4G,
                HUMIDITY,
                LIGHT_MEDIUM_SENSITIVE,
                EXTERNAL_ANALOG_CONNECTOR,
                AMBIENT_TEMPERATURE,
                EXTERNAL_TEMPERATURE
            )
            DeviceType.PHYSIOLOGY -> listOf(
                PH_SENSOR,
                RESPIRATORY_RATE,
                LIGHT_MEDIUM_SENSITIVE,
                ACCELEROMETER_4G,
                EXTERNAL_ANALOG_CONNECTOR,
                BODY_TEMPERATURE,
                HEART_PULSE
            )
            DeviceType.UNKNOWN -> listOf()
        }
    }
}

fun Byte.getSensorTypeFromId(): SensorType {
    return SensorType.entries.firstOrNull { it.id == this } ?: SensorType.UNKNOWN
}

/**
 * Enumeration of physical measurement units supported by the device's sensors.
 **/
enum class MeasureUnit(val symbol: StringDesc) {
    NTU(StringDesc.Resource(MR.strings.ntu_symbol)),
    BEATS_PER_MIN(StringDesc.Resource(MR.strings.beats_heart)),
    AMPS(StringDesc.Resource(MR.strings.milliamps_symbol)),
    CELSIUS(StringDesc.Resource(MR.strings.celsius_symbol)),
    VOLTS(StringDesc.Resource(MR.strings.volts_symbol)),
    MILLIVOLTS(StringDesc.Resource(MR.strings.millivolts_symbol)),
    LUX(StringDesc.Resource(MR.strings.lux_symbol)),
    KLX(StringDesc.Resource(MR.strings.klx_symbol)),
    MICROSIEMENS(StringDesc.Resource(MR.strings.microsiemens_symbol)),
    MILLISIEMENS(StringDesc.Resource(MR.strings.millisiemens_symbol)),
    BITS(StringDesc.Resource(MR.strings.bits_symbol)),
    G_FORCE(StringDesc.Resource(MR.strings.g_force_symbol)),
    MILLITESLA(StringDesc.Resource(MR.strings.millitesla_symbol)),
    KILOPASCAL(StringDesc.Resource(MR.strings.kilopascal_symbol)),
    MM_HG(StringDesc.Resource(MR.strings.mm_hg_symbol)),
    PERCENT(StringDesc.Resource(MR.strings.percent_symbol)),
    NOTHING(StringDesc.Resource(MR.strings.nothing_symbol))
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

    return (0..15)
        .filter { index -> (maskInt and (1 shl index)) != 0 }
        .mapNotNull { index ->
            availableDeviceSensors.getOrNull(index)
        }.mapNotNull { sensorId ->
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
                val processedValues = rawData.map {
                    val processedValue = if (sensor == SensorType.CURRENT_STRENGTH) it.toInt() - 32750 else it.toInt()
                    kotlin.math.round(((processedValue * sensor.multiplier) * 100.0) / 100.0)
                }
                cursor += count
                resultMap[sensor]?.addAll(processedValues)
            }
        }

    return resultMap
}
