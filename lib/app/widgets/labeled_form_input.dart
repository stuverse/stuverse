import 'package:flutter/material.dart';

class LabeledFormInput extends StatelessWidget {
  const LabeledFormInput({
    required this.child,
    required this.label,
    this.isRequired = false,
    super.key,
  });

  final Widget child;
  final bool isRequired;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  fontSize: 15,
                ),
            children: [
              if (isRequired)
                TextSpan(
                  text: '*',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        child,
      ],
    );
  }
}
