import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../domain/enitities/contact_entity.dart';
import '../bloc/contact_bloc.dart';
import 'add_edit_contact_page.dart';

class ContactDetailsPage extends StatelessWidget {
  static const String routeName = "contact-detail-page";
  static const String routePath = "/contact-detail-page";

  final ContactEntity contact;

  const ContactDetailsPage({
    super.key,
    required this.contact,
  });

  Future<void> _makeCall(String phone) async {
    final uri = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> _sendEmail(String email) async {
    final uri = Uri(scheme: 'mailto', path: email);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Contact'),
        content: Text(
          'Are you sure you want to delete "${contact.name}"?',
        ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Details'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AddEditContactPage(contact: contact),
                ),
              );
            },
            icon: const Icon(Icons.edit_outlined),
            tooltip: 'Edit',
          ),
          IconButton(
            onPressed: () => _showDeleteDialog(context),
            icon: const Icon(Icons.delete_outline),
            tooltip: 'Delete',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 48,
                    child: Text(
                      contact.name[0].toUpperCase(),
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    contact.name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  if (contact.company != null &&
                      contact.company!.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      contact.company!,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],

                  const SizedBox(height: 16),

                  // Quick action buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Call button
                      _QuickActionButton(
                        icon: Icons.call,
                        label: 'Call',
                        onTap: () => _makeCall(contact.phone),
                      ),
                      const SizedBox(width: 24),
                      // Email button
                      _QuickActionButton(
                        icon: Icons.email_outlined,
                        label: 'Email',
                        onTap: () => _sendEmail(contact.email),
                      ),
                      const SizedBox(width: 24),
                      // Favorite toggle
                      BlocBuilder<ContactsBloc, ContactsState>(
                        builder: (context, state) {
                          // Use latest state if available
                          final isFav = state.contacts
                              .where((c) => c.id == contact.id)
                              .firstOrNull
                              ?.isFavorite ??
                              contact.isFavorite;

                          return _QuickActionButton(
                            icon: isFav
                                ? Icons.favorite
                                : Icons.favorite_border,
                            label: isFav ? 'Unfavorite' : 'Favorite',
                            iconColor: Colors.red,
                            onTap: () {
                              context.read<ContactsBloc>().add(
                                ContactsEvent.toggleFavorite(contact.id),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const Divider(height: 1),

            // Details
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _InfoTile(
                    icon: Icons.phone_outlined,
                    title: 'Phone',
                    value: contact.phone,
                    onTap: () => _makeCall(contact.phone),
                    trailing: IconButton(
                      icon: const Icon(Icons.call, size: 20),
                      onPressed: () => _makeCall(contact.phone),
                      tooltip: 'Call',
                    ),
                  ),
                  const SizedBox(height: 12),
                  _InfoTile(
                    icon: Icons.email_outlined,
                    title: 'Email',
                    value: contact.email,
                    onTap: () => _sendEmail(contact.email),
                  ),
                  if (contact.company != null &&
                      contact.company!.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    _InfoTile(
                      icon: Icons.business_outlined,
                      title: 'Company',
                      value: contact.company!,
                    ),
                  ],
                  if (contact.notes != null &&
                      contact.notes!.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    _InfoTile(
                      icon: Icons.notes_outlined,
                      title: 'Notes',
                      value: contact.notes!,
                    ),
                  ],
                  const SizedBox(height: 12),
                  _InfoTile(
                    icon: Icons.calendar_today_outlined,
                    title: 'Added on',
                    value:
                    '${contact.createdAt.day}/${contact.createdAt.month}/${contact.createdAt.year}',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? iconColor;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Icon(
              icon,
              color: iconColor ?? Theme.of(context).colorScheme.primary,
              size: 22,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final VoidCallback? onTap;
  final Widget? trailing;

  const _InfoTile({
    required this.icon,
    required this.title,
    required this.value,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade200),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 20, color: Colors.grey.shade600),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    style: const TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}