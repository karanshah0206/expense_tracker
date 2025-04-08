import 'package:expense_tracker/widgets/expense_list_item.dart';
import 'package:expense_tracker/model/expense.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  final void Function(Expense) onRemoveExpense;
  final List<Expense> expenses;

  const ExpenseList({
    required this.expenses,
    required this.onRemoveExpense,
    super.key,
  });

  @override
  Widget build(BuildContext context) => ListView.builder(
    itemCount: expenses.length,
    itemBuilder:
        (BuildContext context, int index) => Dismissible(
          key: ValueKey(expenses[index]),
          onDismissed: (DismissDirection dismissDirection) {
            onRemoveExpense(expenses[index]);
          },
          background: Container(
            color: Colors.red,
            child: const Row(
              children: [
                SizedBox(width: 16),
                Icon(Icons.delete_forever, color: Colors.white),
                Spacer(),
                Icon(Icons.delete_forever, color: Colors.white),
                SizedBox(width: 16),
              ],
            ),
          ),
          child: ExpenseListItem(expenses[index]),
        ),
  );
}
