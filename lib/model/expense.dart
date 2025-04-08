import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

final DateFormat formatter = DateFormat.yMd();
const Uuid uuid = Uuid();

enum Category { food, travel, leisure, work }

const categoryIcons = {
  Category.food: Icons.dinner_dining,
  Category.travel: Icons.directions_car,
  Category.leisure: Icons.hiking,
  Category.work: Icons.work,
};

const categoryFormattedNames = {
  Category.food: 'Food',
  Category.travel: 'Travel',
  Category.leisure: 'Leisure',
  Category.work: 'Work',
};

class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime dateTime;
  final Category category;

  Expense({
    required this.title,
    required this.amount,
    required this.dateTime,
    required this.category,
  }) : id = uuid.v4();

  String get formattedDate => formatter.format(dateTime);
}
