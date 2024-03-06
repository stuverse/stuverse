import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stuverse/app/app.dart';
import 'package:logman/logman.dart';
import 'package:stuverse/features/forum/forum.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

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
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CoreCubit, CoreState>(
      listener: (context, state) {
        if (state.isUserLoading == false) {
          if (state.isFirstTime) {
            context.read<CoreCubit>().setIsFirstTime(false);
            context.go(CommonRoutes.onBoarding);
          } else {
            if (state.user == null) {
              context.go(CommonRoutes.signin);
            } else {
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
