import 'package:expense_tracker/model/expense.dart';
import 'package:flutter/material.dart';

class ExpenseListItem extends StatelessWidget {
  final void Function(Expense) onDismiss;
  final Expense expense;

  const ExpenseListItem({
    required this.expense,
    required this.onDismiss,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Dismissible(
    key: ValueKey(expense),
    onDismissed: (DismissDirection dismissDirection) {
      onDismiss(expense);
    },
    background: Container(
      color: Theme.of(context).colorScheme.error,
      child: Row(
        children: [
          SizedBox(width: 16),
          Icon(
            Icons.delete_forever,
            color: Theme.of(context).colorScheme.onError,
          ),
          Spacer(),
          Icon(
            Icons.delete_forever,
            color: Theme.of(context).colorScheme.onError,
          ),
          SizedBox(width: 16),
        ],
      ),
    ),
    child: Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(expense.title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            Row(
              children: [
                Text('\$${expense.amount.toStringAsFixed(2)}'),
                const Spacer(),
                Row(
                  children: [
                    Icon(categoryIcons[expense.category]),
                    const SizedBox(width: 8),
                    Text(expense.formattedDate),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
