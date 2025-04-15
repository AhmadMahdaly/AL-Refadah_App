import 'package:flutter/material.dart';

Future<String?> errorDialog(BuildContext context) {
  return showDialog<String>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('خطأ'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('موافق'),
          ),
        ],
      );
    },
  );
}
