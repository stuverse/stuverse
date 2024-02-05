import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/comment/comment_cubit.dart';
import '../cubit/vote/vote_cubit.dart';

class ForumProviders {
  static get blocProviders => [
        BlocProvider<VoteCubit>(
          create: (context) => VoteCubit(),
        ),
        BlocProvider<CommentCubit>(
          create: (context) => CommentCubit(),
        ),
      ];
}
