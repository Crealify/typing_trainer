import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:typing_trainer/presentation/providers/typing_providers.dart';

class VirtualKeyboard extends StatelessWidget {
  const VirtualKeyboard({super.key});

  @override
  Widget build(BuildContext context) {
    final qwertyLayout = [
      ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'],
      ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'],
      ['Z', 'X', 'C', 'V', 'B', 'N', 'M'],
      [' '], // Space bar
    ];

    return Column(
      children: qwertyLayout.map((row) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: row.map((key) {
              return KeyboardKey(
                keyChar: key,
                onTap: () => context.read<TypingProvider>().handleInput(
                  context.read<TypingProvider>().userInput + key,
                ),
                isSpace: key == ' ',
              );
            }).toList(),
          ),
        );
      }).toList(),
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
        margin: const EdgeInsets.symmetric(horizontal: 2),
        padding: EdgeInsets.symmetric(
          horizontal: isSpace ? 40 : 8,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(4),
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
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}