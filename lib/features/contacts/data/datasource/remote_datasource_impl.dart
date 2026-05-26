import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_contact/features/contacts/data/datasource/remote_datasource.dart';
import '../../../../core/error/api_exception_model.dart';
import '../model/contact_model.dart';

class ContactsRemoteDataSourceImpl implements ContactsRemoteDataSource {
  final FirebaseFirestore firestore;

  ContactsRemoteDataSourceImpl({required this.firestore});

  final String collection = 'contacts';

  @override
  Stream<List<ContactModel>> getContacts() {
    return firestore
        .collection(collection)
        .orderBy('name')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => ContactModel.fromJson(doc.data()))
              .toList(),
        );
  }

  @override
  Stream<List<ContactModel>> getFavoriteContacts() {
    return firestore
        .collection(collection)
        .where('isFavorite', isEqualTo: true)
        .orderBy('name')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => ContactModel.fromJson(doc.data()))
              .toList(),
        );
  }

  @override
  Future<void> addContact(ContactModel contact) async {
    await _checkDuplicatePhone(contact.phone);
    await firestore
        .collection(collection)
        .doc(contact.id)
        .set(contact.toJson());
  }

  @override
  Future<void> updateContact(ContactModel contact) async {
    final doc = await firestore.collection(collection).doc(contact.id).get();

    if (!doc.exists) {
      throw ApiException('Contact does not exist');
    }


    await _checkDuplicatePhoneForUpdate(contact);

    await firestore
        .collection(collection)
        .doc(contact.id)
        .update(contact.toJson());
  }

  @override
  Future<void> deleteContact(String id) async {
    final doc = await firestore.collection(collection).doc(id).get();

    if (!doc.exists) {
      throw ApiException('Contact does not exist');
    }

    await firestore.collection(collection).doc(id).delete();
  }

  @override
  Future<void> toggleFavorite(String id) async {
    final doc = await firestore.collection(collection).doc(id).get();

    if (!doc.exists) {
      throw ApiException('Contact does not exist');
    }

    final current = ContactModel.fromJson(doc.data()!);

    await firestore.collection(collection).doc(id).update({
      'isFavorite': !current.isFavorite,
    });
  }

  Future<void> _checkDuplicatePhone(String phone) async {
    final result = await firestore
        .collection(collection)
        .where('phone', isEqualTo: phone)
        .limit(1)
        .get();

    if (result.docs.isNotEmpty) {
      throw ApiException('Phone number already exists');
    }
  }

  Future<void> _checkDuplicatePhoneForUpdate(ContactModel contact) async {
    final result = await firestore
        .collection(collection)
        .where('phone', isEqualTo: contact.phone)
        .get();

    final duplicates = result.docs.where((doc) => doc.id != contact.id);

    if (duplicates.isNotEmpty) {
      throw ApiException('Phone number already exists');
    }
  }
}
