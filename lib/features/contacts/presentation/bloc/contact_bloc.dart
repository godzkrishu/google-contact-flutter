import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/error/api_exception_model.dart';
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

  // =========================
  // GET CONTACTS
  // =========================

  Future<void> _onGetContacts(
      _GetContacts event,
      Emitter<ContactsState> emit,
      ) async {
    if (state.contacts.isEmpty) {
      emit(
        state.resetStatuses().copyWith(
          getContactStatus: ContactStatus.loading,
        ),
      );
    }

    await emit.forEach<List<ContactEntity>>(
      getContactsUseCase(),
      onData: (contacts) => state.copyWith(
        getContactStatus: ContactStatus.completed,
        contacts: contacts,
      ),
      onError: (error, stackTrace) => state.copyWith(
        getContactStatus: ContactStatus.error,
        message: error is ApiException
            ? error.message
            : error.toString(),
      ),
    );
  }

  // =========================
  // GET FAVORITE CONTACTS
  // =========================

  Future<void> _onGetFavoriteContacts(
      _GetFavoriteContacts event,
      Emitter<ContactsState> emit,
      ) async {
    if (state.favoriteContacts.isEmpty) {
      emit(
        state.resetStatuses().copyWith(
          getFavoriteContactStatus: ContactStatus.loading,
        ),
      );
    }

    await emit.forEach<List<ContactEntity>>(
      getFavoriteContactsUseCase(),
      onData: (contacts) => state.copyWith(
        getFavoriteContactStatus: ContactStatus.completed,
        favoriteContacts: contacts,
      ),
      onError: (error, stackTrace) => state.copyWith(
        getFavoriteContactStatus: ContactStatus.error,
        message: error is ApiException
            ? error.message
            : error.toString(),
      ),
    );
  }

  // =========================
  // ADD CONTACT
  // =========================

  Future<void> _onAddContact(
      _AddContact event,
      Emitter<ContactsState> emit,
      ) async {
    emit(
      state.resetStatuses().copyWith(
        addContactStatus: ContactStatus.loading,
      ),
    );

    final result = await addContactUseCase(event.contact);

    result.fold(
          (failure) {
        emit(
          state.copyWith(
            addContactStatus: ContactStatus.error,
            message: failure.message,
          ),
        );
      },
          (_) {
        emit(
          state.copyWith(
            addContactStatus: ContactStatus.completed,
          ),
        );
      },
    );
  }

  // =========================
  // UPDATE CONTACT
  // =========================

  Future<void> _onUpdateContact(
      _UpdateContact event,
      Emitter<ContactsState> emit,
      ) async {
    emit(
      state.resetStatuses().copyWith(
        updateContactStatus: ContactStatus.loading,
      ),
    );

    final result = await updateContactUseCase(event.contact);

    result.fold(
          (failure) {
        emit(
          state.copyWith(
            updateContactStatus: ContactStatus.error,
            message: failure.message,
          ),
        );
      },
          (_) {
        emit(
          state.copyWith(
            updateContactStatus: ContactStatus.completed,
          ),
        );
      },
    );
  }

  // =========================
  // DELETE CONTACT
  // =========================

  Future<void> _onDeleteContact(
      _DeleteContact event,
      Emitter<ContactsState> emit,
      ) async {
    emit(
      state.resetStatuses().copyWith(
        deleteContactStatus: ContactStatus.loading,
      ),
    );

    final result = await deleteContactUseCase(event.id);

    result.fold(
          (failure) {
        emit(
          state.copyWith(
            deleteContactStatus: ContactStatus.error,
            message: failure.message,
          ),
        );
      },
          (_) {
        emit(
          state.copyWith(
            deleteContactStatus: ContactStatus.completed,
          ),
        );
      },
    );
  }

  // =========================
  // TOGGLE FAVORITE
  // =========================

  Future<void> _onToggleFavorite(
      _ToggleFavorite event,
      Emitter<ContactsState> emit,
      ) async {
    emit(
      state.resetStatuses().copyWith(
        toggleFavoriteStatus: ContactStatus.loading,
      ),
    );

    final result = await toggleFavoriteUseCase(event.id);

    result.fold(
          (failure) {
        emit(
          state.copyWith(
            toggleFavoriteStatus: ContactStatus.error,
            message: failure.message,
          ),
        );
      },
          (_) {
        emit(
          state.copyWith(
            toggleFavoriteStatus: ContactStatus.completed,
          ),
        );
      },
    );
  }
}