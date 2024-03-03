import 'package:flutter/material.dart';

import 'package:stuverse/app/app.dart';

class BannerCard extends StatelessWidget {
  const BannerCard(
      {super.key,
      required this.title,
      required this.description,
      required this.buttonText,
      required this.onTap,
      this.bannerText = "Beta"});
  final String title;
  final String description;
  final String buttonText;
  final String bannerText;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8),
        child: Banner(
          message: bannerText,
          location: BannerLocation.topEnd,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color:
                  Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.4),
            ),
            child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: context.titleLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      description,
                      textAlign: TextAlign.center,
                      style: context.textTheme.bodyMedium!.copyWith(),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: onTap,
                        child: Text(buttonText,
                            style: context.titleSmall!.copyWith(
                                color: context.colorScheme.surface,
                                fontWeight: FontWeight.bold)),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: context.colorScheme.secondary,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12))),
                      ),
                    )
                  ],
                )),
          ),
        ));
  }
}
