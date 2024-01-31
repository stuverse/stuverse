import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:stuverse/app/views/root_app.dart';

void main() => runApp(
      DevicePreview(
        enabled: false,
        builder: (context) => RootApp(), // Wrap your app
      ),
    );
