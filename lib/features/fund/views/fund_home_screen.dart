import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:go_router/go_router.dart';
import 'package:stuverse/app/app.dart';
import 'package:stuverse/app/common/core/widgets/MarkdownTextInput/markdown_text_input.dart';
import 'package:stuverse/app/widgets/bg_gradient.dart';
import 'package:stuverse/features/fund/cubit/home/fund_home_cubit.dart';
import 'package:stuverse/features/fund/fund.dart';

import 'package:stuverse/features/fund/widgets/category.dart';
import 'package:stuverse/features/fund/widgets/project_card.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/projects.dart';

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

  String? selectedCategory;

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
                        child: Hero(
                          tag: 'search',
                          child: Material(
                            child: InkWell(
                              onTap: () {
                                context.push(FundRoutes.search);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(27),
                                  color: Color.fromARGB(242, 231, 230, 230),
                                ),
                                child: IgnorePointer(
                                  ignoring: true,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: 'find projects and more....',
                                      border: InputBorder.none,
                                      prefixIcon: Icon(
                                        Icons.search,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      BannerCard(
                        title: "Start New Project ",
                        description:
                            "Create your fundraising Project and get funding fast and easy.",
                        buttonText: "Start",
                        onTap: () {
                          context.push(FundRoutes.addProject);
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            FundCategory(
                              title: 'All',
                              image: FundImages.all,
                              isSelected: selectedCategory == null,
                              onTap: () {
                                setState(() {
                                  selectedCategory = null;
                                });
                                context.read<FundHomeCubit>().getProjects(
                                      search: _searchcontroller.text,
                                      category: selectedCategory,
                                    );
                              },
                            ),
                            FundCategory(
                              title: 'Medical',
                              image: FundImages.medical,
                              isSelected: selectedCategory ==
                                  FundCategoryChoice.medical,
                              onTap: () {
                                setState(() {
                                  selectedCategory = FundCategoryChoice.medical;
                                });
                                context.read<FundHomeCubit>().getProjects(
                                      search: _searchcontroller.text,
                                      category: selectedCategory,
                                    );
                              },
                            ),
                            FundCategory(
                              title: 'Education',
                              image: FundImages.education,
                              isSelected: selectedCategory ==
                                  FundCategoryChoice.education,
                              onTap: () {
                                setState(() {
                                  selectedCategory =
                                      FundCategoryChoice.education;
                                });
                                context.read<FundHomeCubit>().getProjects(
                                      search: _searchcontroller.text,
                                      category: selectedCategory,
                                    );
                              },
                            ),
                            FundCategory(
                              title: 'Disaster',
                              image: FundImages.disastor,
                              isSelected: selectedCategory ==
                                  FundCategoryChoice.disaster,
                              onTap: () {
                                setState(() {
                                  selectedCategory =
                                      FundCategoryChoice.disaster;
                                });
                                context.read<FundHomeCubit>().getProjects(
                                      search: _searchcontroller.text,
                                      category: selectedCategory,
                                    );
                              },
                            ),
                            FundCategory(
                              title: 'Charity',
                              image: FundImages.charity,
                              isSelected: selectedCategory ==
                                  FundCategoryChoice.charity,
                              onTap: () {
                                setState(() {
                                  selectedCategory = FundCategoryChoice.charity;
                                });
                                context.read<FundHomeCubit>().getProjects(
                                      search: _searchcontroller.text,
                                      category: selectedCategory,
                                    );
                              },
                            ),
                            FundCategory(
                              title: 'Others',
                              image: FundImages.other,
                              isSelected:
                                  selectedCategory == FundCategoryChoice.others,
                              onTap: () {
                                setState(() {
                                  selectedCategory = FundCategoryChoice.others;
                                });
                                context.read<FundHomeCubit>().getProjects(
                                      search: _searchcontroller.text,
                                      category: selectedCategory,
                                    );
                              },
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
                          if (state is FundHomeError) {
                            return Container(
                              alignment: Alignment.center,
                              child: Text(state.errorMessage),
                            );
                          }

                          if (state is FundHomeSuccess) {
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
