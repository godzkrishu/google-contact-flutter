// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'contact_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ContactModel {

 String get id; String get name; String get phone; String get email; String get company; String get notes; String get profileImage; bool get isFavorite; DateTime get createdAt;
/// Create a copy of ContactModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContactModelCopyWith<ContactModel> get copyWith => _$ContactModelCopyWithImpl<ContactModel>(this as ContactModel, _$identity);

  /// Serializes this ContactModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContactModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.email, email) || other.email == email)&&(identical(other.company, company) || other.company == company)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.profileImage, profileImage) || other.profileImage == profileImage)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,phone,email,company,notes,profileImage,isFavorite,createdAt);

@override
String toString() {
  return 'ContactModel(id: $id, name: $name, phone: $phone, email: $email, company: $company, notes: $notes, profileImage: $profileImage, isFavorite: $isFavorite, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $ContactModelCopyWith<$Res>  {
  factory $ContactModelCopyWith(ContactModel value, $Res Function(ContactModel) _then) = _$ContactModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String phone, String email, String company, String notes, String profileImage, bool isFavorite, DateTime createdAt
});




}
/// @nodoc
class _$ContactModelCopyWithImpl<$Res>
    implements $ContactModelCopyWith<$Res> {
  _$ContactModelCopyWithImpl(this._self, this._then);

  final ContactModel _self;
  final $Res Function(ContactModel) _then;

/// Create a copy of ContactModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? phone = null,Object? email = null,Object? company = null,Object? notes = null,Object? profileImage = null,Object? isFavorite = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,company: null == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,profileImage: null == profileImage ? _self.profileImage : profileImage // ignore: cast_nullable_to_non_nullable
as String,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [ContactModel].
extension ContactModelPatterns on ContactModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ContactModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ContactModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ContactModel value)  $default,){
final _that = this;
switch (_that) {
case _ContactModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ContactModel value)?  $default,){
final _that = this;
switch (_that) {
case _ContactModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String phone,  String email,  String company,  String notes,  String profileImage,  bool isFavorite,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ContactModel() when $default != null:
return $default(_that.id,_that.name,_that.phone,_that.email,_that.company,_that.notes,_that.profileImage,_that.isFavorite,_that.createdAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String phone,  String email,  String company,  String notes,  String profileImage,  bool isFavorite,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _ContactModel():
return $default(_that.id,_that.name,_that.phone,_that.email,_that.company,_that.notes,_that.profileImage,_that.isFavorite,_that.createdAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String phone,  String email,  String company,  String notes,  String profileImage,  bool isFavorite,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _ContactModel() when $default != null:
return $default(_that.id,_that.name,_that.phone,_that.email,_that.company,_that.notes,_that.profileImage,_that.isFavorite,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ContactModel implements ContactModel {
  const _ContactModel({required this.id, required this.name, required this.phone, required this.email, this.company = '', this.notes = '', this.profileImage = '', this.isFavorite = false, required this.createdAt});
  factory _ContactModel.fromJson(Map<String, dynamic> json) => _$ContactModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  String phone;
@override final  String email;
@override@JsonKey() final  String company;
@override@JsonKey() final  String notes;
@override@JsonKey() final  String profileImage;
@override@JsonKey() final  bool isFavorite;
@override final  DateTime createdAt;

/// Create a copy of ContactModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContactModelCopyWith<_ContactModel> get copyWith => __$ContactModelCopyWithImpl<_ContactModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ContactModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ContactModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.email, email) || other.email == email)&&(identical(other.company, company) || other.company == company)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.profileImage, profileImage) || other.profileImage == profileImage)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,phone,email,company,notes,profileImage,isFavorite,createdAt);

@override
String toString() {
  return 'ContactModel(id: $id, name: $name, phone: $phone, email: $email, company: $company, notes: $notes, profileImage: $profileImage, isFavorite: $isFavorite, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$ContactModelCopyWith<$Res> implements $ContactModelCopyWith<$Res> {
  factory _$ContactModelCopyWith(_ContactModel value, $Res Function(_ContactModel) _then) = __$ContactModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String phone, String email, String company, String notes, String profileImage, bool isFavorite, DateTime createdAt
});




}
/// @nodoc
class __$ContactModelCopyWithImpl<$Res>
    implements _$ContactModelCopyWith<$Res> {
  __$ContactModelCopyWithImpl(this._self, this._then);

  final _ContactModel _self;
  final $Res Function(_ContactModel) _then;

/// Create a copy of ContactModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? phone = null,Object? email = null,Object? company = null,Object? notes = null,Object? profileImage = null,Object? isFavorite = null,Object? createdAt = null,}) {
  return _then(_ContactModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,company: null == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,profileImage: null == profileImage ? _self.profileImage : profileImage // ignore: cast_nullable_to_non_nullable
as String,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
