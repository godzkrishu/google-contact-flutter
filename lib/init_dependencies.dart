import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'core/error/response_handler.dart';
import 'features/contacts/data/datasource/remote_datasource.dart';
import 'features/contacts/data/datasource/remote_datasource_impl.dart';
import 'features/contacts/data/repositories/contact_repository_impl.dart';
import 'features/contacts/domain/repositories/contact_repository.dart';
import 'features/contacts/domain/usecases/add_contact_usecase.dart';
import 'features/contacts/domain/usecases/delete_contact_usecase.dart';
import 'features/contacts/domain/usecases/get_contact_usecase.dart';
import 'features/contacts/domain/usecases/get_favorite_contact_usecase.dart';
import 'features/contacts/domain/usecases/toggle_favorite_contact_usecase.dart';
import 'features/contacts/domain/usecases/update_contact_usecase.dart';
import 'features/contacts/presentation/bloc/contact_bloc.dart';



final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  await _initExternalTools();
  _initCore();
  _initContactsFeature();
}

/// ====================
/// EXTERNAL
/// ====================

Future<void> _initExternalTools() async {
  /// Firebase Auth
  serviceLocator.registerLazySingleton<FirebaseAuth>(
        () => FirebaseAuth.instance,
  );

  /// Firestore
  serviceLocator.registerLazySingleton<FirebaseFirestore>(
        () => FirebaseFirestore.instance,
  );
}

/// ====================
/// CORE
/// ====================

void _initCore() {
  serviceLocator.registerLazySingleton<ApiResponseHandler>(
        () => ApiResponseHandler(),
  );
}

/// ====================
/// CONTACTS FEATURE
/// ====================

void _initContactsFeature() {

  /// --------------------
  /// DATA SOURCE
  /// --------------------

  serviceLocator.registerLazySingleton<ContactsRemoteDataSource>(
        () => ContactsRemoteDataSourceImpl(
      firestore: serviceLocator(),
    ),
  );

  /// --------------------
  /// REPOSITORY
  /// --------------------

  serviceLocator.registerLazySingleton<ContactsRepository>(
        () => ContactsRepositoryImpl(
      remoteDataSource: serviceLocator(),
    ),
  );

  /// --------------------
  /// USE CASES
  /// --------------------

  serviceLocator.registerLazySingleton(
        () => GetContactsUseCase(
      repository: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton(
        () => GetFavoriteContactsUseCase(
      repository: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton(
        () => AddContactUseCase(
      repository: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton(
        () => UpdateContactUseCase(
      repository: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton(
        () => DeleteContactUseCase(
      repository: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton(
        () => ToggleFavoriteUseCase(
      repository: serviceLocator(),
    ),
  );

  /// --------------------
  /// BLOC
  /// --------------------

  serviceLocator.registerFactory(
        () => ContactsBloc(
      getContactsUseCase: serviceLocator(),
      getFavoriteContactsUseCase: serviceLocator(),
      addContactUseCase: serviceLocator(),
      updateContactUseCase: serviceLocator(),
      deleteContactUseCase: serviceLocator(),
      toggleFavoriteUseCase: serviceLocator(),
    ),
  );
}