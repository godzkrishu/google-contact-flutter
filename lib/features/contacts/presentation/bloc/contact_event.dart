/// contacts_event.dart

part of 'contact_bloc.dart';

@freezed
class ContactsEvent with _$ContactsEvent {
  const factory ContactsEvent.getContacts() = _GetContacts;

  const factory ContactsEvent.getFavoriteContacts() =
  _GetFavoriteContacts;

  const factory ContactsEvent.addContact(
      ContactEntity contact,
      ) = _AddContact;

  const factory ContactsEvent.updateContact(
      ContactEntity contact,
      ) = _UpdateContact;

  const factory ContactsEvent.deleteContact(
      String id,
      ) = _DeleteContact;

  const factory ContactsEvent.toggleFavorite(
      String id,
      ) = _ToggleFavorite;
}