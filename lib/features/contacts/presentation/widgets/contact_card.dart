import 'package:flutter/material.dart';
import '../../domain/enitities/contact_entity.dart';

class ContactCard extends StatelessWidget {
  final ContactEntity contact;

  final VoidCallback onTap;
  final VoidCallback onFavoriteTap;
  final VoidCallback onDeleteTap;

  const ContactCard({
    super.key,
    required this.contact,
    required this.onTap,
    required this.onFavoriteTap,
    required this.onDeleteTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.grey.shade100,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 10,
            ),
            child: Row(
              children: [
                // AVATAR
                Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: theme.primaryColor.withOpacity(0.08),
                  ),
                  child: Center(
                    child: Text(
                      (contact.name.isNotEmpty
                          ? contact.name[0]
                          : '?')
                          .toUpperCase(),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: theme.primaryColor,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                // CONTACT INFO
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        contact.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.2,
                        ),
                      ),

                      const SizedBox(height: 3),

                      Text(
                        contact.phone,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),

                // FAVORITE
                IconButton(
                  onPressed: onFavoriteTap,
                  splashRadius: 20,
                  icon: Icon(
                    contact.isFavorite
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    color: contact.isFavorite
                        ? Colors.red
                        : Colors.grey.shade500,
                    size: 21,
                  ),
                ),

                // DELETE
                IconButton(
                  onPressed: onDeleteTap,
                  splashRadius: 20,
                  icon: Icon(
                    Icons.delete_outline_rounded,
                    color: Colors.grey.shade500,
                    size: 21,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}