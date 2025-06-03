import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:typing_trainer/presentation/providers/typing_providers.dart';

class FullKeyboard extends StatelessWidget {
  const FullKeyboard({super.key});

  @override
  Widget build(BuildContext context) {
    final keyRows = [
      ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'],
      ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'],
      ['Z', 'X', 'C', 'V', 'B', 'N', 'M'],
      [' '], // Space bar
    ];

    return Container(
      padding: const EdgeInsets.all(10),
      color: Theme.of(context).colorScheme.surfaceVariant,
      child: Column(
        children: keyRows.map((row) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: row.map((key) {
              return KeyboardKey(
                keyChar: key,
                onTap: () {
                  final provider = context.read<TypingProvider>();
                  provider.handleInput(provider.userInput + key);
                },
                isSpace: key == ' ',
              );
            }).toList(),
          );
        }).toList(),
      ),
    );
  }
}

class KeyboardKey extends StatelessWidget {
  final String keyChar;
  final VoidCallback onTap;
  final bool isSpace;

  const KeyboardKey({
    super.key,
    required this.keyChar,
    required this.onTap,
    this.isSpace = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(2),
        padding: EdgeInsets.symmetric(
          horizontal: isSpace ? 40 : 12,
          vertical: 15,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Text(
          keyChar,
          style: TextStyle(
            fontSize: isSpace ? 14 : 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
