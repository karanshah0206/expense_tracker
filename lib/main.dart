import 'package:expense_tracker/widgets/add_expense.dart';
import 'package:expense_tracker/widgets/expense_by_category_chart.dart';
import 'package:expense_tracker/widgets/expense_list_item.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/model/expense.dart';

final ColorScheme kLightColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 139, 195, 74),
);
final ColorScheme kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 139, 195, 74),
);

void main() {
  runApp(
    MaterialApp(
      home: const ExpenseTrackerApp(),
      theme: ThemeData.light().copyWith(
        colorScheme: kLightColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          foregroundColor: kLightColorScheme.primary,
          centerTitle: true,
          backgroundColor: ThemeData.light().scaffoldBackgroundColor,
        ),
        cardTheme: const CardTheme().copyWith(
          color: kLightColorScheme.inversePrimary,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kLightColorScheme.secondaryContainer,
          ),
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDarkColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          foregroundColor: kDarkColorScheme.primary,
          centerTitle: true,
          backgroundColor: ThemeData.dark().scaffoldBackgroundColor,
        ),
        cardTheme: const CardTheme().copyWith(
          color: kDarkColorScheme.inversePrimary,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkColorScheme.secondaryContainer,
          ),
        ),
      ),
    ),
  );
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

  void _addExpense(Expense expense) {
    setState(() {
      _expenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _expenses.indexOf(expense);

    setState(() {
      _expenses.remove(expense);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense deleted.'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _expenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Expense Tracker'),
      actions: [
        IconButton(
          onPressed: () {
            showModalBottomSheet(
              showDragHandle: true,
              isScrollControlled: true,
              useSafeArea: true,
              context: context,
              builder:
                  (BuildContext context) =>
                      AddExpense(onAddExpense: _addExpense),
            );
          },
          icon: const Icon(Icons.add),
        ),
      ],
    ),
    body: ListView.builder(
      itemCount: _expenses.length + 1,
      itemBuilder:
          (BuildContext context, int index) =>
              index == 0
                  ? ExpenseByCategoryChart(
                    expenses: _expenses,
                    colorScheme:
                        MediaQuery.of(context).platformBrightness ==
                                Brightness.dark
                            ? kDarkColorScheme
                            : kLightColorScheme,
                  )
                  : ExpenseListItem(
                    expense: _expenses[index - 1],
                    onDismiss: _removeExpense,
                  ),
    ),
  );
}
