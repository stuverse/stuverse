import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/skill/skill_cubit.dart';

class ProfileProviders {
  static get blocProviders => [
        BlocProvider<SkillCubit>(
          create: (context) => SkillCubit(),
        ),
      ];
}
