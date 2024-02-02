import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    super.initState();
  }

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
      drawer: MainDrawer(),
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: BgGradient(
          child: SafeArea(
        child: Padding(
          padding: context.paddingHorzWith(0.03),
          child: Stack(
            children: [
              widget.navigationShell,
              Positioned(
                top: 0,
                left: 0,
                child: IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: context.colorScheme.onBackground,
                    size: 30,
                  ),
                  onPressed: () {
                    _scaffoldKey.currentState!.openDrawer();
                  },
                ),
              ),
            ],
          ),
        ),
      )),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          elevation: 0,
          backgroundColor: Colors.transparent,
          indicatorColor: context.colorScheme.secondaryContainer,
          labelTextStyle: MaterialStateProperty.resolveWith<TextStyle>(
              (Set<MaterialState> states) =>
                  states.contains(MaterialState.selected)
                      ? TextStyle(color: context.colorScheme.secondaryContainer)
                      : TextStyle(color: context.colorScheme.onBackground)),
        ),
        child: NavigationBar(
          selectedIndex: currentIndex,
          destinations: [
            NavDestItem(
              label: 'Forum',
              svgPath: AppImages.forumSolidSVG,
            ),
            NavDestItem(
              label: 'Funds',
              svgPath: AppImages.fundSolidSVG,
            ),
            NavDestItem(
              label: 'Job',
              svgPath: AppImages.jobSolidSVG,
            ),
            NavDestItem(
              label: 'Mentor',
              svgPath: AppImages.mentorSolidSVG,
            ),
          ],
          onDestinationSelected: _goBranch,
        ),
      ),
    );
  }
}
