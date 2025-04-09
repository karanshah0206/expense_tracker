import 'package:flutter/material.dart';

class NoDataFound extends StatelessWidget {
  final void Function() onTapAction;
  final ColorScheme colorScheme;

  const NoDataFound({
    required this.onTapAction,
    required this.colorScheme,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Container(
    alignment: Alignment.center,
    child: InkWell(
      onTap: onTapAction,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          spacing: 10,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_circle, size: 50, color: colorScheme.tertiary),
            Text(
              'Add an expense to get started!',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge!.copyWith(color: colorScheme.tertiary),
            ),
          ],
        ),
      ),
    ),
  );
}
