import 'package:fpdart/fpdart.dart';
import 'package:google_contact/features/contacts/domain/enitities/contact_entity.dart';
import '../../../../core/error/failure.dart';
import '../repositories/contact_repository.dart';


class AddContactUseCase {

  final ContactsRepository repository;

  AddContactUseCase({required this.repository});

  Future<Either<Failure, void>> call(
      ContactEntity contact,
      ) {
    return repository.addContact(
      contact,
    );
  }
}