import 'dart:async';
import 'package:bloc/bloc.dart';
import '../../../../domain/repositories/repository.dart';
import '../../../../domain/repositories/user_repository.dart';
import 'help_event.dart';
import 'help_state.dart';

class HelpBlock extends Bloc<HelpEvent, HelpState> {
  final Repository repository;
  final UserRepository userRepository;

  HelpBlock({
    required this.repository,
    required this.userRepository,
  }) : super(HelpInitialS()) {
    on<HelpLoadE>(_fetchHelp);
    add(HelpLoadE());
  }

  FutureOr<void> _fetchHelp(HelpLoadE event, Emitter<HelpState> emit) async {
    try {
      emit(HelpLoadingS());
      //String userRole = userRepository.getUserRole() ?? '';
      var response = await repository.getHelp(3);
      var items = response.content;
      for (var item in items) {
        if (item.icon != null && item.icon!.isNotEmpty) {
          var response = await repository.getHelpIcon(item.icon!) as String;
          item.rawSwg = response;
        }
      }
      emit(HelpLoadedS(content: response.content));
    } catch (e) {}
  }
}
