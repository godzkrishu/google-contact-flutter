import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_contact/features/contacts/presentation/widgets/contact_card.dart';
import 'package:google_contact/features/contacts/presentation/widgets/search_bar.dart';
import '../../../../core/utils/app_toast.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        centerTitle: false,
      ),

      body: BlocConsumer<ContactsBloc, ContactsState>(
        listenWhen: (previous, current) =>
        previous.message != current.message,

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

        buildWhen: (previous, current) =>
        previous.favoriteContacts != current.favoriteContacts ||
            previous.getFavoriteContactStatus !=
                current.getFavoriteContactStatus ||
            previous.deleteContactStatus !=
                current.deleteContactStatus ||
            previous.toggleFavoriteStatus !=
                current.toggleFavoriteStatus,

        builder: (context, state) {

          /// LOADINGa
          if (state.getFavoriteContactStatus ==
              ContactStatus.loading &&
              state.favoriteContacts.isEmpty) {

            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          /// ERROR UI
          if (state.getFavoriteContactStatus ==
              ContactStatus.error) {

            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),

                child: Column(
                  mainAxisAlignment:
                  MainAxisAlignment.center,

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
                        color: Colors.red,
                        size: 42,
                      ),
                    ),

                    const SizedBox(height: 24),

                    const Text(
                      'Something went wrong',
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
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(height: 28),

                    ElevatedButton.icon(
                      onPressed: () {
                        context.read<ContactsBloc>().add(
                          const ContactsEvent
                              .getFavoriteContacts(),
                        );
                      },

                      icon: const Icon(Icons.refresh),

                      label: const Text('Try Again'),

                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(
                          160,
                          48,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          final allContacts = state.favoriteContacts;

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

              /// MAIN UI
              Column(
                children: [

                  /// SEARCH
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

                  /// COUNT
                  if (allContacts.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        16,
                        0,
                        16,
                        6,
                      ),

                      child: Align(
                        alignment: Alignment.centerLeft,

                        child: Text(
                          '${contacts.length} favorite${contacts.length == 1 ? '' : 's'}',

                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),

                  /// EMPTY UI
                  Expanded(
                    child: contacts.isEmpty
                        ? Center(
                      child: Padding(
                        padding:
                        const EdgeInsets.all(24),

                        child: Column(
                          mainAxisAlignment:
                          MainAxisAlignment.center,

                          children: [

                            Container(
                              width: 100,
                              height: 100,

                              decoration: BoxDecoration(
                                color: Colors.red
                                    .withOpacity(0.08),

                                shape: BoxShape.circle,
                              ),

                              child: Icon(
                                Icons.favorite_border,
                                size: 44,
                                color: Colors.red.shade300,
                              ),
                            ),

                            const SizedBox(height: 24),

                            Text(
                              _searchController
                                  .text
                                  .isNotEmpty
                                  ? 'No favorites found'
                                  : 'No favorite contacts yet',

                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight:
                                FontWeight.w700,
                              ),
                            ),

                            const SizedBox(height: 10),

                            Text(
                              _searchController
                                  .text
                                  .isNotEmpty
                                  ? 'Try searching with another keyword'
                                  : 'Tap the heart icon on contacts to add them here.',

                              textAlign: TextAlign.center,

                              style: TextStyle(
                                color:
                                Colors.grey.shade600,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )

                    /// LIST
                        : ListView.separated(
                      padding:
                      const EdgeInsets.fromLTRB(
                        16,
                        4,
                        16,
                        24,
                      ),

                      itemCount: contacts.length,

                      separatorBuilder: (_, __) =>
                      const SizedBox(height: 8),

                      itemBuilder: (context, index) {

                        final contact =
                        contacts[index];

                        return Opacity(
                          opacity: isDeleting
                              ? 0.7
                              : 1,

                          child: ContactCard(
                            contact: contact,

                            onTap: () {
                              context.pushNamed(
                                ContactDetailsPage
                                    .routeName,

                                extra: contact,
                              );
                            },

                            onFavoriteTap:
                            isFavoriteLoading
                                ? () {}
                                : () {
                              context
                                  .read<
                                  ContactsBloc>()
                                  .add(
                                ContactsEvent
                                    .toggleFavorite(
                                  contact
                                      .id,
                                ),
                              );
                            },

                            onDeleteTap: isDeleting
                                ? () {}
                                : () =>
                                _confirmDelete(
                                  context,
                                  contact,
                                ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),

              /// FULL SCREEN LOADER
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
