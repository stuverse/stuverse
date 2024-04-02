import 'package:flutter/material.dart';
import 'package:stuverse/app/utils/extentions/app_extensions.dart';

class QuoteLoadingIndicator extends StatefulWidget {
  const QuoteLoadingIndicator({super.key, this.showIndicator = true});
  final bool showIndicator;

  @override
  State<QuoteLoadingIndicator> createState() => _QuoteLoadingIndicatorState();
}

class _QuoteLoadingIndicatorState extends State<QuoteLoadingIndicator> {
  List<Quote> motivationalQuotes = [
    Quote(
        text:
            "The only way to do great work is to love what you do. If you haven't found it yet, keep looking. Don't settle.",
        author: "Steve Jobs"),
    Quote(
        text:
            "Success is not final, failure is not fatal: It is the courage to continue that counts.",
        author: "Winston Churchill"),
    Quote(
        text: "Believe you can and you're halfway there.",
        author: "Theodore Roosevelt"),
    Quote(
        text:
            "The future belongs to those who believe in the beauty of their dreams.",
        author: "Eleanor Roosevelt"),
    Quote(
        text: "Don't watch the clock; do what it does. Keep going.",
        author: "Sam Levenson"),
  ];

  @override
  Widget build(BuildContext context) {
    final random =
        DateTime.now().microsecondsSinceEpoch % motivationalQuotes.length;
    final randomMotivationalQuote = motivationalQuotes[random];
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          Text(
            "\" " + randomMotivationalQuote.text + " \"",
            style: const TextStyle(fontSize: 20),
          ),
          Text(
            "- " + randomMotivationalQuote.author,
            textAlign: TextAlign.end,
            style: TextStyle(
                fontSize: 13,
                color: context.colorScheme.onBackground.withOpacity(0.5)),
          ),
          const SizedBox(height: 10),
          if (widget.showIndicator)
            Text(
              "Loading...",
              style: TextStyle(
                  fontSize: 13,
                  color: context.colorScheme.onBackground.withOpacity(0.5)),
            ),
          const SizedBox(height: 10),
          if (widget.showIndicator) const LinearProgressIndicator(),
        ].defaultListAnimation(),
      ),
    );
  }
}

class Quote {
  String text;
  String author;

  Quote({required this.text, required this.author});
}
