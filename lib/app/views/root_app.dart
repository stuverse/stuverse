import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("This is background message");
  print(message);
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;

  if (notification != null && android != null) {
    flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            icon: 'launch_background',
            priority: Priority.high,
            actions: [
              AndroidNotificationAction(
                'archive',
                'Archive',
              ),
              AndroidNotificationAction(
                'dismiss',
                'Dismiss',
              ),
            ],
          ),
        ));
  }
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description:
      'This channel is used for important notifications.', // description
  importance: Importance.max,
  playSound: true,
);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<dynamic> onSelectNotification(payload) async {
// navigate to booking screen if the payload equal BOOKING
  print("Payload: $payload");
  AppRouter.router.go(JobRoutes.jobHome);
}

class _App extends StatefulWidget {
  const _App();

  @override
  State<_App> createState() => _AppState();
}

class _AppState extends State<_App> {
  void initState() {
    super.initState();
    //foreground notification
    flutterLocalNotificationsPlugin.initialize(
      InitializationSettings(
        android: AndroidInitializationSettings('launch_background'),
      ),
      onDidReceiveBackgroundNotificationResponse: onSelectNotification,
      onDidReceiveNotificationResponse: onSelectNotification,
    );
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                icon: 'launch_background',
                priority: Priority.high,
                actions: [
                  AndroidNotificationAction(
                    'archive',
                    'Archive',
                    inputs: [
                      const AndroidNotificationActionInput(
                        choices: ['Yes', 'No'],
                        allowFreeFormInput: false,
                        label: 'Do you want to archive this notification?',
                      ),
                    ],
                  ),
                  AndroidNotificationAction(
                    'dismiss',
                    'Dismiss',
                  ),
                ],
              ),
            ));
      }
    });
    //background notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                icon: 'launch_background',
                priority: Priority.high,
                actions: [
                  AndroidNotificationAction(
                    'archive',
                    'Archive',
                  ),
                  AndroidNotificationAction(
                    'dismiss',
                    'Dismiss',
                  ),
                ],
              ),
            ));
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
