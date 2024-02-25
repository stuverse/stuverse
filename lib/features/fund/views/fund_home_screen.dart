import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:go_router/go_router.dart';
import 'package:stuverse/app/common/core/widgets/MarkdownTextInput/markdown_text_input.dart';
import 'package:stuverse/app/widgets/bg_gradient.dart';
import 'package:stuverse/features/fund/cubit/cubit/home_cubit.dart';
import 'package:stuverse/features/fund/fund.dart';
import 'package:stuverse/features/fund/views/project_desc.dart';
import 'package:stuverse/features/fund/widgets/category.dart';
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
    context.read<HomeCubit>().getProjects();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BgGradient(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
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
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            fillColor: Theme.of(context).colorScheme.background,
                            border: InputBorder.none,
                            prefixIcon: const Icon(Icons.search),
                            hintText: "Find fundraisers, projects, and more",
                          )),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: Theme.of(context).colorScheme.surfaceTint),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 11, horizontal: 18),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Text(
                                "Start New\nFundraising",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    overflow: TextOverflow.visible),
                              ),
                              Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(18),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onTertiaryContainer),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      "Start Now",
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 76, 68, 68),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  )),
                            ]),
                      ),
                    ),
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
                    BlocConsumer<HomeCubit, HomeState>(
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
                                InkWell(
                                  onTap: () {
                                    context
                                        .pushReplacement(FundRoutes.fundHome);
                                  },
                                  child: Container(
                                    height: 150,
                                    width: double.maxFinite,
                                    margin: const EdgeInsets.only(bottom: 20),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimaryContainer,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Hero(
                                              tag: project.images,
                                              child: Image.network(
                                                project.images,
                                                height: double.maxFinite,
                                                width: double.maxFinite,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(project.title,
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .error)),
                                                Divider(
                                                  color: Colors.black,
                                                  thickness: 1.5,
                                                ),
                                                Text(
                                                  'Target Amount',
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w200,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                    '\$ ${project.targetAmount}',
                                                    style: TextStyle(
                                                      fontSize: 19,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
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
    );
  }
}
