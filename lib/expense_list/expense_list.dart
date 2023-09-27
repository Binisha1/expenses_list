import 'package:flutter/material.dart';
import 'package:pexpense_tracker/expense_list/expense_item.dart';
import 'package:pexpense_tracker/modal/expense.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList(
      {super.key, required this.expenses, required this.onremove});
  final List<Expense> expenses;
  final Function(Expense) onremove;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) => ExpenseItem(
        expense: expenses[index],
        onremove: onremove,
      ),
    );
  }
}
