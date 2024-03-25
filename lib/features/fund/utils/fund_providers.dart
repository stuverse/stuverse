import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuverse/features/fund/cubit/add_edit_fundProject/cubit/add_edit_fund_project_cubit.dart';
import 'package:stuverse/features/fund/cubit/home/fund_home_cubit.dart';

class FundProviders {
  static get blocProviders => [
        BlocProvider(create: (context) => FundHomeCubit()),
        BlocProvider(create: (context) => AddEditFundProjectCubit()),
      ];
}
