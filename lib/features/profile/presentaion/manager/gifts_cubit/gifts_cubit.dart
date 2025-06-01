import 'dart:developer';

import 'package:alhadara_dashboard/features/profile/data/repos/profile_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'gifts_state.dart';

class GiftsCubit extends Cubit<GiftsState>{

  static GiftsCubit get(context) => BlocProvider.of(context);

  GiftsCubit(this.giftsRepo) : super(GiftsInitial());

  final ProfileRepo giftsRepo;

  Future<void> fetchGifts({required int page}) async {
    emit(GiftsLoading());
    var result = await giftsRepo.fetchGifts(page: page);

    result.fold((failure) {
      log(failure.errorMessage);
      emit(GiftsFailure(failure.errorMessage));
    }, (gifts) {
      emit(GiftsSuccess(gifts));
    });
  }
}