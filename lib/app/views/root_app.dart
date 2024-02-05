import 'package:flutter/material.dart';
import 'package:stuverse/app/app.dart';
import 'package:stuverse/app/routes/app_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuverse/features/forum/forum.dart';
import 'package:stuverse/features/fund/fund.dart';
import 'package:stuverse/features/job/job.dart';
import 'package:stuverse/features/mentor/mentor.dart';

class RootApp extends StatelessWidget {
  const RootApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        ...CommonProviders.blocProviders,
        ...FundProviders.blocProviders,
        ...JobProviders.blocProviders,
        ...ForumProviders.blocProviders,
        ...MentorProviders.blocProviders,
      ],
      child: _App(),
    );
  }
}

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      routerConfig: AppRouter.router,
    );
  }
}
