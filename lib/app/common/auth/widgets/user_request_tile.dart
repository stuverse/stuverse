import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuverse/app/app.dart';

class UserRequestTile extends StatelessWidget {
  const UserRequestTile({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(user.name ?? ""),
      subtitle: Text((user.email ?? "")),
      leading: CircleAvatar(
        backgroundImage: CachedNetworkImageProvider(user.image ?? ""),
      ),
      trailing: Icon(Icons.chevron_right),
      onTap: () async {
        await showModalBottomSheet(
            context: context,
            builder: (context) {
              log(user.about.toString());
              return Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: CircleAvatar(
                          backgroundImage:
                              CachedNetworkImageProvider(user.image ?? ""),
                          radius: 50,
                        ),
                      ),
                      20.heightBox,
                      Text(
                        user.name ?? "",
                      ),
                      20.heightBox,
                      Text(
                        user.email ?? "",
                      ),
                      20.heightBox,
                      Text(
                        user.about ?? "",
                      ),
                      20.heightBox,
                      SizedBox(
                        width: double.infinity,
                        child: BlocConsumer<ManageUserRequestCubit,
                            ManageUserRequestState>(
                          listener: (context, state) {
                            if (state is ManageUserRequestFailure) {
                              context.showErrorMessage(
                                message: "Unable to accept user request",
                              );
                            }
                            if (state is ManageUserRequestSuccess) {
                              context.showMessage(
                                message: "User request accepted",
                              );

                              context
                                  .read<UserRequestCubit>()
                                  .getAllUserRequest();

                              Navigator.pop(context);
                            }
                          },
                          builder: (context, state) {
                            if (state is ManageUserRequestLoading) {
                              return Center(
                                  child: const CircularProgressIndicator());
                            }
                            return ElevatedButton(
                              onPressed: () {
                                context
                                    .read<ManageUserRequestCubit>()
                                    .acceptRequest(userId: user.id ?? -1);
                              },
                              child: const Text('Accept'),
                            );
                          },
                        ),
                      )
                    ]),
              );
            });
      },
    );
  }
}
