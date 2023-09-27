import 'package:flutter/material.dart';
import 'package:pexpense_tracker/expense_list/expense_list.dart';
import 'package:pexpense_tracker/modal/expense.dart';
import 'package:pexpense_tracker/new_expenses.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  List<Expense> registeredExpense = [
    Expense(
        title: 'flutter course',
        amount: 45,
        date: DateTime.now(),
        category: Category.work),
  ];
  void addExpense(Expense expense) {
    setState(() {
      registeredExpense.add(expense);
    });
  }

  void removeExpense(Expense expense) {
    int i = registeredExpense.indexOf(expense);
    setState(() {
      registeredExpense.remove(expense);
    });
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('You removed an item'),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () => setState(() {
                  registeredExpense.insert(i, expense);
                })),
      ),
    );
  }

  void _modalBottomSheet() {
    showModalBottomSheet(
        isScrollControlled: true,
        useSafeArea: true,
        context: context,
        builder: (ctx) {
          return NewExpenses(
            addExpense: addExpense,
          );
        });
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Expense Tracker'),
          actions: [
            IconButton(
                onPressed: _modalBottomSheet, icon: const Icon(Icons.add))
          ],
        ),
        body: registeredExpense.isEmpty
            ? const Center(child: Text("You don't have any item. Start adding"))
            : ExpenseList(
                expenses: registeredExpense,
                onremove: removeExpense,
              ));
  }
}
