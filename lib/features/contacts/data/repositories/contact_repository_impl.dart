import 'package:google_contact/features/contacts/domain/enitities/contact_entity.dart';
import '../../domain/repositories/contact_repository.dart';
import '../datasource/remote_datasource.dart';
import '../mapper/conact_mapper.dart';

class ContactsRepositoryImpl implements ContactsRepository {
  final ContactsRemoteDataSource remoteDataSource;

  ContactsRepositoryImpl({required this.remoteDataSource});

  @override
  Stream<List<ContactEntity>> getContacts() {
    return remoteDataSource.getContacts().map(
          (models) => models
          .map((model) => model.toEntity())
          .toList(),
    );
  }

  @override
  Stream<List<ContactEntity>> getFavoriteContacts() {
    return remoteDataSource.getFavoriteContacts().map(
          (models) => models
          .map((model) => model.toEntity())
          .toList(),
    );
  }

  @override
  Future<void> addContact(ContactEntity contact) {
    return remoteDataSource.addContact(contact.toModel());
  }

  @override
  Future<void> updateContact(ContactEntity contact) {
    return remoteDataSource.updateContact(contact.toModel());
  }

  @override
  Future<void> deleteContact(String id) {
    return remoteDataSource.deleteContact(id);
  }

  @override
  Future<void> toggleFavorite(String id) {
    return remoteDataSource.toggleFavorite(id);
  }
}
