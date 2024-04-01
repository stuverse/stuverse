import 'package:cached_network_image/cached_network_image.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:go_router/go_router.dart';

import 'package:stuverse/app/app.dart';

import '../models/job_post.dart';
import '../routes/job_routes.dart';

class JobListTile extends StatefulWidget {
  const JobListTile({
    super.key,
    required this.post,
  });
  final JobPost post;

  @override
  State<JobListTile> createState() => _JobListTileState();
}

class _JobListTileState extends State<JobListTile> {
  @override
  Widget build(BuildContext context) {
    // final user = context.read<CoreCubit>().state.user;
    return InkWell(
      onTap: () {
        context.push(
          JobRoutes.jobDetail,
          extra: widget.post,
        );
      },
      child: Card(
        color: context.colorScheme.surface
            .blend(context.colorScheme.primaryContainer),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
          side: BorderSide(
            color: context.colorScheme.onBackground.withOpacity(0.2),
            width: 1,
          ),
        ),
        margin: const EdgeInsets.only(bottom: 13),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage:
                        CachedNetworkImageProvider(widget.post.image ?? ""),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.post.title ?? "",
                          style: context.textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Text(
                          widget.post.companyName ?? "",
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                                  color: context.colorScheme.onBackground
                                      .withOpacity(0.7)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .surfaceVariant
                            .withOpacity(0.5),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.outline,
                        )),
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.business_center,
                          size: 17,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        Text(
                            "${CommonUtils.toTitleCase(widget.post.jobType ?? "")}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant)),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .surfaceVariant
                            .withOpacity(0.5),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.outline,
                        )),
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (widget.post.jobLocationType ==
                            JOB_LOCATION_TYPE.HYBRID)
                          Icon(
                            Icons.work_outline,
                            size: 17,
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          )
                        else if (widget.post.jobLocationType ==
                            JOB_LOCATION_TYPE.ONSITE)
                          Icon(
                            Icons.storefront,
                            size: 17,
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          )
                        else
                          Icon(
                            Icons.language,
                            size: 17,
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        const SizedBox(
                          width: 6,
                        ),
                        Text(
                            " ${CommonUtils.toTitleCase(widget.post.jobLocationType ?? "")}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    size: 17,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    widget.post.place ?? "",
                    style: context.textTheme.titleSmall,
                  ),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    CommonUtils.relativeTime(
                        DateTime.parse(widget.post.createdAt.toString())),
                    style: context.bodyMedium!.copyWith(
                      color:
                          context.colorScheme.onSurfaceVariant.withOpacity(0.7),
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Theme.of(context).colorScheme.secondaryContainer,
                      ),
                      child: Icon(
                        Icons.chevron_right,
                        size: 20,
                        color: context.colorScheme.onSecondaryContainer,
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
