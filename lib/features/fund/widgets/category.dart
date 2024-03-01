import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  const Category({
    super.key,
    required this.title,
    required this.image,
  });
  final String title;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Theme.of(context).colorScheme.onPrimaryContainer),
            child: Center(
              child: Image.asset(image, height: 30, width: 30),
            )),
        const SizedBox(
          height: 10,
        ),
        Text(title)
      ],
    );
  }
}
