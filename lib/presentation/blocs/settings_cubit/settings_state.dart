// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  final bool savePhoto;

  const SettingsState({this.savePhoto = true});

  @override
  List<Object> get props => [savePhoto];
}
