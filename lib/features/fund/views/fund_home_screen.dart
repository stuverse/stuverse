import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:go_router/go_router.dart';
import 'package:stuverse/app/app.dart';
import 'package:stuverse/app/common/core/widgets/MarkdownTextInput/markdown_text_input.dart';
import 'package:stuverse/app/widgets/bg_gradient.dart';
import 'package:stuverse/features/fund/cubit/cubit/home_cubit.dart';
import 'package:stuverse/features/fund/fund.dart';

import 'package:stuverse/features/fund/widgets/category.dart';
import 'package:stuverse/features/fund/widgets/project_card.dart';
import 'package:url_launcher/url_launcher.dart';

class FundHomeScreen extends StatefulWidget {
  const FundHomeScreen({super.key});

  @override
  State<FundHomeScreen> createState() => _FundHomeScreenState();
}

class _FundHomeScreenState extends State<FundHomeScreen> {
  final _searchcontroller = TextEditingController();
  @override
  void initState() {
    context.read<FundHomeCubit>().getProjects(search: _searchcontroller.text);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BgGradient(
        child: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {
              context.read<FundHomeCubit>().getProjects(
                    search: _searchcontroller.text,
                  );
            },
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 13,
                          vertical: 8,
                        ),
                        child: TextField(
                            controller: _searchcontroller,
                            onChanged: (value) {
                              context.read<FundHomeCubit>().getProjects(
                                    search: _searchcontroller.text,
                                  );
                            },
                            style: context.textTheme.bodyMedium!.copyWith(),
                            decoration: InputDecoration(
                              fillColor:
                                  Theme.of(context).colorScheme.background,
                              border: InputBorder.none,
                              prefixIcon: const Icon(Icons.search),
                              hintText: "Find fundraisers, projects, and more",
                            )),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Padding(
                          padding: const EdgeInsets.all(8),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color:
                                  Theme.of(context).colorScheme.surfaceVariant,
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
                                      "Start New Project ",
                                      style: context.titleLarge!.copyWith(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Create your fundraising Project and get funding fast and easy.",
                                      textAlign: TextAlign.center,
                                      style: context.textTheme.bodyMedium!
                                          .copyWith(),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Center(
                                      child: ElevatedButton(
                                        onPressed: () {},
                                        child: Text('Start',
                                            style: context.titleSmall!.copyWith(
                                                color:
                                                    context.colorScheme.surface,
                                                fontWeight: FontWeight.bold)),
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                context.colorScheme.secondary,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12))),
                                      ),
                                    )
                                  ],
                                )),
                          )),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () {},
                              child: const Category(
                                title: 'Medical',
                                image: FundImages.medical,
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: const Category(
                                title: 'Education',
                                image: FundImages.education,
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: const Category(
                                title: 'Disaster',
                                image: FundImages.disastor,
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: const Category(
                                title: 'Charity',
                                image: FundImages.charity,
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: const Category(
                                title: 'Others',
                                image: FundImages.other,
                              ),
                            ),
                          ]),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        'Statistics',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      BlocConsumer<FundHomeCubit, FundHomeState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          if (state is HomeError) {
                            return Container(
                              alignment: Alignment.center,
                              child: Text(state.errorMessage),
                            );
                          }

                          if (state is HomeSuccess) {
                            return Column(
                              children: [
                                for (final project in state.project)
                                  ProjectCard(project: project),
                              ],
                            );
                          }
                          return CircularProgressIndicator();
                        },
                      )
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
