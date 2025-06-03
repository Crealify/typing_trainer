import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:typing_trainer/presentation/providers/typing_providers.dart';
import 'package:typing_trainer/presentation/widgets/keyboard.dart';
import 'package:typing_trainer/presentation/widgets/stats_panel.dart';
import 'package:typing_trainer/presentation/widgets/typing_text.dart';

class TypingPage extends StatefulWidget {
  final String text;

  const TypingPage({super.key, required this.text});

  @override
  State<TypingPage> createState() => _TypingPageState();
}

class _TypingPageState extends State<TypingPage> {
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
      context.read<TypingProvider>().startSession(widget.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Typing Practice'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<TypingProvider>().startSession(widget.text);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const StatsPanel(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: TypingText(
                text: widget.text,
                userInput: context.watch<TypingProvider>().userInput,
                accuracy: context.watch<TypingProvider>().accuracy,
              ),
            ),
          ),
          const FullKeyboard(),
        ],
      ),
    );
  }
}
