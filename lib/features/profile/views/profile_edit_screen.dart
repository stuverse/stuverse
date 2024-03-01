import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuverse/app/app.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  late final User? user;
  @override
  void initState() {
    user = context.read<CoreCubit>().state.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: BgGradient(
        child: SingleChildScrollView(
          child: Column(
            children: [
              130.heightBox,
              Stack(
                children: [
                  CircleAvatar(
                    radius: 65,
                    backgroundImage: NetworkImage(user?.image ?? ""),
                  ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                          ),
                          child: Icon(
                            Icons.edit,
                            size: 20,
                          )))
                ],
              ),
              10.heightBox,
              Text(user?.name ?? "", style: context.headlineSmall),
              Text(user?.email ?? "",
                  style: context.titleMedium!.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(0.7))),
              30.heightBox,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: user?.name,
                      decoration: InputDecoration(
                        labelText: 'Name',
                      ),
                    ),
                    10.heightBox,
                    TextFormField(
                      initialValue: user?.email,
                      decoration: InputDecoration(
                        labelText: 'Email',
                      ),
                    ),
                    10.heightBox,
                    TextFormField(
                      initialValue: user?.about,
                      decoration: InputDecoration(
                        labelText: 'Bio',
                      ),
                    ),
                    10.heightBox,
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Save'),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
