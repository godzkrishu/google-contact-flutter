import 'package:fpdart/fpdart.dart';
import 'package:google_contact/core/error/response_handler.dart';
import 'package:google_contact/core/error/try_catch_helper.dart';
import 'package:google_contact/features/contacts/domain/enitities/contact_entity.dart';
import '../../../../core/error/failure.dart';
import '../../domain/repositories/contact_repository.dart';
import '../datasource/remote_datasource.dart';
import '../mapper/conact_mapper.dart';

class ContactsRepositoryImpl with TryCatchHelper implements ContactsRepository {
  final ContactsRemoteDataSource remoteDataSource;

  ContactsRepositoryImpl({required this.remoteDataSource});

  @override
  Stream<List<ContactEntity>> getContacts() {
    return remoteDataSource
        .getContacts()
        .map((models) => models.map((model) => model.toEntity()).toList())
        .handleError((e, st) {
          throw ApiResponseHandler().handle(e, st);
        });
  }

  @override
  Stream<List<ContactEntity>> getFavoriteContacts() {
    return remoteDataSource
        .getFavoriteContacts()
        .map((models) => models.map((model) => model.toEntity()).toList())
        .handleError((e, st) {
          throw ApiResponseHandler().handle(e, st);
        });
  }

  @override
  Future<Either<Failure, void>> addContact(ContactEntity contact) {
    return tryCatch(() async {
      await remoteDataSource.addContact(contact.toModel());
    });
  }

  @override
  Future<Either<Failure, void>> updateContact(ContactEntity contact) {
    return tryCatch(() async {
      await remoteDataSource.updateContact(contact.toModel());
    });
  }

  @override
  Future<Either<Failure, void>> deleteContact(String id) {
    return tryCatch(() async {
      await remoteDataSource.deleteContact(id);
    });
  }

  @override
  Future<Either<Failure, void>> toggleFavorite(String id) {
    return tryCatch(() async {
      await remoteDataSource.toggleFavorite(id);
    });
  }
}
