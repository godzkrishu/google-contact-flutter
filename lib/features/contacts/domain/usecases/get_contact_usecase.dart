import 'package:google_contact/features/contacts/domain/enitities/contact_entity.dart';

import '../../data/model/contact_model.dart';
import '../repositories/contact_repository.dart';

class GetContactsUseCase {

  final ContactsRepository repository;

  GetContactsUseCase({required this.repository});

  Stream<List<ContactEntity>> call() {
    return repository.getContacts();
  }
}