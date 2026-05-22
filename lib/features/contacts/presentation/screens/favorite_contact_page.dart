import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_toast.dart';
import '../../domain/enitities/contact_entity.dart';
import '../bloc/contact_bloc.dart';
import '../widgets/contact_count_text.dart';
import '../widgets/contact_listview.dart';
import '../widgets/delete_dialog.dart';
import '../widgets/search_bar.dart';
import '../widgets/status_view.dart';

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

  Future<void> _deleteContact(ContactEntity contact) async {
    final confirmed = await showDeleteContactDialog(context, contact.name);

    if (confirmed && context.mounted) {
      context.read<ContactsBloc>().add(ContactsEvent.deleteContact(contact.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites'), centerTitle: false),

      body: BlocConsumer<ContactsBloc, ContactsState>(
        listenWhen: (previous, current) => previous.message != current.message,

        listener: (context, state) {
          if (state.deleteContactStatus == ContactStatus.error ||
              state.toggleFavoriteStatus == ContactStatus.error) {
            AppToast.showError(state.message);
          }

          if (state.deleteContactStatus == ContactStatus.completed) {
            AppToast.showSuccess('Contact deleted');
          }
        },

        buildWhen: (previous, current) =>
            previous.favoriteContacts != current.favoriteContacts ||
            previous.getFavoriteContactStatus !=
                current.getFavoriteContactStatus ||
            previous.deleteContactStatus != current.deleteContactStatus ||
            previous.toggleFavoriteStatus != current.toggleFavoriteStatus,

        builder: (context, state) {
          if (state.getFavoriteContactStatus == ContactStatus.loading &&
              state.favoriteContacts.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.getFavoriteContactStatus == ContactStatus.error) {
            return StatusView(
              icon: Icons.cloud_off_rounded,
              color: Colors.red,
              title: 'Something went wrong',
              subtitle: state.message,

              button: ElevatedButton.icon(
                onPressed: () {
                  context.read<ContactsBloc>().add(
                    const ContactsEvent.getFavoriteContacts(),
                  );
                },

                icon: const Icon(Icons.refresh),

                label: const Text('Try Again'),
              ),
            );
          }

          final allContacts = state.favoriteContacts;

          final contacts = _searchController.text.isEmpty
              ? allContacts
              : _filteredContacts;

          final isDeleting = state.deleteContactStatus == ContactStatus.loading;

          final isFavoriteLoading =
              state.toggleFavoriteStatus == ContactStatus.loading;

          return Stack(
            children: [
              Column(
                children: [
                  CustomSearchBar(
                    hintText: 'Search favorites',

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
                    ContactCountText(count: contacts.length, label: 'favorite'),

                  Expanded(
                    child: contacts.isEmpty
                        ? StatusView(
                            icon: Icons.favorite_border,
                            color: Colors.red.shade300,

                            title: _searchController.text.isNotEmpty
                                ? 'No favorites found'
                                : 'No favorite contacts yet',

                            subtitle: _searchController.text.isNotEmpty
                                ? 'Try searching with another keyword'
                                : 'Tap the heart icon on contacts to add them here.',
                          )
                        : ContactsListView(
                            contacts: contacts,
                            isDeleting: isDeleting,
                            isFavoriteLoading: isFavoriteLoading,
                            onDelete: _deleteContact,
                          ),
                  ),
                ],
              ),

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
}
