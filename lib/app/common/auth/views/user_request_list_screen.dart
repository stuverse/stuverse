import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:stuverse/app/app.dart';

import '../widgets/user_request_tile.dart';

class UserRequestListScreen extends StatefulWidget {
  const UserRequestListScreen({super.key});

  @override
  State<UserRequestListScreen> createState() => _UserRequestListScreenState();
}

class _UserRequestListScreenState extends State<UserRequestListScreen> {
  String searchValue = '';
  initState() {
    context.read<UserRequestCubit>().getAllUserRequest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EasySearchBar(
          title: Text('Manage User Requests'),
          onSearch: (value) {
            setState(() {
              searchValue = value;
            });
            context.read<UserRequestCubit>().getAllUserRequest(
                  search: value,
                );
          },
          actions: []),
      body: SafeArea(
        child: BlocConsumer<UserRequestCubit, UserRequestState>(
          listener: (context, state) {
            if (state is UserRequestFailure) {
              context.showErrorMessage(
                message: "Unable to fetch user requests",
                duration: 3.seconds,
              );
            }
          },
          builder: (context, state) {
            if (state is UserRequestSuccess) {
              return RefreshIndicator.adaptive(
                onRefresh: () async {
                  context.read<UserRequestCubit>().getAllUserRequest();
                },
                child: ListView(
                  children: [
                    for (final user in state.requestUsersList)
                      BlocProvider(
                        create: (context) => ManageUserRequestCubit(),
                        child: UserRequestTile(user: user),
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
