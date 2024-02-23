import 'package:flutter/material.dart';

import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:stuverse/app/app.dart';

import 'package:url_launcher/url_launcher.dart';

import '../widgets/MarkdownTextInput/markdown_text_input.dart';

enum MenuItem {
  switchView,
  clear,
  save,
}

class MarkDownScreenProps {
  final Function(String) onSaved;
  final String? initialText;

  MarkDownScreenProps({required this.onSaved, this.initialText});
}

class MarkDownScreen extends StatefulWidget {
  const MarkDownScreen({super.key, required this.props});
  final MarkDownScreenProps props;

  @override
  State<MarkDownScreen> createState() => _MarkDownScreenState();
}

class _MarkDownScreenState extends State<MarkDownScreen>
    with WidgetsBindingObserver {
  final TextEditingController _inputTextEditingController =
      TextEditingController();

  String inputText = '';
  bool isVerticalView = true;
  bool isPreview = false;

  @override
  void initState() {
    super.initState();
    if (widget.props.initialText != null) {
      inputText = widget.props.initialText!;
      _inputTextEditingController.text = widget.props.initialText!;
    }
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _inputTextEditingController.dispose();
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  void switchView() {
    setState(() {
      isVerticalView = !isVerticalView;
    });
  }

  void switchPreview() {
    setState(() {
      isPreview = !isPreview;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Editor"),
        actions: [
          IconButton(
            onPressed: isVerticalView ? null : switchPreview,
            tooltip: "Preview",
            icon: Icon(isPreview ? Icons.visibility_off : Icons.visibility),
          ),
          IconButton(
            onPressed: switchView,
            tooltip: "Switch View",
            icon: Icon(Icons.rotate_left),
          ),
          IconButton(
            onPressed: clearText,
            tooltip: "Clear",
            icon: Icon(Icons.clear_all),
          ),
          IconButton(
            onPressed: () => widget.props.onSaved(inputText),
            tooltip: "Save",
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Center(
        child: (isVerticalView) ? verticalView() : hiddenView(),
      ),
    );
  }

  void clearText() async {
    if (inputText.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("There is no text to clear")));
      return;
    }
    FocusScope.of(context).unfocus();
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Clear All"),
        content: Text("Are you sure you want to clear all the text?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                inputText = "";
              });
              _inputTextEditingController.clear();
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text("Yes"),
          ),
        ],
      ),
    );
  }

  Widget markdownPreviewWidget() {
    return Card(
      child: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Scrollbar(
          interactive: true,
          radius: const Radius.circular(8),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(8),
            child: CustomMarkdownBody(
              inputText: inputText,
            ),
          ),
        ),
      ),
    );
  }

  Widget verticalView() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 0, 4, 5),
      child: Column(
        children: [
          Expanded(
            child: markdownPreviewWidget(),
          ),
          const SizedBox(height: 5),
          MarkdownTextInput(
            (String value) => setState(() => inputText = value),
            inputText,
            controller: _inputTextEditingController,
            maxLines: 8,
            isFullPreview: false,
            label: "Type your markdown here",
          ),
        ],
      ),
    );
  }

  Widget hiddenView() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(milliseconds: 300),
        child: (isPreview)
            ? markdownPreviewWidget()
            : MarkdownTextInput(
                (String value) => setState(() => inputText = value),
                inputText,
                controller: _inputTextEditingController,
                isFullPreview: true,
                label: "",
              ),
      ),
    );
  }
}
