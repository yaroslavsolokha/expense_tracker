import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key, required this.submitExpenseData});

  final void Function() submitExpenseData;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: submitExpenseData,
          child: const Text('Save Expense'),
        ),
      ],
    );
  }
}
