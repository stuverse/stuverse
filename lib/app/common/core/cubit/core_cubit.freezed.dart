// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'core_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CoreState {
  bool get isDarkMode => throw _privateConstructorUsedError;
  bool get isFirstTime => throw _privateConstructorUsedError;
  User? get user => throw _privateConstructorUsedError;
  bool get isUserLoading => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CoreStateCopyWith<CoreState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CoreStateCopyWith<$Res> {
  factory $CoreStateCopyWith(CoreState value, $Res Function(CoreState) then) =
      _$CoreStateCopyWithImpl<$Res, CoreState>;
  @useResult
  $Res call(
      {bool isDarkMode, bool isFirstTime, User? user, bool isUserLoading});

  $UserCopyWith<$Res>? get user;
}

/// @nodoc
class _$CoreStateCopyWithImpl<$Res, $Val extends CoreState>
    implements $CoreStateCopyWith<$Res> {
  _$CoreStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isDarkMode = null,
    Object? isFirstTime = null,
    Object? user = freezed,
    Object? isUserLoading = null,
  }) {
    return _then(_value.copyWith(
      isDarkMode: null == isDarkMode
          ? _value.isDarkMode
          : isDarkMode // ignore: cast_nullable_to_non_nullable
              as bool,
      isFirstTime: null == isFirstTime
          ? _value.isFirstTime
          : isFirstTime // ignore: cast_nullable_to_non_nullable
              as bool,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
      isUserLoading: null == isUserLoading
          ? _value.isUserLoading
          : isUserLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $UserCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CoreStateImplCopyWith<$Res>
    implements $CoreStateCopyWith<$Res> {
  factory _$$CoreStateImplCopyWith(
          _$CoreStateImpl value, $Res Function(_$CoreStateImpl) then) =
      __$$CoreStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isDarkMode, bool isFirstTime, User? user, bool isUserLoading});

  @override
  $UserCopyWith<$Res>? get user;
}

/// @nodoc
class __$$CoreStateImplCopyWithImpl<$Res>
    extends _$CoreStateCopyWithImpl<$Res, _$CoreStateImpl>
    implements _$$CoreStateImplCopyWith<$Res> {
  __$$CoreStateImplCopyWithImpl(
      _$CoreStateImpl _value, $Res Function(_$CoreStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isDarkMode = null,
    Object? isFirstTime = null,
    Object? user = freezed,
    Object? isUserLoading = null,
  }) {
    return _then(_$CoreStateImpl(
      isDarkMode: null == isDarkMode
          ? _value.isDarkMode
          : isDarkMode // ignore: cast_nullable_to_non_nullable
              as bool,
      isFirstTime: null == isFirstTime
          ? _value.isFirstTime
          : isFirstTime // ignore: cast_nullable_to_non_nullable
              as bool,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
      isUserLoading: null == isUserLoading
          ? _value.isUserLoading
          : isUserLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$CoreStateImpl implements _CoreState {
  const _$CoreStateImpl(
      {required this.isDarkMode,
      required this.isFirstTime,
      this.user,
      required this.isUserLoading});

  @override
  final bool isDarkMode;
  @override
  final bool isFirstTime;
  @override
  final User? user;
  @override
  final bool isUserLoading;

  @override
  String toString() {
    return 'CoreState(isDarkMode: $isDarkMode, isFirstTime: $isFirstTime, user: $user, isUserLoading: $isUserLoading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CoreStateImpl &&
            (identical(other.isDarkMode, isDarkMode) ||
                other.isDarkMode == isDarkMode) &&
            (identical(other.isFirstTime, isFirstTime) ||
                other.isFirstTime == isFirstTime) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.isUserLoading, isUserLoading) ||
                other.isUserLoading == isUserLoading));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, isDarkMode, isFirstTime, user, isUserLoading);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CoreStateImplCopyWith<_$CoreStateImpl> get copyWith =>
      __$$CoreStateImplCopyWithImpl<_$CoreStateImpl>(this, _$identity);
}

abstract class _CoreState implements CoreState {
  const factory _CoreState(
      {required final bool isDarkMode,
      required final bool isFirstTime,
      final User? user,
      required final bool isUserLoading}) = _$CoreStateImpl;

  @override
  bool get isDarkMode;
  @override
  bool get isFirstTime;
  @override
  User? get user;
  @override
  bool get isUserLoading;
  @override
  @JsonKey(ignore: true)
  _$$CoreStateImplCopyWith<_$CoreStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
