import 'package:flutter/material.dart';
import 'package:typing_trainer/presentation/pages/typing_page.dart';

class HomePage extends StatelessWidget {
  final List<String> sampleTexts = [
    "The quick brown fox jumps over the lazy dog",
    "Flutter is Google's UI toolkit for building beautiful applications",
    "Practice typing to improve your speed and accuracy",
    "The five boxing wizards jump quickly",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Typing Trainer'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.1),
              Theme.of(context).colorScheme.secondary.withOpacity(0.1),
            ],
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: sampleTexts.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                title: Text(
                  sampleTexts[index],
                  style: const TextStyle(fontSize: 16),
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TypingPage(text: sampleTexts[index]),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
