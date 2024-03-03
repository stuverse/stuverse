import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuverse/features/profile/cubit/manage_profile_cubit.dart';

import '../cubit/skill/skill_cubit.dart';

class ProfileProviders {
  static get blocProviders => [
        BlocProvider<SkillCubit>(
          create: (context) => SkillCubit(),
        ),
        BlocProvider<ManageProfileCubit>(
          create: (context) => ManageProfileCubit(),
        ),
      ];
}
