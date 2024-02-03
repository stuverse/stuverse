import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stuverse/app/app.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<CoreCubit>().state.user;
    return SafeArea(
        child: ListView.separated(
            itemBuilder: (ctx, index) {
              return ThreadCard(user: user, showImage: index.isEven);
            },
            separatorBuilder: (ctx, int) {
              return Divider();
            },
            itemCount: 20));
  }
}

class ThreadCard extends StatelessWidget {
  const ThreadCard({
    super.key,
    required this.user,
    required this.showImage,
  });

  final User? user;
  final bool showImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingHorzWith(0.035),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage(user?.image ?? ""),
              ),
              10.widthBox,
              Text(
                "r/communityname",
                style: context.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontWeight: FontWeight.bold),
              ),
              10.widthBox,
              Text(
                "41m",
                style: context.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              Spacer(),
              Icon(Icons.more_horiz)
            ],
          ),
          10.heightBox,
          Text(
            "Title of the post lorem ipsum dolor sit amet, ",
            style: context.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          5.heightBox,
          Text(
            "Description of the post lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
            style: context.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          5.heightBox,
          if (showImage)
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                "https://picsum.photos/200/300",
                width: double.infinity,
                height: context.minSize * 0.8,
                fit: BoxFit.cover,
              ),
            ),
          10.heightBox,
          Row(
            children: [
              Chip(
                side: BorderSide(
                  color: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(0.2),
                  width: 0.5,
                ),
                label: Row(
                  children: [
                    SvgPicture.asset(
                      AppImages.upSVG,
                      height: 20,
                      width: 20,
                      colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.onBackground,
                          BlendMode.srcIn),
                    ),
                    5.widthBox,
                    Text(
                      "1.5k",
                      style: context.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                    5.widthBox,
                    VerticalDivider(),
                    5.widthBox,
                    SvgPicture.asset(
                      AppImages.downSVG,
                      height: 20,
                      width: 20,
                      colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.onBackground,
                          BlendMode.srcIn),
                    ),
                  ],
                ),
              ),
              10.widthBox,
              Chip(
                side: BorderSide(
                  color: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(0.2),
                  width: 0.5,
                ),
                label: Row(
                  children: [
                    SvgPicture.asset(
                      AppImages.commentSVG,
                      height: 20,
                      width: 20,
                      colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.onBackground,
                          BlendMode.srcIn),
                    ),
                    5.widthBox,
                    Text(
                      "1.5k",
                      style: context.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Chip(
                side: BorderSide(
                  color: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(0.2),
                  width: 0.5,
                ),
                label: Row(
                  children: [
                    SvgPicture.asset(
                      AppImages.shareSVG,
                      height: 20,
                      width: 20,
                      colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.onBackground,
                          BlendMode.srcIn),
                    ),
                    5.widthBox,
                    Text(
                      "1.5k",
                      style: context.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
