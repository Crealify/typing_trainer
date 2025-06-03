import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final ScrollController _scrollController = ScrollController();

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
    final provider = context.watch<TypingProvider>();

    // Auto-scroll to keep cursor visible
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeOut,
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Typing Practice'),
        centerTitle: true,
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
              provider
                  .handleInput(provider.userInput + event.logicalKey.keyLabel);
            }
          }
        },
        child: Column(
          children: [
            const StatsPanel(),
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                padding: const EdgeInsets.all(20),
                child: TypingText(
                  text: widget.text,
                  userInput: provider.userInput,
                  currentIndex: provider.currentIndex,
                ),
              ),
            ),
            const FullKeyboard(),
          ],
        ),
      ),
    );
  }
}
