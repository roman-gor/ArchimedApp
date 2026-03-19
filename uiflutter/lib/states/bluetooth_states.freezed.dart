// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bluetooth_states.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DeviceConnectionState _$DeviceConnectionStateFromJson(
  Map<String, dynamic> json,
) {
  switch (json['type']) {
    case 'connecting':
      return _Connecting.fromJson(json);
    case 'connected':
      return _Connected.fromJson(json);
    case 'disconnecting':
      return _Disconnecting.fromJson(json);
    case 'disconnected':
      return _Disconnected.fromJson(json);

    default:
      throw CheckedFromJsonException(
        json,
        'type',
        'DeviceConnectionState',
        'Invalid union type "${json['type']}"!',
      );
  }
}

/// @nodoc
mixin _$DeviceConnectionState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() connecting,
    required TResult Function() connected,
    required TResult Function() disconnecting,
    required TResult Function(DisconnectReason? reason) disconnected,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? connecting,
    TResult? Function()? connected,
    TResult? Function()? disconnecting,
    TResult? Function(DisconnectReason? reason)? disconnected,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? connecting,
    TResult Function()? connected,
    TResult Function()? disconnecting,
    TResult Function(DisconnectReason? reason)? disconnected,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Connecting value) connecting,
    required TResult Function(_Connected value) connected,
    required TResult Function(_Disconnecting value) disconnecting,
    required TResult Function(_Disconnected value) disconnected,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Connecting value)? connecting,
    TResult? Function(_Connected value)? connected,
    TResult? Function(_Disconnecting value)? disconnecting,
    TResult? Function(_Disconnected value)? disconnected,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Connecting value)? connecting,
    TResult Function(_Connected value)? connected,
    TResult Function(_Disconnecting value)? disconnecting,
    TResult Function(_Disconnected value)? disconnected,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Serializes this DeviceConnectionState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeviceConnectionStateCopyWith<$Res> {
  factory $DeviceConnectionStateCopyWith(
    DeviceConnectionState value,
    $Res Function(DeviceConnectionState) then,
  ) = _$DeviceConnectionStateCopyWithImpl<$Res, DeviceConnectionState>;
}

/// @nodoc
class _$DeviceConnectionStateCopyWithImpl<
  $Res,
  $Val extends DeviceConnectionState
>
    implements $DeviceConnectionStateCopyWith<$Res> {
  _$DeviceConnectionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DeviceConnectionState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ConnectingImplCopyWith<$Res> {
  factory _$$ConnectingImplCopyWith(
    _$ConnectingImpl value,
    $Res Function(_$ConnectingImpl) then,
  ) = __$$ConnectingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ConnectingImplCopyWithImpl<$Res>
    extends _$DeviceConnectionStateCopyWithImpl<$Res, _$ConnectingImpl>
    implements _$$ConnectingImplCopyWith<$Res> {
  __$$ConnectingImplCopyWithImpl(
    _$ConnectingImpl _value,
    $Res Function(_$ConnectingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DeviceConnectionState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$ConnectingImpl implements _Connecting {
  const _$ConnectingImpl({final String? $type}) : $type = $type ?? 'connecting';

  factory _$ConnectingImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConnectingImplFromJson(json);

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DeviceConnectionState.connecting()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ConnectingImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() connecting,
    required TResult Function() connected,
    required TResult Function() disconnecting,
    required TResult Function(DisconnectReason? reason) disconnected,
  }) {
    return connecting();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? connecting,
    TResult? Function()? connected,
    TResult? Function()? disconnecting,
    TResult? Function(DisconnectReason? reason)? disconnected,
  }) {
    return connecting?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? connecting,
    TResult Function()? connected,
    TResult Function()? disconnecting,
    TResult Function(DisconnectReason? reason)? disconnected,
    required TResult orElse(),
  }) {
    if (connecting != null) {
      return connecting();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Connecting value) connecting,
    required TResult Function(_Connected value) connected,
    required TResult Function(_Disconnecting value) disconnecting,
    required TResult Function(_Disconnected value) disconnected,
  }) {
    return connecting(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Connecting value)? connecting,
    TResult? Function(_Connected value)? connected,
    TResult? Function(_Disconnecting value)? disconnecting,
    TResult? Function(_Disconnected value)? disconnected,
  }) {
    return connecting?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Connecting value)? connecting,
    TResult Function(_Connected value)? connected,
    TResult Function(_Disconnecting value)? disconnecting,
    TResult Function(_Disconnected value)? disconnected,
    required TResult orElse(),
  }) {
    if (connecting != null) {
      return connecting(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ConnectingImplToJson(this);
  }
}

abstract class _Connecting implements DeviceConnectionState {
  const factory _Connecting() = _$ConnectingImpl;

  factory _Connecting.fromJson(Map<String, dynamic> json) =
      _$ConnectingImpl.fromJson;
}

/// @nodoc
abstract class _$$ConnectedImplCopyWith<$Res> {
  factory _$$ConnectedImplCopyWith(
    _$ConnectedImpl value,
    $Res Function(_$ConnectedImpl) then,
  ) = __$$ConnectedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ConnectedImplCopyWithImpl<$Res>
    extends _$DeviceConnectionStateCopyWithImpl<$Res, _$ConnectedImpl>
    implements _$$ConnectedImplCopyWith<$Res> {
  __$$ConnectedImplCopyWithImpl(
    _$ConnectedImpl _value,
    $Res Function(_$ConnectedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DeviceConnectionState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$ConnectedImpl implements _Connected {
  const _$ConnectedImpl({final String? $type}) : $type = $type ?? 'connected';

  factory _$ConnectedImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConnectedImplFromJson(json);

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DeviceConnectionState.connected()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ConnectedImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() connecting,
    required TResult Function() connected,
    required TResult Function() disconnecting,
    required TResult Function(DisconnectReason? reason) disconnected,
  }) {
    return connected();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? connecting,
    TResult? Function()? connected,
    TResult? Function()? disconnecting,
    TResult? Function(DisconnectReason? reason)? disconnected,
  }) {
    return connected?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? connecting,
    TResult Function()? connected,
    TResult Function()? disconnecting,
    TResult Function(DisconnectReason? reason)? disconnected,
    required TResult orElse(),
  }) {
    if (connected != null) {
      return connected();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Connecting value) connecting,
    required TResult Function(_Connected value) connected,
    required TResult Function(_Disconnecting value) disconnecting,
    required TResult Function(_Disconnected value) disconnected,
  }) {
    return connected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Connecting value)? connecting,
    TResult? Function(_Connected value)? connected,
    TResult? Function(_Disconnecting value)? disconnecting,
    TResult? Function(_Disconnected value)? disconnected,
  }) {
    return connected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Connecting value)? connecting,
    TResult Function(_Connected value)? connected,
    TResult Function(_Disconnecting value)? disconnecting,
    TResult Function(_Disconnected value)? disconnected,
    required TResult orElse(),
  }) {
    if (connected != null) {
      return connected(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ConnectedImplToJson(this);
  }
}

abstract class _Connected implements DeviceConnectionState {
  const factory _Connected() = _$ConnectedImpl;

  factory _Connected.fromJson(Map<String, dynamic> json) =
      _$ConnectedImpl.fromJson;
}

/// @nodoc
abstract class _$$DisconnectingImplCopyWith<$Res> {
  factory _$$DisconnectingImplCopyWith(
    _$DisconnectingImpl value,
    $Res Function(_$DisconnectingImpl) then,
  ) = __$$DisconnectingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DisconnectingImplCopyWithImpl<$Res>
    extends _$DeviceConnectionStateCopyWithImpl<$Res, _$DisconnectingImpl>
    implements _$$DisconnectingImplCopyWith<$Res> {
  __$$DisconnectingImplCopyWithImpl(
    _$DisconnectingImpl _value,
    $Res Function(_$DisconnectingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DeviceConnectionState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$DisconnectingImpl implements _Disconnecting {
  const _$DisconnectingImpl({final String? $type})
    : $type = $type ?? 'disconnecting';

  factory _$DisconnectingImpl.fromJson(Map<String, dynamic> json) =>
      _$$DisconnectingImplFromJson(json);

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DeviceConnectionState.disconnecting()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$DisconnectingImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() connecting,
    required TResult Function() connected,
    required TResult Function() disconnecting,
    required TResult Function(DisconnectReason? reason) disconnected,
  }) {
    return disconnecting();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? connecting,
    TResult? Function()? connected,
    TResult? Function()? disconnecting,
    TResult? Function(DisconnectReason? reason)? disconnected,
  }) {
    return disconnecting?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? connecting,
    TResult Function()? connected,
    TResult Function()? disconnecting,
    TResult Function(DisconnectReason? reason)? disconnected,
    required TResult orElse(),
  }) {
    if (disconnecting != null) {
      return disconnecting();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Connecting value) connecting,
    required TResult Function(_Connected value) connected,
    required TResult Function(_Disconnecting value) disconnecting,
    required TResult Function(_Disconnected value) disconnected,
  }) {
    return disconnecting(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Connecting value)? connecting,
    TResult? Function(_Connected value)? connected,
    TResult? Function(_Disconnecting value)? disconnecting,
    TResult? Function(_Disconnected value)? disconnected,
  }) {
    return disconnecting?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Connecting value)? connecting,
    TResult Function(_Connected value)? connected,
    TResult Function(_Disconnecting value)? disconnecting,
    TResult Function(_Disconnected value)? disconnected,
    required TResult orElse(),
  }) {
    if (disconnecting != null) {
      return disconnecting(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DisconnectingImplToJson(this);
  }
}

abstract class _Disconnecting implements DeviceConnectionState {
  const factory _Disconnecting() = _$DisconnectingImpl;

  factory _Disconnecting.fromJson(Map<String, dynamic> json) =
      _$DisconnectingImpl.fromJson;
}

/// @nodoc
abstract class _$$DisconnectedImplCopyWith<$Res> {
  factory _$$DisconnectedImplCopyWith(
    _$DisconnectedImpl value,
    $Res Function(_$DisconnectedImpl) then,
  ) = __$$DisconnectedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({DisconnectReason? reason});

  $DisconnectReasonCopyWith<$Res>? get reason;
}

/// @nodoc
class __$$DisconnectedImplCopyWithImpl<$Res>
    extends _$DeviceConnectionStateCopyWithImpl<$Res, _$DisconnectedImpl>
    implements _$$DisconnectedImplCopyWith<$Res> {
  __$$DisconnectedImplCopyWithImpl(
    _$DisconnectedImpl _value,
    $Res Function(_$DisconnectedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DeviceConnectionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? reason = freezed}) {
    return _then(
      _$DisconnectedImpl(
        reason: freezed == reason
            ? _value.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as DisconnectReason?,
      ),
    );
  }

  /// Create a copy of DeviceConnectionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DisconnectReasonCopyWith<$Res>? get reason {
    if (_value.reason == null) {
      return null;
    }

    return $DisconnectReasonCopyWith<$Res>(_value.reason!, (value) {
      return _then(_value.copyWith(reason: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$DisconnectedImpl implements _Disconnected {
  const _$DisconnectedImpl({this.reason, final String? $type})
    : $type = $type ?? 'disconnected';

  factory _$DisconnectedImpl.fromJson(Map<String, dynamic> json) =>
      _$$DisconnectedImplFromJson(json);

  @override
  final DisconnectReason? reason;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DeviceConnectionState.disconnected(reason: $reason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DisconnectedImpl &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, reason);

  /// Create a copy of DeviceConnectionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DisconnectedImplCopyWith<_$DisconnectedImpl> get copyWith =>
      __$$DisconnectedImplCopyWithImpl<_$DisconnectedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() connecting,
    required TResult Function() connected,
    required TResult Function() disconnecting,
    required TResult Function(DisconnectReason? reason) disconnected,
  }) {
    return disconnected(reason);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? connecting,
    TResult? Function()? connected,
    TResult? Function()? disconnecting,
    TResult? Function(DisconnectReason? reason)? disconnected,
  }) {
    return disconnected?.call(reason);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? connecting,
    TResult Function()? connected,
    TResult Function()? disconnecting,
    TResult Function(DisconnectReason? reason)? disconnected,
    required TResult orElse(),
  }) {
    if (disconnected != null) {
      return disconnected(reason);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Connecting value) connecting,
    required TResult Function(_Connected value) connected,
    required TResult Function(_Disconnecting value) disconnecting,
    required TResult Function(_Disconnected value) disconnected,
  }) {
    return disconnected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Connecting value)? connecting,
    TResult? Function(_Connected value)? connected,
    TResult? Function(_Disconnecting value)? disconnecting,
    TResult? Function(_Disconnected value)? disconnected,
  }) {
    return disconnected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Connecting value)? connecting,
    TResult Function(_Connected value)? connected,
    TResult Function(_Disconnecting value)? disconnecting,
    TResult Function(_Disconnected value)? disconnected,
    required TResult orElse(),
  }) {
    if (disconnected != null) {
      return disconnected(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DisconnectedImplToJson(this);
  }
}

abstract class _Disconnected implements DeviceConnectionState {
  const factory _Disconnected({final DisconnectReason? reason}) =
      _$DisconnectedImpl;

  factory _Disconnected.fromJson(Map<String, dynamic> json) =
      _$DisconnectedImpl.fromJson;

  DisconnectReason? get reason;

  /// Create a copy of DeviceConnectionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DisconnectedImplCopyWith<_$DisconnectedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DisconnectReason _$DisconnectReasonFromJson(Map<String, dynamic> json) {
  switch (json['type']) {
    case 'peripheralDisconnected':
      return _PeripheralDisconnected.fromJson(json);
    case 'centralDisconnected':
      return _CentralDisconnected.fromJson(json);
    case 'failed':
      return _Failed.fromJson(json);
    case 'l2CapFailure':
      return _L2CapFailure.fromJson(json);
    case 'timeout':
      return _Timeout.fromJson(json);
    case 'linkManagerProtocolTimeout':
      return _LinkManagerProtocolTimeout.fromJson(json);
    case 'unknownDevice':
      return _UnknownDevice.fromJson(json);
    case 'cancelled':
      return _Cancelled.fromJson(json);
    case 'connectionLimitReached':
      return _ConnectionLimitReached.fromJson(json);
    case 'encryptionTimedOut':
      return _EncryptionTimedOut.fromJson(json);
    case 'unknown':
      return _Unknown.fromJson(json);

    default:
      throw CheckedFromJsonException(
        json,
        'type',
        'DisconnectReason',
        'Invalid union type "${json['type']}"!',
      );
  }
}

/// @nodoc
mixin _$DisconnectReason {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() peripheralDisconnected,
    required TResult Function() centralDisconnected,
    required TResult Function() failed,
    required TResult Function() l2CapFailure,
    required TResult Function() timeout,
    required TResult Function() linkManagerProtocolTimeout,
    required TResult Function() unknownDevice,
    required TResult Function() cancelled,
    required TResult Function() connectionLimitReached,
    required TResult Function() encryptionTimedOut,
    required TResult Function(int code) unknown,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? peripheralDisconnected,
    TResult? Function()? centralDisconnected,
    TResult? Function()? failed,
    TResult? Function()? l2CapFailure,
    TResult? Function()? timeout,
    TResult? Function()? linkManagerProtocolTimeout,
    TResult? Function()? unknownDevice,
    TResult? Function()? cancelled,
    TResult? Function()? connectionLimitReached,
    TResult? Function()? encryptionTimedOut,
    TResult? Function(int code)? unknown,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? peripheralDisconnected,
    TResult Function()? centralDisconnected,
    TResult Function()? failed,
    TResult Function()? l2CapFailure,
    TResult Function()? timeout,
    TResult Function()? linkManagerProtocolTimeout,
    TResult Function()? unknownDevice,
    TResult Function()? cancelled,
    TResult Function()? connectionLimitReached,
    TResult Function()? encryptionTimedOut,
    TResult Function(int code)? unknown,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PeripheralDisconnected value)
    peripheralDisconnected,
    required TResult Function(_CentralDisconnected value) centralDisconnected,
    required TResult Function(_Failed value) failed,
    required TResult Function(_L2CapFailure value) l2CapFailure,
    required TResult Function(_Timeout value) timeout,
    required TResult Function(_LinkManagerProtocolTimeout value)
    linkManagerProtocolTimeout,
    required TResult Function(_UnknownDevice value) unknownDevice,
    required TResult Function(_Cancelled value) cancelled,
    required TResult Function(_ConnectionLimitReached value)
    connectionLimitReached,
    required TResult Function(_EncryptionTimedOut value) encryptionTimedOut,
    required TResult Function(_Unknown value) unknown,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PeripheralDisconnected value)? peripheralDisconnected,
    TResult? Function(_CentralDisconnected value)? centralDisconnected,
    TResult? Function(_Failed value)? failed,
    TResult? Function(_L2CapFailure value)? l2CapFailure,
    TResult? Function(_Timeout value)? timeout,
    TResult? Function(_LinkManagerProtocolTimeout value)?
    linkManagerProtocolTimeout,
    TResult? Function(_UnknownDevice value)? unknownDevice,
    TResult? Function(_Cancelled value)? cancelled,
    TResult? Function(_ConnectionLimitReached value)? connectionLimitReached,
    TResult? Function(_EncryptionTimedOut value)? encryptionTimedOut,
    TResult? Function(_Unknown value)? unknown,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PeripheralDisconnected value)? peripheralDisconnected,
    TResult Function(_CentralDisconnected value)? centralDisconnected,
    TResult Function(_Failed value)? failed,
    TResult Function(_L2CapFailure value)? l2CapFailure,
    TResult Function(_Timeout value)? timeout,
    TResult Function(_LinkManagerProtocolTimeout value)?
    linkManagerProtocolTimeout,
    TResult Function(_UnknownDevice value)? unknownDevice,
    TResult Function(_Cancelled value)? cancelled,
    TResult Function(_ConnectionLimitReached value)? connectionLimitReached,
    TResult Function(_EncryptionTimedOut value)? encryptionTimedOut,
    TResult Function(_Unknown value)? unknown,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Serializes this DisconnectReason to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DisconnectReasonCopyWith<$Res> {
  factory $DisconnectReasonCopyWith(
    DisconnectReason value,
    $Res Function(DisconnectReason) then,
  ) = _$DisconnectReasonCopyWithImpl<$Res, DisconnectReason>;
}

/// @nodoc
class _$DisconnectReasonCopyWithImpl<$Res, $Val extends DisconnectReason>
    implements $DisconnectReasonCopyWith<$Res> {
  _$DisconnectReasonCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DisconnectReason
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$PeripheralDisconnectedImplCopyWith<$Res> {
  factory _$$PeripheralDisconnectedImplCopyWith(
    _$PeripheralDisconnectedImpl value,
    $Res Function(_$PeripheralDisconnectedImpl) then,
  ) = __$$PeripheralDisconnectedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PeripheralDisconnectedImplCopyWithImpl<$Res>
    extends _$DisconnectReasonCopyWithImpl<$Res, _$PeripheralDisconnectedImpl>
    implements _$$PeripheralDisconnectedImplCopyWith<$Res> {
  __$$PeripheralDisconnectedImplCopyWithImpl(
    _$PeripheralDisconnectedImpl _value,
    $Res Function(_$PeripheralDisconnectedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DisconnectReason
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$PeripheralDisconnectedImpl implements _PeripheralDisconnected {
  const _$PeripheralDisconnectedImpl({final String? $type})
    : $type = $type ?? 'peripheralDisconnected';

  factory _$PeripheralDisconnectedImpl.fromJson(Map<String, dynamic> json) =>
      _$$PeripheralDisconnectedImplFromJson(json);

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DisconnectReason.peripheralDisconnected()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PeripheralDisconnectedImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() peripheralDisconnected,
    required TResult Function() centralDisconnected,
    required TResult Function() failed,
    required TResult Function() l2CapFailure,
    required TResult Function() timeout,
    required TResult Function() linkManagerProtocolTimeout,
    required TResult Function() unknownDevice,
    required TResult Function() cancelled,
    required TResult Function() connectionLimitReached,
    required TResult Function() encryptionTimedOut,
    required TResult Function(int code) unknown,
  }) {
    return peripheralDisconnected();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? peripheralDisconnected,
    TResult? Function()? centralDisconnected,
    TResult? Function()? failed,
    TResult? Function()? l2CapFailure,
    TResult? Function()? timeout,
    TResult? Function()? linkManagerProtocolTimeout,
    TResult? Function()? unknownDevice,
    TResult? Function()? cancelled,
    TResult? Function()? connectionLimitReached,
    TResult? Function()? encryptionTimedOut,
    TResult? Function(int code)? unknown,
  }) {
    return peripheralDisconnected?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? peripheralDisconnected,
    TResult Function()? centralDisconnected,
    TResult Function()? failed,
    TResult Function()? l2CapFailure,
    TResult Function()? timeout,
    TResult Function()? linkManagerProtocolTimeout,
    TResult Function()? unknownDevice,
    TResult Function()? cancelled,
    TResult Function()? connectionLimitReached,
    TResult Function()? encryptionTimedOut,
    TResult Function(int code)? unknown,
    required TResult orElse(),
  }) {
    if (peripheralDisconnected != null) {
      return peripheralDisconnected();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PeripheralDisconnected value)
    peripheralDisconnected,
    required TResult Function(_CentralDisconnected value) centralDisconnected,
    required TResult Function(_Failed value) failed,
    required TResult Function(_L2CapFailure value) l2CapFailure,
    required TResult Function(_Timeout value) timeout,
    required TResult Function(_LinkManagerProtocolTimeout value)
    linkManagerProtocolTimeout,
    required TResult Function(_UnknownDevice value) unknownDevice,
    required TResult Function(_Cancelled value) cancelled,
    required TResult Function(_ConnectionLimitReached value)
    connectionLimitReached,
    required TResult Function(_EncryptionTimedOut value) encryptionTimedOut,
    required TResult Function(_Unknown value) unknown,
  }) {
    return peripheralDisconnected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PeripheralDisconnected value)? peripheralDisconnected,
    TResult? Function(_CentralDisconnected value)? centralDisconnected,
    TResult? Function(_Failed value)? failed,
    TResult? Function(_L2CapFailure value)? l2CapFailure,
    TResult? Function(_Timeout value)? timeout,
    TResult? Function(_LinkManagerProtocolTimeout value)?
    linkManagerProtocolTimeout,
    TResult? Function(_UnknownDevice value)? unknownDevice,
    TResult? Function(_Cancelled value)? cancelled,
    TResult? Function(_ConnectionLimitReached value)? connectionLimitReached,
    TResult? Function(_EncryptionTimedOut value)? encryptionTimedOut,
    TResult? Function(_Unknown value)? unknown,
  }) {
    return peripheralDisconnected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PeripheralDisconnected value)? peripheralDisconnected,
    TResult Function(_CentralDisconnected value)? centralDisconnected,
    TResult Function(_Failed value)? failed,
    TResult Function(_L2CapFailure value)? l2CapFailure,
    TResult Function(_Timeout value)? timeout,
    TResult Function(_LinkManagerProtocolTimeout value)?
    linkManagerProtocolTimeout,
    TResult Function(_UnknownDevice value)? unknownDevice,
    TResult Function(_Cancelled value)? cancelled,
    TResult Function(_ConnectionLimitReached value)? connectionLimitReached,
    TResult Function(_EncryptionTimedOut value)? encryptionTimedOut,
    TResult Function(_Unknown value)? unknown,
    required TResult orElse(),
  }) {
    if (peripheralDisconnected != null) {
      return peripheralDisconnected(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$PeripheralDisconnectedImplToJson(this);
  }
}

abstract class _PeripheralDisconnected implements DisconnectReason {
  const factory _PeripheralDisconnected() = _$PeripheralDisconnectedImpl;

  factory _PeripheralDisconnected.fromJson(Map<String, dynamic> json) =
      _$PeripheralDisconnectedImpl.fromJson;
}

/// @nodoc
abstract class _$$CentralDisconnectedImplCopyWith<$Res> {
  factory _$$CentralDisconnectedImplCopyWith(
    _$CentralDisconnectedImpl value,
    $Res Function(_$CentralDisconnectedImpl) then,
  ) = __$$CentralDisconnectedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CentralDisconnectedImplCopyWithImpl<$Res>
    extends _$DisconnectReasonCopyWithImpl<$Res, _$CentralDisconnectedImpl>
    implements _$$CentralDisconnectedImplCopyWith<$Res> {
  __$$CentralDisconnectedImplCopyWithImpl(
    _$CentralDisconnectedImpl _value,
    $Res Function(_$CentralDisconnectedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DisconnectReason
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$CentralDisconnectedImpl implements _CentralDisconnected {
  const _$CentralDisconnectedImpl({final String? $type})
    : $type = $type ?? 'centralDisconnected';

  factory _$CentralDisconnectedImpl.fromJson(Map<String, dynamic> json) =>
      _$$CentralDisconnectedImplFromJson(json);

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DisconnectReason.centralDisconnected()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CentralDisconnectedImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() peripheralDisconnected,
    required TResult Function() centralDisconnected,
    required TResult Function() failed,
    required TResult Function() l2CapFailure,
    required TResult Function() timeout,
    required TResult Function() linkManagerProtocolTimeout,
    required TResult Function() unknownDevice,
    required TResult Function() cancelled,
    required TResult Function() connectionLimitReached,
    required TResult Function() encryptionTimedOut,
    required TResult Function(int code) unknown,
  }) {
    return centralDisconnected();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? peripheralDisconnected,
    TResult? Function()? centralDisconnected,
    TResult? Function()? failed,
    TResult? Function()? l2CapFailure,
    TResult? Function()? timeout,
    TResult? Function()? linkManagerProtocolTimeout,
    TResult? Function()? unknownDevice,
    TResult? Function()? cancelled,
    TResult? Function()? connectionLimitReached,
    TResult? Function()? encryptionTimedOut,
    TResult? Function(int code)? unknown,
  }) {
    return centralDisconnected?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? peripheralDisconnected,
    TResult Function()? centralDisconnected,
    TResult Function()? failed,
    TResult Function()? l2CapFailure,
    TResult Function()? timeout,
    TResult Function()? linkManagerProtocolTimeout,
    TResult Function()? unknownDevice,
    TResult Function()? cancelled,
    TResult Function()? connectionLimitReached,
    TResult Function()? encryptionTimedOut,
    TResult Function(int code)? unknown,
    required TResult orElse(),
  }) {
    if (centralDisconnected != null) {
      return centralDisconnected();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PeripheralDisconnected value)
    peripheralDisconnected,
    required TResult Function(_CentralDisconnected value) centralDisconnected,
    required TResult Function(_Failed value) failed,
    required TResult Function(_L2CapFailure value) l2CapFailure,
    required TResult Function(_Timeout value) timeout,
    required TResult Function(_LinkManagerProtocolTimeout value)
    linkManagerProtocolTimeout,
    required TResult Function(_UnknownDevice value) unknownDevice,
    required TResult Function(_Cancelled value) cancelled,
    required TResult Function(_ConnectionLimitReached value)
    connectionLimitReached,
    required TResult Function(_EncryptionTimedOut value) encryptionTimedOut,
    required TResult Function(_Unknown value) unknown,
  }) {
    return centralDisconnected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PeripheralDisconnected value)? peripheralDisconnected,
    TResult? Function(_CentralDisconnected value)? centralDisconnected,
    TResult? Function(_Failed value)? failed,
    TResult? Function(_L2CapFailure value)? l2CapFailure,
    TResult? Function(_Timeout value)? timeout,
    TResult? Function(_LinkManagerProtocolTimeout value)?
    linkManagerProtocolTimeout,
    TResult? Function(_UnknownDevice value)? unknownDevice,
    TResult? Function(_Cancelled value)? cancelled,
    TResult? Function(_ConnectionLimitReached value)? connectionLimitReached,
    TResult? Function(_EncryptionTimedOut value)? encryptionTimedOut,
    TResult? Function(_Unknown value)? unknown,
  }) {
    return centralDisconnected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PeripheralDisconnected value)? peripheralDisconnected,
    TResult Function(_CentralDisconnected value)? centralDisconnected,
    TResult Function(_Failed value)? failed,
    TResult Function(_L2CapFailure value)? l2CapFailure,
    TResult Function(_Timeout value)? timeout,
    TResult Function(_LinkManagerProtocolTimeout value)?
    linkManagerProtocolTimeout,
    TResult Function(_UnknownDevice value)? unknownDevice,
    TResult Function(_Cancelled value)? cancelled,
    TResult Function(_ConnectionLimitReached value)? connectionLimitReached,
    TResult Function(_EncryptionTimedOut value)? encryptionTimedOut,
    TResult Function(_Unknown value)? unknown,
    required TResult orElse(),
  }) {
    if (centralDisconnected != null) {
      return centralDisconnected(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$CentralDisconnectedImplToJson(this);
  }
}

abstract class _CentralDisconnected implements DisconnectReason {
  const factory _CentralDisconnected() = _$CentralDisconnectedImpl;

  factory _CentralDisconnected.fromJson(Map<String, dynamic> json) =
      _$CentralDisconnectedImpl.fromJson;
}

/// @nodoc
abstract class _$$FailedImplCopyWith<$Res> {
  factory _$$FailedImplCopyWith(
    _$FailedImpl value,
    $Res Function(_$FailedImpl) then,
  ) = __$$FailedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$FailedImplCopyWithImpl<$Res>
    extends _$DisconnectReasonCopyWithImpl<$Res, _$FailedImpl>
    implements _$$FailedImplCopyWith<$Res> {
  __$$FailedImplCopyWithImpl(
    _$FailedImpl _value,
    $Res Function(_$FailedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DisconnectReason
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$FailedImpl implements _Failed {
  const _$FailedImpl({final String? $type}) : $type = $type ?? 'failed';

  factory _$FailedImpl.fromJson(Map<String, dynamic> json) =>
      _$$FailedImplFromJson(json);

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DisconnectReason.failed()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$FailedImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() peripheralDisconnected,
    required TResult Function() centralDisconnected,
    required TResult Function() failed,
    required TResult Function() l2CapFailure,
    required TResult Function() timeout,
    required TResult Function() linkManagerProtocolTimeout,
    required TResult Function() unknownDevice,
    required TResult Function() cancelled,
    required TResult Function() connectionLimitReached,
    required TResult Function() encryptionTimedOut,
    required TResult Function(int code) unknown,
  }) {
    return failed();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? peripheralDisconnected,
    TResult? Function()? centralDisconnected,
    TResult? Function()? failed,
    TResult? Function()? l2CapFailure,
    TResult? Function()? timeout,
    TResult? Function()? linkManagerProtocolTimeout,
    TResult? Function()? unknownDevice,
    TResult? Function()? cancelled,
    TResult? Function()? connectionLimitReached,
    TResult? Function()? encryptionTimedOut,
    TResult? Function(int code)? unknown,
  }) {
    return failed?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? peripheralDisconnected,
    TResult Function()? centralDisconnected,
    TResult Function()? failed,
    TResult Function()? l2CapFailure,
    TResult Function()? timeout,
    TResult Function()? linkManagerProtocolTimeout,
    TResult Function()? unknownDevice,
    TResult Function()? cancelled,
    TResult Function()? connectionLimitReached,
    TResult Function()? encryptionTimedOut,
    TResult Function(int code)? unknown,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PeripheralDisconnected value)
    peripheralDisconnected,
    required TResult Function(_CentralDisconnected value) centralDisconnected,
    required TResult Function(_Failed value) failed,
    required TResult Function(_L2CapFailure value) l2CapFailure,
    required TResult Function(_Timeout value) timeout,
    required TResult Function(_LinkManagerProtocolTimeout value)
    linkManagerProtocolTimeout,
    required TResult Function(_UnknownDevice value) unknownDevice,
    required TResult Function(_Cancelled value) cancelled,
    required TResult Function(_ConnectionLimitReached value)
    connectionLimitReached,
    required TResult Function(_EncryptionTimedOut value) encryptionTimedOut,
    required TResult Function(_Unknown value) unknown,
  }) {
    return failed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PeripheralDisconnected value)? peripheralDisconnected,
    TResult? Function(_CentralDisconnected value)? centralDisconnected,
    TResult? Function(_Failed value)? failed,
    TResult? Function(_L2CapFailure value)? l2CapFailure,
    TResult? Function(_Timeout value)? timeout,
    TResult? Function(_LinkManagerProtocolTimeout value)?
    linkManagerProtocolTimeout,
    TResult? Function(_UnknownDevice value)? unknownDevice,
    TResult? Function(_Cancelled value)? cancelled,
    TResult? Function(_ConnectionLimitReached value)? connectionLimitReached,
    TResult? Function(_EncryptionTimedOut value)? encryptionTimedOut,
    TResult? Function(_Unknown value)? unknown,
  }) {
    return failed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PeripheralDisconnected value)? peripheralDisconnected,
    TResult Function(_CentralDisconnected value)? centralDisconnected,
    TResult Function(_Failed value)? failed,
    TResult Function(_L2CapFailure value)? l2CapFailure,
    TResult Function(_Timeout value)? timeout,
    TResult Function(_LinkManagerProtocolTimeout value)?
    linkManagerProtocolTimeout,
    TResult Function(_UnknownDevice value)? unknownDevice,
    TResult Function(_Cancelled value)? cancelled,
    TResult Function(_ConnectionLimitReached value)? connectionLimitReached,
    TResult Function(_EncryptionTimedOut value)? encryptionTimedOut,
    TResult Function(_Unknown value)? unknown,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$FailedImplToJson(this);
  }
}

abstract class _Failed implements DisconnectReason {
  const factory _Failed() = _$FailedImpl;

  factory _Failed.fromJson(Map<String, dynamic> json) = _$FailedImpl.fromJson;
}

/// @nodoc
abstract class _$$L2CapFailureImplCopyWith<$Res> {
  factory _$$L2CapFailureImplCopyWith(
    _$L2CapFailureImpl value,
    $Res Function(_$L2CapFailureImpl) then,
  ) = __$$L2CapFailureImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$L2CapFailureImplCopyWithImpl<$Res>
    extends _$DisconnectReasonCopyWithImpl<$Res, _$L2CapFailureImpl>
    implements _$$L2CapFailureImplCopyWith<$Res> {
  __$$L2CapFailureImplCopyWithImpl(
    _$L2CapFailureImpl _value,
    $Res Function(_$L2CapFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DisconnectReason
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$L2CapFailureImpl implements _L2CapFailure {
  const _$L2CapFailureImpl({final String? $type})
    : $type = $type ?? 'l2CapFailure';

  factory _$L2CapFailureImpl.fromJson(Map<String, dynamic> json) =>
      _$$L2CapFailureImplFromJson(json);

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DisconnectReason.l2CapFailure()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$L2CapFailureImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() peripheralDisconnected,
    required TResult Function() centralDisconnected,
    required TResult Function() failed,
    required TResult Function() l2CapFailure,
    required TResult Function() timeout,
    required TResult Function() linkManagerProtocolTimeout,
    required TResult Function() unknownDevice,
    required TResult Function() cancelled,
    required TResult Function() connectionLimitReached,
    required TResult Function() encryptionTimedOut,
    required TResult Function(int code) unknown,
  }) {
    return l2CapFailure();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? peripheralDisconnected,
    TResult? Function()? centralDisconnected,
    TResult? Function()? failed,
    TResult? Function()? l2CapFailure,
    TResult? Function()? timeout,
    TResult? Function()? linkManagerProtocolTimeout,
    TResult? Function()? unknownDevice,
    TResult? Function()? cancelled,
    TResult? Function()? connectionLimitReached,
    TResult? Function()? encryptionTimedOut,
    TResult? Function(int code)? unknown,
  }) {
    return l2CapFailure?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? peripheralDisconnected,
    TResult Function()? centralDisconnected,
    TResult Function()? failed,
    TResult Function()? l2CapFailure,
    TResult Function()? timeout,
    TResult Function()? linkManagerProtocolTimeout,
    TResult Function()? unknownDevice,
    TResult Function()? cancelled,
    TResult Function()? connectionLimitReached,
    TResult Function()? encryptionTimedOut,
    TResult Function(int code)? unknown,
    required TResult orElse(),
  }) {
    if (l2CapFailure != null) {
      return l2CapFailure();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PeripheralDisconnected value)
    peripheralDisconnected,
    required TResult Function(_CentralDisconnected value) centralDisconnected,
    required TResult Function(_Failed value) failed,
    required TResult Function(_L2CapFailure value) l2CapFailure,
    required TResult Function(_Timeout value) timeout,
    required TResult Function(_LinkManagerProtocolTimeout value)
    linkManagerProtocolTimeout,
    required TResult Function(_UnknownDevice value) unknownDevice,
    required TResult Function(_Cancelled value) cancelled,
    required TResult Function(_ConnectionLimitReached value)
    connectionLimitReached,
    required TResult Function(_EncryptionTimedOut value) encryptionTimedOut,
    required TResult Function(_Unknown value) unknown,
  }) {
    return l2CapFailure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PeripheralDisconnected value)? peripheralDisconnected,
    TResult? Function(_CentralDisconnected value)? centralDisconnected,
    TResult? Function(_Failed value)? failed,
    TResult? Function(_L2CapFailure value)? l2CapFailure,
    TResult? Function(_Timeout value)? timeout,
    TResult? Function(_LinkManagerProtocolTimeout value)?
    linkManagerProtocolTimeout,
    TResult? Function(_UnknownDevice value)? unknownDevice,
    TResult? Function(_Cancelled value)? cancelled,
    TResult? Function(_ConnectionLimitReached value)? connectionLimitReached,
    TResult? Function(_EncryptionTimedOut value)? encryptionTimedOut,
    TResult? Function(_Unknown value)? unknown,
  }) {
    return l2CapFailure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PeripheralDisconnected value)? peripheralDisconnected,
    TResult Function(_CentralDisconnected value)? centralDisconnected,
    TResult Function(_Failed value)? failed,
    TResult Function(_L2CapFailure value)? l2CapFailure,
    TResult Function(_Timeout value)? timeout,
    TResult Function(_LinkManagerProtocolTimeout value)?
    linkManagerProtocolTimeout,
    TResult Function(_UnknownDevice value)? unknownDevice,
    TResult Function(_Cancelled value)? cancelled,
    TResult Function(_ConnectionLimitReached value)? connectionLimitReached,
    TResult Function(_EncryptionTimedOut value)? encryptionTimedOut,
    TResult Function(_Unknown value)? unknown,
    required TResult orElse(),
  }) {
    if (l2CapFailure != null) {
      return l2CapFailure(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$L2CapFailureImplToJson(this);
  }
}

abstract class _L2CapFailure implements DisconnectReason {
  const factory _L2CapFailure() = _$L2CapFailureImpl;

  factory _L2CapFailure.fromJson(Map<String, dynamic> json) =
      _$L2CapFailureImpl.fromJson;
}

/// @nodoc
abstract class _$$TimeoutImplCopyWith<$Res> {
  factory _$$TimeoutImplCopyWith(
    _$TimeoutImpl value,
    $Res Function(_$TimeoutImpl) then,
  ) = __$$TimeoutImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TimeoutImplCopyWithImpl<$Res>
    extends _$DisconnectReasonCopyWithImpl<$Res, _$TimeoutImpl>
    implements _$$TimeoutImplCopyWith<$Res> {
  __$$TimeoutImplCopyWithImpl(
    _$TimeoutImpl _value,
    $Res Function(_$TimeoutImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DisconnectReason
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$TimeoutImpl implements _Timeout {
  const _$TimeoutImpl({final String? $type}) : $type = $type ?? 'timeout';

  factory _$TimeoutImpl.fromJson(Map<String, dynamic> json) =>
      _$$TimeoutImplFromJson(json);

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DisconnectReason.timeout()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$TimeoutImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() peripheralDisconnected,
    required TResult Function() centralDisconnected,
    required TResult Function() failed,
    required TResult Function() l2CapFailure,
    required TResult Function() timeout,
    required TResult Function() linkManagerProtocolTimeout,
    required TResult Function() unknownDevice,
    required TResult Function() cancelled,
    required TResult Function() connectionLimitReached,
    required TResult Function() encryptionTimedOut,
    required TResult Function(int code) unknown,
  }) {
    return timeout();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? peripheralDisconnected,
    TResult? Function()? centralDisconnected,
    TResult? Function()? failed,
    TResult? Function()? l2CapFailure,
    TResult? Function()? timeout,
    TResult? Function()? linkManagerProtocolTimeout,
    TResult? Function()? unknownDevice,
    TResult? Function()? cancelled,
    TResult? Function()? connectionLimitReached,
    TResult? Function()? encryptionTimedOut,
    TResult? Function(int code)? unknown,
  }) {
    return timeout?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? peripheralDisconnected,
    TResult Function()? centralDisconnected,
    TResult Function()? failed,
    TResult Function()? l2CapFailure,
    TResult Function()? timeout,
    TResult Function()? linkManagerProtocolTimeout,
    TResult Function()? unknownDevice,
    TResult Function()? cancelled,
    TResult Function()? connectionLimitReached,
    TResult Function()? encryptionTimedOut,
    TResult Function(int code)? unknown,
    required TResult orElse(),
  }) {
    if (timeout != null) {
      return timeout();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PeripheralDisconnected value)
    peripheralDisconnected,
    required TResult Function(_CentralDisconnected value) centralDisconnected,
    required TResult Function(_Failed value) failed,
    required TResult Function(_L2CapFailure value) l2CapFailure,
    required TResult Function(_Timeout value) timeout,
    required TResult Function(_LinkManagerProtocolTimeout value)
    linkManagerProtocolTimeout,
    required TResult Function(_UnknownDevice value) unknownDevice,
    required TResult Function(_Cancelled value) cancelled,
    required TResult Function(_ConnectionLimitReached value)
    connectionLimitReached,
    required TResult Function(_EncryptionTimedOut value) encryptionTimedOut,
    required TResult Function(_Unknown value) unknown,
  }) {
    return timeout(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PeripheralDisconnected value)? peripheralDisconnected,
    TResult? Function(_CentralDisconnected value)? centralDisconnected,
    TResult? Function(_Failed value)? failed,
    TResult? Function(_L2CapFailure value)? l2CapFailure,
    TResult? Function(_Timeout value)? timeout,
    TResult? Function(_LinkManagerProtocolTimeout value)?
    linkManagerProtocolTimeout,
    TResult? Function(_UnknownDevice value)? unknownDevice,
    TResult? Function(_Cancelled value)? cancelled,
    TResult? Function(_ConnectionLimitReached value)? connectionLimitReached,
    TResult? Function(_EncryptionTimedOut value)? encryptionTimedOut,
    TResult? Function(_Unknown value)? unknown,
  }) {
    return timeout?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PeripheralDisconnected value)? peripheralDisconnected,
    TResult Function(_CentralDisconnected value)? centralDisconnected,
    TResult Function(_Failed value)? failed,
    TResult Function(_L2CapFailure value)? l2CapFailure,
    TResult Function(_Timeout value)? timeout,
    TResult Function(_LinkManagerProtocolTimeout value)?
    linkManagerProtocolTimeout,
    TResult Function(_UnknownDevice value)? unknownDevice,
    TResult Function(_Cancelled value)? cancelled,
    TResult Function(_ConnectionLimitReached value)? connectionLimitReached,
    TResult Function(_EncryptionTimedOut value)? encryptionTimedOut,
    TResult Function(_Unknown value)? unknown,
    required TResult orElse(),
  }) {
    if (timeout != null) {
      return timeout(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$TimeoutImplToJson(this);
  }
}

abstract class _Timeout implements DisconnectReason {
  const factory _Timeout() = _$TimeoutImpl;

  factory _Timeout.fromJson(Map<String, dynamic> json) = _$TimeoutImpl.fromJson;
}

/// @nodoc
abstract class _$$LinkManagerProtocolTimeoutImplCopyWith<$Res> {
  factory _$$LinkManagerProtocolTimeoutImplCopyWith(
    _$LinkManagerProtocolTimeoutImpl value,
    $Res Function(_$LinkManagerProtocolTimeoutImpl) then,
  ) = __$$LinkManagerProtocolTimeoutImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LinkManagerProtocolTimeoutImplCopyWithImpl<$Res>
    extends
        _$DisconnectReasonCopyWithImpl<$Res, _$LinkManagerProtocolTimeoutImpl>
    implements _$$LinkManagerProtocolTimeoutImplCopyWith<$Res> {
  __$$LinkManagerProtocolTimeoutImplCopyWithImpl(
    _$LinkManagerProtocolTimeoutImpl _value,
    $Res Function(_$LinkManagerProtocolTimeoutImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DisconnectReason
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$LinkManagerProtocolTimeoutImpl implements _LinkManagerProtocolTimeout {
  const _$LinkManagerProtocolTimeoutImpl({final String? $type})
    : $type = $type ?? 'linkManagerProtocolTimeout';

  factory _$LinkManagerProtocolTimeoutImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$LinkManagerProtocolTimeoutImplFromJson(json);

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DisconnectReason.linkManagerProtocolTimeout()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LinkManagerProtocolTimeoutImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() peripheralDisconnected,
    required TResult Function() centralDisconnected,
    required TResult Function() failed,
    required TResult Function() l2CapFailure,
    required TResult Function() timeout,
    required TResult Function() linkManagerProtocolTimeout,
    required TResult Function() unknownDevice,
    required TResult Function() cancelled,
    required TResult Function() connectionLimitReached,
    required TResult Function() encryptionTimedOut,
    required TResult Function(int code) unknown,
  }) {
    return linkManagerProtocolTimeout();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? peripheralDisconnected,
    TResult? Function()? centralDisconnected,
    TResult? Function()? failed,
    TResult? Function()? l2CapFailure,
    TResult? Function()? timeout,
    TResult? Function()? linkManagerProtocolTimeout,
    TResult? Function()? unknownDevice,
    TResult? Function()? cancelled,
    TResult? Function()? connectionLimitReached,
    TResult? Function()? encryptionTimedOut,
    TResult? Function(int code)? unknown,
  }) {
    return linkManagerProtocolTimeout?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? peripheralDisconnected,
    TResult Function()? centralDisconnected,
    TResult Function()? failed,
    TResult Function()? l2CapFailure,
    TResult Function()? timeout,
    TResult Function()? linkManagerProtocolTimeout,
    TResult Function()? unknownDevice,
    TResult Function()? cancelled,
    TResult Function()? connectionLimitReached,
    TResult Function()? encryptionTimedOut,
    TResult Function(int code)? unknown,
    required TResult orElse(),
  }) {
    if (linkManagerProtocolTimeout != null) {
      return linkManagerProtocolTimeout();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PeripheralDisconnected value)
    peripheralDisconnected,
    required TResult Function(_CentralDisconnected value) centralDisconnected,
    required TResult Function(_Failed value) failed,
    required TResult Function(_L2CapFailure value) l2CapFailure,
    required TResult Function(_Timeout value) timeout,
    required TResult Function(_LinkManagerProtocolTimeout value)
    linkManagerProtocolTimeout,
    required TResult Function(_UnknownDevice value) unknownDevice,
    required TResult Function(_Cancelled value) cancelled,
    required TResult Function(_ConnectionLimitReached value)
    connectionLimitReached,
    required TResult Function(_EncryptionTimedOut value) encryptionTimedOut,
    required TResult Function(_Unknown value) unknown,
  }) {
    return linkManagerProtocolTimeout(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PeripheralDisconnected value)? peripheralDisconnected,
    TResult? Function(_CentralDisconnected value)? centralDisconnected,
    TResult? Function(_Failed value)? failed,
    TResult? Function(_L2CapFailure value)? l2CapFailure,
    TResult? Function(_Timeout value)? timeout,
    TResult? Function(_LinkManagerProtocolTimeout value)?
    linkManagerProtocolTimeout,
    TResult? Function(_UnknownDevice value)? unknownDevice,
    TResult? Function(_Cancelled value)? cancelled,
    TResult? Function(_ConnectionLimitReached value)? connectionLimitReached,
    TResult? Function(_EncryptionTimedOut value)? encryptionTimedOut,
    TResult? Function(_Unknown value)? unknown,
  }) {
    return linkManagerProtocolTimeout?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PeripheralDisconnected value)? peripheralDisconnected,
    TResult Function(_CentralDisconnected value)? centralDisconnected,
    TResult Function(_Failed value)? failed,
    TResult Function(_L2CapFailure value)? l2CapFailure,
    TResult Function(_Timeout value)? timeout,
    TResult Function(_LinkManagerProtocolTimeout value)?
    linkManagerProtocolTimeout,
    TResult Function(_UnknownDevice value)? unknownDevice,
    TResult Function(_Cancelled value)? cancelled,
    TResult Function(_ConnectionLimitReached value)? connectionLimitReached,
    TResult Function(_EncryptionTimedOut value)? encryptionTimedOut,
    TResult Function(_Unknown value)? unknown,
    required TResult orElse(),
  }) {
    if (linkManagerProtocolTimeout != null) {
      return linkManagerProtocolTimeout(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$LinkManagerProtocolTimeoutImplToJson(this);
  }
}

abstract class _LinkManagerProtocolTimeout implements DisconnectReason {
  const factory _LinkManagerProtocolTimeout() =
      _$LinkManagerProtocolTimeoutImpl;

  factory _LinkManagerProtocolTimeout.fromJson(Map<String, dynamic> json) =
      _$LinkManagerProtocolTimeoutImpl.fromJson;
}

/// @nodoc
abstract class _$$UnknownDeviceImplCopyWith<$Res> {
  factory _$$UnknownDeviceImplCopyWith(
    _$UnknownDeviceImpl value,
    $Res Function(_$UnknownDeviceImpl) then,
  ) = __$$UnknownDeviceImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UnknownDeviceImplCopyWithImpl<$Res>
    extends _$DisconnectReasonCopyWithImpl<$Res, _$UnknownDeviceImpl>
    implements _$$UnknownDeviceImplCopyWith<$Res> {
  __$$UnknownDeviceImplCopyWithImpl(
    _$UnknownDeviceImpl _value,
    $Res Function(_$UnknownDeviceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DisconnectReason
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$UnknownDeviceImpl implements _UnknownDevice {
  const _$UnknownDeviceImpl({final String? $type})
    : $type = $type ?? 'unknownDevice';

  factory _$UnknownDeviceImpl.fromJson(Map<String, dynamic> json) =>
      _$$UnknownDeviceImplFromJson(json);

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DisconnectReason.unknownDevice()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$UnknownDeviceImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() peripheralDisconnected,
    required TResult Function() centralDisconnected,
    required TResult Function() failed,
    required TResult Function() l2CapFailure,
    required TResult Function() timeout,
    required TResult Function() linkManagerProtocolTimeout,
    required TResult Function() unknownDevice,
    required TResult Function() cancelled,
    required TResult Function() connectionLimitReached,
    required TResult Function() encryptionTimedOut,
    required TResult Function(int code) unknown,
  }) {
    return unknownDevice();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? peripheralDisconnected,
    TResult? Function()? centralDisconnected,
    TResult? Function()? failed,
    TResult? Function()? l2CapFailure,
    TResult? Function()? timeout,
    TResult? Function()? linkManagerProtocolTimeout,
    TResult? Function()? unknownDevice,
    TResult? Function()? cancelled,
    TResult? Function()? connectionLimitReached,
    TResult? Function()? encryptionTimedOut,
    TResult? Function(int code)? unknown,
  }) {
    return unknownDevice?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? peripheralDisconnected,
    TResult Function()? centralDisconnected,
    TResult Function()? failed,
    TResult Function()? l2CapFailure,
    TResult Function()? timeout,
    TResult Function()? linkManagerProtocolTimeout,
    TResult Function()? unknownDevice,
    TResult Function()? cancelled,
    TResult Function()? connectionLimitReached,
    TResult Function()? encryptionTimedOut,
    TResult Function(int code)? unknown,
    required TResult orElse(),
  }) {
    if (unknownDevice != null) {
      return unknownDevice();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PeripheralDisconnected value)
    peripheralDisconnected,
    required TResult Function(_CentralDisconnected value) centralDisconnected,
    required TResult Function(_Failed value) failed,
    required TResult Function(_L2CapFailure value) l2CapFailure,
    required TResult Function(_Timeout value) timeout,
    required TResult Function(_LinkManagerProtocolTimeout value)
    linkManagerProtocolTimeout,
    required TResult Function(_UnknownDevice value) unknownDevice,
    required TResult Function(_Cancelled value) cancelled,
    required TResult Function(_ConnectionLimitReached value)
    connectionLimitReached,
    required TResult Function(_EncryptionTimedOut value) encryptionTimedOut,
    required TResult Function(_Unknown value) unknown,
  }) {
    return unknownDevice(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PeripheralDisconnected value)? peripheralDisconnected,
    TResult? Function(_CentralDisconnected value)? centralDisconnected,
    TResult? Function(_Failed value)? failed,
    TResult? Function(_L2CapFailure value)? l2CapFailure,
    TResult? Function(_Timeout value)? timeout,
    TResult? Function(_LinkManagerProtocolTimeout value)?
    linkManagerProtocolTimeout,
    TResult? Function(_UnknownDevice value)? unknownDevice,
    TResult? Function(_Cancelled value)? cancelled,
    TResult? Function(_ConnectionLimitReached value)? connectionLimitReached,
    TResult? Function(_EncryptionTimedOut value)? encryptionTimedOut,
    TResult? Function(_Unknown value)? unknown,
  }) {
    return unknownDevice?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PeripheralDisconnected value)? peripheralDisconnected,
    TResult Function(_CentralDisconnected value)? centralDisconnected,
    TResult Function(_Failed value)? failed,
    TResult Function(_L2CapFailure value)? l2CapFailure,
    TResult Function(_Timeout value)? timeout,
    TResult Function(_LinkManagerProtocolTimeout value)?
    linkManagerProtocolTimeout,
    TResult Function(_UnknownDevice value)? unknownDevice,
    TResult Function(_Cancelled value)? cancelled,
    TResult Function(_ConnectionLimitReached value)? connectionLimitReached,
    TResult Function(_EncryptionTimedOut value)? encryptionTimedOut,
    TResult Function(_Unknown value)? unknown,
    required TResult orElse(),
  }) {
    if (unknownDevice != null) {
      return unknownDevice(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$UnknownDeviceImplToJson(this);
  }
}

abstract class _UnknownDevice implements DisconnectReason {
  const factory _UnknownDevice() = _$UnknownDeviceImpl;

  factory _UnknownDevice.fromJson(Map<String, dynamic> json) =
      _$UnknownDeviceImpl.fromJson;
}

/// @nodoc
abstract class _$$CancelledImplCopyWith<$Res> {
  factory _$$CancelledImplCopyWith(
    _$CancelledImpl value,
    $Res Function(_$CancelledImpl) then,
  ) = __$$CancelledImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CancelledImplCopyWithImpl<$Res>
    extends _$DisconnectReasonCopyWithImpl<$Res, _$CancelledImpl>
    implements _$$CancelledImplCopyWith<$Res> {
  __$$CancelledImplCopyWithImpl(
    _$CancelledImpl _value,
    $Res Function(_$CancelledImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DisconnectReason
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$CancelledImpl implements _Cancelled {
  const _$CancelledImpl({final String? $type}) : $type = $type ?? 'cancelled';

  factory _$CancelledImpl.fromJson(Map<String, dynamic> json) =>
      _$$CancelledImplFromJson(json);

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DisconnectReason.cancelled()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CancelledImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() peripheralDisconnected,
    required TResult Function() centralDisconnected,
    required TResult Function() failed,
    required TResult Function() l2CapFailure,
    required TResult Function() timeout,
    required TResult Function() linkManagerProtocolTimeout,
    required TResult Function() unknownDevice,
    required TResult Function() cancelled,
    required TResult Function() connectionLimitReached,
    required TResult Function() encryptionTimedOut,
    required TResult Function(int code) unknown,
  }) {
    return cancelled();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? peripheralDisconnected,
    TResult? Function()? centralDisconnected,
    TResult? Function()? failed,
    TResult? Function()? l2CapFailure,
    TResult? Function()? timeout,
    TResult? Function()? linkManagerProtocolTimeout,
    TResult? Function()? unknownDevice,
    TResult? Function()? cancelled,
    TResult? Function()? connectionLimitReached,
    TResult? Function()? encryptionTimedOut,
    TResult? Function(int code)? unknown,
  }) {
    return cancelled?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? peripheralDisconnected,
    TResult Function()? centralDisconnected,
    TResult Function()? failed,
    TResult Function()? l2CapFailure,
    TResult Function()? timeout,
    TResult Function()? linkManagerProtocolTimeout,
    TResult Function()? unknownDevice,
    TResult Function()? cancelled,
    TResult Function()? connectionLimitReached,
    TResult Function()? encryptionTimedOut,
    TResult Function(int code)? unknown,
    required TResult orElse(),
  }) {
    if (cancelled != null) {
      return cancelled();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PeripheralDisconnected value)
    peripheralDisconnected,
    required TResult Function(_CentralDisconnected value) centralDisconnected,
    required TResult Function(_Failed value) failed,
    required TResult Function(_L2CapFailure value) l2CapFailure,
    required TResult Function(_Timeout value) timeout,
    required TResult Function(_LinkManagerProtocolTimeout value)
    linkManagerProtocolTimeout,
    required TResult Function(_UnknownDevice value) unknownDevice,
    required TResult Function(_Cancelled value) cancelled,
    required TResult Function(_ConnectionLimitReached value)
    connectionLimitReached,
    required TResult Function(_EncryptionTimedOut value) encryptionTimedOut,
    required TResult Function(_Unknown value) unknown,
  }) {
    return cancelled(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PeripheralDisconnected value)? peripheralDisconnected,
    TResult? Function(_CentralDisconnected value)? centralDisconnected,
    TResult? Function(_Failed value)? failed,
    TResult? Function(_L2CapFailure value)? l2CapFailure,
    TResult? Function(_Timeout value)? timeout,
    TResult? Function(_LinkManagerProtocolTimeout value)?
    linkManagerProtocolTimeout,
    TResult? Function(_UnknownDevice value)? unknownDevice,
    TResult? Function(_Cancelled value)? cancelled,
    TResult? Function(_ConnectionLimitReached value)? connectionLimitReached,
    TResult? Function(_EncryptionTimedOut value)? encryptionTimedOut,
    TResult? Function(_Unknown value)? unknown,
  }) {
    return cancelled?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PeripheralDisconnected value)? peripheralDisconnected,
    TResult Function(_CentralDisconnected value)? centralDisconnected,
    TResult Function(_Failed value)? failed,
    TResult Function(_L2CapFailure value)? l2CapFailure,
    TResult Function(_Timeout value)? timeout,
    TResult Function(_LinkManagerProtocolTimeout value)?
    linkManagerProtocolTimeout,
    TResult Function(_UnknownDevice value)? unknownDevice,
    TResult Function(_Cancelled value)? cancelled,
    TResult Function(_ConnectionLimitReached value)? connectionLimitReached,
    TResult Function(_EncryptionTimedOut value)? encryptionTimedOut,
    TResult Function(_Unknown value)? unknown,
    required TResult orElse(),
  }) {
    if (cancelled != null) {
      return cancelled(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$CancelledImplToJson(this);
  }
}

abstract class _Cancelled implements DisconnectReason {
  const factory _Cancelled() = _$CancelledImpl;

  factory _Cancelled.fromJson(Map<String, dynamic> json) =
      _$CancelledImpl.fromJson;
}

/// @nodoc
abstract class _$$ConnectionLimitReachedImplCopyWith<$Res> {
  factory _$$ConnectionLimitReachedImplCopyWith(
    _$ConnectionLimitReachedImpl value,
    $Res Function(_$ConnectionLimitReachedImpl) then,
  ) = __$$ConnectionLimitReachedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ConnectionLimitReachedImplCopyWithImpl<$Res>
    extends _$DisconnectReasonCopyWithImpl<$Res, _$ConnectionLimitReachedImpl>
    implements _$$ConnectionLimitReachedImplCopyWith<$Res> {
  __$$ConnectionLimitReachedImplCopyWithImpl(
    _$ConnectionLimitReachedImpl _value,
    $Res Function(_$ConnectionLimitReachedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DisconnectReason
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$ConnectionLimitReachedImpl implements _ConnectionLimitReached {
  const _$ConnectionLimitReachedImpl({final String? $type})
    : $type = $type ?? 'connectionLimitReached';

  factory _$ConnectionLimitReachedImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConnectionLimitReachedImplFromJson(json);

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DisconnectReason.connectionLimitReached()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectionLimitReachedImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() peripheralDisconnected,
    required TResult Function() centralDisconnected,
    required TResult Function() failed,
    required TResult Function() l2CapFailure,
    required TResult Function() timeout,
    required TResult Function() linkManagerProtocolTimeout,
    required TResult Function() unknownDevice,
    required TResult Function() cancelled,
    required TResult Function() connectionLimitReached,
    required TResult Function() encryptionTimedOut,
    required TResult Function(int code) unknown,
  }) {
    return connectionLimitReached();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? peripheralDisconnected,
    TResult? Function()? centralDisconnected,
    TResult? Function()? failed,
    TResult? Function()? l2CapFailure,
    TResult? Function()? timeout,
    TResult? Function()? linkManagerProtocolTimeout,
    TResult? Function()? unknownDevice,
    TResult? Function()? cancelled,
    TResult? Function()? connectionLimitReached,
    TResult? Function()? encryptionTimedOut,
    TResult? Function(int code)? unknown,
  }) {
    return connectionLimitReached?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? peripheralDisconnected,
    TResult Function()? centralDisconnected,
    TResult Function()? failed,
    TResult Function()? l2CapFailure,
    TResult Function()? timeout,
    TResult Function()? linkManagerProtocolTimeout,
    TResult Function()? unknownDevice,
    TResult Function()? cancelled,
    TResult Function()? connectionLimitReached,
    TResult Function()? encryptionTimedOut,
    TResult Function(int code)? unknown,
    required TResult orElse(),
  }) {
    if (connectionLimitReached != null) {
      return connectionLimitReached();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PeripheralDisconnected value)
    peripheralDisconnected,
    required TResult Function(_CentralDisconnected value) centralDisconnected,
    required TResult Function(_Failed value) failed,
    required TResult Function(_L2CapFailure value) l2CapFailure,
    required TResult Function(_Timeout value) timeout,
    required TResult Function(_LinkManagerProtocolTimeout value)
    linkManagerProtocolTimeout,
    required TResult Function(_UnknownDevice value) unknownDevice,
    required TResult Function(_Cancelled value) cancelled,
    required TResult Function(_ConnectionLimitReached value)
    connectionLimitReached,
    required TResult Function(_EncryptionTimedOut value) encryptionTimedOut,
    required TResult Function(_Unknown value) unknown,
  }) {
    return connectionLimitReached(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PeripheralDisconnected value)? peripheralDisconnected,
    TResult? Function(_CentralDisconnected value)? centralDisconnected,
    TResult? Function(_Failed value)? failed,
    TResult? Function(_L2CapFailure value)? l2CapFailure,
    TResult? Function(_Timeout value)? timeout,
    TResult? Function(_LinkManagerProtocolTimeout value)?
    linkManagerProtocolTimeout,
    TResult? Function(_UnknownDevice value)? unknownDevice,
    TResult? Function(_Cancelled value)? cancelled,
    TResult? Function(_ConnectionLimitReached value)? connectionLimitReached,
    TResult? Function(_EncryptionTimedOut value)? encryptionTimedOut,
    TResult? Function(_Unknown value)? unknown,
  }) {
    return connectionLimitReached?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PeripheralDisconnected value)? peripheralDisconnected,
    TResult Function(_CentralDisconnected value)? centralDisconnected,
    TResult Function(_Failed value)? failed,
    TResult Function(_L2CapFailure value)? l2CapFailure,
    TResult Function(_Timeout value)? timeout,
    TResult Function(_LinkManagerProtocolTimeout value)?
    linkManagerProtocolTimeout,
    TResult Function(_UnknownDevice value)? unknownDevice,
    TResult Function(_Cancelled value)? cancelled,
    TResult Function(_ConnectionLimitReached value)? connectionLimitReached,
    TResult Function(_EncryptionTimedOut value)? encryptionTimedOut,
    TResult Function(_Unknown value)? unknown,
    required TResult orElse(),
  }) {
    if (connectionLimitReached != null) {
      return connectionLimitReached(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ConnectionLimitReachedImplToJson(this);
  }
}

abstract class _ConnectionLimitReached implements DisconnectReason {
  const factory _ConnectionLimitReached() = _$ConnectionLimitReachedImpl;

  factory _ConnectionLimitReached.fromJson(Map<String, dynamic> json) =
      _$ConnectionLimitReachedImpl.fromJson;
}

/// @nodoc
abstract class _$$EncryptionTimedOutImplCopyWith<$Res> {
  factory _$$EncryptionTimedOutImplCopyWith(
    _$EncryptionTimedOutImpl value,
    $Res Function(_$EncryptionTimedOutImpl) then,
  ) = __$$EncryptionTimedOutImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$EncryptionTimedOutImplCopyWithImpl<$Res>
    extends _$DisconnectReasonCopyWithImpl<$Res, _$EncryptionTimedOutImpl>
    implements _$$EncryptionTimedOutImplCopyWith<$Res> {
  __$$EncryptionTimedOutImplCopyWithImpl(
    _$EncryptionTimedOutImpl _value,
    $Res Function(_$EncryptionTimedOutImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DisconnectReason
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$EncryptionTimedOutImpl implements _EncryptionTimedOut {
  const _$EncryptionTimedOutImpl({final String? $type})
    : $type = $type ?? 'encryptionTimedOut';

  factory _$EncryptionTimedOutImpl.fromJson(Map<String, dynamic> json) =>
      _$$EncryptionTimedOutImplFromJson(json);

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DisconnectReason.encryptionTimedOut()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$EncryptionTimedOutImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() peripheralDisconnected,
    required TResult Function() centralDisconnected,
    required TResult Function() failed,
    required TResult Function() l2CapFailure,
    required TResult Function() timeout,
    required TResult Function() linkManagerProtocolTimeout,
    required TResult Function() unknownDevice,
    required TResult Function() cancelled,
    required TResult Function() connectionLimitReached,
    required TResult Function() encryptionTimedOut,
    required TResult Function(int code) unknown,
  }) {
    return encryptionTimedOut();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? peripheralDisconnected,
    TResult? Function()? centralDisconnected,
    TResult? Function()? failed,
    TResult? Function()? l2CapFailure,
    TResult? Function()? timeout,
    TResult? Function()? linkManagerProtocolTimeout,
    TResult? Function()? unknownDevice,
    TResult? Function()? cancelled,
    TResult? Function()? connectionLimitReached,
    TResult? Function()? encryptionTimedOut,
    TResult? Function(int code)? unknown,
  }) {
    return encryptionTimedOut?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? peripheralDisconnected,
    TResult Function()? centralDisconnected,
    TResult Function()? failed,
    TResult Function()? l2CapFailure,
    TResult Function()? timeout,
    TResult Function()? linkManagerProtocolTimeout,
    TResult Function()? unknownDevice,
    TResult Function()? cancelled,
    TResult Function()? connectionLimitReached,
    TResult Function()? encryptionTimedOut,
    TResult Function(int code)? unknown,
    required TResult orElse(),
  }) {
    if (encryptionTimedOut != null) {
      return encryptionTimedOut();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PeripheralDisconnected value)
    peripheralDisconnected,
    required TResult Function(_CentralDisconnected value) centralDisconnected,
    required TResult Function(_Failed value) failed,
    required TResult Function(_L2CapFailure value) l2CapFailure,
    required TResult Function(_Timeout value) timeout,
    required TResult Function(_LinkManagerProtocolTimeout value)
    linkManagerProtocolTimeout,
    required TResult Function(_UnknownDevice value) unknownDevice,
    required TResult Function(_Cancelled value) cancelled,
    required TResult Function(_ConnectionLimitReached value)
    connectionLimitReached,
    required TResult Function(_EncryptionTimedOut value) encryptionTimedOut,
    required TResult Function(_Unknown value) unknown,
  }) {
    return encryptionTimedOut(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PeripheralDisconnected value)? peripheralDisconnected,
    TResult? Function(_CentralDisconnected value)? centralDisconnected,
    TResult? Function(_Failed value)? failed,
    TResult? Function(_L2CapFailure value)? l2CapFailure,
    TResult? Function(_Timeout value)? timeout,
    TResult? Function(_LinkManagerProtocolTimeout value)?
    linkManagerProtocolTimeout,
    TResult? Function(_UnknownDevice value)? unknownDevice,
    TResult? Function(_Cancelled value)? cancelled,
    TResult? Function(_ConnectionLimitReached value)? connectionLimitReached,
    TResult? Function(_EncryptionTimedOut value)? encryptionTimedOut,
    TResult? Function(_Unknown value)? unknown,
  }) {
    return encryptionTimedOut?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PeripheralDisconnected value)? peripheralDisconnected,
    TResult Function(_CentralDisconnected value)? centralDisconnected,
    TResult Function(_Failed value)? failed,
    TResult Function(_L2CapFailure value)? l2CapFailure,
    TResult Function(_Timeout value)? timeout,
    TResult Function(_LinkManagerProtocolTimeout value)?
    linkManagerProtocolTimeout,
    TResult Function(_UnknownDevice value)? unknownDevice,
    TResult Function(_Cancelled value)? cancelled,
    TResult Function(_ConnectionLimitReached value)? connectionLimitReached,
    TResult Function(_EncryptionTimedOut value)? encryptionTimedOut,
    TResult Function(_Unknown value)? unknown,
    required TResult orElse(),
  }) {
    if (encryptionTimedOut != null) {
      return encryptionTimedOut(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$EncryptionTimedOutImplToJson(this);
  }
}

abstract class _EncryptionTimedOut implements DisconnectReason {
  const factory _EncryptionTimedOut() = _$EncryptionTimedOutImpl;

  factory _EncryptionTimedOut.fromJson(Map<String, dynamic> json) =
      _$EncryptionTimedOutImpl.fromJson;
}

/// @nodoc
abstract class _$$UnknownImplCopyWith<$Res> {
  factory _$$UnknownImplCopyWith(
    _$UnknownImpl value,
    $Res Function(_$UnknownImpl) then,
  ) = __$$UnknownImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int code});
}

/// @nodoc
class __$$UnknownImplCopyWithImpl<$Res>
    extends _$DisconnectReasonCopyWithImpl<$Res, _$UnknownImpl>
    implements _$$UnknownImplCopyWith<$Res> {
  __$$UnknownImplCopyWithImpl(
    _$UnknownImpl _value,
    $Res Function(_$UnknownImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DisconnectReason
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? code = null}) {
    return _then(
      _$UnknownImpl(
        code: null == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UnknownImpl implements _Unknown {
  const _$UnknownImpl({required this.code, final String? $type})
    : $type = $type ?? 'unknown';

  factory _$UnknownImpl.fromJson(Map<String, dynamic> json) =>
      _$$UnknownImplFromJson(json);

  @override
  final int code;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DisconnectReason.unknown(code: $code)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnknownImpl &&
            (identical(other.code, code) || other.code == code));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, code);

  /// Create a copy of DisconnectReason
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UnknownImplCopyWith<_$UnknownImpl> get copyWith =>
      __$$UnknownImplCopyWithImpl<_$UnknownImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() peripheralDisconnected,
    required TResult Function() centralDisconnected,
    required TResult Function() failed,
    required TResult Function() l2CapFailure,
    required TResult Function() timeout,
    required TResult Function() linkManagerProtocolTimeout,
    required TResult Function() unknownDevice,
    required TResult Function() cancelled,
    required TResult Function() connectionLimitReached,
    required TResult Function() encryptionTimedOut,
    required TResult Function(int code) unknown,
  }) {
    return unknown(code);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? peripheralDisconnected,
    TResult? Function()? centralDisconnected,
    TResult? Function()? failed,
    TResult? Function()? l2CapFailure,
    TResult? Function()? timeout,
    TResult? Function()? linkManagerProtocolTimeout,
    TResult? Function()? unknownDevice,
    TResult? Function()? cancelled,
    TResult? Function()? connectionLimitReached,
    TResult? Function()? encryptionTimedOut,
    TResult? Function(int code)? unknown,
  }) {
    return unknown?.call(code);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? peripheralDisconnected,
    TResult Function()? centralDisconnected,
    TResult Function()? failed,
    TResult Function()? l2CapFailure,
    TResult Function()? timeout,
    TResult Function()? linkManagerProtocolTimeout,
    TResult Function()? unknownDevice,
    TResult Function()? cancelled,
    TResult Function()? connectionLimitReached,
    TResult Function()? encryptionTimedOut,
    TResult Function(int code)? unknown,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(code);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PeripheralDisconnected value)
    peripheralDisconnected,
    required TResult Function(_CentralDisconnected value) centralDisconnected,
    required TResult Function(_Failed value) failed,
    required TResult Function(_L2CapFailure value) l2CapFailure,
    required TResult Function(_Timeout value) timeout,
    required TResult Function(_LinkManagerProtocolTimeout value)
    linkManagerProtocolTimeout,
    required TResult Function(_UnknownDevice value) unknownDevice,
    required TResult Function(_Cancelled value) cancelled,
    required TResult Function(_ConnectionLimitReached value)
    connectionLimitReached,
    required TResult Function(_EncryptionTimedOut value) encryptionTimedOut,
    required TResult Function(_Unknown value) unknown,
  }) {
    return unknown(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PeripheralDisconnected value)? peripheralDisconnected,
    TResult? Function(_CentralDisconnected value)? centralDisconnected,
    TResult? Function(_Failed value)? failed,
    TResult? Function(_L2CapFailure value)? l2CapFailure,
    TResult? Function(_Timeout value)? timeout,
    TResult? Function(_LinkManagerProtocolTimeout value)?
    linkManagerProtocolTimeout,
    TResult? Function(_UnknownDevice value)? unknownDevice,
    TResult? Function(_Cancelled value)? cancelled,
    TResult? Function(_ConnectionLimitReached value)? connectionLimitReached,
    TResult? Function(_EncryptionTimedOut value)? encryptionTimedOut,
    TResult? Function(_Unknown value)? unknown,
  }) {
    return unknown?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PeripheralDisconnected value)? peripheralDisconnected,
    TResult Function(_CentralDisconnected value)? centralDisconnected,
    TResult Function(_Failed value)? failed,
    TResult Function(_L2CapFailure value)? l2CapFailure,
    TResult Function(_Timeout value)? timeout,
    TResult Function(_LinkManagerProtocolTimeout value)?
    linkManagerProtocolTimeout,
    TResult Function(_UnknownDevice value)? unknownDevice,
    TResult Function(_Cancelled value)? cancelled,
    TResult Function(_ConnectionLimitReached value)? connectionLimitReached,
    TResult Function(_EncryptionTimedOut value)? encryptionTimedOut,
    TResult Function(_Unknown value)? unknown,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$UnknownImplToJson(this);
  }
}

abstract class _Unknown implements DisconnectReason {
  const factory _Unknown({required final int code}) = _$UnknownImpl;

  factory _Unknown.fromJson(Map<String, dynamic> json) = _$UnknownImpl.fromJson;

  int get code;

  /// Create a copy of DisconnectReason
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UnknownImplCopyWith<_$UnknownImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ExperimentOnlineData _$ExperimentOnlineDataFromJson(Map<String, dynamic> json) {
  return _ExperimentOnlineData.fromJson(json);
}

/// @nodoc
mixin _$ExperimentOnlineData {
  /// Serializes this ExperimentOnlineData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExperimentOnlineDataCopyWith<$Res> {
  factory $ExperimentOnlineDataCopyWith(
    ExperimentOnlineData value,
    $Res Function(ExperimentOnlineData) then,
  ) = _$ExperimentOnlineDataCopyWithImpl<$Res, ExperimentOnlineData>;
}

/// @nodoc
class _$ExperimentOnlineDataCopyWithImpl<
  $Res,
  $Val extends ExperimentOnlineData
>
    implements $ExperimentOnlineDataCopyWith<$Res> {
  _$ExperimentOnlineDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExperimentOnlineData
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ExperimentOnlineDataImplCopyWith<$Res> {
  factory _$$ExperimentOnlineDataImplCopyWith(
    _$ExperimentOnlineDataImpl value,
    $Res Function(_$ExperimentOnlineDataImpl) then,
  ) = __$$ExperimentOnlineDataImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ExperimentOnlineDataImplCopyWithImpl<$Res>
    extends _$ExperimentOnlineDataCopyWithImpl<$Res, _$ExperimentOnlineDataImpl>
    implements _$$ExperimentOnlineDataImplCopyWith<$Res> {
  __$$ExperimentOnlineDataImplCopyWithImpl(
    _$ExperimentOnlineDataImpl _value,
    $Res Function(_$ExperimentOnlineDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ExperimentOnlineData
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$ExperimentOnlineDataImpl implements _ExperimentOnlineData {
  const _$ExperimentOnlineDataImpl();

  factory _$ExperimentOnlineDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExperimentOnlineDataImplFromJson(json);

  @override
  String toString() {
    return 'ExperimentOnlineData()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExperimentOnlineDataImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  Map<String, dynamic> toJson() {
    return _$$ExperimentOnlineDataImplToJson(this);
  }
}

abstract class _ExperimentOnlineData implements ExperimentOnlineData {
  const factory _ExperimentOnlineData() = _$ExperimentOnlineDataImpl;

  factory _ExperimentOnlineData.fromJson(Map<String, dynamic> json) =
      _$ExperimentOnlineDataImpl.fromJson;
}

ExperimentsData _$ExperimentsDataFromJson(Map<String, dynamic> json) {
  return _ExperimentsData.fromJson(json);
}

/// @nodoc
mixin _$ExperimentsData {
  int get experimentNumber => throw _privateConstructorUsedError;
  Map<String, List<double>> get sensorsData =>
      throw _privateConstructorUsedError;
  Rates? get sampleRate => throw _privateConstructorUsedError;
  Samples? get samplesCount => throw _privateConstructorUsedError;
  DateTime? get experimentDateTime => throw _privateConstructorUsedError;
  List<SensorType> get activeSensors => throw _privateConstructorUsedError;

  /// Serializes this ExperimentsData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ExperimentsData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExperimentsDataCopyWith<ExperimentsData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExperimentsDataCopyWith<$Res> {
  factory $ExperimentsDataCopyWith(
    ExperimentsData value,
    $Res Function(ExperimentsData) then,
  ) = _$ExperimentsDataCopyWithImpl<$Res, ExperimentsData>;
  @useResult
  $Res call({
    int experimentNumber,
    Map<String, List<double>> sensorsData,
    Rates? sampleRate,
    Samples? samplesCount,
    DateTime? experimentDateTime,
    List<SensorType> activeSensors,
  });
}

/// @nodoc
class _$ExperimentsDataCopyWithImpl<$Res, $Val extends ExperimentsData>
    implements $ExperimentsDataCopyWith<$Res> {
  _$ExperimentsDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExperimentsData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? experimentNumber = null,
    Object? sensorsData = null,
    Object? sampleRate = freezed,
    Object? samplesCount = freezed,
    Object? experimentDateTime = freezed,
    Object? activeSensors = null,
  }) {
    return _then(
      _value.copyWith(
            experimentNumber: null == experimentNumber
                ? _value.experimentNumber
                : experimentNumber // ignore: cast_nullable_to_non_nullable
                      as int,
            sensorsData: null == sensorsData
                ? _value.sensorsData
                : sensorsData // ignore: cast_nullable_to_non_nullable
                      as Map<String, List<double>>,
            sampleRate: freezed == sampleRate
                ? _value.sampleRate
                : sampleRate // ignore: cast_nullable_to_non_nullable
                      as Rates?,
            samplesCount: freezed == samplesCount
                ? _value.samplesCount
                : samplesCount // ignore: cast_nullable_to_non_nullable
                      as Samples?,
            experimentDateTime: freezed == experimentDateTime
                ? _value.experimentDateTime
                : experimentDateTime // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            activeSensors: null == activeSensors
                ? _value.activeSensors
                : activeSensors // ignore: cast_nullable_to_non_nullable
                      as List<SensorType>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ExperimentsDataImplCopyWith<$Res>
    implements $ExperimentsDataCopyWith<$Res> {
  factory _$$ExperimentsDataImplCopyWith(
    _$ExperimentsDataImpl value,
    $Res Function(_$ExperimentsDataImpl) then,
  ) = __$$ExperimentsDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int experimentNumber,
    Map<String, List<double>> sensorsData,
    Rates? sampleRate,
    Samples? samplesCount,
    DateTime? experimentDateTime,
    List<SensorType> activeSensors,
  });
}

/// @nodoc
class __$$ExperimentsDataImplCopyWithImpl<$Res>
    extends _$ExperimentsDataCopyWithImpl<$Res, _$ExperimentsDataImpl>
    implements _$$ExperimentsDataImplCopyWith<$Res> {
  __$$ExperimentsDataImplCopyWithImpl(
    _$ExperimentsDataImpl _value,
    $Res Function(_$ExperimentsDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ExperimentsData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? experimentNumber = null,
    Object? sensorsData = null,
    Object? sampleRate = freezed,
    Object? samplesCount = freezed,
    Object? experimentDateTime = freezed,
    Object? activeSensors = null,
  }) {
    return _then(
      _$ExperimentsDataImpl(
        experimentNumber: null == experimentNumber
            ? _value.experimentNumber
            : experimentNumber // ignore: cast_nullable_to_non_nullable
                  as int,
        sensorsData: null == sensorsData
            ? _value._sensorsData
            : sensorsData // ignore: cast_nullable_to_non_nullable
                  as Map<String, List<double>>,
        sampleRate: freezed == sampleRate
            ? _value.sampleRate
            : sampleRate // ignore: cast_nullable_to_non_nullable
                  as Rates?,
        samplesCount: freezed == samplesCount
            ? _value.samplesCount
            : samplesCount // ignore: cast_nullable_to_non_nullable
                  as Samples?,
        experimentDateTime: freezed == experimentDateTime
            ? _value.experimentDateTime
            : experimentDateTime // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        activeSensors: null == activeSensors
            ? _value._activeSensors
            : activeSensors // ignore: cast_nullable_to_non_nullable
                  as List<SensorType>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ExperimentsDataImpl implements _ExperimentsData {
  const _$ExperimentsDataImpl({
    this.experimentNumber = 0,
    final Map<String, List<double>> sensorsData = const {},
    this.sampleRate,
    this.samplesCount,
    this.experimentDateTime,
    final List<SensorType> activeSensors = const [],
  }) : _sensorsData = sensorsData,
       _activeSensors = activeSensors;

  factory _$ExperimentsDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExperimentsDataImplFromJson(json);

  @override
  @JsonKey()
  final int experimentNumber;
  final Map<String, List<double>> _sensorsData;
  @override
  @JsonKey()
  Map<String, List<double>> get sensorsData {
    if (_sensorsData is EqualUnmodifiableMapView) return _sensorsData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_sensorsData);
  }

  @override
  final Rates? sampleRate;
  @override
  final Samples? samplesCount;
  @override
  final DateTime? experimentDateTime;
  final List<SensorType> _activeSensors;
  @override
  @JsonKey()
  List<SensorType> get activeSensors {
    if (_activeSensors is EqualUnmodifiableListView) return _activeSensors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_activeSensors);
  }

  @override
  String toString() {
    return 'ExperimentsData(experimentNumber: $experimentNumber, sensorsData: $sensorsData, sampleRate: $sampleRate, samplesCount: $samplesCount, experimentDateTime: $experimentDateTime, activeSensors: $activeSensors)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExperimentsDataImpl &&
            (identical(other.experimentNumber, experimentNumber) ||
                other.experimentNumber == experimentNumber) &&
            const DeepCollectionEquality().equals(
              other._sensorsData,
              _sensorsData,
            ) &&
            (identical(other.sampleRate, sampleRate) ||
                other.sampleRate == sampleRate) &&
            (identical(other.samplesCount, samplesCount) ||
                other.samplesCount == samplesCount) &&
            (identical(other.experimentDateTime, experimentDateTime) ||
                other.experimentDateTime == experimentDateTime) &&
            const DeepCollectionEquality().equals(
              other._activeSensors,
              _activeSensors,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    experimentNumber,
    const DeepCollectionEquality().hash(_sensorsData),
    sampleRate,
    samplesCount,
    experimentDateTime,
    const DeepCollectionEquality().hash(_activeSensors),
  );

  /// Create a copy of ExperimentsData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExperimentsDataImplCopyWith<_$ExperimentsDataImpl> get copyWith =>
      __$$ExperimentsDataImplCopyWithImpl<_$ExperimentsDataImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ExperimentsDataImplToJson(this);
  }
}

abstract class _ExperimentsData implements ExperimentsData {
  const factory _ExperimentsData({
    final int experimentNumber,
    final Map<String, List<double>> sensorsData,
    final Rates? sampleRate,
    final Samples? samplesCount,
    final DateTime? experimentDateTime,
    final List<SensorType> activeSensors,
  }) = _$ExperimentsDataImpl;

  factory _ExperimentsData.fromJson(Map<String, dynamic> json) =
      _$ExperimentsDataImpl.fromJson;

  @override
  int get experimentNumber;
  @override
  Map<String, List<double>> get sensorsData;
  @override
  Rates? get sampleRate;
  @override
  Samples? get samplesCount;
  @override
  DateTime? get experimentDateTime;
  @override
  List<SensorType> get activeSensors;

  /// Create a copy of ExperimentsData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExperimentsDataImplCopyWith<_$ExperimentsDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StatusDeviceData _$StatusDeviceDataFromJson(Map<String, dynamic> json) {
  return _StatusDeviceData.fromJson(json);
}

/// @nodoc
mixin _$StatusDeviceData {
  DeviceType get archimedesVersion => throw _privateConstructorUsedError;
  int get experimentsInMemory => throw _privateConstructorUsedError;
  List<SensorType> get lastUsedSensorsType =>
      throw _privateConstructorUsedError;
  Rates? get lastSamplesRates => throw _privateConstructorUsedError;
  Samples? get lastSamplesCount => throw _privateConstructorUsedError;
  DateTime? get dateTime => throw _privateConstructorUsedError;
  int get batteryLevel => throw _privateConstructorUsedError;
  int get memoryUsed => throw _privateConstructorUsedError;
  int get externalAnalogSensor => throw _privateConstructorUsedError;

  /// Serializes this StatusDeviceData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StatusDeviceData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StatusDeviceDataCopyWith<StatusDeviceData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StatusDeviceDataCopyWith<$Res> {
  factory $StatusDeviceDataCopyWith(
    StatusDeviceData value,
    $Res Function(StatusDeviceData) then,
  ) = _$StatusDeviceDataCopyWithImpl<$Res, StatusDeviceData>;
  @useResult
  $Res call({
    DeviceType archimedesVersion,
    int experimentsInMemory,
    List<SensorType> lastUsedSensorsType,
    Rates? lastSamplesRates,
    Samples? lastSamplesCount,
    DateTime? dateTime,
    int batteryLevel,
    int memoryUsed,
    int externalAnalogSensor,
  });
}

/// @nodoc
class _$StatusDeviceDataCopyWithImpl<$Res, $Val extends StatusDeviceData>
    implements $StatusDeviceDataCopyWith<$Res> {
  _$StatusDeviceDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StatusDeviceData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? archimedesVersion = null,
    Object? experimentsInMemory = null,
    Object? lastUsedSensorsType = null,
    Object? lastSamplesRates = freezed,
    Object? lastSamplesCount = freezed,
    Object? dateTime = freezed,
    Object? batteryLevel = null,
    Object? memoryUsed = null,
    Object? externalAnalogSensor = null,
  }) {
    return _then(
      _value.copyWith(
            archimedesVersion: null == archimedesVersion
                ? _value.archimedesVersion
                : archimedesVersion // ignore: cast_nullable_to_non_nullable
                      as DeviceType,
            experimentsInMemory: null == experimentsInMemory
                ? _value.experimentsInMemory
                : experimentsInMemory // ignore: cast_nullable_to_non_nullable
                      as int,
            lastUsedSensorsType: null == lastUsedSensorsType
                ? _value.lastUsedSensorsType
                : lastUsedSensorsType // ignore: cast_nullable_to_non_nullable
                      as List<SensorType>,
            lastSamplesRates: freezed == lastSamplesRates
                ? _value.lastSamplesRates
                : lastSamplesRates // ignore: cast_nullable_to_non_nullable
                      as Rates?,
            lastSamplesCount: freezed == lastSamplesCount
                ? _value.lastSamplesCount
                : lastSamplesCount // ignore: cast_nullable_to_non_nullable
                      as Samples?,
            dateTime: freezed == dateTime
                ? _value.dateTime
                : dateTime // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            batteryLevel: null == batteryLevel
                ? _value.batteryLevel
                : batteryLevel // ignore: cast_nullable_to_non_nullable
                      as int,
            memoryUsed: null == memoryUsed
                ? _value.memoryUsed
                : memoryUsed // ignore: cast_nullable_to_non_nullable
                      as int,
            externalAnalogSensor: null == externalAnalogSensor
                ? _value.externalAnalogSensor
                : externalAnalogSensor // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StatusDeviceDataImplCopyWith<$Res>
    implements $StatusDeviceDataCopyWith<$Res> {
  factory _$$StatusDeviceDataImplCopyWith(
    _$StatusDeviceDataImpl value,
    $Res Function(_$StatusDeviceDataImpl) then,
  ) = __$$StatusDeviceDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    DeviceType archimedesVersion,
    int experimentsInMemory,
    List<SensorType> lastUsedSensorsType,
    Rates? lastSamplesRates,
    Samples? lastSamplesCount,
    DateTime? dateTime,
    int batteryLevel,
    int memoryUsed,
    int externalAnalogSensor,
  });
}

/// @nodoc
class __$$StatusDeviceDataImplCopyWithImpl<$Res>
    extends _$StatusDeviceDataCopyWithImpl<$Res, _$StatusDeviceDataImpl>
    implements _$$StatusDeviceDataImplCopyWith<$Res> {
  __$$StatusDeviceDataImplCopyWithImpl(
    _$StatusDeviceDataImpl _value,
    $Res Function(_$StatusDeviceDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StatusDeviceData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? archimedesVersion = null,
    Object? experimentsInMemory = null,
    Object? lastUsedSensorsType = null,
    Object? lastSamplesRates = freezed,
    Object? lastSamplesCount = freezed,
    Object? dateTime = freezed,
    Object? batteryLevel = null,
    Object? memoryUsed = null,
    Object? externalAnalogSensor = null,
  }) {
    return _then(
      _$StatusDeviceDataImpl(
        archimedesVersion: null == archimedesVersion
            ? _value.archimedesVersion
            : archimedesVersion // ignore: cast_nullable_to_non_nullable
                  as DeviceType,
        experimentsInMemory: null == experimentsInMemory
            ? _value.experimentsInMemory
            : experimentsInMemory // ignore: cast_nullable_to_non_nullable
                  as int,
        lastUsedSensorsType: null == lastUsedSensorsType
            ? _value._lastUsedSensorsType
            : lastUsedSensorsType // ignore: cast_nullable_to_non_nullable
                  as List<SensorType>,
        lastSamplesRates: freezed == lastSamplesRates
            ? _value.lastSamplesRates
            : lastSamplesRates // ignore: cast_nullable_to_non_nullable
                  as Rates?,
        lastSamplesCount: freezed == lastSamplesCount
            ? _value.lastSamplesCount
            : lastSamplesCount // ignore: cast_nullable_to_non_nullable
                  as Samples?,
        dateTime: freezed == dateTime
            ? _value.dateTime
            : dateTime // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        batteryLevel: null == batteryLevel
            ? _value.batteryLevel
            : batteryLevel // ignore: cast_nullable_to_non_nullable
                  as int,
        memoryUsed: null == memoryUsed
            ? _value.memoryUsed
            : memoryUsed // ignore: cast_nullable_to_non_nullable
                  as int,
        externalAnalogSensor: null == externalAnalogSensor
            ? _value.externalAnalogSensor
            : externalAnalogSensor // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StatusDeviceDataImpl implements _StatusDeviceData {
  const _$StatusDeviceDataImpl({
    this.archimedesVersion = DeviceType.unknown,
    this.experimentsInMemory = 0,
    final List<SensorType> lastUsedSensorsType = const [],
    this.lastSamplesRates,
    this.lastSamplesCount,
    this.dateTime,
    this.batteryLevel = 0,
    this.memoryUsed = 0,
    this.externalAnalogSensor = 0,
  }) : _lastUsedSensorsType = lastUsedSensorsType;

  factory _$StatusDeviceDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$StatusDeviceDataImplFromJson(json);

  @override
  @JsonKey()
  final DeviceType archimedesVersion;
  @override
  @JsonKey()
  final int experimentsInMemory;
  final List<SensorType> _lastUsedSensorsType;
  @override
  @JsonKey()
  List<SensorType> get lastUsedSensorsType {
    if (_lastUsedSensorsType is EqualUnmodifiableListView)
      return _lastUsedSensorsType;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_lastUsedSensorsType);
  }

  @override
  final Rates? lastSamplesRates;
  @override
  final Samples? lastSamplesCount;
  @override
  final DateTime? dateTime;
  @override
  @JsonKey()
  final int batteryLevel;
  @override
  @JsonKey()
  final int memoryUsed;
  @override
  @JsonKey()
  final int externalAnalogSensor;

  @override
  String toString() {
    return 'StatusDeviceData(archimedesVersion: $archimedesVersion, experimentsInMemory: $experimentsInMemory, lastUsedSensorsType: $lastUsedSensorsType, lastSamplesRates: $lastSamplesRates, lastSamplesCount: $lastSamplesCount, dateTime: $dateTime, batteryLevel: $batteryLevel, memoryUsed: $memoryUsed, externalAnalogSensor: $externalAnalogSensor)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StatusDeviceDataImpl &&
            (identical(other.archimedesVersion, archimedesVersion) ||
                other.archimedesVersion == archimedesVersion) &&
            (identical(other.experimentsInMemory, experimentsInMemory) ||
                other.experimentsInMemory == experimentsInMemory) &&
            const DeepCollectionEquality().equals(
              other._lastUsedSensorsType,
              _lastUsedSensorsType,
            ) &&
            (identical(other.lastSamplesRates, lastSamplesRates) ||
                other.lastSamplesRates == lastSamplesRates) &&
            (identical(other.lastSamplesCount, lastSamplesCount) ||
                other.lastSamplesCount == lastSamplesCount) &&
            (identical(other.dateTime, dateTime) ||
                other.dateTime == dateTime) &&
            (identical(other.batteryLevel, batteryLevel) ||
                other.batteryLevel == batteryLevel) &&
            (identical(other.memoryUsed, memoryUsed) ||
                other.memoryUsed == memoryUsed) &&
            (identical(other.externalAnalogSensor, externalAnalogSensor) ||
                other.externalAnalogSensor == externalAnalogSensor));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    archimedesVersion,
    experimentsInMemory,
    const DeepCollectionEquality().hash(_lastUsedSensorsType),
    lastSamplesRates,
    lastSamplesCount,
    dateTime,
    batteryLevel,
    memoryUsed,
    externalAnalogSensor,
  );

  /// Create a copy of StatusDeviceData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StatusDeviceDataImplCopyWith<_$StatusDeviceDataImpl> get copyWith =>
      __$$StatusDeviceDataImplCopyWithImpl<_$StatusDeviceDataImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$StatusDeviceDataImplToJson(this);
  }
}

abstract class _StatusDeviceData implements StatusDeviceData {
  const factory _StatusDeviceData({
    final DeviceType archimedesVersion,
    final int experimentsInMemory,
    final List<SensorType> lastUsedSensorsType,
    final Rates? lastSamplesRates,
    final Samples? lastSamplesCount,
    final DateTime? dateTime,
    final int batteryLevel,
    final int memoryUsed,
    final int externalAnalogSensor,
  }) = _$StatusDeviceDataImpl;

  factory _StatusDeviceData.fromJson(Map<String, dynamic> json) =
      _$StatusDeviceDataImpl.fromJson;

  @override
  DeviceType get archimedesVersion;
  @override
  int get experimentsInMemory;
  @override
  List<SensorType> get lastUsedSensorsType;
  @override
  Rates? get lastSamplesRates;
  @override
  Samples? get lastSamplesCount;
  @override
  DateTime? get dateTime;
  @override
  int get batteryLevel;
  @override
  int get memoryUsed;
  @override
  int get externalAnalogSensor;

  /// Create a copy of StatusDeviceData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StatusDeviceDataImplCopyWith<_$StatusDeviceDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EnhancedBluetoothPeripheral _$EnhancedBluetoothPeripheralFromJson(
  Map<String, dynamic> json,
) {
  return _EnhancedBluetoothPeripheral.fromJson(json);
}

/// @nodoc
mixin _$EnhancedBluetoothPeripheral {
  bool get connected => throw _privateConstructorUsedError;
  DeviceConnectionState get connectedState =>
      throw _privateConstructorUsedError;
  PeripheralDeviceState get peripheral => throw _privateConstructorUsedError;

  /// Serializes this EnhancedBluetoothPeripheral to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EnhancedBluetoothPeripheral
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EnhancedBluetoothPeripheralCopyWith<EnhancedBluetoothPeripheral>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EnhancedBluetoothPeripheralCopyWith<$Res> {
  factory $EnhancedBluetoothPeripheralCopyWith(
    EnhancedBluetoothPeripheral value,
    $Res Function(EnhancedBluetoothPeripheral) then,
  ) =
      _$EnhancedBluetoothPeripheralCopyWithImpl<
        $Res,
        EnhancedBluetoothPeripheral
      >;
  @useResult
  $Res call({
    bool connected,
    DeviceConnectionState connectedState,
    PeripheralDeviceState peripheral,
  });

  $DeviceConnectionStateCopyWith<$Res> get connectedState;
  $PeripheralDeviceStateCopyWith<$Res> get peripheral;
}

/// @nodoc
class _$EnhancedBluetoothPeripheralCopyWithImpl<
  $Res,
  $Val extends EnhancedBluetoothPeripheral
>
    implements $EnhancedBluetoothPeripheralCopyWith<$Res> {
  _$EnhancedBluetoothPeripheralCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EnhancedBluetoothPeripheral
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? connected = null,
    Object? connectedState = null,
    Object? peripheral = null,
  }) {
    return _then(
      _value.copyWith(
            connected: null == connected
                ? _value.connected
                : connected // ignore: cast_nullable_to_non_nullable
                      as bool,
            connectedState: null == connectedState
                ? _value.connectedState
                : connectedState // ignore: cast_nullable_to_non_nullable
                      as DeviceConnectionState,
            peripheral: null == peripheral
                ? _value.peripheral
                : peripheral // ignore: cast_nullable_to_non_nullable
                      as PeripheralDeviceState,
          )
          as $Val,
    );
  }

  /// Create a copy of EnhancedBluetoothPeripheral
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DeviceConnectionStateCopyWith<$Res> get connectedState {
    return $DeviceConnectionStateCopyWith<$Res>(_value.connectedState, (value) {
      return _then(_value.copyWith(connectedState: value) as $Val);
    });
  }

  /// Create a copy of EnhancedBluetoothPeripheral
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PeripheralDeviceStateCopyWith<$Res> get peripheral {
    return $PeripheralDeviceStateCopyWith<$Res>(_value.peripheral, (value) {
      return _then(_value.copyWith(peripheral: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$EnhancedBluetoothPeripheralImplCopyWith<$Res>
    implements $EnhancedBluetoothPeripheralCopyWith<$Res> {
  factory _$$EnhancedBluetoothPeripheralImplCopyWith(
    _$EnhancedBluetoothPeripheralImpl value,
    $Res Function(_$EnhancedBluetoothPeripheralImpl) then,
  ) = __$$EnhancedBluetoothPeripheralImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool connected,
    DeviceConnectionState connectedState,
    PeripheralDeviceState peripheral,
  });

  @override
  $DeviceConnectionStateCopyWith<$Res> get connectedState;
  @override
  $PeripheralDeviceStateCopyWith<$Res> get peripheral;
}

/// @nodoc
class __$$EnhancedBluetoothPeripheralImplCopyWithImpl<$Res>
    extends
        _$EnhancedBluetoothPeripheralCopyWithImpl<
          $Res,
          _$EnhancedBluetoothPeripheralImpl
        >
    implements _$$EnhancedBluetoothPeripheralImplCopyWith<$Res> {
  __$$EnhancedBluetoothPeripheralImplCopyWithImpl(
    _$EnhancedBluetoothPeripheralImpl _value,
    $Res Function(_$EnhancedBluetoothPeripheralImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EnhancedBluetoothPeripheral
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? connected = null,
    Object? connectedState = null,
    Object? peripheral = null,
  }) {
    return _then(
      _$EnhancedBluetoothPeripheralImpl(
        connected: null == connected
            ? _value.connected
            : connected // ignore: cast_nullable_to_non_nullable
                  as bool,
        connectedState: null == connectedState
            ? _value.connectedState
            : connectedState // ignore: cast_nullable_to_non_nullable
                  as DeviceConnectionState,
        peripheral: null == peripheral
            ? _value.peripheral
            : peripheral // ignore: cast_nullable_to_non_nullable
                  as PeripheralDeviceState,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$EnhancedBluetoothPeripheralImpl
    implements _EnhancedBluetoothPeripheral {
  _$EnhancedBluetoothPeripheralImpl({
    required this.connected,
    required this.connectedState,
    required this.peripheral,
  });

  factory _$EnhancedBluetoothPeripheralImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$EnhancedBluetoothPeripheralImplFromJson(json);

  @override
  final bool connected;
  @override
  final DeviceConnectionState connectedState;
  @override
  final PeripheralDeviceState peripheral;

  @override
  String toString() {
    return 'EnhancedBluetoothPeripheral(connected: $connected, connectedState: $connectedState, peripheral: $peripheral)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EnhancedBluetoothPeripheralImpl &&
            (identical(other.connected, connected) ||
                other.connected == connected) &&
            (identical(other.connectedState, connectedState) ||
                other.connectedState == connectedState) &&
            (identical(other.peripheral, peripheral) ||
                other.peripheral == peripheral));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, connected, connectedState, peripheral);

  /// Create a copy of EnhancedBluetoothPeripheral
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EnhancedBluetoothPeripheralImplCopyWith<_$EnhancedBluetoothPeripheralImpl>
  get copyWith =>
      __$$EnhancedBluetoothPeripheralImplCopyWithImpl<
        _$EnhancedBluetoothPeripheralImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EnhancedBluetoothPeripheralImplToJson(this);
  }
}

abstract class _EnhancedBluetoothPeripheral
    implements EnhancedBluetoothPeripheral {
  factory _EnhancedBluetoothPeripheral({
    required final bool connected,
    required final DeviceConnectionState connectedState,
    required final PeripheralDeviceState peripheral,
  }) = _$EnhancedBluetoothPeripheralImpl;

  factory _EnhancedBluetoothPeripheral.fromJson(Map<String, dynamic> json) =
      _$EnhancedBluetoothPeripheralImpl.fromJson;

  @override
  bool get connected;
  @override
  DeviceConnectionState get connectedState;
  @override
  PeripheralDeviceState get peripheral;

  /// Create a copy of EnhancedBluetoothPeripheral
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EnhancedBluetoothPeripheralImplCopyWith<_$EnhancedBluetoothPeripheralImpl>
  get copyWith => throw _privateConstructorUsedError;
}

PeripheralDeviceState _$PeripheralDeviceStateFromJson(
  Map<String, dynamic> json,
) {
  return _PeripheralDeviceState.fromJson(json);
}

/// @nodoc
mixin _$PeripheralDeviceState {
  String get name => throw _privateConstructorUsedError;
  String get uuid => throw _privateConstructorUsedError;

  /// Serializes this PeripheralDeviceState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PeripheralDeviceState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PeripheralDeviceStateCopyWith<PeripheralDeviceState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PeripheralDeviceStateCopyWith<$Res> {
  factory $PeripheralDeviceStateCopyWith(
    PeripheralDeviceState value,
    $Res Function(PeripheralDeviceState) then,
  ) = _$PeripheralDeviceStateCopyWithImpl<$Res, PeripheralDeviceState>;
  @useResult
  $Res call({String name, String uuid});
}

/// @nodoc
class _$PeripheralDeviceStateCopyWithImpl<
  $Res,
  $Val extends PeripheralDeviceState
>
    implements $PeripheralDeviceStateCopyWith<$Res> {
  _$PeripheralDeviceStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PeripheralDeviceState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null, Object? uuid = null}) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            uuid: null == uuid
                ? _value.uuid
                : uuid // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PeripheralDeviceStateImplCopyWith<$Res>
    implements $PeripheralDeviceStateCopyWith<$Res> {
  factory _$$PeripheralDeviceStateImplCopyWith(
    _$PeripheralDeviceStateImpl value,
    $Res Function(_$PeripheralDeviceStateImpl) then,
  ) = __$$PeripheralDeviceStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String uuid});
}

/// @nodoc
class __$$PeripheralDeviceStateImplCopyWithImpl<$Res>
    extends
        _$PeripheralDeviceStateCopyWithImpl<$Res, _$PeripheralDeviceStateImpl>
    implements _$$PeripheralDeviceStateImplCopyWith<$Res> {
  __$$PeripheralDeviceStateImplCopyWithImpl(
    _$PeripheralDeviceStateImpl _value,
    $Res Function(_$PeripheralDeviceStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PeripheralDeviceState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null, Object? uuid = null}) {
    return _then(
      _$PeripheralDeviceStateImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        uuid: null == uuid
            ? _value.uuid
            : uuid // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PeripheralDeviceStateImpl implements _PeripheralDeviceState {
  _$PeripheralDeviceStateImpl({required this.name, required this.uuid});

  factory _$PeripheralDeviceStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$PeripheralDeviceStateImplFromJson(json);

  @override
  final String name;
  @override
  final String uuid;

  @override
  String toString() {
    return 'PeripheralDeviceState(name: $name, uuid: $uuid)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PeripheralDeviceStateImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.uuid, uuid) || other.uuid == uuid));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, uuid);

  /// Create a copy of PeripheralDeviceState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PeripheralDeviceStateImplCopyWith<_$PeripheralDeviceStateImpl>
  get copyWith =>
      __$$PeripheralDeviceStateImplCopyWithImpl<_$PeripheralDeviceStateImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PeripheralDeviceStateImplToJson(this);
  }
}

abstract class _PeripheralDeviceState implements PeripheralDeviceState {
  factory _PeripheralDeviceState({
    required final String name,
    required final String uuid,
  }) = _$PeripheralDeviceStateImpl;

  factory _PeripheralDeviceState.fromJson(Map<String, dynamic> json) =
      _$PeripheralDeviceStateImpl.fromJson;

  @override
  String get name;
  @override
  String get uuid;

  /// Create a copy of PeripheralDeviceState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PeripheralDeviceStateImplCopyWith<_$PeripheralDeviceStateImpl>
  get copyWith => throw _privateConstructorUsedError;
}

BluetoothDeviceState _$BluetoothDeviceStateFromJson(Map<String, dynamic> json) {
  return _BluetoothDeviceState.fromJson(json);
}

/// @nodoc
mixin _$BluetoothDeviceState {
  Map<String, EnhancedBluetoothPeripheral> get devices =>
      throw _privateConstructorUsedError;
  bool? get isScanning => throw _privateConstructorUsedError;
  String? get selectedDeviceId => throw _privateConstructorUsedError;
  DeviceType get selectedDeviceType => throw _privateConstructorUsedError;
  StatusDeviceData get statusDeviceData => throw _privateConstructorUsedError;
  List<ExperimentsData> get experimentsHistoryData =>
      throw _privateConstructorUsedError;
  ExperimentOnlineData get experimentOnlineData =>
      throw _privateConstructorUsedError;
  ExperimentsData get experimentData => throw _privateConstructorUsedError;

  /// Serializes this BluetoothDeviceState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BluetoothDeviceState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BluetoothDeviceStateCopyWith<BluetoothDeviceState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BluetoothDeviceStateCopyWith<$Res> {
  factory $BluetoothDeviceStateCopyWith(
    BluetoothDeviceState value,
    $Res Function(BluetoothDeviceState) then,
  ) = _$BluetoothDeviceStateCopyWithImpl<$Res, BluetoothDeviceState>;
  @useResult
  $Res call({
    Map<String, EnhancedBluetoothPeripheral> devices,
    bool? isScanning,
    String? selectedDeviceId,
    DeviceType selectedDeviceType,
    StatusDeviceData statusDeviceData,
    List<ExperimentsData> experimentsHistoryData,
    ExperimentOnlineData experimentOnlineData,
    ExperimentsData experimentData,
  });

  $StatusDeviceDataCopyWith<$Res> get statusDeviceData;
  $ExperimentOnlineDataCopyWith<$Res> get experimentOnlineData;
  $ExperimentsDataCopyWith<$Res> get experimentData;
}

/// @nodoc
class _$BluetoothDeviceStateCopyWithImpl<
  $Res,
  $Val extends BluetoothDeviceState
>
    implements $BluetoothDeviceStateCopyWith<$Res> {
  _$BluetoothDeviceStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BluetoothDeviceState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? devices = null,
    Object? isScanning = freezed,
    Object? selectedDeviceId = freezed,
    Object? selectedDeviceType = null,
    Object? statusDeviceData = null,
    Object? experimentsHistoryData = null,
    Object? experimentOnlineData = null,
    Object? experimentData = null,
  }) {
    return _then(
      _value.copyWith(
            devices: null == devices
                ? _value.devices
                : devices // ignore: cast_nullable_to_non_nullable
                      as Map<String, EnhancedBluetoothPeripheral>,
            isScanning: freezed == isScanning
                ? _value.isScanning
                : isScanning // ignore: cast_nullable_to_non_nullable
                      as bool?,
            selectedDeviceId: freezed == selectedDeviceId
                ? _value.selectedDeviceId
                : selectedDeviceId // ignore: cast_nullable_to_non_nullable
                      as String?,
            selectedDeviceType: null == selectedDeviceType
                ? _value.selectedDeviceType
                : selectedDeviceType // ignore: cast_nullable_to_non_nullable
                      as DeviceType,
            statusDeviceData: null == statusDeviceData
                ? _value.statusDeviceData
                : statusDeviceData // ignore: cast_nullable_to_non_nullable
                      as StatusDeviceData,
            experimentsHistoryData: null == experimentsHistoryData
                ? _value.experimentsHistoryData
                : experimentsHistoryData // ignore: cast_nullable_to_non_nullable
                      as List<ExperimentsData>,
            experimentOnlineData: null == experimentOnlineData
                ? _value.experimentOnlineData
                : experimentOnlineData // ignore: cast_nullable_to_non_nullable
                      as ExperimentOnlineData,
            experimentData: null == experimentData
                ? _value.experimentData
                : experimentData // ignore: cast_nullable_to_non_nullable
                      as ExperimentsData,
          )
          as $Val,
    );
  }

  /// Create a copy of BluetoothDeviceState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StatusDeviceDataCopyWith<$Res> get statusDeviceData {
    return $StatusDeviceDataCopyWith<$Res>(_value.statusDeviceData, (value) {
      return _then(_value.copyWith(statusDeviceData: value) as $Val);
    });
  }

  /// Create a copy of BluetoothDeviceState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ExperimentOnlineDataCopyWith<$Res> get experimentOnlineData {
    return $ExperimentOnlineDataCopyWith<$Res>(_value.experimentOnlineData, (
      value,
    ) {
      return _then(_value.copyWith(experimentOnlineData: value) as $Val);
    });
  }

  /// Create a copy of BluetoothDeviceState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ExperimentsDataCopyWith<$Res> get experimentData {
    return $ExperimentsDataCopyWith<$Res>(_value.experimentData, (value) {
      return _then(_value.copyWith(experimentData: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BluetoothDeviceStateImplCopyWith<$Res>
    implements $BluetoothDeviceStateCopyWith<$Res> {
  factory _$$BluetoothDeviceStateImplCopyWith(
    _$BluetoothDeviceStateImpl value,
    $Res Function(_$BluetoothDeviceStateImpl) then,
  ) = __$$BluetoothDeviceStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    Map<String, EnhancedBluetoothPeripheral> devices,
    bool? isScanning,
    String? selectedDeviceId,
    DeviceType selectedDeviceType,
    StatusDeviceData statusDeviceData,
    List<ExperimentsData> experimentsHistoryData,
    ExperimentOnlineData experimentOnlineData,
    ExperimentsData experimentData,
  });

  @override
  $StatusDeviceDataCopyWith<$Res> get statusDeviceData;
  @override
  $ExperimentOnlineDataCopyWith<$Res> get experimentOnlineData;
  @override
  $ExperimentsDataCopyWith<$Res> get experimentData;
}

/// @nodoc
class __$$BluetoothDeviceStateImplCopyWithImpl<$Res>
    extends _$BluetoothDeviceStateCopyWithImpl<$Res, _$BluetoothDeviceStateImpl>
    implements _$$BluetoothDeviceStateImplCopyWith<$Res> {
  __$$BluetoothDeviceStateImplCopyWithImpl(
    _$BluetoothDeviceStateImpl _value,
    $Res Function(_$BluetoothDeviceStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BluetoothDeviceState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? devices = null,
    Object? isScanning = freezed,
    Object? selectedDeviceId = freezed,
    Object? selectedDeviceType = null,
    Object? statusDeviceData = null,
    Object? experimentsHistoryData = null,
    Object? experimentOnlineData = null,
    Object? experimentData = null,
  }) {
    return _then(
      _$BluetoothDeviceStateImpl(
        devices: null == devices
            ? _value._devices
            : devices // ignore: cast_nullable_to_non_nullable
                  as Map<String, EnhancedBluetoothPeripheral>,
        isScanning: freezed == isScanning
            ? _value.isScanning
            : isScanning // ignore: cast_nullable_to_non_nullable
                  as bool?,
        selectedDeviceId: freezed == selectedDeviceId
            ? _value.selectedDeviceId
            : selectedDeviceId // ignore: cast_nullable_to_non_nullable
                  as String?,
        selectedDeviceType: null == selectedDeviceType
            ? _value.selectedDeviceType
            : selectedDeviceType // ignore: cast_nullable_to_non_nullable
                  as DeviceType,
        statusDeviceData: null == statusDeviceData
            ? _value.statusDeviceData
            : statusDeviceData // ignore: cast_nullable_to_non_nullable
                  as StatusDeviceData,
        experimentsHistoryData: null == experimentsHistoryData
            ? _value._experimentsHistoryData
            : experimentsHistoryData // ignore: cast_nullable_to_non_nullable
                  as List<ExperimentsData>,
        experimentOnlineData: null == experimentOnlineData
            ? _value.experimentOnlineData
            : experimentOnlineData // ignore: cast_nullable_to_non_nullable
                  as ExperimentOnlineData,
        experimentData: null == experimentData
            ? _value.experimentData
            : experimentData // ignore: cast_nullable_to_non_nullable
                  as ExperimentsData,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BluetoothDeviceStateImpl implements _BluetoothDeviceState {
  const _$BluetoothDeviceStateImpl({
    final Map<String, EnhancedBluetoothPeripheral> devices = const {},
    this.isScanning,
    this.selectedDeviceId,
    this.selectedDeviceType = DeviceType.unknown,
    this.statusDeviceData = const StatusDeviceData(),
    final List<ExperimentsData> experimentsHistoryData = const [],
    this.experimentOnlineData = const ExperimentOnlineData(),
    this.experimentData = const ExperimentsData(),
  }) : _devices = devices,
       _experimentsHistoryData = experimentsHistoryData;

  factory _$BluetoothDeviceStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$BluetoothDeviceStateImplFromJson(json);

  final Map<String, EnhancedBluetoothPeripheral> _devices;
  @override
  @JsonKey()
  Map<String, EnhancedBluetoothPeripheral> get devices {
    if (_devices is EqualUnmodifiableMapView) return _devices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_devices);
  }

  @override
  final bool? isScanning;
  @override
  final String? selectedDeviceId;
  @override
  @JsonKey()
  final DeviceType selectedDeviceType;
  @override
  @JsonKey()
  final StatusDeviceData statusDeviceData;
  final List<ExperimentsData> _experimentsHistoryData;
  @override
  @JsonKey()
  List<ExperimentsData> get experimentsHistoryData {
    if (_experimentsHistoryData is EqualUnmodifiableListView)
      return _experimentsHistoryData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_experimentsHistoryData);
  }

  @override
  @JsonKey()
  final ExperimentOnlineData experimentOnlineData;
  @override
  @JsonKey()
  final ExperimentsData experimentData;

  @override
  String toString() {
    return 'BluetoothDeviceState(devices: $devices, isScanning: $isScanning, selectedDeviceId: $selectedDeviceId, selectedDeviceType: $selectedDeviceType, statusDeviceData: $statusDeviceData, experimentsHistoryData: $experimentsHistoryData, experimentOnlineData: $experimentOnlineData, experimentData: $experimentData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BluetoothDeviceStateImpl &&
            const DeepCollectionEquality().equals(other._devices, _devices) &&
            (identical(other.isScanning, isScanning) ||
                other.isScanning == isScanning) &&
            (identical(other.selectedDeviceId, selectedDeviceId) ||
                other.selectedDeviceId == selectedDeviceId) &&
            (identical(other.selectedDeviceType, selectedDeviceType) ||
                other.selectedDeviceType == selectedDeviceType) &&
            (identical(other.statusDeviceData, statusDeviceData) ||
                other.statusDeviceData == statusDeviceData) &&
            const DeepCollectionEquality().equals(
              other._experimentsHistoryData,
              _experimentsHistoryData,
            ) &&
            (identical(other.experimentOnlineData, experimentOnlineData) ||
                other.experimentOnlineData == experimentOnlineData) &&
            (identical(other.experimentData, experimentData) ||
                other.experimentData == experimentData));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_devices),
    isScanning,
    selectedDeviceId,
    selectedDeviceType,
    statusDeviceData,
    const DeepCollectionEquality().hash(_experimentsHistoryData),
    experimentOnlineData,
    experimentData,
  );

  /// Create a copy of BluetoothDeviceState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BluetoothDeviceStateImplCopyWith<_$BluetoothDeviceStateImpl>
  get copyWith =>
      __$$BluetoothDeviceStateImplCopyWithImpl<_$BluetoothDeviceStateImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$BluetoothDeviceStateImplToJson(this);
  }
}

abstract class _BluetoothDeviceState implements BluetoothDeviceState {
  const factory _BluetoothDeviceState({
    final Map<String, EnhancedBluetoothPeripheral> devices,
    final bool? isScanning,
    final String? selectedDeviceId,
    final DeviceType selectedDeviceType,
    final StatusDeviceData statusDeviceData,
    final List<ExperimentsData> experimentsHistoryData,
    final ExperimentOnlineData experimentOnlineData,
    final ExperimentsData experimentData,
  }) = _$BluetoothDeviceStateImpl;

  factory _BluetoothDeviceState.fromJson(Map<String, dynamic> json) =
      _$BluetoothDeviceStateImpl.fromJson;

  @override
  Map<String, EnhancedBluetoothPeripheral> get devices;
  @override
  bool? get isScanning;
  @override
  String? get selectedDeviceId;
  @override
  DeviceType get selectedDeviceType;
  @override
  StatusDeviceData get statusDeviceData;
  @override
  List<ExperimentsData> get experimentsHistoryData;
  @override
  ExperimentOnlineData get experimentOnlineData;
  @override
  ExperimentsData get experimentData;

  /// Create a copy of BluetoothDeviceState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BluetoothDeviceStateImplCopyWith<_$BluetoothDeviceStateImpl>
  get copyWith => throw _privateConstructorUsedError;
}
