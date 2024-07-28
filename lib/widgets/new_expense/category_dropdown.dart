import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class CategoryDropdown extends StatefulWidget {
  const CategoryDropdown({
    super.key,
    required this.selectedCategory,
    required this.onSelectCategory,
  });

  final void Function(Category category) onSelectCategory;
  final Category selectedCategory;

  @override
  State<CategoryDropdown> createState() {
    return _CategoryDropdownState();
  }
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: widget.selectedCategory,
      items: Category.values
          .map(
            (category) => DropdownMenuItem(
              value: category,
              child: Text(
                category.name.toUpperCase(),
              ),
            ),
          )
          .toList(),
      onChanged: (value) {
        if (value == null) {
          return;
        }

        widget.onSelectCategory(value);
      },
    );
  }
}
