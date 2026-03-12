package com.gorman.bluetooth.constants

enum class DeviceType(val sensorType: SensorType?) {
    IDLE(null),
    ECOLOGY(SensorType.ECOLOGY_SENS),
    PHYSICS(SensorType.PHYSICS_SENS),
    BIOLOGY(SensorType.BIOLOGY_SENS),
    PHYSIOLOGY(SensorType.PHYSIOLOGY_SENS),
    ENVIRONMENT(SensorType.ENVIRONMENT_SENS)
}
