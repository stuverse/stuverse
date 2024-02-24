import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuverse/features/forum/forum.dart';

class ForumProviders {
  static get blocProviders => [
        BlocProvider<ThreadCommentCubit>(
          create: (context) => ThreadCommentCubit(),
        ),
        BlocProvider<ForumHomeCubit>(
          create: (context) => ForumHomeCubit(),
        ),
        BlocProvider<CommunityAdminCubit>(
          create: (context) => CommunityAdminCubit(),
        ),
      ];
}
