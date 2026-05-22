import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_contact/features/contacts/presentation/widgets/contact_card.dart';
import 'package:google_contact/features/contacts/presentation/widgets/search_bar.dart';
import '../../../../core/utils/app_toast.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contacts'), centerTitle: false),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed(AddEditContactPage.routeName);
        },
        tooltip: 'Add Contact',
        child: const Icon(Icons.add),
      ),

      body: BlocConsumer<ContactsBloc, ContactsState>(
        /// LISTENER
        listenWhen: (previous, current) => previous.message != current.message,

        listener: (context, state) {
          /// ERROR TOAST
          if (state.deleteContactStatus == ContactStatus.error ||
              state.toggleFavoriteStatus == ContactStatus.error) {
            AppToast.showError(state.message);
          }

          /// SUCCESS TOAST
          if (state.deleteContactStatus == ContactStatus.completed) {
            AppToast.showSuccess('Contact deleted');
          }
        },

        builder: (context, state) {
          if (state.getContactStatus == ContactStatus.loading &&
              state.contacts.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          /// ERROR UI
          if (state.getContactStatus == ContactStatus.error) {
            return emptyWidget(state, context);
          }

          final allContacts = state.contacts;

          final contacts = _searchController.text.isEmpty
              ? allContacts
              : _filteredContacts;

          final isDeleting = state.deleteContactStatus == ContactStatus.loading;

          final isFavoriteLoading =
              state.toggleFavoriteStatus == ContactStatus.loading;

          return Stack(
            children: [
              /// MAIN UI
              Column(
                children: [
                  /// SEARCH BAR
                  CustomSearchBar(
                    controller: _searchController,

                    onChanged: (_) {
                      _filterContacts(allContacts);
                    },

                    onClear: () {
                      _searchController.clear();

                      _filterContacts(allContacts);
                    },
                  ),

                  /// CONTACT COUNT
                  if (allContacts.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 6),

                      child: Align(
                        alignment: Alignment.centerLeft,

                        child: Text(
                          '${contacts.length} contact${contacts.length == 1 ? '' : 's'}',

                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,

                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                    ),

                  /// LIST / EMPTY
                  Expanded(
                    child: contacts.isEmpty
                        /// EMPTY UI
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.all(24),

                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,

                                children: [
                                  Container(
                                    width: 100,
                                    height: 100,

                                    decoration: BoxDecoration(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primary.withOpacity(0.08),

                                      shape: BoxShape.circle,
                                    ),

                                    child: Icon(
                                      Icons.people_alt_outlined,

                                      size: 46,

                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                    ),
                                  ),

                                  const SizedBox(height: 24),

                                  Text(
                                    _searchController.text.isNotEmpty
                                        ? 'No contacts found'
                                        : 'No contacts yet',

                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  Text(
                                    _searchController.text.isNotEmpty
                                        ? 'Try searching with another keyword'
                                        : 'Tap the + button to add your first contact.',

                                    textAlign: TextAlign.center,

                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        /// CONTACT LIST
                        : contactListWidget(contacts, isDeleting, isFavoriteLoading),
                  ),
                ],
              ),

              /// FULL SCREEN LOADER
              if (isDeleting)
                Container(
                  color: Colors.black.withOpacity(0.08),

                  child: const Center(child: CircularProgressIndicator()),
                ),
            ],
          );
        },
      ),
    );
  }

  ListView contactListWidget(List<ContactEntity> contacts, bool isDeleting, bool isFavoriteLoading) {
    return ListView.separated(
                          padding: const EdgeInsets.fromLTRB(16, 4, 16, 100),

                          itemCount: contacts.length,

                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 8),

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
                                          ContactsEvent.toggleFavorite(
                                            contact.id,
                                          ),
                                        );
                                      },

                                onDeleteTap: isDeleting
                                    ? () {}
                                    : () => _confirmDelete(context, contact),
                              ),
                            );
                          },
                        );
  }

 Widget emptyWidget(ContactsState state, BuildContext context) {
    return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Container(
                    width: 90,
                    height: 90,

                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.08),
                      shape: BoxShape.circle,
                    ),

                    child: const Icon(
                      Icons.cloud_off_rounded,
                      size: 42,
                      color: Colors.red,
                    ),
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    'Failed to load contacts',

                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    state.message,

                    textAlign: TextAlign.center,

                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),

                  const SizedBox(height: 28),

                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<ContactsBloc>().add(
                        const ContactsEvent.getContacts(),
                      );
                    },

                    icon: const Icon(Icons.refresh),

                    label: const Text('Try Again'),

                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(160, 48),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
