import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuverse/features/mentor/cubit/manage_mentor_post/manage_mentor_post_cubit.dart';
import 'package:stuverse/features/mentor/cubit/mentor_request/cubit/mentorship_request_cubit.dart';

import '../cubit/home/cubit/mentor_home_cubit.dart';
import '../cubit/manage_mentor_request/cubit/manage_mentor_request_cubit.dart';
import '../cubit/search/mentor_search_cubit.dart';

class MentorProviders {
  static get blocProviders => [
        BlocProvider<MentorHomeCubit>(
          create: (context) => MentorHomeCubit(),
        ),
        BlocProvider<ManageMentorPostCubit>(
          create: (context) => ManageMentorPostCubit(),
        ),
        BlocProvider<MentorSearchCubit>(
          create: (context) => MentorSearchCubit(),
        ),
        BlocProvider<MentorshipRequestCubit>(
          create: (context) => MentorshipRequestCubit(),
        ),
         BlocProvider<ManageMentorRequestCubit>(
          create: (context) => ManageMentorRequestCubit(),
        ),
      ];
}
