import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stuverse/app/app.dart';
import 'package:stuverse/features/forum/forum.dart';

class CommunityAdminScreen extends StatefulWidget {
  const CommunityAdminScreen({super.key});

  @override
  State<CommunityAdminScreen> createState() => _CommunityAdminScreenState();
}

class _CommunityAdminScreenState extends State<CommunityAdminScreen> {
  String searchValue = '';
  initState() {
    context.read<CommunityAdminCubit>().getAllCommunities();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EasySearchBar(
          title: Text('Manage Communities'),
          onSearch: (value) {
            setState(() {
              searchValue = value;
            });
            context.read<CommunityAdminCubit>().getAllCommunities(
                  search: value,
                );
          },
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                context.push(ForumRoutes.communityAddEdit);
              },
            ),
          ]),
      body: SafeArea(
        child: BlocConsumer<CommunityAdminCubit, CommunityAdminState>(
          listener: (context, state) {
            if (state is CommunityAdminError) {
              context.showErrorMessage(
                message: state.message,
                duration: 3.seconds,
              );
            }
          },
          builder: (context, state) {
            if (state is CommunityAdminLoaded) {
              return RefreshIndicator.adaptive(
                onRefresh: () async {
                  context.read<CommunityAdminCubit>().getAllCommunities();
                },
                child: ListView(
                  children: [
                    for (final community in state.communities)
                      BlocProvider(
                        create: (context) => CommunityManageCubit(),
                        child: _CommunityTile(community: community),
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
}

class _CommunityTile extends StatelessWidget {
  const _CommunityTile({
    super.key,
    required this.community,
  });

  final Community community;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(community.name ?? ""),
      subtitle: Text((community.description ?? "")),
      leading: CircleAvatar(
        backgroundImage: CachedNetworkImageProvider(community.image ?? ""),
      ),
      onTap: () {
        context.push(
          ForumRoutes.communityAddEdit,
          extra: community,
        );
      },
    );
  }
}
