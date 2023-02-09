import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_loader_event.dart';
part 'app_loader_state.dart';

class AppLoaderBloc extends Bloc<AppLoaderEvent, AppLoaderState> {
  AppLoaderBloc() : super(const AppLoaderState(isLoading: false)) {
    on<AppLoaderStartE>((event, emit) {
      emit(state.copyWith(isLoading: true));
    });
    on<AppLoaderStopE>((event, emit) {
      emit(state.copyWith(isLoading: false));
    });
  }
}
