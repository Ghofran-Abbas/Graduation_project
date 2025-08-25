import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/task_repo.dart';
import 'update_task_state.dart';

class UpdateTaskCubit extends Cubit<UpdateTaskState>{
  static UpdateTaskCubit get(context) => BlocProvider.of(context);

  final TaskRepo taskRepo;

  UpdateTaskCubit(this.taskRepo) : super(UpdateTaskInitial());

  Future<void> fetchUpdateTask({required int taskId, required String state}) async {
    emit(UpdateTaskLoading());
    var result = await taskRepo.fetchUpdateSection(taskId: taskId, state: state);

    result.fold((failure) {
      log(failure.errorMessage);
      emit(UpdateTaskFailure(failure.errorMessage));
    }, (result) {
      emit(UpdateTaskSuccess(result));
    });
  }
}