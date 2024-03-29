import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuverse/app/app.dart';

class CommonProviders {
  static get blocProviders => [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => CoreCubit()),
        BlocProvider(create: (context) => HomeCubit()),
        BlocProvider(create: (context) => AICubit()),
        BlocProvider(create: (context) => UserRequestCubit()),
        BlocProvider(create: (context) => ManageUserRequestCubit()),
        BlocProvider(create: (context) => UsersListCubit()),
      ];
}
