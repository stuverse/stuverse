import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuverse/features/forum/cubit/thread/summary/thread_summary_cubit.dart';
import 'package:stuverse/features/forum/forum.dart';


import '../cubit/community/all/all_community_cubit.dart';

import '../cubit/community/members/community_members_cubit.dart';
import '../cubit/thread/detail/thread_detail_cubit.dart';

class ForumProviders {
  static get blocProviders => [
        BlocProvider<ThreadCommentCubit>(
          create: (context) => ThreadCommentCubit(),
        ),
        BlocProvider<ThreadDetailCubit>(
          create: (context) => ThreadDetailCubit(),
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
        BlocProvider<ThreadSummaryCubit>(
          create: (context) => ThreadSummaryCubit(),
        ),
        
      ];
}
