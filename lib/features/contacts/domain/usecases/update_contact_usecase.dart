import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failure.dart';
import '../enitities/contact_entity.dart';
import '../repositories/contact_repository.dart';

class UpdateContactUseCase {
  final ContactsRepository repository;

  UpdateContactUseCase({required this.repository});

  // ✅ Return Either so BLoC can fold it
  Future<Either<Failure, void>> call(ContactEntity contact) {
    return repository.updateContact(contact);
  }
}