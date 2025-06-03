import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:typing_trainer/presentation/pages/typing_page.dart';
import 'package:typing_trainer/presentation/providers/typing_providers.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final sampleTexts = [
      "The quick brown fox jumps over the lazy dog",
      "Flutter is Google's UI toolkit for building beautiful applications",
      "Practice typing to improve your speed and accuracy",
      "The five boxing wizards jump quickly",
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Typing Trainer')),
      body: ListView.builder(
        itemCount: sampleTexts.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(sampleTexts[index]),
            onTap: () {
              context.read<TypingProvider>().startSession(sampleTexts[index]);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const TypingPage()),
              );
            },
          );
        },
      ),
    );
  }
}
