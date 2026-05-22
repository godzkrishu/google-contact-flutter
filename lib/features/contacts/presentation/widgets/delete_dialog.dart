import 'package:flutter/material.dart';

Future<bool> showDeleteContactDialog(
    BuildContext context,
    String contactName,
    ) async {
  return await showDialog<bool>(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text('Delete Contact'),

      content: Text(
        'Are you sure you want to delete "$contactName"?',
      ),

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
  ) ??
      false;
}