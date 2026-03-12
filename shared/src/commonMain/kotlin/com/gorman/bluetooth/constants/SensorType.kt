package com.gorman.bluetooth.constants


/**
 * A complete registry of supported hardware sensors for the device Archimedes.
 * @property value The decimal identifier (ID) of the sensor.
 * @property multiplier The multiplier (bit value).
 * @property measureUnit The physical unit of measurement ([MeasureUnit]) in which this sensor operates.
 **/
enum class SensorType(
    val value: Short,
    val multiplier: Double,
    val measureUnit: MeasureUnit
) {
    AMBIENT_TEMPERATURE(30, 0.1, MeasureUnit.CELSIUS),
    EXTERNAL_TEMPERATURE(51, 0.1, MeasureUnit.CELSIUS),
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
    HUMIDITY(6, 1.0, MeasureUnit.PERCENT),
    CONDUCTIVITY_GENERIC(2, 1.0, MeasureUnit.MICROSIEMENS)
}

/**
 * Enumeration of physical measurement units supported by the device's sensors.
 **/
enum class MeasureUnit(val symbol: String) {
    CELSIUS("°C"),
    VOLTS("V"),
    MILLIVOLTS("mV"),
    LUX("lux"),
    KLX("klx"),
    MICROSIEMENS("uS"),
    MILLISIEMENS("mS"),
    BITS("bits"),
    G_FORCE("g"),
    MILLITESLA("mT"),
    KILOPASCAL("kPa"),
    MM_HG("mmHg"),
    PERCENT("%"),
    NOTHING("")
}

/**
 * Create 2-bit mask to enable necessary sensors.
 * @param availableDeviceSensors List of available device sensors.
 * @return 2 byte ByteArray.
 */
fun List<SensorType>.createSensorsMask(availableDeviceSensors: List<Short>): ByteArray {

    val mask = ByteArray(2)

    availableDeviceSensors.forEachIndexed { index, deviceSensorId ->

        val shouldEnable = this.any { it.value == deviceSensorId }

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
