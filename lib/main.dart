import 'package:expense_tracker/widgets/add_expense.dart';
import 'package:expense_tracker/widgets/expense_list.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/model/expense.dart';

void main() {
  runApp(const MaterialApp(home: ExpenseTrackerApp()));
}

class ExpenseTrackerApp extends StatefulWidget {
  const ExpenseTrackerApp({super.key});

  @override
  State<ExpenseTrackerApp> createState() {
    return _ExpenseTrackerAppState();
  }
}

class _ExpenseTrackerAppState extends State<ExpenseTrackerApp> {
  final List<Expense> _expenses = [
    Expense(
      title: 'Porsche Taycan Turbo S',
      amount: 400000.01,
      dateTime: DateTime.now(),
      category: Category.travel,
    ),
    Expense(
      title: 'Vietnamese Iced Coffee',
      amount: 4.2,
      dateTime: DateTime.now(),
      category: Category.food,
    ),
    Expense(
      title: 'Fitness equipment for mom',
      amount: 108.12,
      dateTime: DateTime.now(),
      category: Category.leisure,
    ),
    Expense(
      title: 'Office rent payment',
      amount: 2477,
      dateTime: DateTime.now(),
      category: Category.work,
    ),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Expense Tracker'),
      actions: [
        IconButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) => const AddExpense(),
            );
          },
          icon: const Icon(Icons.add),
        ),
      ],
    ),
    body: ExpenseList(_expenses),
  );
}
