import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuverse/features/job/cubit/job_material/job_material_cubit.dart';

import '../cubit/add_edit/manage_job_cubit.dart';

import '../cubit/ai_search/job_ai_search_cubit.dart';
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
        BlocProvider<JobAiSearchCubit>(
          create: (context) => JobAiSearchCubit(),
        ),
        BlocProvider<JobMaterialCubit>(
          create: (context) => JobMaterialCubit(),
        ),
      ];
}
