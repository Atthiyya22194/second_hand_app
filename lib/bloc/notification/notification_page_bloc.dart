import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../repositories/market_repository.dart';
import 'notification_page_events.dart';
import 'notification_page_states.dart';

class NotificationBloc extends Bloc<NotificationPageEvent, NotificationState> {
  NotificationBloc(this._repository) : super(NotificationInitState()) {
    on<GetNotification>(_getNotification);
  }

  final MarketRepository _repository;

  Future<void> _getNotification(
      GetNotification event, Emitter<NotificationState> emit) async {
    emit(NotificationLoadingState());
    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('accessToken');
      final data = await _repository.getNotification(
          accessToken: accessToken!, type: event.type);
      emit(NotificationLoadedState(data));
    } catch (e) {
      emit(NotificationErrorState(e.toString()));
    }
  }
}
