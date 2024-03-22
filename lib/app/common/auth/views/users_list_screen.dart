import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:stuverse/app/app.dart';




class UsersListScreen extends StatefulWidget {
  const UsersListScreen({super.key, required this.onSubmit});
  final Function(List<MiniUser>) onSubmit;

  @override
  State<UsersListScreen> createState() => _UsersListScreenState();
}

class _UsersListScreenState extends State<UsersListScreen> {
  String searchValue = '';
  List<MiniUser> selectedUsers = [];
  initState() {
    context.read<UsersListCubit>().getAllUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EasySearchBar(
          title: Text('Users'),
          onSearch: (value) {
            setState(() {
              searchValue = value;
            });
            context.read<UsersListCubit>().getAllUsers(
                  query: value,
                );
          },
          actions: [
            TextButton(
              onPressed: () {
                widget.onSubmit(selectedUsers);
                context.pop();
              },
              child: const Text("Done"),
            )
          ]),
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
              return RefreshIndicator.adaptive(
                onRefresh: () async {
                  context.read<UsersListCubit>().getAllUsers();
                },
                child: ListView(
                  children: [
                    for (final user in state.usersList)
                     CheckboxListTile(
                       title: Text(user.name!),
                       value: selectedUsers.any((u) => u.id! == user.id),
                       controlAffinity: ListTileControlAffinity.leading,
                       onChanged: (value) {
                         setState(() {
                           if (value!) {
                             selectedUsers.add(user);
                           } else {
                             selectedUsers.remove(user);
                           }
                         });
                       },
                     )
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
