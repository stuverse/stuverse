// ignore_for_file: unused_import

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stuverse/app/app.dart';
import 'package:logman/logman.dart';
import 'package:stuverse/features/forum/forum.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, this.from});
  final String? from;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   Logman.instance.attachOverlay(
    //     context: context,
    //   );
    // });

    context.read<CoreCubit>().getInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CoreCubit, CoreState>(
      listener: (context, state) {
        log(state.toString());
        if (state.isUserLoading == false) {
          if (state.isFirstTime) {
            context.read<CoreCubit>().setIsFirstTime(false);
            context.go(CommonRoutes.onBoarding);
          } else {
            if (state.user == null) {
              context.go(CommonRoutes.signin);
            } else {
              if (widget.from != null) {
                context.go(widget.from!);
              } else
                context.go(ForumRoutes.forumHome);
            }
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: BgGradient(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppImages.logo,
                width: 250,
              ),
              const SizedBox(
                height: 20,
              ),
              CircularProgressIndicator(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ],
          )),
        );
      },
    );
  }
}
