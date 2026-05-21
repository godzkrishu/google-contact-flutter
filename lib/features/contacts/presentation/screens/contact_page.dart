import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_contact/features/contacts/presentation/widgets/contact_card.dart';
import 'package:google_contact/features/contacts/presentation/widgets/search_bar.dart';
import '../../domain/enitities/contact_entity.dart';
import '../bloc/contact_bloc.dart';
import 'add_edit_contact_page.dart';
import 'contact_detail_page.dart';

class ContactsPage extends StatefulWidget {
  static const String routeName = "contact-page";
  static const String routePath = "/contact-page";

  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  final TextEditingController _searchController = TextEditingController();
  List<ContactEntity> _filteredContacts = [];

  @override
  void initState() {
    super.initState();
    context.read<ContactsBloc>().add(const ContactsEvent.getContacts());
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
      appBar: AppBar(title: const Text('Contacts'), centerTitle: false),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pushNamed(AddEditContactPage.routeName),
        tooltip: 'Add Contact',
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<ContactsBloc, ContactsState>(
        builder: (context, state) {
          if (state.getContactStatus == ContactStatus.loading &&
              state.contacts.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.getContactStatus == ContactStatus.error) {
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
                      const ContactsEvent.getContacts(),
                    ),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          final allContacts = state.contacts;
          final contacts = _searchController.text.isEmpty
              ? allContacts
              : _filteredContacts;

          return Column(
            children: [
              CustomSearchBar(
                controller: _searchController,
                onChanged: (_) => _filterContacts(allContacts),
                onClear: () {
                  _searchController.clear();
                  _filterContacts(allContacts);
                },
              ),

              // Contact count
              if (allContacts.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 4),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${contacts.length} contact${contacts.length == 1 ? '' : 's'}',
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
                              Icons.person_search,
                              size: 64,
                              color: Colors.grey.shade400,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              _searchController.text.isNotEmpty
                                  ? 'No contacts match your search'
                                  : 'No contacts yet.\nTap + to add one.',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ],
                        ),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.fromLTRB(16, 4, 16, 100),
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
                          return Card(
                            margin: EdgeInsets.zero,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: Colors.grey.shade200),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              leading: CircleAvatar(
                                radius: 22,
                                child: Text(
                                  contact.name[0].toUpperCase(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              title: Text(
                                contact.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              subtitle: Text(
                                contact.phone,
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 13,
                                ),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Favorite toggle
                                  IconButton(
                                    onPressed: () {
                                      context.read<ContactsBloc>().add(
                                        ContactsEvent.toggleFavorite(
                                          contact.id,
                                        ),
                                      );
                                    },
                                    icon: Icon(
                                      contact.isFavorite
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: Colors.red,
                                      size: 20,
                                    ),
                                    tooltip: contact.isFavorite
                                        ? 'Remove from favorites'
                                        : 'Add to favorites',
                                  ),
                                  // Delete
                                  IconButton(
                                    onPressed: () =>
                                        _confirmDelete(context, contact),
                                    icon: Icon(
                                      Icons.delete_outline,
                                      color: Colors.grey.shade600,
                                      size: 20,
                                    ),
                                    tooltip: 'Delete contact',
                                  ),
                                ],
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        ContactDetailsPage(contact: contact),
                                  ),
                                );
                              },
                            ),
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
