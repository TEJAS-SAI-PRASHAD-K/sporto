import 'package:flutter/material.dart';
import 'package:playo/features/train/model/trainer.dart';

class AddNoteDialog extends StatelessWidget {
  final Trainer trainer;

  const AddNoteDialog({super.key, required this.trainer});

  static void show(BuildContext context, Trainer trainer) {
    showDialog(
      context: context,
      builder: (context) => AddNoteDialog(trainer: trainer),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController noteController = TextEditingController();

    return AlertDialog(
      title: Text('Add Note for ${trainer.name}'),
      content: TextField(
        controller: noteController,
        decoration: const InputDecoration(
          hintText: 'Enter your note...',
          border: OutlineInputBorder(),
        ),
        maxLines: 3,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            // Handle note saving logic here
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Note added successfully!')),
            );
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
