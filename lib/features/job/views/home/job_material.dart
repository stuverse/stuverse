import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuverse/features/job/cubit/job_material/job_material_cubit.dart';
import 'package:stuverse/features/job/widgets/job_material_card.dart';

class JobMaterialsScreen extends StatefulWidget {
  const JobMaterialsScreen({super.key});

  @override
  State<JobMaterialsScreen> createState() => _JobMaterialsState();
}

class _JobMaterialsState extends State<JobMaterialsScreen> {
  @override
  void initState() {
    context.read<JobMaterialCubit>().getJobMaterial();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Materials'),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Scrollbar(
          thumbVisibility: true,
          child: RefreshIndicator(
            onRefresh: () async {
              context.read<JobMaterialCubit>().getJobMaterial();
            },
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: BlocBuilder<JobMaterialCubit, JobMaterialState>(
                builder: (context, state) {
                  if (state is JobMaterialSuccess) {
                    return Column(
                      children: [
                        for (final material in state.materialsList)
                          JobMaterialCard(material: material),
                      ],
                    );
                  }

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ),
        ),
      )),
    );
  }
}
