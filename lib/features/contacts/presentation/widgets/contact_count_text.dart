import 'package:flutter/material.dart';

class ContactCountText extends StatelessWidget {
  final int count;
  final String label;

  const ContactCountText({
    super.key,
    required this.count,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 6),

      child: Align(
        alignment: Alignment.centerLeft,

        child: Text(
          '$count $label${count == 1 ? '' : 's'}',

          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade600,
          ),
        ),
      ),
    );
  }
}