import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/profile_repo.dart';
import 'details_gift_state.dart';

class DetailsGiftCubit extends Cubit<DetailsGiftState>{

  static DetailsGiftCubit get(context) => BlocProvider.of(context);

  DetailsGiftCubit(this.profileRepo) : super(DetailsGiftInitial());

  final ProfileRepo profileRepo;

  Future<void> fetchDetailsGift({required int id}) async {
    emit(DetailsGiftLoading());
    var result = await profileRepo.fetchDetailsGift(id: id);

    result.fold((failure) {
      log(failure.errorMessage);
      emit(DetailsGiftFailure(failure.errorMessage));
    }, (detailsGift) {
      emit(DetailsGiftSuccess(detailsGift));
    });
  }
}