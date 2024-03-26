import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:stuverse/app/views/root_app.dart';
import 'package:stuverse/bootstrap.dart';

void main() => bootstrap(
      () => DevicePreview(
        enabled: false,
        builder: (context) => RootApp(), // Wrap your app
      ),
    );
