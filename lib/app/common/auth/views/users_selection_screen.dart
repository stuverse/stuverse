import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:stuverse/app/app.dart';

class UsersSelectionScreen extends StatefulWidget {
  const UsersSelectionScreen({super.key, required this.onSubmit});
  final Function(List<MiniUser>) onSubmit;

  @override
  State<UsersSelectionScreen> createState() => _UsersSelectionScreenState();
}

class _UsersSelectionScreenState extends State<UsersSelectionScreen> {
  String searchValue = '';
  List<MiniUser> selectedUsers = [];
  initState() {
    context.read<UsersSelectionCubit>().getAllUsers();
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
            context.read<UsersSelectionCubit>().getAllUsers(
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
        child: BlocConsumer<UsersSelectionCubit, UsersSelectionState>(
          listener: (context, state) {
            if (state is UsersSelectionFailure) {
              context.showErrorMessage(
                message: "Unable to fetch user requests",
                duration: 3.seconds,
              );
            }
          },
          builder: (context, state) {
            if (state is UsersSelectionSuccess) {
              return RefreshIndicator.adaptive(
                onRefresh: () async {
                  context.read<UsersSelectionCubit>().getAllUsers();
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
