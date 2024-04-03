import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:stuverse/app/app.dart';
import 'package:stuverse/features/job/models/job_material.dart';

class JobMaterialCard extends StatelessWidget {
  const JobMaterialCard({
    super.key,
    required this.material,
  });
  final JobMaterial material;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(),
        color: context.colorScheme.surface
            .blend(context.colorScheme.primaryContainer),
      ),
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(material.title ?? "",
                    style: context.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    )),
                Text(material.description ?? "",
                    style: context.bodyMedium!.copyWith(
                      color: context.colorScheme.onSurface.withOpacity(0.6),
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          10.widthBox,
          TextButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: Padding(
                        padding: context.paddingHorzWithTop,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Text(material.title ?? "",
                                  style: context.titleLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  )),
                              Text(material.description ?? "",
                                  style: context.bodyMedium!.copyWith(
                                    color: context.colorScheme.onSurface
                                        .withOpacity(0.8),
                                  )),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    context.push(CommonRoutes.webView,
                                        extra: material.url);
                                  },
                                  icon: Icon(Icons.link),
                                  label: Text('Open Link',
                                      style: context.bodyMedium),
                                  style: FilledButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      backgroundColor:
                                          context.colorScheme.primaryContainer),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                );
              },
              child: Text(
                'View',
                style: context.bodyLarge!.copyWith(
                  color: context.colorScheme.primary,
                ),
              ))
        ],
      ),
    );
  }
}
