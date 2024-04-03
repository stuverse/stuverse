import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuverse/features/profile/cubit/delete_account/delete_account_cubit.dart';
import 'package:stuverse/features/profile/cubit/manage_profile_cubit.dart';
import 'package:stuverse/features/profile/cubit/reset_password/reset_password_cubit.dart';

class ProfileProviders {
  static get blocProviders => [
        BlocProvider<ManageProfileCubit>(
          create: (context) => ManageProfileCubit(),
        ),
        BlocProvider<DeleteAccountCubit>(
          create: (context) => DeleteAccountCubit(),
        ),
        BlocProvider<ResetPasswordCubit>(
          create: (context) => ResetPasswordCubit(),
        ),
      ];
}
