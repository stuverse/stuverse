import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuverse/app/app.dart';

class ForumHomeScreen extends StatefulWidget {
  const ForumHomeScreen({super.key});

  @override
  State<ForumHomeScreen> createState() => _ForumHomeScreenState();
}

class _ForumHomeScreenState extends State<ForumHomeScreen> {
  final categoryList = [
    HorzTabItem(title: "Top", id: 1),
    HorzTabItem(title: "Public", id: 2),
    HorzTabItem(title: "Private", id: 3),
  ];

  late final ValueNotifier<HorzTabItem> selectedCategory;

  @override
  void initState() {
    selectedCategory = ValueNotifier(categoryList.first);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<CoreCubit>().state.user;
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(CommonUtils.getGreeting(),
                style: context.titleLarge!.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withOpacity(0.8),
                    fontWeight: FontWeight.w400)),
            Text("${CommonUtils.toTitleCase(user?.name ?? "")}",
                style: context.headlineLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontWeight: FontWeight.bold)),
            20.heightBox,
            ValueListenableBuilder(
                valueListenable: selectedCategory,
                builder: (context, child, _) {
                  return HorzTabBar(
                      categoryList: categoryList,
                      onSelected: (item) {
                        selectedCategory.value = item;
                      },
                      selectedCategory: selectedCategory.value);
                }),
          ],
        ),
      ),
    );
  }
}
