/// contact_state.dart

part of 'contact_bloc.dart';

enum ContactStatus {
  initial,
  loading,
  completed,
  error,
}

@freezed
abstract class ContactsState with _$ContactsState {
  const factory ContactsState({
    @Default(ContactStatus.initial)
    ContactStatus getContactStatus,
    @Default(ContactStatus.initial)
    ContactStatus getFavoriteContactStatus,

    @Default([])
    List<ContactEntity> contacts,
    @Default([])
    List<ContactEntity> favoriteContacts,

    @Default('')
    String message,
  }) = _ContactsState;
}