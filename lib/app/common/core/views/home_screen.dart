import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
