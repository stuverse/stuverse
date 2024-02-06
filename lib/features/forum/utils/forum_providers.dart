import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/comment/comment_cubit.dart';

class ForumProviders {
  static get blocProviders => [
        BlocProvider<CommentCubit>(
          create: (context) => CommentCubit(),
        ),
      ];
}
