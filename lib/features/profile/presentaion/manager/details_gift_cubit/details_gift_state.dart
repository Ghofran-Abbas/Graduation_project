import 'package:equatable/equatable.dart';

import '../../../data/model/details_gift_model.dart';

abstract class DetailsGiftState extends Equatable{
  const DetailsGiftState();

  @override
  List<Object?> get props => [];
}

class DetailsGiftInitial extends DetailsGiftState{}
class DetailsGiftLoading extends DetailsGiftState{}
class DetailsGiftFailure extends DetailsGiftState{
  final String errorMessage;

  const DetailsGiftFailure(this.errorMessage);
}
class DetailsGiftSuccess extends DetailsGiftState{
  final DetailsGiftModel detailsGift;

  const DetailsGiftSuccess(this.detailsGift);
}