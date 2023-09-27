import 'package:pexpense_tracker/modal/expense.dart';
import 'package:flutter/material.dart';

class NewExpenses extends StatefulWidget {
  const NewExpenses({super.key, required this.addExpense});
  final void Function(Expense) addExpense;

  @override
  State<NewExpenses> createState() => _NewExpensesState();
}

class _NewExpensesState extends State<NewExpenses> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? pickedDate;
  Category? selectedcategory;
  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _pickDate() async {
    final date = DateTime.now();
    final firstDate = DateTime(date.year - 1, date.month, date.day);

    final selectedDate = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: firstDate,
      lastDate: date,
    );
    setState(() {
      pickedDate = selectedDate;
    });
  }

  void onSubmit() {
    if (_titleController.text.isEmpty ||
        _amountController.text.isEmpty ||
        pickedDate == null ||
        selectedcategory == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'You should enter data',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 20),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'okay',
                  ))
            ],
          );
        },
      );
    } else {
      widget.addExpense(Expense(
          title: _titleController.text,
          amount: double.tryParse(_amountController.text.toString())!,
          date: pickedDate!,
          category: selectedcategory!));

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefix: Text('\$ '),
                    label: Text('Amount'),
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      pickedDate == null
                          ? 'no selected date'
                          : formatter.format(pickedDate!),
                    ),
                    IconButton(
                      onPressed: _pickDate,
                      icon: const Icon(Icons.calendar_month),
                    )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              DropdownButton(
                value: selectedcategory,
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
                  setState(() {
                    selectedcategory = value;
                  });
                },
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: onSubmit,
                child: const Text('Submit'),
              )
            ],
          )
        ],
      ),
    );
  }
}
