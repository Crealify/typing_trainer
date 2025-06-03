import 'package:flutter/material.dart';

class TypingText extends StatelessWidget {
  final String text;
  final String userInput;
  final List<bool> accuracy;

  const TypingText({
    super.key,
    required this.text,
    required this.userInput,
    required this.accuracy,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Wrap(
        children: List.generate(text.length, (index) {
          Color color;
          BoxDecoration? decoration;

          if (index < userInput.length) {
            color = accuracy[index] ? Colors.green : Colors.red;
          } else if (index == userInput.length) {
            color = Theme.of(context).colorScheme.primary;
            decoration = BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(2),
            );
          } else {
            color = Theme.of(context).textTheme.bodyLarge!.color!;
          }

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 1),
            decoration: decoration,
            child: Text(
              text[index],
              style: TextStyle(
                color: color,
                fontSize: 24,
                fontWeight: index == userInput.length
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
          );
        }),
      ),
    );
  }
}
