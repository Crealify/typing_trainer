import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:typing_trainer/presentation/providers/typing_providers.dart';
import 'package:typing_trainer/presentation/widgets/keyboard.dart';
import 'package:typing_trainer/presentation/widgets/stats_panel.dart';
import 'package:typing_trainer/presentation/widgets/typing_text.dart';

class TypingPage extends StatefulWidget {
  const TypingPage({super.key});

  @override
  State<TypingPage> createState() => _TypingPageState();
}

class _TypingPageState extends State<TypingPage> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TypingProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Typing Practice'),
        actions: [
          IconButton(
            icon: Icon(
              provider.themeMode == ThemeMode.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: () =>
                provider.toggleTheme(provider.themeMode != ThemeMode.dark),
          ),
        ],
      ),
      body: RawKeyboardListener(
        focusNode: _focusNode,
        onKey: (event) {
          if (event is RawKeyDownEvent) {
            if (event.logicalKey == LogicalKeyboardKey.backspace) {
              provider.handleInput(
                provider.userInput.substring(0, provider.userInput.length - 1),
              );
            } else if (event.logicalKey.keyLabel.length == 1) {
              provider.handleInput(
                provider.userInput + event.logicalKey.keyLabel,
              );
            }
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const StatsPanel(),
              const SizedBox(height: 20),
              Expanded(
                child: TypingText(
                  text: provider.currentText,
                  userInput: provider.userInput,
                  accuracy: provider.accuracy,
                ),
              ),
              const SizedBox(height: 20),
              const VirtualKeyboard(),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  provider.endSession();
                  Navigator.pop(context);
                },
                child: const Text('Finish Session'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
