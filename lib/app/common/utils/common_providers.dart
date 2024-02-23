import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuverse/app/app.dart';

class CommonProviders {
  static get blocProviders => [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => CoreCubit()..getInitialData()),
        BlocProvider(create: (context) => HomeCubit()),
        BlocProvider(create: (context) => AICubit()),
      ];
}
