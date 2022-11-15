// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'act_bloc.dart';

abstract class ActEvent extends Equatable {
  const ActEvent();

  @override
  List<Object> get props => [];
}

class ActRequestE extends ActEvent {
  final ProfileActParams params;
  const ActRequestE({
    required this.params,
  });

  @override
  List<Object> get props => [params];
}
