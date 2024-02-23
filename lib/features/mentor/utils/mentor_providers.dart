import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuverse/features/mentor/cubit/add_post/add_edit_post_cubit.dart';

import '../cubit/home/mentor_home_cubit.dart';

class MentorProviders {
  static get blocProviders => [
        BlocProvider<MentorHomeCubit>(
          create: (context) => MentorHomeCubit(),
        ),
        BlocProvider<AddEditPostCubit>(
          create: (context) => AddEditPostCubit(),
        ),
      ];
}
