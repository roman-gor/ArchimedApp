package com.gorman.bluetooth.constants

//TODO(Define sensors types after success connection.
// Change this enum, need to leave only SensorsTypes
// without Device Types)
enum class SensorType(val sensors: List<Sensors>) {
    ECOLOGY_SENS(
        listOf(
            Sensors.ILLUMINATION,
            Sensors.TEMPERATURE,
            Sensors.HUMIDITY,
            Sensors.BNC_CONNECTOR,
            Sensors.EXTERNAL_MINI_DIN
        )
    ),
    PHYSICS_SENS(
        listOf(
            Sensors.VOLTMETER,
            Sensors.AMMETER,
            Sensors.ACCELEROMETER,
            Sensors.TEMPERATURE,
            Sensors.PRESSURE,
            Sensors.EXTERNAL_MINI_DIN
        )
    ),
    BIOLOGY_SENS(
        listOf(
            Sensors.EXTERNAL_MINI_DIN,
            Sensors.ILLUMINATION,
            Sensors.HUMIDITY,
            Sensors.ACIDITY,
            Sensors.TEMPERATURE
        )
    ),
    PHYSIOLOGY_SENS(
        listOf(
            Sensors.EXTERNAL_MINI_DIN,
            Sensors.ILLUMINATION,
            Sensors.HEART,
            Sensors.BREATH,
            Sensors.ACIDITY
        )
    ),
    ENVIRONMENT_SENS(
        listOf(
            Sensors.EXTERNAL_MINI_DIN,
            Sensors.ILLUMINATION,
            Sensors.HUMIDITY,
            Sensors.ACIDITY,
            Sensors.TEMPERATURE
        )
    )
}
