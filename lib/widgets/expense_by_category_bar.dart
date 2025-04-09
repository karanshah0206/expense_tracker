import 'package:flutter/material.dart';

class ExpenseByCategoryBar extends StatelessWidget {
  final double barSize, ceilingSize;
  final Color color;

  const ExpenseByCategoryBar({
    required this.barSize,
    required this.ceilingSize,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: FractionallySizedBox(
          heightFactor: barSize / ceilingSize,
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(8),
              ),
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}
