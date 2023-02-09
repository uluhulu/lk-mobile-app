part of 'app_loader_bloc.dart';

class AppLoaderState extends Equatable {
  final bool isLoading;
  const AppLoaderState({
    required this.isLoading,
  });

  @override
  List<Object> get props => [isLoading];

  AppLoaderState copyWith({
    bool? isLoading,
  }) {
    return AppLoaderState(
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
