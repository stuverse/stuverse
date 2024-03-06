import 'package:flutter/material.dart';

class FundCategory extends StatelessWidget {
  const FundCategory({
    super.key,
    required this.title,
    required this.image,
    this.isSelected = false,
    this.onTap,
  });
  final String title;
  final String image;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: isSelected
                      ? Theme.of(context).colorScheme.onPrimaryContainer
                      : Theme.of(context)
                          .colorScheme
                          .onPrimaryContainer
                          .withOpacity(0.5)),
              child: Center(
                child: Image.asset(image, height: 25, width: 30),
              )),
          const SizedBox(
            height: 10,
          ),
          Text(title)
        ],
      ),
    );
  }
}
