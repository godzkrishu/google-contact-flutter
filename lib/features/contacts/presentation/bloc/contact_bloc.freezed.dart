// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'contact_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ContactsEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContactsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ContactsEvent()';
}


}

/// @nodoc
class $ContactsEventCopyWith<$Res>  {
$ContactsEventCopyWith(ContactsEvent _, $Res Function(ContactsEvent) __);
}


/// Adds pattern-matching-related methods to [ContactsEvent].
extension ContactsEventPatterns on ContactsEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _GetContacts value)?  getContacts,TResult Function( _GetFavoriteContacts value)?  getFavoriteContacts,TResult Function( _AddContact value)?  addContact,TResult Function( _UpdateContact value)?  updateContact,TResult Function( _DeleteContact value)?  deleteContact,TResult Function( _ToggleFavorite value)?  toggleFavorite,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GetContacts() when getContacts != null:
return getContacts(_that);case _GetFavoriteContacts() when getFavoriteContacts != null:
return getFavoriteContacts(_that);case _AddContact() when addContact != null:
return addContact(_that);case _UpdateContact() when updateContact != null:
return updateContact(_that);case _DeleteContact() when deleteContact != null:
return deleteContact(_that);case _ToggleFavorite() when toggleFavorite != null:
return toggleFavorite(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _GetContacts value)  getContacts,required TResult Function( _GetFavoriteContacts value)  getFavoriteContacts,required TResult Function( _AddContact value)  addContact,required TResult Function( _UpdateContact value)  updateContact,required TResult Function( _DeleteContact value)  deleteContact,required TResult Function( _ToggleFavorite value)  toggleFavorite,}){
final _that = this;
switch (_that) {
case _GetContacts():
return getContacts(_that);case _GetFavoriteContacts():
return getFavoriteContacts(_that);case _AddContact():
return addContact(_that);case _UpdateContact():
return updateContact(_that);case _DeleteContact():
return deleteContact(_that);case _ToggleFavorite():
return toggleFavorite(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _GetContacts value)?  getContacts,TResult? Function( _GetFavoriteContacts value)?  getFavoriteContacts,TResult? Function( _AddContact value)?  addContact,TResult? Function( _UpdateContact value)?  updateContact,TResult? Function( _DeleteContact value)?  deleteContact,TResult? Function( _ToggleFavorite value)?  toggleFavorite,}){
final _that = this;
switch (_that) {
case _GetContacts() when getContacts != null:
return getContacts(_that);case _GetFavoriteContacts() when getFavoriteContacts != null:
return getFavoriteContacts(_that);case _AddContact() when addContact != null:
return addContact(_that);case _UpdateContact() when updateContact != null:
return updateContact(_that);case _DeleteContact() when deleteContact != null:
return deleteContact(_that);case _ToggleFavorite() when toggleFavorite != null:
return toggleFavorite(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  getContacts,TResult Function()?  getFavoriteContacts,TResult Function( ContactEntity contact)?  addContact,TResult Function( ContactEntity contact)?  updateContact,TResult Function( String id)?  deleteContact,TResult Function( String id)?  toggleFavorite,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GetContacts() when getContacts != null:
return getContacts();case _GetFavoriteContacts() when getFavoriteContacts != null:
return getFavoriteContacts();case _AddContact() when addContact != null:
return addContact(_that.contact);case _UpdateContact() when updateContact != null:
return updateContact(_that.contact);case _DeleteContact() when deleteContact != null:
return deleteContact(_that.id);case _ToggleFavorite() when toggleFavorite != null:
return toggleFavorite(_that.id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  getContacts,required TResult Function()  getFavoriteContacts,required TResult Function( ContactEntity contact)  addContact,required TResult Function( ContactEntity contact)  updateContact,required TResult Function( String id)  deleteContact,required TResult Function( String id)  toggleFavorite,}) {final _that = this;
switch (_that) {
case _GetContacts():
return getContacts();case _GetFavoriteContacts():
return getFavoriteContacts();case _AddContact():
return addContact(_that.contact);case _UpdateContact():
return updateContact(_that.contact);case _DeleteContact():
return deleteContact(_that.id);case _ToggleFavorite():
return toggleFavorite(_that.id);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  getContacts,TResult? Function()?  getFavoriteContacts,TResult? Function( ContactEntity contact)?  addContact,TResult? Function( ContactEntity contact)?  updateContact,TResult? Function( String id)?  deleteContact,TResult? Function( String id)?  toggleFavorite,}) {final _that = this;
switch (_that) {
case _GetContacts() when getContacts != null:
return getContacts();case _GetFavoriteContacts() when getFavoriteContacts != null:
return getFavoriteContacts();case _AddContact() when addContact != null:
return addContact(_that.contact);case _UpdateContact() when updateContact != null:
return updateContact(_that.contact);case _DeleteContact() when deleteContact != null:
return deleteContact(_that.id);case _ToggleFavorite() when toggleFavorite != null:
return toggleFavorite(_that.id);case _:
  return null;

}
}

}

/// @nodoc


class _GetContacts implements ContactsEvent {
  const _GetContacts();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetContacts);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ContactsEvent.getContacts()';
}


}




/// @nodoc


class _GetFavoriteContacts implements ContactsEvent {
  const _GetFavoriteContacts();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetFavoriteContacts);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ContactsEvent.getFavoriteContacts()';
}


}




/// @nodoc


class _AddContact implements ContactsEvent {
  const _AddContact(this.contact);
  

 final  ContactEntity contact;

/// Create a copy of ContactsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddContactCopyWith<_AddContact> get copyWith => __$AddContactCopyWithImpl<_AddContact>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddContact&&(identical(other.contact, contact) || other.contact == contact));
}


@override
int get hashCode => Object.hash(runtimeType,contact);

@override
String toString() {
  return 'ContactsEvent.addContact(contact: $contact)';
}


}

/// @nodoc
abstract mixin class _$AddContactCopyWith<$Res> implements $ContactsEventCopyWith<$Res> {
  factory _$AddContactCopyWith(_AddContact value, $Res Function(_AddContact) _then) = __$AddContactCopyWithImpl;
@useResult
$Res call({
 ContactEntity contact
});


$ContactEntityCopyWith<$Res> get contact;

}
/// @nodoc
class __$AddContactCopyWithImpl<$Res>
    implements _$AddContactCopyWith<$Res> {
  __$AddContactCopyWithImpl(this._self, this._then);

  final _AddContact _self;
  final $Res Function(_AddContact) _then;

/// Create a copy of ContactsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? contact = null,}) {
  return _then(_AddContact(
null == contact ? _self.contact : contact // ignore: cast_nullable_to_non_nullable
as ContactEntity,
  ));
}

/// Create a copy of ContactsEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ContactEntityCopyWith<$Res> get contact {
  
  return $ContactEntityCopyWith<$Res>(_self.contact, (value) {
    return _then(_self.copyWith(contact: value));
  });
}
}

/// @nodoc


class _UpdateContact implements ContactsEvent {
  const _UpdateContact(this.contact);
  

 final  ContactEntity contact;

/// Create a copy of ContactsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateContactCopyWith<_UpdateContact> get copyWith => __$UpdateContactCopyWithImpl<_UpdateContact>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateContact&&(identical(other.contact, contact) || other.contact == contact));
}


@override
int get hashCode => Object.hash(runtimeType,contact);

@override
String toString() {
  return 'ContactsEvent.updateContact(contact: $contact)';
}


}

/// @nodoc
abstract mixin class _$UpdateContactCopyWith<$Res> implements $ContactsEventCopyWith<$Res> {
  factory _$UpdateContactCopyWith(_UpdateContact value, $Res Function(_UpdateContact) _then) = __$UpdateContactCopyWithImpl;
@useResult
$Res call({
 ContactEntity contact
});


$ContactEntityCopyWith<$Res> get contact;

}
/// @nodoc
class __$UpdateContactCopyWithImpl<$Res>
    implements _$UpdateContactCopyWith<$Res> {
  __$UpdateContactCopyWithImpl(this._self, this._then);

  final _UpdateContact _self;
  final $Res Function(_UpdateContact) _then;

/// Create a copy of ContactsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? contact = null,}) {
  return _then(_UpdateContact(
null == contact ? _self.contact : contact // ignore: cast_nullable_to_non_nullable
as ContactEntity,
  ));
}

/// Create a copy of ContactsEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ContactEntityCopyWith<$Res> get contact {
  
  return $ContactEntityCopyWith<$Res>(_self.contact, (value) {
    return _then(_self.copyWith(contact: value));
  });
}
}

/// @nodoc


class _DeleteContact implements ContactsEvent {
  const _DeleteContact(this.id);
  

 final  String id;

/// Create a copy of ContactsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeleteContactCopyWith<_DeleteContact> get copyWith => __$DeleteContactCopyWithImpl<_DeleteContact>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeleteContact&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'ContactsEvent.deleteContact(id: $id)';
}


}

/// @nodoc
abstract mixin class _$DeleteContactCopyWith<$Res> implements $ContactsEventCopyWith<$Res> {
  factory _$DeleteContactCopyWith(_DeleteContact value, $Res Function(_DeleteContact) _then) = __$DeleteContactCopyWithImpl;
@useResult
$Res call({
 String id
});




}
/// @nodoc
class __$DeleteContactCopyWithImpl<$Res>
    implements _$DeleteContactCopyWith<$Res> {
  __$DeleteContactCopyWithImpl(this._self, this._then);

  final _DeleteContact _self;
  final $Res Function(_DeleteContact) _then;

/// Create a copy of ContactsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(_DeleteContact(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ToggleFavorite implements ContactsEvent {
  const _ToggleFavorite(this.id);
  

 final  String id;

/// Create a copy of ContactsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ToggleFavoriteCopyWith<_ToggleFavorite> get copyWith => __$ToggleFavoriteCopyWithImpl<_ToggleFavorite>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ToggleFavorite&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'ContactsEvent.toggleFavorite(id: $id)';
}


}

/// @nodoc
abstract mixin class _$ToggleFavoriteCopyWith<$Res> implements $ContactsEventCopyWith<$Res> {
  factory _$ToggleFavoriteCopyWith(_ToggleFavorite value, $Res Function(_ToggleFavorite) _then) = __$ToggleFavoriteCopyWithImpl;
@useResult
$Res call({
 String id
});




}
/// @nodoc
class __$ToggleFavoriteCopyWithImpl<$Res>
    implements _$ToggleFavoriteCopyWith<$Res> {
  __$ToggleFavoriteCopyWithImpl(this._self, this._then);

  final _ToggleFavorite _self;
  final $Res Function(_ToggleFavorite) _then;

/// Create a copy of ContactsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(_ToggleFavorite(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$ContactsState {

 ContactStatus get getContactStatus; ContactStatus get getFavoriteContactStatus; ContactStatus get addContactStatus; ContactStatus get updateContactStatus; ContactStatus get deleteContactStatus; ContactStatus get toggleFavoriteStatus; List<ContactEntity> get contacts; List<ContactEntity> get favoriteContacts; String get message;
/// Create a copy of ContactsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContactsStateCopyWith<ContactsState> get copyWith => _$ContactsStateCopyWithImpl<ContactsState>(this as ContactsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContactsState&&(identical(other.getContactStatus, getContactStatus) || other.getContactStatus == getContactStatus)&&(identical(other.getFavoriteContactStatus, getFavoriteContactStatus) || other.getFavoriteContactStatus == getFavoriteContactStatus)&&(identical(other.addContactStatus, addContactStatus) || other.addContactStatus == addContactStatus)&&(identical(other.updateContactStatus, updateContactStatus) || other.updateContactStatus == updateContactStatus)&&(identical(other.deleteContactStatus, deleteContactStatus) || other.deleteContactStatus == deleteContactStatus)&&(identical(other.toggleFavoriteStatus, toggleFavoriteStatus) || other.toggleFavoriteStatus == toggleFavoriteStatus)&&const DeepCollectionEquality().equals(other.contacts, contacts)&&const DeepCollectionEquality().equals(other.favoriteContacts, favoriteContacts)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,getContactStatus,getFavoriteContactStatus,addContactStatus,updateContactStatus,deleteContactStatus,toggleFavoriteStatus,const DeepCollectionEquality().hash(contacts),const DeepCollectionEquality().hash(favoriteContacts),message);

@override
String toString() {
  return 'ContactsState(getContactStatus: $getContactStatus, getFavoriteContactStatus: $getFavoriteContactStatus, addContactStatus: $addContactStatus, updateContactStatus: $updateContactStatus, deleteContactStatus: $deleteContactStatus, toggleFavoriteStatus: $toggleFavoriteStatus, contacts: $contacts, favoriteContacts: $favoriteContacts, message: $message)';
}


}

/// @nodoc
abstract mixin class $ContactsStateCopyWith<$Res>  {
  factory $ContactsStateCopyWith(ContactsState value, $Res Function(ContactsState) _then) = _$ContactsStateCopyWithImpl;
@useResult
$Res call({
 ContactStatus getContactStatus, ContactStatus getFavoriteContactStatus, ContactStatus addContactStatus, ContactStatus updateContactStatus, ContactStatus deleteContactStatus, ContactStatus toggleFavoriteStatus, List<ContactEntity> contacts, List<ContactEntity> favoriteContacts, String message
});




}
/// @nodoc
class _$ContactsStateCopyWithImpl<$Res>
    implements $ContactsStateCopyWith<$Res> {
  _$ContactsStateCopyWithImpl(this._self, this._then);

  final ContactsState _self;
  final $Res Function(ContactsState) _then;

/// Create a copy of ContactsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? getContactStatus = null,Object? getFavoriteContactStatus = null,Object? addContactStatus = null,Object? updateContactStatus = null,Object? deleteContactStatus = null,Object? toggleFavoriteStatus = null,Object? contacts = null,Object? favoriteContacts = null,Object? message = null,}) {
  return _then(_self.copyWith(
getContactStatus: null == getContactStatus ? _self.getContactStatus : getContactStatus // ignore: cast_nullable_to_non_nullable
as ContactStatus,getFavoriteContactStatus: null == getFavoriteContactStatus ? _self.getFavoriteContactStatus : getFavoriteContactStatus // ignore: cast_nullable_to_non_nullable
as ContactStatus,addContactStatus: null == addContactStatus ? _self.addContactStatus : addContactStatus // ignore: cast_nullable_to_non_nullable
as ContactStatus,updateContactStatus: null == updateContactStatus ? _self.updateContactStatus : updateContactStatus // ignore: cast_nullable_to_non_nullable
as ContactStatus,deleteContactStatus: null == deleteContactStatus ? _self.deleteContactStatus : deleteContactStatus // ignore: cast_nullable_to_non_nullable
as ContactStatus,toggleFavoriteStatus: null == toggleFavoriteStatus ? _self.toggleFavoriteStatus : toggleFavoriteStatus // ignore: cast_nullable_to_non_nullable
as ContactStatus,contacts: null == contacts ? _self.contacts : contacts // ignore: cast_nullable_to_non_nullable
as List<ContactEntity>,favoriteContacts: null == favoriteContacts ? _self.favoriteContacts : favoriteContacts // ignore: cast_nullable_to_non_nullable
as List<ContactEntity>,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ContactsState].
extension ContactsStatePatterns on ContactsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ContactsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ContactsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ContactsState value)  $default,){
final _that = this;
switch (_that) {
case _ContactsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ContactsState value)?  $default,){
final _that = this;
switch (_that) {
case _ContactsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ContactStatus getContactStatus,  ContactStatus getFavoriteContactStatus,  ContactStatus addContactStatus,  ContactStatus updateContactStatus,  ContactStatus deleteContactStatus,  ContactStatus toggleFavoriteStatus,  List<ContactEntity> contacts,  List<ContactEntity> favoriteContacts,  String message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ContactsState() when $default != null:
return $default(_that.getContactStatus,_that.getFavoriteContactStatus,_that.addContactStatus,_that.updateContactStatus,_that.deleteContactStatus,_that.toggleFavoriteStatus,_that.contacts,_that.favoriteContacts,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ContactStatus getContactStatus,  ContactStatus getFavoriteContactStatus,  ContactStatus addContactStatus,  ContactStatus updateContactStatus,  ContactStatus deleteContactStatus,  ContactStatus toggleFavoriteStatus,  List<ContactEntity> contacts,  List<ContactEntity> favoriteContacts,  String message)  $default,) {final _that = this;
switch (_that) {
case _ContactsState():
return $default(_that.getContactStatus,_that.getFavoriteContactStatus,_that.addContactStatus,_that.updateContactStatus,_that.deleteContactStatus,_that.toggleFavoriteStatus,_that.contacts,_that.favoriteContacts,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ContactStatus getContactStatus,  ContactStatus getFavoriteContactStatus,  ContactStatus addContactStatus,  ContactStatus updateContactStatus,  ContactStatus deleteContactStatus,  ContactStatus toggleFavoriteStatus,  List<ContactEntity> contacts,  List<ContactEntity> favoriteContacts,  String message)?  $default,) {final _that = this;
switch (_that) {
case _ContactsState() when $default != null:
return $default(_that.getContactStatus,_that.getFavoriteContactStatus,_that.addContactStatus,_that.updateContactStatus,_that.deleteContactStatus,_that.toggleFavoriteStatus,_that.contacts,_that.favoriteContacts,_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _ContactsState implements ContactsState {
  const _ContactsState({this.getContactStatus = ContactStatus.initial, this.getFavoriteContactStatus = ContactStatus.initial, this.addContactStatus = ContactStatus.initial, this.updateContactStatus = ContactStatus.initial, this.deleteContactStatus = ContactStatus.initial, this.toggleFavoriteStatus = ContactStatus.initial, final  List<ContactEntity> contacts = const [], final  List<ContactEntity> favoriteContacts = const [], this.message = ''}): _contacts = contacts,_favoriteContacts = favoriteContacts;
  

@override@JsonKey() final  ContactStatus getContactStatus;
@override@JsonKey() final  ContactStatus getFavoriteContactStatus;
@override@JsonKey() final  ContactStatus addContactStatus;
@override@JsonKey() final  ContactStatus updateContactStatus;
@override@JsonKey() final  ContactStatus deleteContactStatus;
@override@JsonKey() final  ContactStatus toggleFavoriteStatus;
 final  List<ContactEntity> _contacts;
@override@JsonKey() List<ContactEntity> get contacts {
  if (_contacts is EqualUnmodifiableListView) return _contacts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_contacts);
}

 final  List<ContactEntity> _favoriteContacts;
@override@JsonKey() List<ContactEntity> get favoriteContacts {
  if (_favoriteContacts is EqualUnmodifiableListView) return _favoriteContacts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_favoriteContacts);
}

@override@JsonKey() final  String message;

/// Create a copy of ContactsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContactsStateCopyWith<_ContactsState> get copyWith => __$ContactsStateCopyWithImpl<_ContactsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ContactsState&&(identical(other.getContactStatus, getContactStatus) || other.getContactStatus == getContactStatus)&&(identical(other.getFavoriteContactStatus, getFavoriteContactStatus) || other.getFavoriteContactStatus == getFavoriteContactStatus)&&(identical(other.addContactStatus, addContactStatus) || other.addContactStatus == addContactStatus)&&(identical(other.updateContactStatus, updateContactStatus) || other.updateContactStatus == updateContactStatus)&&(identical(other.deleteContactStatus, deleteContactStatus) || other.deleteContactStatus == deleteContactStatus)&&(identical(other.toggleFavoriteStatus, toggleFavoriteStatus) || other.toggleFavoriteStatus == toggleFavoriteStatus)&&const DeepCollectionEquality().equals(other._contacts, _contacts)&&const DeepCollectionEquality().equals(other._favoriteContacts, _favoriteContacts)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,getContactStatus,getFavoriteContactStatus,addContactStatus,updateContactStatus,deleteContactStatus,toggleFavoriteStatus,const DeepCollectionEquality().hash(_contacts),const DeepCollectionEquality().hash(_favoriteContacts),message);

@override
String toString() {
  return 'ContactsState(getContactStatus: $getContactStatus, getFavoriteContactStatus: $getFavoriteContactStatus, addContactStatus: $addContactStatus, updateContactStatus: $updateContactStatus, deleteContactStatus: $deleteContactStatus, toggleFavoriteStatus: $toggleFavoriteStatus, contacts: $contacts, favoriteContacts: $favoriteContacts, message: $message)';
}


}

/// @nodoc
abstract mixin class _$ContactsStateCopyWith<$Res> implements $ContactsStateCopyWith<$Res> {
  factory _$ContactsStateCopyWith(_ContactsState value, $Res Function(_ContactsState) _then) = __$ContactsStateCopyWithImpl;
@override @useResult
$Res call({
 ContactStatus getContactStatus, ContactStatus getFavoriteContactStatus, ContactStatus addContactStatus, ContactStatus updateContactStatus, ContactStatus deleteContactStatus, ContactStatus toggleFavoriteStatus, List<ContactEntity> contacts, List<ContactEntity> favoriteContacts, String message
});




}
/// @nodoc
class __$ContactsStateCopyWithImpl<$Res>
    implements _$ContactsStateCopyWith<$Res> {
  __$ContactsStateCopyWithImpl(this._self, this._then);

  final _ContactsState _self;
  final $Res Function(_ContactsState) _then;

/// Create a copy of ContactsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? getContactStatus = null,Object? getFavoriteContactStatus = null,Object? addContactStatus = null,Object? updateContactStatus = null,Object? deleteContactStatus = null,Object? toggleFavoriteStatus = null,Object? contacts = null,Object? favoriteContacts = null,Object? message = null,}) {
  return _then(_ContactsState(
getContactStatus: null == getContactStatus ? _self.getContactStatus : getContactStatus // ignore: cast_nullable_to_non_nullable
as ContactStatus,getFavoriteContactStatus: null == getFavoriteContactStatus ? _self.getFavoriteContactStatus : getFavoriteContactStatus // ignore: cast_nullable_to_non_nullable
as ContactStatus,addContactStatus: null == addContactStatus ? _self.addContactStatus : addContactStatus // ignore: cast_nullable_to_non_nullable
as ContactStatus,updateContactStatus: null == updateContactStatus ? _self.updateContactStatus : updateContactStatus // ignore: cast_nullable_to_non_nullable
as ContactStatus,deleteContactStatus: null == deleteContactStatus ? _self.deleteContactStatus : deleteContactStatus // ignore: cast_nullable_to_non_nullable
as ContactStatus,toggleFavoriteStatus: null == toggleFavoriteStatus ? _self.toggleFavoriteStatus : toggleFavoriteStatus // ignore: cast_nullable_to_non_nullable
as ContactStatus,contacts: null == contacts ? _self._contacts : contacts // ignore: cast_nullable_to_non_nullable
as List<ContactEntity>,favoriteContacts: null == favoriteContacts ? _self._favoriteContacts : favoriteContacts // ignore: cast_nullable_to_non_nullable
as List<ContactEntity>,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
