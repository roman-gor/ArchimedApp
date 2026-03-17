package com.gorman.bluetooth.mappers

import com.gorman.archimed.states.bluetooth.BluetoothUiEvent
import com.gorman.bluetooth.constants.Rates
import com.gorman.bluetooth.constants.Samples
import com.gorman.bluetooth.constants.SensorType
import com.gorman.bluetooth.constants.createSensorsMask
import com.gorman.bluetooth.models.DeviceRequest
import kotlinx.datetime.TimeZone
import kotlinx.datetime.number
import kotlinx.datetime.toLocalDateTime
import kotlin.time.Clock
import kotlin.time.Instant

object DeviceCommandBuilder {
    fun startLogging(
        command: BluetoothUiEvent.DeviceCommand.StartLogging,
        availableDeviceSensors: List<Byte>
    ): List<DeviceRequest> {
        val sensorsArray = command.sensors.createSensorsMask(availableDeviceSensors)

        val shouldCalibrate = when (command.shouldCalibrate) {
            true -> 0x01
            false -> 0x00
        }.toByte()

        return listOf(
            DeviceRequest.StopLogging,
            setDateTimes(),
            DeviceRequest.SetupLoggingParameters(
                sensors = sensorsArray,
                rate = Rates.valueOf(command.sampleRate.toString()).byte,
                samples = Samples.valueOf(command.sampleCount.toString()).byte,
                sensorsCalibrate = shouldCalibrate
            ),
            DeviceRequest.StartLogging
        )
    }

    fun startDefaultLogging(
        availableDeviceSensors: List<Byte>
    ): List<DeviceRequest> {
        val sensorsArray = SensorType.entries
            .filter { it.id in availableDeviceSensors }
            .createSensorsMask(availableDeviceSensors)

        return listOf(
            setDateTimes(),
            DeviceRequest.SetupLoggingParameters(
                sensors = sensorsArray,
                rate = Rates.RATE_10_PER_SEC.byte,
                samples = Samples.SAMPLES_10.byte,
                sensorsCalibrate = 0x00.toByte()
            ),
            DeviceRequest.StartLogging
        )
    }

    fun setDateTimes(): DeviceRequest.SetDateTime {
        val now: Instant = Clock.System.now()
        val localDateTime = now.toLocalDateTime(TimeZone.currentSystemDefault())
        return DeviceRequest.SetDateTime(
            day = localDateTime.day.toByte(),
            month = localDateTime.month.number.toByte(),
            year = (localDateTime.year % 100).toByte(),
            hour = localDateTime.hour.toByte(),
            min = localDateTime.minute.toByte(),
            sec = localDateTime.second.toByte()
        )
    }
}
