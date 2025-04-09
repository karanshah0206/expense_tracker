import 'package:flutter/material.dart';
import 'package:expense_tracker/model/expense.dart';
import 'package:expense_tracker/widgets/expense_by_category_bar.dart';

class ExpenseByCategoryChart extends StatelessWidget {
  final Map<Category, double> _buckets;
  final ColorScheme colorScheme;

  ExpenseByCategoryChart({
    super.key,
    required List<Expense> expenses,
    required this.colorScheme,
  }) : _buckets = {
         for (Category category in Category.values)
           category: expenses
               .where((expense) => expense.category == category)
               .fold(0.0, (sum, expense) => sum + expense.amount),
       };

  double get _maxNetExpense {
    double result = 0;
    for (double netExpense in _buckets.values) {
      if (netExpense > result) {
        result = netExpense;
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.all(16),
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
    height: 200,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      gradient: LinearGradient(
        colors: [
          colorScheme.inversePrimary.withAlpha(200),
          colorScheme.inversePrimary.withAlpha(0),
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      ),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (Category category in Category.values)
                Expanded(
                  child: ExpenseByCategoryBar(
                    barSize: _buckets[category]!,
                    ceilingSize: _maxNetExpense,
                    color: colorScheme.primary,
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children:
              _buckets.keys
                  .map(
                    (Category category) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Icon(
                          categoryIcons[category],
                          color: colorScheme.primary,
                        ),
                      ),
                    ),
                  )
                  .toList(),
        ),
      ],
    ),
  );
}
