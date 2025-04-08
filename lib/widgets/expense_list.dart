import 'package:expense_tracker/widgets/expense_list_item.dart';
import 'package:expense_tracker/model/expense.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  final List<Expense> expenses;

  const ExpenseList(this.expenses, {super.key});

  @override
  Widget build(BuildContext context) => ListView.builder(
    itemCount: expenses.length,
    itemBuilder:
        (BuildContext context, int index) => ExpenseListItem(expenses[index]),
  );
}
