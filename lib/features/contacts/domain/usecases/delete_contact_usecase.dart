import '../repositories/contact_repository.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failure.dart';

class DeleteContactUseCase {
  final ContactsRepository repository;

  DeleteContactUseCase({required this.repository});
  Future<Either<Failure, void>> call(String id) {
    return repository.deleteContact(id);
  }
}