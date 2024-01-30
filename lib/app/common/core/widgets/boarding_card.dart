import 'package:flutter/material.dart';
import 'package:stuverse/app/app.dart';

class BoardingCard extends StatelessWidget {
  const BoardingCard(
      {super.key,
      required this.title,
      required this.description,
      required this.img});
  final String title;
  final String description;
  final String img;

  @override
  Widget build(BuildContext context) {
    return BgGradient(
      child: SafeArea(
        child: Column(
          children: [
            Image.asset(
              img,
              height: context.minSize * 0.8,
              width: context.minSize * 0.8,
            ),
            10.widthBox,
            Text(
              title,
              textAlign: TextAlign.center,
              style: context.headlineMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            10.heightBox,
            Text(
              description,
              textAlign: TextAlign.center,
              style: context.bodyLarge,
            ),
          ],
        ).paddingSymmetric(
          horizontal: context.width * 0.05,
          vertical: context.height * 0.05,
        ),
      ),
    );
  }
}
