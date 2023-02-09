// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

import '../../../../data/api/help/entity/help_entity.dart';

abstract class HelpState extends Equatable {
  const HelpState();

  @override
  List<Object> get props => [];
}

class HelpInitialS extends HelpState {}

class HelpLoadingS extends HelpState {}

class HelpLoadedS extends HelpState {
  final List<Content> content;

  const HelpLoadedS({required this.content});

  @override
  List<Object> get props => [content];
}

class HelpErrorS extends HelpState {}
