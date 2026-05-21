import 'package:google_contact/features/contacts/data/model/contact_model.dart';
import '../../domain/enitities/contact_entity.dart';

extension ContactToEntityMapper on ContactModel{
  ContactEntity toEntity(){
    return ContactEntity(
      id: id,
      name: name,
      phone: phone,
      email: email,
      company: company,
      notes: notes,
      profileImage: profileImage,
      isFavorite: isFavorite,
      createdAt: createdAt,
    );
  }
}
extension ContactToModelMapper on ContactEntity{
  ContactModel toModel(){
    return ContactModel(
      id: id,
      name: name,
      phone: phone,
      email:email,
      company: company??'',
      notes: notes??'',
      profileImage: profileImage??'',
      isFavorite:isFavorite,
      createdAt:createdAt,
    );

  }
}