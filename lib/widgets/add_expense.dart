import 'package:flutter/material.dart';
import 'package:expense_tracker/model/expense.dart';

class AddExpense extends StatefulWidget {
  final void Function(Expense) onAddExpense;

  const AddExpense({required this.onAddExpense, super.key});

  @override
  State<AddExpense> createState() {
    return _AddExpenseState();
  }
}

class _AddExpenseState extends State<AddExpense> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  Category _selectedCategory = Category.food;
  bool _titleHasError = false;
  bool _amountHasError = false;

  void _validateTitleInput() {
    setState(() {
      _titleHasError = false;
    });

    if (_titleController.text.isEmpty) {
      setState(() {
        _titleHasError = true;
      });
    }
  }

  void _validateAmountInput() {
    setState(() {
      _amountHasError = false;
    });

    if (double.tryParse(_amountController.text) == null) {
      setState(() {
        _amountHasError = true;
      });
    }
  }

  void _addExpense() {
    _titleController.text = _titleController.text.trim();
    _amountController.text = _amountController.text.trim();

    _validateTitleInput();
    _validateAmountInput();

    if (!_amountHasError && !_titleHasError) {
      widget.onAddExpense(
        Expense(
          title: _titleController.text,
          amount: double.parse(_amountController.text),
          dateTime: _selectedDate,
          category: _selectedCategory,
        ),
      );
      Navigator.pop(context);
    }
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      firstDate: DateTime(1800),
      lastDate: DateTime.now(),
      initialDate: _selectedDate,
    ).then((selectedDate) {
      if (selectedDate != null) {
        setState(() {
          _selectedDate = selectedDate;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            onChanged: (_) {
              _validateTitleInput();
            },
            decoration: InputDecoration(
              label: const Text('Expense title'),
              errorText:
                  _titleHasError ? 'Expense title cannot be empty.' : null,
            ),
          ),
          TextField(
            controller: _amountController,
            onChanged: (_) {
              _validateAmountInput();
            },
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              prefixText: '\$',
              label: const Text('Amount'),
              errorText:
                  _amountHasError ? 'Valid numeric amount is rqeuired.' : null,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              DropdownButton(
                value: _selectedCategory,
                items:
                    Category.values
                        .map(
                          (category) => DropdownMenuItem(
                            value: category,
                            child: Text(categoryFormattedNames[category]!),
                          ),
                        )
                        .toList(),
                onChanged: (selectedCategory) {
                  if (selectedCategory != null) {
                    setState(() {
                      _selectedCategory = selectedCategory;
                    });
                  }
                },
              ),
              const SizedBox(width: 16),
              TextButton.icon(
                onPressed: _showDatePicker,
                icon: const Icon(Icons.calendar_month),
                label: Text(formatter.format(_selectedDate)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: _addExpense,
                child: const Text('Add Expense'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }
}
