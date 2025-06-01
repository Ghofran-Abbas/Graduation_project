import 'package:equatable/equatable.dart';

import '../../../data/model/gifts_model.dart';

abstract class GiftsState extends Equatable{
  const GiftsState();

  @override
  List<Object?> get props => [];
}

class GiftsInitial extends GiftsState{}
class GiftsLoading extends GiftsState{}
class GiftsFailure extends GiftsState{
  final String errorMessage;

  const GiftsFailure(this.errorMessage);
}
class GiftsSuccess extends GiftsState{
  final GiftsModel gifts;

  const GiftsSuccess(this.gifts);
}