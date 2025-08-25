import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/task_repo.dart';
import 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState>{
  static TasksCubit get(context) => BlocProvider.of(context);

  final TaskRepo taskRepo;

  TasksCubit(this.taskRepo) : super(TasksInitial());

  Future<void> fetchTasks({required int page}) async {
    emit(TasksLoading());
    var result = await taskRepo.fetchTasks(page: page);

    result.fold((failure) {
      log(failure.errorMessage);
      emit(TasksFailure(failure.errorMessage));
    }, (tasks) {
      emit(TasksSuccess(tasks));
    });
  }
}