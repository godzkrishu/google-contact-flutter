import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact_entity.freezed.dart';

@freezed
abstract class ContactEntity with _$ContactEntity {
  const factory ContactEntity({
    required String id,
    required String name,
    required String phone,
    required String email,
    String? company,
    String? notes,
    String? profileImage,
    required bool isFavorite,
    required DateTime createdAt,
  }) = _ContactEntity;
}