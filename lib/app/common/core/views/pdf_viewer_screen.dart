import 'dart:io';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewerScreen extends StatefulWidget {
  const PdfViewerScreen({super.key, required this.path});
  final String path;

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  @override
  Widget build(BuildContext context) {
    bool isPathUrl =
        widget.path.startsWith('http') || widget.path.startsWith('https');
    return Scaffold(
        appBar: AppBar(
          title: const Text('PDF Viewer'),
        ),
        body: Container(
            child: isPathUrl
                ? SfPdfViewer.network(widget.path)
                : SfPdfViewer.file(File(widget.path))));
  }
}
