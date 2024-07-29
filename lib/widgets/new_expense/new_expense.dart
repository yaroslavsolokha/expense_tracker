import 'dart:io';
import 'package:expense_tracker/widgets/new_expense/action_buttons.dart';
import 'package:expense_tracker/widgets/new_expense/amount_field.dart';
import 'package:expense_tracker/widgets/new_expense/category_dropdown.dart';
import 'package:expense_tracker/widgets/new_expense/date_picker.dart';
import 'package:expense_tracker/widgets/new_expense/title_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _changeCategory(Category category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _showDialog() {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: const Text('Invalid input'),
          content: const Text(
              'Please make sure a valid title, amount, date and category was entered.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid input'),
          content: const Text(
              'Please make sure a valid title, amount, date and category was entered.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
    }
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;

    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      _showDialog();
      return;
    }

    widget.onAddExpense(
      Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory,
      ),
    );

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        final width = constraints.maxWidth;

        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          child: Column(
            children: [
              if (width >= 600)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TitleField(titleController: _titleController),
                    ),
                    const SizedBox(width: 24),
                    AmountField(amountController: _amountController),
                  ],
                )
              else
                TitleField(titleController: _titleController),
              if (width >= 600)
                Row(
                  children: [
                    CategoryDropdown(
                      selectedCategory: _selectedCategory,
                      onSelectCategory: _changeCategory,
                    ),
                    const SizedBox(width: 24),
                    DatePicker(
                      selectedDate: _selectedDate,
                      onPresentDatePicker: _presentDatePicker,
                    ),
                  ],
                )
              else
                Row(
                  children: [
                    AmountField(amountController: _amountController),
                    const SizedBox(width: 16),
                    DatePicker(
                      selectedDate: _selectedDate,
                      onPresentDatePicker: _presentDatePicker,
                    ),
                  ],
                ),
              const SizedBox(height: 16),
              if (width >= 600)
                Row(
                  children: [
                    const Spacer(),
                    ActionButtons(submitExpenseData: _submitExpenseData),
                  ],
                )
              else
                Row(
                  children: [
                    CategoryDropdown(
                      selectedCategory: _selectedCategory,
                      onSelectCategory: _changeCategory,
                    ),
                    const Spacer(),
                    ActionButtons(submitExpenseData: _submitExpenseData),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }
}
