import '../repositories/contact_repository.dart';

class DeleteContactUseCase {
  final ContactsRepository repository;

  DeleteContactUseCase({
    required this.repository,
  });

  Future<void> call(String id) {
    return repository.deleteContact(id);
  }
}