import 'package:flutter/material.dart';
import 'package:pexpense_tracker/modal/expense.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({super.key, required this.expense, required this.onremove});
  final Expense expense;
  final Function(Expense) onremove;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Container(
        color: ThemeData().colorScheme.error.withOpacity(0.3),
        margin: const EdgeInsets.all(10),
      ),
      key: ValueKey(expense.id),
      onDismissed: (direction) {
        onremove(expense);
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(expense.title, style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: 15),
              Row(
                children: [
                  Text('\$${expense.amount.toStringAsFixed(2)}'),
                  const Spacer(),
                  Text(formatter.format(expense.date))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
