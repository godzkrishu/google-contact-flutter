import 'package:fpdart/fpdart.dart';
import 'package:google_contact/features/contacts/domain/enitities/contact_entity.dart';
import '../../../../core/error/failure.dart';

abstract class ContactsRepository {

  Stream<List<ContactEntity>> getContacts();

  Stream<List<ContactEntity>> getFavoriteContacts();

  Future<Either<Failure, void>> addContact(ContactEntity contact);

  Future<Either<Failure, void>> updateContact(ContactEntity contact);

  Future<Either<Failure, void>> deleteContact(String id);

  Future<Either<Failure, void>> toggleFavorite(String id);
}