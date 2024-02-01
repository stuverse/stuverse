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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: Colors.transparent,
      body: BgGradient(child: widget.navigationShell),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedIndex: widget.navigationShell.currentIndex,
        destinations: const [
          NavigationDestination(
              label: 'Home', icon: Icon(Icons.home)), //! This is Forum Module
          NavigationDestination(
              label: 'Fund', icon: Icon(Icons.monetization_on)),
          NavigationDestination(label: 'Job', icon: Icon(Icons.work)),
          NavigationDestination(
              label: 'Mentor', icon: Icon(Icons.person_search))
        ],
        onDestinationSelected: _goBranch,
      ),
    );
  }
}

class NamedNavigationBarItemWidget extends BottomNavigationBarItem {
  final String initialLocation;

  const NamedNavigationBarItemWidget(
      {required this.initialLocation, required Widget icon, String? label})
      : super(icon: icon, label: label);
}
