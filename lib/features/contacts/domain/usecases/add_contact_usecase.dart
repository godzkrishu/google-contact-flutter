import 'package:google_contact/features/contacts/domain/enitities/contact_entity.dart';

import '../repositories/contact_repository.dart';

class AddContactUseCase {

  final ContactsRepository repository;

  AddContactUseCase({required this.repository});

  Future<void> call(
      ContactEntity contact,
      ) {
    return repository.addContact(
      contact,
    );
  }
}