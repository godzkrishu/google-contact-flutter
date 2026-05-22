import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failure.dart';
import '../repositories/contact_repository.dart';

class ToggleFavoriteUseCase {
  final ContactsRepository repository;

  ToggleFavoriteUseCase({required this.repository});

  // ✅ Return Either so BLoC can fold it
  Future<Either<Failure, void>> call(String id) {
    return repository.toggleFavorite(id);
  }
}