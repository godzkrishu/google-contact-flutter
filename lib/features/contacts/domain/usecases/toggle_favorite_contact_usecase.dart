import '../repositories/contact_repository.dart';

class ToggleFavoriteUseCase {
  final ContactsRepository repository;

  ToggleFavoriteUseCase({
    required this.repository,
  });

  Future<void> call(String id) {
    return repository.toggleFavorite(id);
  }
}