import '../model/contact_model.dart';

abstract class ContactsRemoteDataSource {
  Stream<List<ContactModel>> getContacts();
  Stream<List<ContactModel>> getFavoriteContacts();
  Future<void> addContact(ContactModel contact);
  Future<void> updateContact(ContactModel contact);
  Future<void> deleteContact(String id);
  Future<void> toggleFavorite(String id);
}
