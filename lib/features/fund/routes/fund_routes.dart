import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:stuverse/features/fund/cubit/home/fund_home_cubit.dart';
import 'package:stuverse/features/fund/fund.dart';
import 'package:stuverse/features/fund/models/projects.dart';
import 'package:stuverse/features/fund/views/donate_page.dart';
import 'package:stuverse/features/fund/views/project_desc.dart';
import 'package:stuverse/features/fund/views/project_search_screen.dart';
import 'package:stuverse/features/fund/widgets/project_card.dart';

class FundRoutes {
  //! ---DO NOT MODIFY-----
  static const String fundHome = '/fund';
  static final GoRoute fundHomeRoute = GoRoute(
    path: fundHome,
    builder: (context, state) => const FundHomeScreen(),
  );
  //! ----------------

  static const String projectDesc = '/fund/projectdesc';
  static const String donationpage = '/fund/donation';
  static const String search = '/fund/search';

  static List<GoRoute> fundRoutes = [
    GoRoute(
      path: projectDesc,
      builder: (context, state) => ProjectDescScreen(
        project: state.extra as Projects,
      ),
    ),
    GoRoute(path: donationpage, builder: (context, state) => DonatePage()),
    GoRoute(
      path: search,
      builder: (context, state) => BlocProvider(
        key: const Key("fund_search_cubit"),
        create: (context) => FundHomeCubit(),
        child: ProjectSearchScreen(),
      ),
    ),
  ];
}
