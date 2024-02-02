import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
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

  final navItems = [
    // NavDestItem(
    //   label: 'Home',
    //   regularSvgPath: AppImages.homeSVG,
    //   solidSvgPath: AppImages.homeSolidSVG,
    // ),
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
      label: 'Job Portal',
      regularSvgPath: AppImages.jobSVG,
      solidSvgPath: AppImages.jobSolidSVG,
    ),
    NavDestItem(
      label: 'Mentor Portal',
      regularSvgPath: AppImages.mentorSVG,
      solidSvgPath: AppImages.mentorSolidSVG,
    ),
  ];
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
        title: Text(
          navItems[currentIndex].label,
        ),
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              AppImages.bellSVG,
              colorFilter: ColorFilter.mode(
                  context.colorScheme.onBackground, BlendMode.srcIn),
              height: 25,
            ),
            onPressed: () {},
          ),
        ],
      ),
      drawer: MainDrawer(),
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: BgGradient(
          child: SafeArea(
        child: Padding(
          padding: context.paddingHorzWith(0.02),
          child: Stack(
            children: [
              Column(
                children: [
                  (context.height * 0.08).heightBox,
                  Expanded(
                      child: Padding(
                    padding: context.paddingHorzWith(0.025),
                    child: widget.navigationShell,
                  )),
                ],
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.menu,
                        color: context.colorScheme.onBackground,
                        size: 30,
                      ),
                      onPressed: () {
                        _scaffoldKey.currentState!.openDrawer();
                      },
                    ),
                    Spacer(),
                    Text(
                      navItems[currentIndex].label,
                      style: context.titleLarge!.copyWith(
                        color: context.colorScheme.onBackground,
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      icon: Stack(
                        children: [
                          SvgPicture.asset(
                            AppImages.bellSVG,
                            colorFilter: ColorFilter.mode(
                                context.colorScheme.onBackground,
                                BlendMode.srcIn),
                            height: 25,
                          ),
                          Positioned(
                            right: 0,
                            top: -2,
                            child: Container(
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: context.colorScheme.error,
                                shape: BoxShape.circle,
                              ),
                              constraints: BoxConstraints(
                                minWidth: 16,
                                minHeight: 16,
                              ),
                              child: Text(
                                '2',
                                style: TextStyle(
                                  color: context.colorScheme.onError,
                                  fontSize: 10,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
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
