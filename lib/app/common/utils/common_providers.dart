import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuverse/app/app.dart';

import '../auth/cubit/users_list/users_list_cubit.dart';

class CommonProviders {
  static get blocProviders => [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => CoreCubit()),
        BlocProvider(create: (context) => HomeCubit()),
        BlocProvider(create: (context) => AICubit()),
        BlocProvider(create: (context) => UserRequestCubit()),
        BlocProvider(create: (context) => ManageUserRequestCubit()),
        BlocProvider(create: (context) => UsersSelectionCubit()),
        BlocProvider(create: (context) => SkillCubit()),
        BlocProvider(create: (context) => UsersListCubit()),
             BlocProvider(create: (context) => ReportCubit()),
      ];
}
