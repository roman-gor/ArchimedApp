package com.gorman.bluetooth.states

import kotlin.uuid.ExperimentalUuidApi
import kotlin.uuid.Uuid

data class CharacteristicState
@OptIn(ExperimentalUuidApi::class)
constructor(
    val serviceUuid: Uuid,
    val characteristicUuid: Uuid
)
