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
    return BgGradient(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.heightBox,
              Padding(
                padding: context.paddingHorz,
                child: Text(
                  "Popular Communities",
                  style: context.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              ),
              20.heightBox,
              SizedBox(
                height: 300,
                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categoryList.length,
                  controller: PageController(
                    viewportFraction: 0.92,
                    initialPage: 0,
                  ),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        CommunityMiniCard(),
                        10.heightBox,
                        CommunityMiniCard(),
                      ],
                    );
                  },
                ),
              ),
              Padding(
                padding: context.paddingHorz,
                child: Text(
                  "Latest Communities",
                  style: context.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              ),
              20.heightBox,
              SizedBox(
                height: 300,
                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categoryList.length,
                  controller: PageController(
                    viewportFraction: 0.92,
                    initialPage: 0,
                  ),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        CommunityMiniCard(),
                        10.heightBox,
                        CommunityMiniCard(),
                      ],
                    );
                  },
                ),
              ),
              // ValueListenableBuilder(
              //     valueListenable: selectedCategory,
              //     builder: (context, child, _) {
              //       return HorzTabBar(
              //           categoryList: categoryList,
              //           onSelected: (item) {
              //             selectedCategory.value = item;
              //           },
              //           selectedCategory: selectedCategory.value);
              //     }),
            ].defaultListAnimation(),
          ),
        ),
      ),
    );
  }
}

class CommunityMiniCard extends StatelessWidget {
  const CommunityMiniCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: context.paddingOnlyWith(right: 15),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Theme.of(context).colorScheme.onBackground.withOpacity(0.2),
          width: 0.5,
        ),
      ),
      padding: context.paddingAllWith(0.02),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage("https://picsum.photos/200"),
              ),
              10.widthBox,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "VisionPro",
                    style: context.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "25 Members",
                    style: context.bodyMedium!.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(0.7),
                    ),
                  ),
                ],
              ),
              Spacer(),
              FilledButton(
                onPressed: () {},
                child: Text(
                  "Join",
                  style: context.bodyMedium!
                      .copyWith(color: Theme.of(context).colorScheme.onPrimary),
                ),
              ),
            ],
          ),
          10.heightBox,
          Text(
            "A community for developers and designers to share their knowledge and work.A community for developers and designers to share their knowledge and work.",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: context.bodyMedium!.copyWith(
              color:
                  Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}
