import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:stuverse/app/app.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({required this.navigationShell, Key? key})
      : super(
            key: key ?? const ValueKey<String>('ScaffoldWithNestedNavigation'));
  final StatefulNavigationShell navigationShell;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    user = context.read<CoreCubit>().state.user;
    FirebaseMessaging.onMessage.listen((message) {
      print(message);
      if (message.notification != null) {
        context.showMessage(
            message:
                "${message.notification?.title ?? ''} \n${message.notification?.body ?? ''} ",
            duration: const Duration(seconds: 5));
      }
    });
    navItems.addAll([
      NavDestItem(
        label: 'Forum',
        regularSvgPath: AppImages.forumSVG,
        solidSvgPath: AppImages.forumSolidSVG,
      ),
      NavDestItem(
        label: 'Fundraising',
        regularSvgPath: AppImages.fundSVG,
        solidSvgPath: AppImages.fundSolidSVG,
      ),
      NavDestItem(
        label: 'Jobs',
        regularSvgPath: AppImages.jobSVG,
        solidSvgPath: AppImages.jobSolidSVG,
      ),
      NavDestItem(
        label: 'Mentoring',
        regularSvgPath: AppImages.mentorSVG,
        solidSvgPath: AppImages.mentorSolidSVG,
      ),
      ProfileNavItem(),
    ]);
    super.initState();
  }

  late final User? user;

  final List<Widget> navItems = [];
  void _goBranch(int index) {
    HapticFeedback.lightImpact();
    widget.navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final currentIndex = widget.navigationShell.currentIndex;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Image.asset(
          AppImages.logoGlow,
          width: 90,
        ),
        centerTitle: true,
        actions: [
          // NotificationIcon(
          //   hasNotification: false,
          //   onPressed: () {},
          // ),
          Padding(
            padding: const EdgeInsets.only(
              top: 7,
            ),
            child: IconButton(
              onPressed: () {
                context.showMessage(
                    message: "Notifications will be available soon");
              },
              icon: SvgPicture.asset(
                AppImages.bellSVG,
                height: 20,
                colorFilter: ColorFilter.mode(
                  context.colorScheme.onBackground,
                  BlendMode.srcIn,
                ),
              ),
            ),
          )
        ],
      ),
      drawer: MainDrawer(),
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: BgGradient(
        child: SafeArea(
          child: widget.navigationShell,
        ),
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          elevation: 5,
          backgroundColor: Colors.transparent,
          indicatorColor: Colors.transparent,
          labelTextStyle: MaterialStateProperty.resolveWith<TextStyle>(
              (Set<MaterialState> states) =>
                  states.contains(MaterialState.selected)
                      ? TextStyle(color: context.colorScheme.secondaryContainer)
                      : TextStyle(color: context.colorScheme.onBackground)),
        ),
        child: NavigationBar(
          selectedIndex: currentIndex,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          destinations: navItems,
          onDestinationSelected: _goBranch,
        ),
      ),
    );
  }
}

class ProfileNavItem extends StatelessWidget {
  const ProfileNavItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final user = context.read<CoreCubit>().state.user;
    return NavigationDestination(
      icon: CircleAvatar(
        radius: 15,
        backgroundColor: context.colorScheme.onBackground.withOpacity(0.5),
        child: CircleAvatar(
          radius: 13,
          backgroundImage: NetworkImage(
            user?.image ?? "",
          ),
        ),
      ),
      selectedIcon: CircleAvatar(
        radius: 15,
        backgroundColor: context.colorScheme.secondaryContainer,
        child: CircleAvatar(
          radius: 13,
          backgroundImage: NetworkImage(
            user?.image ?? "",
          ),
        ),
      ),
      label: "Profile",
    );
  }
}
