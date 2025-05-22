import 'dart:developer';
import 'dart:typed_data';

import 'package:alhadara_dashboard/features/secretary_features/course/data/repos/course_repo.dart';
import 'package:alhadara_dashboard/features/secretary_features/course/presentation/manager/create_course_cubit/create_course_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateCourseCubit extends Cubit<CreateCourseState>{

  static CreateCourseCubit get(context) => BlocProvider.of(context);

  final CourseRepo courseRepo;

  CreateCourseCubit(this.courseRepo) : super(CreateCourseInitial());

  Future<void> fetchCreateCourse({
    required int departmentId,
    required String name,
    required String description,
    required Uint8List photo,
  }) async {
    emit(CreateCourseLoading());
    var result = await courseRepo.fetchCreateCourse(
        departmentId: departmentId,
        name: name,
        description: description,
        photo: photo,
    );

    result.fold((failure) {
      log(failure.errorMessage);
      emit(CreateCourseFailure(failure.errorMessage));
    }, (createResult) {
      emit(CreateCourseSuccess(createResult));
    });
  }
}