import 'package:freezed_annotation/freezed_annotation.dart';



part 'contact_model.freezed.dart';
part 'contact_model.g.dart';

@freezed
abstract class ContactModel with _$ContactModel {
  const factory ContactModel({
    required String id,
    required String name,
    required String phone,
    required String email,
    @Default('') String company,
    @Default('') String notes,
    @Default('') String profileImage,
    @Default(false) bool isFavorite,
    required DateTime createdAt,
  }) = _ContactModel;

  factory ContactModel.fromJson(Map<String, dynamic> json)
  => _$ContactModelFromJson(json);
}