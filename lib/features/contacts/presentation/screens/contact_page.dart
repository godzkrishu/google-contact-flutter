import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/app_toast.dart';
import '../../domain/enitities/contact_entity.dart';
import '../bloc/contact_bloc.dart';
import '../widgets/contact_count_text.dart';
import '../widgets/contact_listview.dart';
import '../widgets/delete_dialog.dart';
import '../widgets/search_bar.dart';
import '../widgets/status_view.dart';
import 'add_edit_contact_page.dart';

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

    context.read<ContactsBloc>().add(
      const ContactsEvent.getContacts(),
    );
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
        return c.name.toLowerCase().contains(query) ||
            c.phone.contains(query);
      }).toList();
    });
  }

  Future<void> _deleteContact(ContactEntity contact) async {
    final confirmed = await showDeleteContactDialog(
      context,
      contact.name,
    );

    if (confirmed && context.mounted) {
      context.read<ContactsBloc>().add(
        ContactsEvent.deleteContact(contact.id),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
        centerTitle: false,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed(AddEditContactPage.routeName);
        },
        child: const Icon(Icons.add),
      ),

      body: BlocConsumer<ContactsBloc, ContactsState>(
        listenWhen: (previous, current) =>
        previous.message != current.message,

        listener: (context, state) {
          if (state.deleteContactStatus == ContactStatus.error ||
              state.toggleFavoriteStatus == ContactStatus.error) {
            AppToast.showError(state.message);
          }

          if (state.deleteContactStatus ==
              ContactStatus.completed) {
            AppToast.showSuccess('Contact deleted');
          }
        },

        builder: (context, state) {
          if (state.getContactStatus == ContactStatus.loading &&
              state.contacts.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state.getContactStatus == ContactStatus.error) {
            return StatusView(
              icon: Icons.cloud_off_rounded,
              color: Colors.red,
              title: 'Failed to load contacts',
              subtitle: state.message,

              button: ElevatedButton.icon(
                onPressed: () {
                  context.read<ContactsBloc>().add(
                    const ContactsEvent.getContacts(),
                  );
                },

                icon: const Icon(Icons.refresh),

                label: const Text('Try Again'),
              ),
            );
          }

          final allContacts = state.contacts;

          final contacts = _searchController.text.isEmpty
              ? allContacts
              : _filteredContacts;

          final isDeleting =
              state.deleteContactStatus ==
                  ContactStatus.loading;

          final isFavoriteLoading =
              state.toggleFavoriteStatus ==
                  ContactStatus.loading;

          return Stack(
            children: [
              Column(
                children: [
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

                  if (allContacts.isNotEmpty)
                    ContactCountText(
                      count: contacts.length,
                      label: 'contact',
                    ),

                  Expanded(
                    child: contacts.isEmpty
                        ? StatusView(
                      icon: Icons.people_alt_outlined,
                      color: Theme.of(context)
                          .colorScheme
                          .primary,

                      title:
                      _searchController.text.isNotEmpty
                          ? 'No contacts found'
                          : 'No contacts yet',

                      subtitle:
                      _searchController.text.isNotEmpty
                          ? 'Try searching with another keyword'
                          : 'Tap the + button to add your first contact.',
                    )
                        : ContactsListView(
                      contacts: contacts,
                      isDeleting: isDeleting,
                      isFavoriteLoading:
                      isFavoriteLoading,
                      onDelete: _deleteContact,
                    ),
                  ),
                ],
              ),

              if (isDeleting)
                Container(
                  color: Colors.black.withOpacity(0.08),

                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}