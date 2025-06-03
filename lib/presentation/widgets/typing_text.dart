import 'package:flutter/material.dart';

class TypingText extends StatelessWidget {
  final String text;
  final String userInput;
  final int currentIndex;

  const TypingText({
    super.key,
    required this.text,
    required this.userInput,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: 24,
              height: 1.5,
            ),
        children: List.generate(text.length, (index) {
          Color color;
          TextStyle? style;

          if (index < userInput.length) {
            color = userInput[index] == text[index] ? Colors.green : Colors.red;
            style = TextStyle(color: color);
          } else if (index == currentIndex) {
            // Cursor position
            return TextSpan(
              text: text[index],
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                backgroundColor:
                    Theme.of(context).colorScheme.primary.withOpacity(0.2),
              ),
            );
          } else {
            color = Theme.of(context).textTheme.bodyLarge!.color!;
            style = TextStyle(color: color.withOpacity(0.5));
          }

          return TextSpan(
            text: text[index],
            style: style,
          );
        }),
      ),
    );
  }
}
