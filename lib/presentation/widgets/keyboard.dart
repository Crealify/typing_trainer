import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:typing_trainer/presentation/providers/typing_providers.dart';

class FullKeyboard extends StatefulWidget {
  const FullKeyboard({super.key});

  @override
  State<FullKeyboard> createState() => _FullKeyboardState();
}

class _FullKeyboardState extends State<FullKeyboard> {
  final keyRows = [
    ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'],
    ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'],
    ['Z', 'X', 'C', 'V', 'B', 'N', 'M'],
    [' '], // Space bar
  ];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TypingProvider>(context, listen: false);

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

class KeyboardKey extends StatefulWidget {
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
  State<KeyboardKey> createState() => _KeyboardKeyState();
}

class _KeyboardKeyState extends State<KeyboardKey> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: () {
        widget.onTap();
        setState(() => _isPressed = false);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 50),
        margin: const EdgeInsets.all(2),
        padding: EdgeInsets.symmetric(
          horizontal: widget.isSpace ? 40 : 12,
          vertical: 15,
        ),
        decoration: BoxDecoration(
          color: _isPressed
              ? Theme.of(context).colorScheme.primary.withOpacity(0.2)
              : Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(5),
          boxShadow: _isPressed
              ? []
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
          border: Border.all(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
          ),
        ),
        child: Text(
          widget.keyChar,
          style: TextStyle(
            fontSize: widget.isSpace ? 14 : 18,
            fontWeight: FontWeight.bold,
            color: _isPressed
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
