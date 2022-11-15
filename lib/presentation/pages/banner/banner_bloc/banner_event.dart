part of 'banner_bloc.dart';

abstract class BannerEvent extends Equatable {
  const BannerEvent();

  @override
  List<Object> get props => [];
}

class BannerInitializeE extends BannerEvent {}

class BannerSetPinShowedE extends BannerEvent {}

class BannerRemoveAllE extends BannerEvent {}

class BannerPostInitE extends BannerEvent {}
