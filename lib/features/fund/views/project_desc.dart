import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stuverse/app/app.dart';
import 'package:stuverse/features/fund/cubit/cubit/home_cubit.dart';
import 'package:stuverse/features/fund/models/projects.dart';

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
                            child: Image.network(
                              widget.project.images,
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
                        backgroundImage:
                            NetworkImage(widget.project.user.image),
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
                  onPressed: () {
                    // context.push(
                    //   FundRoutes.donationpage,
                    // );
                    context.showMessage(message: 'Not yet implemented');
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
