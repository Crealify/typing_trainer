import 'package:flutter/material.dart';

class TypingVisualizer extends StatelessWidget {
  final String text;
  final String userInput;
  final int currentIndex;

  const TypingVisualizer({
    super.key,
    required this.text,
    required this.userInput,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Current sentence progress
        LinearProgressIndicator(
          value: currentIndex / text.length,
        ),
        const SizedBox(height: 20),
        // Text display with cursor and accuracy
        _buildTextDisplay(),
        // Finger position guide
        _buildHandDiagram(),
      ],
    );
  }

  Widget _buildTextDisplay() {
    return RichText(
      text: TextSpan(
        style: const TextStyle(fontSize: 24),
        children: List.generate(text.length, (index) {
          if (index < userInput.length) {
            return TextSpan(
              text: text[index],
              style: TextStyle(
                color:
                    userInput[index] == text[index] ? Colors.green : Colors.red,
                backgroundColor: userInput[index] == text[index]
                    ? Colors.green.withOpacity(0.1)
                    : Colors.red.withOpacity(0.1),
              ),
            );
          } else if (index == currentIndex) {
            return TextSpan(
              text: text[index],
              style: const TextStyle(
                backgroundColor: Colors.blue,
                color: Colors.white,
              ),
            );
          }
          return TextSpan(
            text: text[index],
            style: TextStyle(
              color: Colors.grey[400],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildHandDiagram() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildFingerGuide('Left Hand', ['A', 'S', 'D', 'F']),
          _buildFingerGuide('Right Hand', ['J', 'K', 'L', ';']),
        ],
      ),
    );
  }

  Widget _buildFingerGuide(String hand, List<String> keys) {
    return Column(
      children: [
        Text(
          hand,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: keys
              .map((key) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Text(
                      key,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }
}
