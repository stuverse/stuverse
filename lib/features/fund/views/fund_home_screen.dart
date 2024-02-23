import 'package:flutter/material.dart';

import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:stuverse/app/common/core/widgets/MarkdownTextInput/markdown_text_input.dart';
import 'package:url_launcher/url_launcher.dart';

enum MenuItem {
  switchView,
  clear,
  save,
}

class FundHomeScreen extends StatelessWidget {
  const FundHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Fund"),
      ),
      body: Center(child: Text("Fund")),
    );
  }
}
