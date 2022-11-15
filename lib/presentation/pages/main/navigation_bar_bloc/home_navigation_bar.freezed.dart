// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'home_navigation_bar.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$HomeNavigationBarEvent {
  int get index => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int index) changed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int index)? changed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int index)? changed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HomeNavigationBarChanged value) changed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HomeNavigationBarChanged value)? changed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HomeNavigationBarChanged value)? changed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HomeNavigationBarEventCopyWith<HomeNavigationBarEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeNavigationBarEventCopyWith<$Res> {
  factory $HomeNavigationBarEventCopyWith(HomeNavigationBarEvent value,
          $Res Function(HomeNavigationBarEvent) then) =
      _$HomeNavigationBarEventCopyWithImpl<$Res, HomeNavigationBarEvent>;
  @useResult
  $Res call({int index});
}

/// @nodoc
class _$HomeNavigationBarEventCopyWithImpl<$Res,
        $Val extends HomeNavigationBarEvent>
    implements $HomeNavigationBarEventCopyWith<$Res> {
  _$HomeNavigationBarEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = null,
  }) {
    return _then(_value.copyWith(
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HomeNavigationBarChangedCopyWith<$Res>
    implements $HomeNavigationBarEventCopyWith<$Res> {
  factory _$$HomeNavigationBarChangedCopyWith(_$HomeNavigationBarChanged value,
          $Res Function(_$HomeNavigationBarChanged) then) =
      __$$HomeNavigationBarChangedCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int index});
}

/// @nodoc
class __$$HomeNavigationBarChangedCopyWithImpl<$Res>
    extends _$HomeNavigationBarEventCopyWithImpl<$Res,
        _$HomeNavigationBarChanged>
    implements _$$HomeNavigationBarChangedCopyWith<$Res> {
  __$$HomeNavigationBarChangedCopyWithImpl(_$HomeNavigationBarChanged _value,
      $Res Function(_$HomeNavigationBarChanged) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = null,
  }) {
    return _then(_$HomeNavigationBarChanged(
      null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$HomeNavigationBarChanged extends HomeNavigationBarChanged {
  const _$HomeNavigationBarChanged(this.index) : super._();

  @override
  final int index;

  @override
  String toString() {
    return 'HomeNavigationBarEvent.changed(index: $index)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeNavigationBarChanged &&
            (identical(other.index, index) || other.index == index));
  }

  @override
  int get hashCode => Object.hash(runtimeType, index);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeNavigationBarChangedCopyWith<_$HomeNavigationBarChanged>
      get copyWith =>
          __$$HomeNavigationBarChangedCopyWithImpl<_$HomeNavigationBarChanged>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int index) changed,
  }) {
    return changed(index);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int index)? changed,
  }) {
    return changed?.call(index);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int index)? changed,
    required TResult orElse(),
  }) {
    if (changed != null) {
      return changed(index);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HomeNavigationBarChanged value) changed,
  }) {
    return changed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HomeNavigationBarChanged value)? changed,
  }) {
    return changed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HomeNavigationBarChanged value)? changed,
    required TResult orElse(),
  }) {
    if (changed != null) {
      return changed(this);
    }
    return orElse();
  }
}

abstract class HomeNavigationBarChanged extends HomeNavigationBarEvent {
  const factory HomeNavigationBarChanged(final int index) =
      _$HomeNavigationBarChanged;
  const HomeNavigationBarChanged._() : super._();

  @override
  int get index;
  @override
  @JsonKey(ignore: true)
  _$$HomeNavigationBarChangedCopyWith<_$HomeNavigationBarChanged>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$HomeNavigationBarState {
  int get index => throw _privateConstructorUsedError;
  int? get key => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int index, int? key) change,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int index, int? key)? change,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int index, int? key)? change,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HomeNavigationBarChange value) change,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HomeNavigationBarChange value)? change,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HomeNavigationBarChange value)? change,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HomeNavigationBarStateCopyWith<HomeNavigationBarState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeNavigationBarStateCopyWith<$Res> {
  factory $HomeNavigationBarStateCopyWith(HomeNavigationBarState value,
          $Res Function(HomeNavigationBarState) then) =
      _$HomeNavigationBarStateCopyWithImpl<$Res, HomeNavigationBarState>;
  @useResult
  $Res call({int index, int? key});
}

/// @nodoc
class _$HomeNavigationBarStateCopyWithImpl<$Res,
        $Val extends HomeNavigationBarState>
    implements $HomeNavigationBarStateCopyWith<$Res> {
  _$HomeNavigationBarStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = null,
    Object? key = freezed,
  }) {
    return _then(_value.copyWith(
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      key: freezed == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HomeNavigationBarChangeCopyWith<$Res>
    implements $HomeNavigationBarStateCopyWith<$Res> {
  factory _$$HomeNavigationBarChangeCopyWith(_$HomeNavigationBarChange value,
          $Res Function(_$HomeNavigationBarChange) then) =
      __$$HomeNavigationBarChangeCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int index, int? key});
}

/// @nodoc
class __$$HomeNavigationBarChangeCopyWithImpl<$Res>
    extends _$HomeNavigationBarStateCopyWithImpl<$Res,
        _$HomeNavigationBarChange>
    implements _$$HomeNavigationBarChangeCopyWith<$Res> {
  __$$HomeNavigationBarChangeCopyWithImpl(_$HomeNavigationBarChange _value,
      $Res Function(_$HomeNavigationBarChange) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = null,
    Object? key = freezed,
  }) {
    return _then(_$HomeNavigationBarChange(
      null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      freezed == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$HomeNavigationBarChange extends HomeNavigationBarChange {
  _$HomeNavigationBarChange(this.index, [this.key]) : super._();

  @override
  final int index;
  @override
  final int? key;

  @override
  String toString() {
    return 'HomeNavigationBarState.change(index: $index, key: $key)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeNavigationBarChange &&
            (identical(other.index, index) || other.index == index) &&
            (identical(other.key, key) || other.key == key));
  }

  @override
  int get hashCode => Object.hash(runtimeType, index, key);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeNavigationBarChangeCopyWith<_$HomeNavigationBarChange> get copyWith =>
      __$$HomeNavigationBarChangeCopyWithImpl<_$HomeNavigationBarChange>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int index, int? key) change,
  }) {
    return change(index, key);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int index, int? key)? change,
  }) {
    return change?.call(index, key);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int index, int? key)? change,
    required TResult orElse(),
  }) {
    if (change != null) {
      return change(index, key);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HomeNavigationBarChange value) change,
  }) {
    return change(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HomeNavigationBarChange value)? change,
  }) {
    return change?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HomeNavigationBarChange value)? change,
    required TResult orElse(),
  }) {
    if (change != null) {
      return change(this);
    }
    return orElse();
  }
}

abstract class HomeNavigationBarChange extends HomeNavigationBarState {
  factory HomeNavigationBarChange(final int index, [final int? key]) =
      _$HomeNavigationBarChange;
  HomeNavigationBarChange._() : super._();

  @override
  int get index;
  @override
  int? get key;
  @override
  @JsonKey(ignore: true)
  _$$HomeNavigationBarChangeCopyWith<_$HomeNavigationBarChange> get copyWith =>
      throw _privateConstructorUsedError;
}
