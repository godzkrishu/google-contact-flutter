import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_contact/features/contacts/presentation/widgets/contact_card.dart';
import 'package:google_contact/features/contacts/presentation/widgets/search_bar.dart';
import '../../domain/enitities/contact_entity.dart';
import '../bloc/contact_bloc.dart';
import 'contact_detail_page.dart';

class FavoriteContactsPage extends StatefulWidget {
  static const String routeName = "favorite-contact-page";
  static const String routePath = "/favorite-contact-page";

  const FavoriteContactsPage({super.key});

  @override
  State<FavoriteContactsPage> createState() => _FavoriteContactsPageState();
}

class _FavoriteContactsPageState extends State<FavoriteContactsPage> {
  final TextEditingController _searchController = TextEditingController();
  List<ContactEntity> _filteredContacts = [];

  @override
  void initState() {
    super.initState();
    context.read<ContactsBloc>().add(const ContactsEvent.getFavoriteContacts());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterContacts(List<ContactEntity> contacts) {
    final query = _searchController.text.toLowerCase().trim();
    setState(() {
      _filteredContacts = contacts.where((c) {
        return c.name.toLowerCase().contains(query) || c.phone.contains(query);
      }).toList();
    });
  }

  Future<void> _confirmDelete(
    BuildContext context,
    ContactEntity contact,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Contact'),
        content: Text('Are you sure you want to delete "${contact.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      context.read<ContactsBloc>().add(ContactsEvent.deleteContact(contact.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites'), centerTitle: false),
      body: BlocBuilder<ContactsBloc, ContactsState>(
        buildWhen: (previous, current) =>
            previous.favoriteContacts != current.favoriteContacts ||
            previous.getFavoriteContactStatus !=
                current.getFavoriteContactStatus,
        builder: (context, state) {
          if (state.getFavoriteContactStatus == ContactStatus.loading &&
              state.favoriteContacts.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.getFavoriteContactStatus == ContactStatus.error) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 12),
                  Text(state.message),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () => context.read<ContactsBloc>().add(
                      const ContactsEvent.getFavoriteContacts(),
                    ),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          final allContacts = state.favoriteContacts;
          final contacts = _searchController.text.isEmpty
              ? allContacts
              : _filteredContacts;

          return Column(
            children: [
              CustomSearchBar(
                hintText: 'Search favorites',
                controller: _searchController,
                onChanged: (_) {
                  _filterContacts(allContacts);
                  setState(() {});
                },
                onClear: () {
                  _searchController.clear();
                  _filterContacts(allContacts);
                },
              ),

              // Count
              if (allContacts.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 4),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${contacts.length} favorite${contacts.length == 1 ? '' : 's'}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                ),

              // List
              Expanded(
                child: contacts.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.favorite_border,
                              size: 64,
                              color: Colors.grey.shade400,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              _searchController.text.isNotEmpty
                                  ? 'No favorites match your search'
                                  : 'No favorite contacts yet.\nTap ♡ on a contact to add.',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ],
                        ),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                        itemCount: contacts.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 4),
                        itemBuilder: (context, index) {
                          final contact = contacts[index];

                          return ContactCard(
                            contact: contact,
                            onTap: () {
                              context.pushNamed(
                                ContactDetailsPage.routeName,
                                extra: contact,
                              );
                            },
                            onFavoriteTap: () {
                              context.read<ContactsBloc>().add(
                                ContactsEvent.toggleFavorite(contact.id),
                              );
                            },
                            onDeleteTap: () => _confirmDelete(context, contact),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
