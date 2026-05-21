import 'package:google_contact/features/contacts/domain/enitities/contact_entity.dart';

import '../../data/model/contact_model.dart';

abstract class ContactsRepository {

  Stream<List<ContactEntity>> getContacts();

  Stream<List<ContactEntity>> getFavoriteContacts();

  Future<void> addContact(ContactEntity contact);

  Future<void> updateContact(ContactEntity contact);

  Future<void> deleteContact(String id);

  Future<void> toggleFavorite(String id);
}