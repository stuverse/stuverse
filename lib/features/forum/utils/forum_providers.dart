import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuverse/features/forum/forum.dart';


import '../cubit/community/all/all_community_cubit.dart';

import '../cubit/community/members/community_members_cubit.dart';


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
        BlocProvider<CommunityDetailCubit>(
          create: (context) => CommunityDetailCubit(),
        ),

        BlocProvider<AllCommunityCubit>(
          create: (context) => AllCommunityCubit(),
),
        BlocProvider<CommunityMembersCubit>(
          create: (context) => CommunityMembersCubit(),
        ),
      ];
}
