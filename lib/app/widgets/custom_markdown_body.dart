import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomMarkdownBody extends StatelessWidget {
  final String inputText;
  const CustomMarkdownBody({super.key, required this.inputText});

  @override
  Widget build(BuildContext context) {
    return MarkdownBody(
      data: inputText,
      shrinkWrap: true,
      softLineBreak: true,
      imageBuilder: (imageUri, _, alternateText) {
        return Image.network(
          imageUri.toString(),
          errorBuilder: (_, __, ___) {
            return Text(alternateText ?? "");
          },
        );
      },
      styleSheet: MarkdownStyleSheet(
        blockquoteDecoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 5,
            ),
          ),
          color: Theme.of(context).colorScheme.primary.withAlpha(70),
        ),
        blockquotePadding: const EdgeInsets.all(8),
        blockquote: TextStyle(
          fontStyle: FontStyle.italic,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
      onTapLink: (i, j, k) {
        launchUrl(Uri.parse(j ?? ""));
      },
    );
  }
}
