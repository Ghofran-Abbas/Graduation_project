import 'package:alhadara_dashboard/core/utils/service_locator.dart';
import 'package:alhadara_dashboard/features/secretary_features/task/data/repos/task_repo_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/tasks_cubit/tasks_cubit.dart';
import '../manager/update_task_cubit/update_task_cubit.dart';
import 'widgets/tasks_view_body.dart';

class TasksView extends StatelessWidget {
  const TasksView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return TasksCubit(
              getIt.get<TaskRepoImpl>(),
            )..fetchTasks(page: 1);
          },
        ),
        BlocProvider(
          create: (context) {
            return UpdateTaskCubit(
              getIt.get<TaskRepoImpl>(),
            );
          },
        ),
      ],
      child: TasksViewBody(),);
  }
}
