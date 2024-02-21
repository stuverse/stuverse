import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/home/mentor_home_cubit.dart';


class MentorProviders {
  static get blocProviders => [
        BlocProvider<MentorHomeCubit>(
          create: (context) => MentorHomeCubit(),
        ),
      ];
}
