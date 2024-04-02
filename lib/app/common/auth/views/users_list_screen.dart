import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:readmore/readmore.dart';

import 'package:stuverse/app/app.dart';
import 'package:url_launcher/url_launcher.dart';

import '../cubit/users_list/users_list_cubit.dart';

class UsersListScreen extends StatefulWidget {
  const UsersListScreen({super.key});

  @override
  State<UsersListScreen> createState() => _UsersListScreenState();
}

class _UsersListScreenState extends State<UsersListScreen> {
  String searchValue = '';
  String? type;
  initState() {
    type = UserTypes.STUDENT;
    context.read<UsersListCubit>().getAllUsers(
          query: searchValue,
          type: type,
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EasySearchBar(
          title: Text('Users List'),
          onSearch: (value) {
            setState(() {
              searchValue = value;
            });
            context
                .read<UsersListCubit>()
                .getAllUsers(query: value, type: type);
          },
          actions: []),
      body: SafeArea(
        child: BlocConsumer<UsersListCubit, UsersListState>(
          listener: (context, state) {
            if (state is UsersListFailure) {
              context.showErrorMessage(
                message: "Unable to fetch user requests",
                duration: 3.seconds,
              );
            }
          },
          builder: (context, state) {
            if (state is UsersListSuccess) {
              if (state.usersList.isEmpty)
                return const Center(
                  child: Text('No user requests found'),
                );
              return RefreshIndicator.adaptive(
                onRefresh: () async {
                  context.read<UsersListCubit>().getAllUsers(
                        query: searchValue,
                        type: type,
                      );
                },
                child: ListView(
                  children: [
                    for (final user in state.usersList)
                      ListTile(
                        title: Text(user.name ?? ""),
                        subtitle: Text(user.email ?? ""),
                        leading: CircleAvatar(
                          backgroundImage:
                              CachedNetworkImageProvider(user.image ?? ""),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          onUserTap(user);
                        },
                        tileColor: Theme.of(context)
                            .colorScheme
                            .surfaceVariant
                            .withOpacity(0.7),
                      ),
                  ],
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  void onUserTap(User user) {
    showModalBottomSheet(
      clipBehavior: Clip.none,
      context: context,
      isScrollControlled: true,
      builder: (context) => SingleChildScrollView(
        child: SafeArea(
            child: Stack(
          clipBehavior: Clip.none,
          alignment: AlignmentDirectional.topCenter,
          children: [
            Container(
              height: context.height * 0.7,
              width: double.infinity,
              padding: context.paddingHorzWithTop,
              decoration: BoxDecoration(
                  color: context.isDark
                      ? context.colorScheme.surfaceVariant.withOpacity(0.2)
                      : context.colorScheme.surfaceVariant,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              child: Column(
                children: [
                  Text(
                    user.name ?? "",
                    style: context.titleLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ).paddingOnly(top: context.height * 0.09),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (user.linkedin != null &&
                            (user.linkedin?.isNotEmpty ?? false))
                          InkWell(
                            onTap: () {
                              context.push(CommonRoutes.webView,
                                  extra: user.linkedin);
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: context.height * 0.02,
                              backgroundImage: AssetImage(
                                'assets/app/icons/circle-linkedin-512.webp',
                              ),
                            ),
                          ),
                        100.widthBox,
                        if (user.github != null &&
                            (user.github?.isNotEmpty ?? false))
                          InkWell(
                            onTap: () {
                              context.push(CommonRoutes.webView,
                                  extra: user.github);
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: context.height * 0.02,
                              backgroundImage: AssetImage(
                                'assets/app/icons/25231.png',
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.mail,
                                size: context.height * 0.021,
                              ),
                              3.widthBox,
                              Text(
                                user.email ?? "N/A",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(),
                              ),
                            ],
                          ),
                          if (user.mobile != null &&
                              (user.mobile?.isNotEmpty ?? false))
                            Row(
                              children: [
                                Icon(
                                  Icons.phone,
                                  size: context.height * 0.021,
                                ),
                                3.widthBox,
                                Text(
                                  '+91 ${user.mobile ?? "N/A"}',
                                  style:
                                      Theme.of(context).textTheme.bodyMedium!,
                                )
                              ],
                            ),
                        ]),
                  ),
                  if (user.mobile != null && user.mobile!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () async {
                              final url = Uri.parse(
                                  "http://wa.me/+91${user.mobile ?? ""}");
                              final canlaunch = await canLaunchUrl(url);
                              if (!canlaunch) {
                                return;
                              } else {
                                await launchUrl(url);
                              }
                            },
                            child: Expanded(
                              flex: 1,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        width: 1,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/app/icons/WhatsApp_icon.png',
                                        height: context.height * 0.028,
                                        width: context.height * 0.028,
                                      ),
                                      3.widthBox,
                                      Text(
                                        'Connect to whatsapp',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.green),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          7.widthBox,
                          if (user.resume != null && (user.resume!.isNotEmpty))
                            Expanded(
                              flex: 1,
                              child: InkWell(
                                onTap: () {
                                  context.push(CommonRoutes.pdfViewer,
                                      extra: user.resume);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          width: 1,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/app/icons/1250696.png',
                                          color:
                                              context.colorScheme.onBackground,
                                          height: context.height * 0.028,
                                          width: context.height * 0.028,
                                        ),
                                        3.widthBox,
                                        Text(
                                          'See Resume',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (user.about != null && (user.about!.isNotEmpty))
                          Text(
                            "About",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        if (user.about != null && (user.about!.isNotEmpty))
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: ReadMoreText(
                              user.about ?? "N/A",
                              trimLines: 3,
                              colorClickableText:
                                  Theme.of(context).colorScheme.primary,
                              trimCollapsedText: 'Read more',
                              trimExpandedText: 'Show less',
                              moreStyle: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.bold),
                              lessStyle: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.bold),
                            ),
                          ),
                        if (user.skills != null && (user.skills!.isNotEmpty))
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              "Skills",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                        if (user.skills != null && (user.skills!.isNotEmpty))
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: user.skills!.map((skill) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground
                                            .withOpacity(0.2),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 4),
                                        child: Text(
                                          skill.name!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: -50,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: context.height * 0.06,
                backgroundImage: CachedNetworkImageProvider(user.image ?? ""),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
