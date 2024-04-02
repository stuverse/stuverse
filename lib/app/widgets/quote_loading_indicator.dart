import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:stuverse/app/app.dart';
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
    Quote(
        text:
            "Your time is limited, don't waste it living someone else's life.",
        author: "Steve Jobs"),
    Quote(
        text:
            "The only limit to our realization of tomorrow will be our doubts of today.",
        author: "Franklin D. Roosevelt"),
    Quote(
        text:
            "It does not matter how slowly you go as long as you do not stop.",
        author: "Confucius"),
    Quote(
        text:
            "The road to success and the road to failure are almost exactly the same.",
        author: "Colin R. Davis"),
    Quote(
        text: "I find that the harder I work, the more luck I seem to have.",
        author: "Thomas Jefferson"),
    Quote(
        text:
            "Success is stumbling from failure to failure with no loss of enthusiasm.",
        author: "Winston Churchill"),
    Quote(
        text:
            "Don't be pushed around by the fears in your mind. Be led by the dreams in your heart.",
        author: "Roy T. Bennett"),
    Quote(
        text:
            "The only way to achieve the impossible is to believe it is possible.",
        author: "Charles Kingsleigh"),
    Quote(
        text:
            "Success is not the key to happiness. Happiness is the key to success. If you love what you are doing, you will be successful.",
        author: "Albert Schweitzer"),
    Quote(
        text:
            "The biggest risk is not taking any risk. In a world that is changing really quickly, the only strategy that is guaranteed to fail is not taking risks.",
        author: "Mark Zuckerberg"),
    Quote(
        text:
            "The only person you should try to be better than is the person you were yesterday.",
        author: "Unknown"),
    Quote(
        text:
            "Believe in yourself and all that you are. Know that there is something inside you that is greater than any obstacle.",
        author: "Christian D. Larson"),
    Quote(
        text:
            "It's not about how bad you want it. It's about how hard you're willing to work for it.",
        author: "Unknown"),
    Quote(
        text:
            "The only limit to our realization of tomorrow will be our doubts of today.",
        author: "Franklin D. Roosevelt"),
    Quote(
        text:
            "The only way to achieve the impossible is to believe it is possible.",
        author: "Charles Kingsleigh"),
    Quote(
        text:
            "Success is not the key to happiness. Happiness is the key to success. If you love what you are doing, you will be successful.",
        author: "Albert Schweitzer"),
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
          const SizedBox(height: 10),
          if (widget.showIndicator)
            LottieBuilder.asset(
              AppImages.loadingPlaneLottie,
              height: context.height * 0.2,
            ),
          if (widget.showIndicator)
            Text(
              "Loading...",
              style: TextStyle(
                  fontSize: 13,
                  color: context.colorScheme.onBackground.withOpacity(0.5)),
            ),
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
