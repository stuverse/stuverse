import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        color: Theme.of(context).colorScheme.surface,
        width: double.infinity,
        child: SingleChildScrollView(
          child: SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(35),
                  child: Container(
                    height: context.height * 0.35,
                    width: double.infinity,
                    child: CachedNetworkImage(
                      placeholder: (context, url) {
                        return Container(
                          color: Theme.of(context).colorScheme.primaryContainer,
                        );
                      },
                      imageUrl: user.image ?? '',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      user.name ?? '',
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Experience',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(),
                              ),
                              Text(
                                '${user.experienceYears!.toString()} Years',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Container(
                            height: 30,
                            child: VerticalDivider(
                              color: Theme.of(context).colorScheme.onBackground,
                              thickness: 1,
                            ),
                          ),
                        ]),
                    SizedBox(
                      height: 3,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final url = Uri.parse("http://wa.me/+91${user.mobile}");
                        final canlaunch = await canLaunchUrl(url);
                        if (!canlaunch) {
                          return;
                        } else {
                          await launchUrl(url);
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.send,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text('Connect',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                          maximumSize: Size(double.infinity, 80),
                          backgroundColor: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.86),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                    )
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  "About",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                ReadMoreText(
                  user.about!,
                  trimLines: 3,
                  colorClickableText: Theme.of(context).colorScheme.primary,
                  trimCollapsedText: 'Read more',
                  trimExpandedText: 'Show less',
                  moreStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold),
                  lessStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Skills",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: user.skills!.map((skill) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).colorScheme.surfaceVariant,
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
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
