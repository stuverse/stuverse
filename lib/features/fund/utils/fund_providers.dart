import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuverse/features/fund/cubit/cubit/home_cubit.dart';

class FundProviders {
  static get blocProviders =>
      [BlocProvider(create: (context) => FundHomeCubit())];
}
