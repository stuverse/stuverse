import 'package:flutter/material.dart';
import 'package:stuverse/app/app.dart';

import '../models/thread/tag.dart';

class ThreadTagChip extends StatelessWidget {
  const ThreadTagChip({
    super.key,
    required this.tag,
  });
  final ThreadTag tag;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: tag.background != null
            ? CommonUtils.hexToColor(tag.background!)
            : context.colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(5),
      ),
      padding: context.paddingHorzWith(0.01),
      child: Text(
        tag.name ?? "",
        style: context.bodyMedium!.copyWith(
          fontWeight: FontWeight.bold,
          color: tag.onBackground != null
              ? CommonUtils.hexToColor(tag.onBackground!)
              : context.colorScheme.onSecondaryContainer,
        ),
      ),
    );
  }
}
