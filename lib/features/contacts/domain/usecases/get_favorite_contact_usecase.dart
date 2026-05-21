

import '../enitities/contact_entity.dart';
import '../repositories/contact_repository.dart';

class GetFavoriteContactsUseCase {
  final ContactsRepository repository;

  GetFavoriteContactsUseCase({
    required this.repository,
  });

  Stream<List<ContactEntity>> call() {
    return repository.getFavoriteContacts();
  }
}