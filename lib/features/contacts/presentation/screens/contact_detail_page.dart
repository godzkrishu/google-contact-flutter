import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_toast.dart';
import '../../../../core/utils/app_utils.dart';
import '../../domain/enitities/contact_entity.dart';
import '../bloc/contact_bloc.dart';
import '../widgets/info_tile.dart';
import '../widgets/quick_action_button.dart';
import 'add_edit_contact_page.dart';

class ContactDetailsPage extends StatelessWidget {
  static const String routeName = "contact-detail-page";
  static const String routePath = "/contact-detail-page";

  final ContactEntity contact;

  const ContactDetailsPage({super.key, required this.contact});

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Contact'),
        content: Text('Are you sure you want to delete "${contact.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<ContactsBloc>().add(
                ContactsEvent.deleteContact(contact.id),
              );
              Navigator.pop(context); // close dialog
              Navigator.pop(context); // go back to list
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,

      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),

          titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 8),

          contentPadding: const EdgeInsets.fromLTRB(24, 0, 24, 20),

          title: Row(
            children: [
              Container(
                width: 42,
                height: 42,

                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),

                child: const Icon(Icons.error_outline, color: Colors.red),
              ),

              const SizedBox(width: 12),

              const Text(
                'Something went wrong',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ],
          ),

          content: Text(
            message,
            style: TextStyle(color: Colors.grey.shade700, height: 1.4),
          ),

          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),

              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ContactsBloc, ContactsState>(
      listener: (context, state) {
        /// DELETE SUCCESS
        if (state.deleteContactStatus == ContactStatus.completed) {
          AppToast.showSuccess('Contact deleted successfully');

          Navigator.pop(context);
        }

        /// DELETE ERROR
        if (state.deleteContactStatus == ContactStatus.error) {
          _showErrorDialog(context, state.message);
        }

        /// FAVORITE ERROR
        if (state.toggleFavoriteStatus == ContactStatus.error) {
          AppToast.showError(state.message);
        }
      },

      child: BlocBuilder<ContactsBloc, ContactsState>(
        builder: (context, state) {
          final bool isDeleting =
              state.deleteContactStatus == ContactStatus.loading;

          final bool isFavoriteLoading =
              state.toggleFavoriteStatus == ContactStatus.loading;

          final updatedContact = state.contacts
              .where((c) => c.id == contact.id)
              .firstOrNull;

          final currentContact = updatedContact ?? contact;
          return Scaffold(
            appBar: AppBar(
              title: const Text('Contact Details'),

              actions: [

                /// EDIT
                IconButton(
                  onPressed: isDeleting
                      ? null
                      : () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AddEditContactPage(
                          contact: currentContact,
                        ),
                      ),
                    );
                  },

                  icon: const Icon(Icons.edit_outlined),
                ),

                /// DELETE
                IconButton(
                  onPressed: isDeleting
                      ? null
                      : () => _showDeleteDialog(context),

                  icon: isDeleting
                      ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  )
                      : const Icon(Icons.delete_outline),
                ),
              ],
            ),

            body: Stack(
              children: [

                /// MAIN UI
                SingleChildScrollView(
                  child: Column(
                    children: [

                      /// HEADER
                      Container(
                        width: double.infinity,

                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 28,
                        ),

                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.08),

                              Colors.transparent,
                            ],

                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),

                        child: Column(
                          children: [

                            /// AVATAR
                            Hero(
                              tag: currentContact.id,

                              child: CircleAvatar(
                                radius: 50,

                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.12),

                                child: Text(
                                  currentContact.name[0]
                                      .toUpperCase(),

                                  style: TextStyle(
                                    fontSize: 36,
                                    fontWeight: FontWeight.bold,

                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 18),

                            /// NAME
                            Text(
                              currentContact.name,

                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),

                            /// COMPANY
                            if (currentContact.company != null &&
                                currentContact.company!.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 6),

                                child: Text(
                                  currentContact.company!,

                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ),

                            const SizedBox(height: 26),

                            /// QUICK ACTIONS
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,

                              children: [

                                /// CALL
                                QuickActionButton(
                                  icon: Icons.call,
                                  label: 'Call',
                                  isLoading: false,
                                  onTap: () => makeCall(
                                    currentContact.phone,
                                  ),
                                ),

                                const SizedBox(width: 22),

                                /// EMAIL
                                QuickActionButton(
                                  icon: Icons.email_outlined,
                                  label: 'Email',
                                  isLoading: false,
                                  onTap: () => sendEmail(
                                    currentContact.email,
                                  ),
                                ),

                                const SizedBox(width: 22),

                                /// FAVORITE
                                QuickActionButton(
                                  icon: currentContact.isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_border,

                                  label: currentContact.isFavorite
                                      ? 'Favorited'
                                      : 'Favorite',

                                  iconColor: Colors.red,

                                  isLoading: isFavoriteLoading,

                                  onTap: () {
                                    context
                                        .read<ContactsBloc>()
                                        .add(
                                      ContactsEvent
                                          .toggleFavorite(
                                        currentContact.id,
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      /// DETAILS
                      Padding(
                        padding: const EdgeInsets.all(20),

                        child: Column(
                          children: [

                            InfoTile(
                              icon: Icons.phone_outlined,
                              title: 'Phone',
                              value: currentContact.phone,

                              onTap: () => makeCall(
                                currentContact.phone,
                              ),
                            ),

                            const SizedBox(height: 14),

                            InfoTile(
                              icon: Icons.email_outlined,
                              title: 'Email',
                              value: currentContact.email,

                              onTap: () => sendEmail(
                                currentContact.email,
                              ),
                            ),

                            if (currentContact.notes != null &&
                                currentContact.notes!.isNotEmpty) ...[

                              const SizedBox(height: 14),

                              InfoTile(
                                icon: Icons.notes_outlined,
                                title: 'Notes',
                                value: currentContact.notes!,
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
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
            ),
          );
        },
      ),
    );
  }
}


