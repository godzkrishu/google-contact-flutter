import '../enitities/contact_entity.dart';
import '../repositories/contact_repository.dart';

class UpdateContactUseCase {
  final ContactsRepository repository;

  UpdateContactUseCase({
    required this.repository,
  });

  Future<void> call(ContactEntity contact) {
    return repository.updateContact(contact);
  }
}