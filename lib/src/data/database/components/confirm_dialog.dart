import 'package:flutter/material.dart';

/// Show a confirmation dialog for restore action
Future<void> showRestoreConfirmationDialog(
    context, function, filename, option) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Confirm $option'),
        content: Text(
            'Are you sure you want to $option the database from the backup file ?'),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
          TextButton(
            child: const Text('Yes'),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
              function(filename); // Call the restore method
            },
          ),
        ],
      );
    },
  );
}
