import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/add_edit/add_edit_job_post_cubit.dart';

import '../cubit/home/job_home_cubit.dart';

class JobProviders {
  static get blocProviders => [
        BlocProvider<JobHomeCubit>(
          create: (context) => JobHomeCubit(),
        ),
        BlocProvider<AddEditJobPostCubit>(
          create: (context) => AddEditJobPostCubit(),
        )
      ];
}
