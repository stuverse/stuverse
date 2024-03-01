import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:stuverse/features/fund/fund.dart';
import 'package:stuverse/features/fund/models/projects.dart';
import 'package:stuverse/features/fund/views/project_desc.dart';
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

  static List<GoRoute> fundRoutes = [
    GoRoute(
      path: projectDesc,
      builder: (context, state) => ProjectDescScreen(
        project: state.extra as Projects,
      ),
    ),
    // GoRoute(
    //   path: '/mentor/manage',
    //   builder: (context, state) => const MentorManageScreen(),
    // ),
  ];
}
