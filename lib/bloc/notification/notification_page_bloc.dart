import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../repositories/market_repository.dart';
import 'notification_page_events.dart';
import 'notification_page_states.dart';

class NotificationBloc extends Bloc<HomePageEvent, NotificationState> {
  final MarketRepository _repository;

  NotificationBloc(this._repository) : super(NotificationInitState()) {
    on<GetNotification>(_getNotification);
  }

  Future<void> _getNotification(
      GetNotification event, Emitter<NotificationState> emit) async {
    emit(NotificationLoadingState());
    print('loading');
    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('accessToken');
      final data = await _repository.getNotification(
          accessToken: accessToken!, type: event.type);
      emit(NotificationLoadedState(data));
      print('success');
      print(data);
    } catch (e) {
      emit(NotificationErrorState(e.toString()));
      print('error: $e');
    }
  }
}
