import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuverse/app/app.dart';
import 'package:stuverse/app/common/core/cubit/core_cubit.dart';
import 'package:stuverse/app/utils/extentions/app_extensions.dart';
import 'package:stuverse/features/forum/cubit/community/all/all_community_cubit.dart';
import 'package:stuverse/features/forum/cubit/community/manage/community_manage_cubit.dart';

import '../../widgets/community/community_mini_card.dart';

class ShowAllCommunitiesScreen extends StatefulWidget {
  const ShowAllCommunitiesScreen({super.key, required this.yourCommunity});
  final bool yourCommunity;

  @override
  State<ShowAllCommunitiesScreen> createState() =>
      _ShowAllCommunitiesScreenState();
}

class _ShowAllCommunitiesScreenState extends State<ShowAllCommunitiesScreen> {
  late final User? user;
  @override
  void initState() {
    super.initState();
    user = context.read<CoreCubit>().state.user;
    context.read<AllCommunityCubit>().getCommunities(
          userId: widget.yourCommunity ? user!.id : null,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.yourCommunity ? "Your communities" : "All Communities"),
      ),
      body: SafeArea(
        child: Padding(
          padding: context.paddingHorzWithTop,
          child: Column(
            children: [
              TextField(
                onChanged: (value) {
                  context.read<AllCommunityCubit>().getCommunities(
                        query: value,
                        userId: widget.yourCommunity ? user!.id : null,
                      );
                },
                decoration: InputDecoration(
                  labelText: "Search",
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  ),
                ),
              ),
              Expanded(
                child: BlocConsumer<AllCommunityCubit, AllCommunityState>(
                  listener: (context, state) {
                    if (state is AllCommunityError) {
                      context.showErrorMessage(
                        message: state.message,
                        duration: 3.seconds,
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is AllCommunityLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is AllCommunityLoaded) {
                      return ListView.builder(
                        itemCount: state.communities.length,
                        itemBuilder: (context, index) {
                          final community = state.communities[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: BlocProvider(
                              create: (context) => CommunityManageCubit(),
                              child: CommunityMiniCard(
                                community: community,
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: Text("No communities found"),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
