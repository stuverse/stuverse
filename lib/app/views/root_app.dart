import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:stuverse/app/app.dart';
import 'package:stuverse/app/routes/app_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuverse/features/forum/forum.dart';
import 'package:stuverse/features/fund/fund.dart';
import 'package:stuverse/features/job/job.dart';
import 'package:stuverse/features/mentor/mentor.dart';
import 'package:stuverse/features/profile/profile.dart';

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
        ...ProfileProviders.blocProviders,
      ],
      child: _App(),
    );
  }
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {}

class _App extends StatefulWidget {
  const _App();

  @override
  State<_App> createState() => _AppState();
}

class _AppState extends State<_App> {
  void initState() {
    super.initState();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {});
    //background notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      print(message.data);

      try {
        final data = message.data;
        if (data['action'] == 'thread') {
          AppRouter.router
              .go(ForumRoutes.threadDetail.replaceFirst(":id", data['id']));
        }
      } catch (e) {
        print(e);
      }
    });
    //foreground notification
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: !context.watch<CoreCubit>().state.isDarkMode
          ? ThemeMode.light
          : ThemeMode.dark,
      routerConfig: AppRouter.router,
    );
  }
}
