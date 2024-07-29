import 'package:flutter/material.dart';

class AmountField extends StatelessWidget {
  const AmountField({super.key, required this.amountController});

  final TextEditingController amountController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        controller: amountController,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          suffixText: ' CZK',
          label: Text('Amount'),
        ),
      ),
    );
  }
}
