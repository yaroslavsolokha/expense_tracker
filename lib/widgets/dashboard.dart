import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/cupertino.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({
    super.key,
    required this.width,
    required this.reqisteredExpenses,
    required this.mainContent,
  });

  final double width;
  final List<Expense> reqisteredExpenses;
  final Widget mainContent;

  @override
  Widget build(BuildContext context) {
    return width < 600
        ? Column(
            children: [
              Expanded(child: Chart(expenses: reqisteredExpenses)),
              Expanded(child: mainContent),
            ],
          )
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Chart(expenses: reqisteredExpenses)),
              Expanded(child: mainContent),
            ],
          );
  }
}
