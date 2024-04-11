import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:stuverse/app/app.dart';

import 'package:url_launcher/url_launcher.dart';

import '../widgets/MarkdownTextInput/markdown_text_input.dart';

enum MenuItem {
  clear,
  guide,
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
  late final ConfettiController _confettiController;

  String inputText = '';
  bool isVerticalView = true;
  bool isPreview = false;

  @override
  void initState() {
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 1));
    super.initState();
    if (widget.props.initialText != null) {
      inputText = widget.props.initialText!;
      _inputTextEditingController.text = widget.props.initialText!;
    }
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _confettiController.dispose();
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
            onPressed: () => widget.props.onSaved(inputText),
            tooltip: "Save",
            icon: Icon(Icons.save),
          ),
          PopupMenuButton<MenuItem>(
            onSelected: (selectedMenuItem) {
              switch (selectedMenuItem) {
                case MenuItem.clear:
                  clearText();
                  break;
                case MenuItem.guide:
                  launchUrl(Uri.parse(
                      "https://youtube.com/shorts/4z0l5Kl2Q6E?si=ZMEp6IiU1GAoDSeY"));
                  break;
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: MenuItem.guide,
                child: Row(
                  children: [
                    const Icon(Icons.help),
                    const SizedBox(width: 8),
                    Text("Learn Markdown"),
                  ],
                ),
              ),
              PopupMenuItem(
                value: MenuItem.clear,
                child: Row(
                  children: [
                    const Icon(Icons.clear_all),
                    const SizedBox(width: 8),
                    Text("Clear"),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: ConfettiWidget(
        confettiController: _confettiController,
        blastDirectionality: BlastDirectionality.explosive,
        particleDrag: 0.05,
        emissionFrequency: 0.05,
        numberOfParticles: 50,
        gravity: 0.05,
        colors: const [
          Colors.green,
          Colors.blue,
          Colors.pink,
          Colors.orange,
          Colors.purple
        ], // manually specify the colors to be used
        child: BlocConsumer<AICubit, AIState>(
          listener: (context, state) {
            if (state is AIError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
            if (state is AISuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Generated Markdown"),
                ),
              );
              inputText = state.markdown;
              _inputTextEditingController.text = state.markdown;
              _confettiController.play();
            }
          },
          builder: (context, state) {
            return IgnorePointer(
              ignoring: state is AILoading,
              child: SafeArea(
                child: Stack(
                  children: [
                    Center(
                      child: (isVerticalView) ? verticalView() : hiddenView(),
                    ),
                    // if (!isVerticalView)
                    //   Positioned(
                    //     bottom: 20,
                    //     right: 20,
                    //     child: FloatingActionButton(
                    //       onPressed: switchPreview,
                    //       tooltip: isPreview ? "Show Editor" : "Show Preview",
                    //       child: Icon(
                    //           isPreview ? Icons.visibility_off : Icons.visibility),
                    //     ),
                    //   ),

                    Positioned(
                      bottom: 20,
                      right: 20,
                      child: FloatingActionButton(
                        onPressed: () async {
                          await showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Row(
                                children: [
                                  Icon(Icons.auto_awesome,
                                      color: context.colorScheme.secondary),
                                  const SizedBox(width: 8),
                                  Text("AI Generate"),
                                ],
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                      "Here is our new feature to generate markdown using AI."),
                                  const SizedBox(height: 8),
                                  Text(
                                      "This will generate markdown from the text you have written."),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text("Cancel"),
                                ),
                                FilledButton(
                                  onPressed: () {
                                    if (inputText.length < 20) {
                                      context.showErrorMessage(
                                          message:
                                              "Please write at least 20 characters to generate markdown.",
                                          duration: Duration(seconds: 5));
                                      Navigator.pop(context);
                                      return;
                                    }
                                    context
                                        .read<AICubit>()
                                        .generateAIDescMarkdown(inputText);
                                    Navigator.pop(context);
                                  },
                                  child: Text("Generate Now"),
                                ),
                              ],
                            ),
                          );
                        },
                        tooltip: "AI Generate",
                        child: Icon(Icons.auto_awesome),
                      ),
                    ),
                    if (state is AILoading)
                      Positioned.fill(
                        child: ColoredBox(
                            color: Colors.black.withOpacity(0.5),
                            child: Center(child: QuoteLoadingIndicator())),
                      )
                  ],
                ),
              ),
            );
          },
        ),
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
