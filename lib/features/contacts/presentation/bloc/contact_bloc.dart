import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/enitities/contact_entity.dart';
import '../../domain/usecases/add_contact_usecase.dart';
import '../../domain/usecases/delete_contact_usecase.dart';
import '../../domain/usecases/get_contact_usecase.dart';
import '../../domain/usecases/get_favorite_contact_usecase.dart';
import '../../domain/usecases/toggle_favorite_contact_usecase.dart';
import '../../domain/usecases/update_contact_usecase.dart';

part 'contact_bloc.freezed.dart';
part 'contact_event.dart';
part 'contact_state.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  final GetContactsUseCase getContactsUseCase;

  final GetFavoriteContactsUseCase getFavoriteContactsUseCase;

  final AddContactUseCase addContactUseCase;

  final UpdateContactUseCase updateContactUseCase;

  final DeleteContactUseCase deleteContactUseCase;

  final ToggleFavoriteUseCase toggleFavoriteUseCase;

  ContactsBloc({
    required this.getContactsUseCase,
    required this.getFavoriteContactsUseCase,
    required this.addContactUseCase,
    required this.updateContactUseCase,
    required this.deleteContactUseCase,
    required this.toggleFavoriteUseCase,
  }) : super(const ContactsState()) {

    on<_GetContacts>(_onGetContacts);

    on<_GetFavoriteContacts>(_onGetFavoriteContacts);

    on<_AddContact>(_onAddContact);

    on<_UpdateContact>(_onUpdateContact);

    on<_DeleteContact>(_onDeleteContact);

    on<_ToggleFavorite>(_onToggleFavorite);
  }

  /// =====================================
  /// GET CONTACTS
  /// =====================================

  Future<void> _onGetContacts(
      _GetContacts event,
      Emitter<ContactsState> emit,
      ) async {

    if (state.contacts.isEmpty) {
      emit(
        state.copyWith(
          getContactStatus: ContactStatus.loading,
        ),
      );
    }

    await emit.forEach<List<ContactEntity>>(

      getContactsUseCase(),

      onData: (contacts) {

        return state.copyWith(
          getContactStatus: ContactStatus.completed,
          contacts: contacts,
        );
      },

      onError: (error, stackTrace) {

        return state.copyWith(
          getContactStatus: ContactStatus.error,
          message: error.toString(),
        );
      },
    );
  }

  /// =====================================
  /// GET FAVORITE CONTACTS
  /// =====================================

  Future<void> _onGetFavoriteContacts(
      _GetFavoriteContacts event,
      Emitter<ContactsState> emit,
      ) async {

    if (state.favoriteContacts.isEmpty) {
      emit(
        state.copyWith(
          getFavoriteContactStatus: ContactStatus.loading,
        ),
      );
    }

    await emit.forEach<List<ContactEntity>>(

      getFavoriteContactsUseCase(),

      onData: (contacts) {

        return state.copyWith(
          getFavoriteContactStatus: ContactStatus.completed,
          favoriteContacts: contacts,
        );
      },

      onError: (error, stackTrace) {

        return state.copyWith(
          getFavoriteContactStatus: ContactStatus.error,
          message: error.toString(),
        );
      },
    );
  }

  /// =====================================
  /// ADD CONTACT
  /// =====================================

  Future<void> _onAddContact(
      _AddContact event,
      Emitter<ContactsState> emit,
      ) async {

    try {

      await addContactUseCase(
        event.contact,
      );

    } catch (e) {

      emit(
        state.copyWith(
          message: e.toString(),
        ),
      );
    }
  }

  /// =====================================
  /// UPDATE CONTACT
  /// =====================================

  Future<void> _onUpdateContact(
      _UpdateContact event,
      Emitter<ContactsState> emit,
      ) async {

    try {

      await updateContactUseCase(
        event.contact,
      );

    } catch (e) {

      emit(
        state.copyWith(
          message: e.toString(),
        ),
      );
    }
  }

  /// =====================================
  /// DELETE CONTACT
  /// =====================================

  Future<void> _onDeleteContact(
      _DeleteContact event,
      Emitter<ContactsState> emit,
      ) async {

    try {

      await deleteContactUseCase(
        event.id,
      );

    } catch (e) {

      emit(
        state.copyWith(
          message: e.toString(),
        ),
      );
    }
  }

  /// =====================================
  /// TOGGLE FAVORITE
  /// =====================================

  Future<void> _onToggleFavorite(
      _ToggleFavorite event,
      Emitter<ContactsState> emit,
      ) async {

    try {

      await toggleFavoriteUseCase(
        event.id,
      );

    } catch (e) {

      emit(
        state.copyWith(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}