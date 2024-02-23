import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/add_edit/manage_job_cubit.dart';

import '../cubit/home/job_home_cubit.dart';
import '../cubit/search/job_search_cubit.dart';

class JobProviders {
  static get blocProviders => [
        BlocProvider<JobHomeCubit>(
          create: (context) => JobHomeCubit(),
        ),
        BlocProvider<ManageJobCubit>(
          create: (context) => ManageJobCubit(),
        ),
        BlocProvider<JobSearchCubit>(
          create: (context) => JobSearchCubit(),
        ),
      ];
}
