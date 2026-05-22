import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../domain/enitities/contact_entity.dart';
import '../bloc/contact_bloc.dart';
import '../screens/contact_detail_page.dart';
import 'contact_card.dart';

class ContactsListView extends StatelessWidget {
  final List<ContactEntity> contacts;
  final bool isDeleting;
  final bool isFavoriteLoading;
  final Future<void> Function(ContactEntity contact) onDelete;

  const ContactsListView({
    super.key,
    required this.contacts,
    required this.isDeleting,
    required this.isFavoriteLoading,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 100),

      itemCount: contacts.length,

      separatorBuilder: (_, __) => const SizedBox(height: 8),

      itemBuilder: (context, index) {
        final contact = contacts[index];

        return Opacity(
          opacity: isDeleting ? 0.7 : 1,

          child: ContactCard(
            contact: contact,

            onTap: () {
              context.pushNamed(
                ContactDetailsPage.routeName,
                extra: contact,
              );
            },

            onFavoriteTap: isFavoriteLoading
                ? () {}
                : () {
              context.read<ContactsBloc>().add(
                ContactsEvent.toggleFavorite(contact.id),
              );
            },

            onDeleteTap: isDeleting
                ? () {}
                : () => onDelete(contact),
          ),
        );
      },
    );
  }
}