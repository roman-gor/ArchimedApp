package com.gorman.bluetooth.constants

import com.gorman.archimed.shared.MR
import dev.icerock.moko.resources.desc.Resource
import dev.icerock.moko.resources.desc.StringDesc

/**
 * A complete registry of supported hardware sensors for the device Archimedes.
 * @property index The decimal identifier (ID) of the sensor.
 * @property multiplier The multiplier (bit value).
 * @property measureUnit The physical unit of measurement ([MeasureUnit]) in which this sensor operates.
 **/
enum class SensorType(
    val index: Short,
    val multiplier: Double,
    val measureUnit: MeasureUnit
) {
    AMBIENT_TEMPERATURE(30, 0.1, MeasureUnit.CELSIUS),
    EXTERNAL_TEMPERATURE(51, 0.01, MeasureUnit.CELSIUS),
    EXTERNAL_ANALOG_CONNECTOR(52, 0.001, MeasureUnit.VOLTS),
    LIGHT_HIGH_SENSITIVE(53, 0.1, MeasureUnit.LUX),
    LIGHT_MEDIUM_SENSITIVE(54, 1.0, MeasureUnit.LUX),
    LIGHT_LOW_SENSITIVE(55, 0.01, MeasureUnit.KLX),
    CONDUCTIVITY_HIGH_SENSITIVE(56, 0.1, MeasureUnit.MICROSIEMENS),
    CONDUCTIVITY_MEDIUM_SENSITIVE(57, 1.0, MeasureUnit.MICROSIEMENS),
    CONDUCTIVITY_LOW_SENSITIVE(58, 0.01, MeasureUnit.MILLISIEMENS),
    COMMON_ANALOG(75, 1.0, MeasureUnit.BITS),
    ACCELEROMETER_HIGH_SENSITIVE(59, 1.0, MeasureUnit.G_FORCE),
    ACCELEROMETER_MEDIUM_SENSITIVE(60, 1.0, MeasureUnit.G_FORCE),
    ACCELEROMETER_LOW_SENSITIVE(35, 1.0, MeasureUnit.G_FORCE),
    MAGNETIC_FIELD(61, 0.01, MeasureUnit.MILLITESLA),
    AIR_PRESSURE(62, 0.1, MeasureUnit.KILOPASCAL),
    VOLTAGE_2V(63, 0.001, MeasureUnit.VOLTS),
    VOLTAGE_5V(64, 0.001, MeasureUnit.VOLTS),
    VOLTAGE_10V(65, 0.001, MeasureUnit.VOLTS),
    VOLTAGE_15V(66, 0.001, MeasureUnit.VOLTS),
    VOLTAGE_30V(67, 0.01, MeasureUnit.VOLTS),
    EXTERNAL_TEMPERATURE_NTC(74, 0.1, MeasureUnit.CELSIUS),
    NITRATE_ION(72, 0.1, MeasureUnit.MILLIVOLTS),
    CHLORIDE_ION(73, 0.1, MeasureUnit.MILLIVOLTS),
    BLOOD_PRESSURE_MAIN(79, 0.0, MeasureUnit.NOTHING),
    BLOOD_PRESSURE_CUFF(80, 0.1, MeasureUnit.MM_HG),
    BLOOD_PRESSURE_PULSE(81, 0.00004578, MeasureUnit.VOLTS),
    BODY_TEMPERATURE(70, 0.01, MeasureUnit.CELSIUS),
    RESPIRATORY_RATE(71, 0.1, MeasureUnit.MM_HG),
    HUMIDITY(6, 0.1, MeasureUnit.PERCENT),
    CONDUCTIVITY_GENERIC(2, 1.0, MeasureUnit.MICROSIEMENS),
    UNKNOWN(-1, 1.0, MeasureUnit.NOTHING)
}

fun Byte.getSensorTypeFromIndex(): SensorType {
    return SensorType.entries.firstOrNull { it.index == this.toShort() } ?: SensorType.UNKNOWN
}

/**
 * Enumeration of physical measurement units supported by the device's sensors.
 **/
enum class MeasureUnit(val symbol: StringDesc) {
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
fun List<SensorType>.createSensorsMask(availableDeviceSensors: List<Short>): ByteArray {
    val mask = ByteArray(2)

    availableDeviceSensors.forEachIndexed { index, deviceSensorId ->

        val shouldEnable = this.any { it.index == deviceSensorId }

        if (shouldEnable) {
            when (index) {
                in 0..7 -> {
                    mask[1] = (mask[1].toInt() or (1 shl index)).toByte()
                }
                in 8..15 -> {
                    val bitPosition = index - 8
                    mask[0] = (mask[0].toInt() or (1 shl bitPosition)).toByte()
                }
            }
        }
    }
    return mask
}

/**
 * Decodes a 2-byte mask from the device back into a list of sensors.
 * @param availableDeviceSensors An array of 16 sensor IDs received from the device (GetSensorsIds).
 * @return A list of recognized sensors from the SensorType enum.
 */
fun Short.toSensorsList(availableDeviceSensors: List<Short>): List<SensorType> {
    val byte0 = (this.toInt() shr 8) and 0xFF
    val byte1 = this.toInt() and 0xFF

    return (0..15)
        .filter { index ->
            if (index < 8) {
                (byte1 and (1 shl index)) != 0
            } else {
                (byte0 and (1 shl (index - 8))) != 0
            }
        }
        .mapNotNull { activeIndex ->
            availableDeviceSensors.getOrNull(activeIndex)
        }
        .filter { sensorId ->
            sensorId != 0.toShort()
        }
        .mapNotNull { validSensorId ->
            SensorType.entries.find { it.index == validSensorId }
        }
}

/**
 * Parses a byte array into a list of sensor values.
 * Combines pairs of bytes into 16-bit signed integers.
 * @return A list of integer values representing sensor data.
 */
fun ByteArray.getSensorsValues(): List<Int> {
    val parsedList = mutableListOf<Int>()

    for (i in 0 until this.size - 1 step 2) {
        val msb = this[i].toInt() and 0xFF
        val lsb = this[i + 1].toInt() and 0xFF

        val combined = (msb shl 8) or lsb

        parsedList.add(combined.toShort().toInt())
    }
    return parsedList.toList()
}

/**
 * Splits a continuous raw data array into separate lists for each sensor,
 * while multiplying the values by their respective factor (multiplier).
 * @param activeSensors A list of enabled sensors (decoded from the Packet 0 mask).
 * @param expectedSamples Optional: the number of data points from Packet 0 used to trim trailing "garbage" zeros.
 */
fun List<Int>.toChartData(
    activeSensors: List<SensorType>,
    expectedSamples: Int? = null
): Map<SensorType, List<Double>> {
    val sensorsCount = activeSensors.size
    if (sensorsCount == 0) return emptyMap()

    val chartData = activeSensors.associateWith { mutableListOf<Double>() }

    val validDataLimit = expectedSamples?.let { it * sensorsCount } ?: this.size

    for (index in 0 until validDataLimit) {
        if (index >= this.size) break

        val rawValue = this[index]
        val currentSensor = activeSensors[index % sensorsCount]

        val physicalValue = rawValue * currentSensor.multiplier

        val roundedValue = kotlin.math.round(physicalValue * 100.0) / 100.0

        chartData[currentSensor]?.add(roundedValue)
    }

    return chartData
}
