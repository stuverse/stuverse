import 'package:flutter/material.dart';

class QuoteLoadingIndicator extends StatelessWidget {
  const QuoteLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        const CircularProgressIndicator(),
        const SizedBox(height: 20),
        Text('Loading quotes...'),
      ],
    );
  }
}
