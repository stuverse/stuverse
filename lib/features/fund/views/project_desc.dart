import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stuverse/app/app.dart';
import 'package:stuverse/features/fund/cubit/home/fund_home_cubit.dart';
import 'package:stuverse/features/fund/models/projects.dart';
import 'package:url_launcher/url_launcher.dart';

import '../routes/fund_routes.dart';

class ProjectDescScreen extends StatefulWidget {
  const ProjectDescScreen({super.key, required this.project});

  final Projects project;

  @override
  State<ProjectDescScreen> createState() => _ProjectDescScreenState();
}

class _ProjectDescScreenState extends State<ProjectDescScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              context.pop(
                FundRoutes.projectDesc,
              );
            },
            icon: Icon(
              Icons.arrow_back_ios_new_outlined,
              size: 18,
            )),
        title: Text(
          'Details',
          style: context.titleMedium!.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              if (widget.project.user.id ==
                  context.read<CoreCubit>().state.user!.id) {
                context.push(
                  FundRoutes.addProject,
                  extra: widget.project,
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("You can't edit this project")));
              }
            },
            icon: Icon(
              Icons.more_vert_outlined,
              size: 18,
            ),
          )
        ],
      ),
      body: BgGradient(
          child: SafeArea(
              child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Stack(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Hero(
                          tag: widget.project.images,
                          child: Container(
                            height: 300,
                            width: double.infinity,
                            child: CachedNetworkImage(
                              placeholder: (context, url) {
                                return Container(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                );
                              },
                              imageUrl: widget.project.images,
                              fit: BoxFit.fill,
                            ),
                          )),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      widget.project.title,
                      style: context.titleLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '#tag: ${widget.project.category}',
                      style: context.bodySmall!
                          .copyWith(fontWeight: FontWeight.w100),
                    ),
                    Divider(
                      color: Colors.white,
                      thickness: 0.3,
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: CachedNetworkImageProvider(
                            widget.project.user.image),
                      ),
                      title: Text(
                        widget.project.user.name,
                        style: context.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(widget.project.user.type,
                          style: context.titleSmall!.copyWith(
                              fontWeight: FontWeight.w200, fontSize: 15)),
                    ),
                    Divider(
                      color: Colors.white,
                      thickness: 0.3,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(widget.project.description,
                        style: context.bodyMedium!.copyWith(fontSize: 15)),
                    const SizedBox(
                      height: 40,
                    ),
                  ]),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    // context.push(
                    //   FundRoutes.donationpage,
                    // );
                    context.showMessage(message: "Donation Page not available");
                    final uri = Uri.parse(
                        "upi://pay?cu=INR&pa=7356910877@paytm&pn=Basha&tn=&am=3.00");

                    final canLaunch = await canLaunchUrl(uri);

                    if (canLaunch) {
                      await launchUrl(uri);
                    } else {
                      context.showMessage(message: "Cant open upi app");
                    }
                  },
                  child: Text('Donate',
                      style: context.titleSmall!.copyWith(
                          color: context.colorScheme.surface,
                          fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: context.colorScheme.secondary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12))),
                ),
              ),
            )
          ],
        ),
      ))),
    );
  }
}
