import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/notification/notification_page_bloc.dart';
import '../../../bloc/notification/notification_page_events.dart';
import '../../../bloc/notification/notification_page_states.dart';
import '../../../models/notification_response.dart';
import '../../../repositories/market_repository.dart';
import '../../../widgets/notification_card.dart';
import '../../../widgets/show_loading.dart';
import '../../../widgets/show_snack_bar.dart';

class SellerNotificationList extends StatelessWidget {
  const SellerNotificationList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Seller Notification")),
      body: Column(
        children: [
          BlocProvider(
            create: (context) => NotificationBloc(MarketRepository()),
            child: BlocConsumer<NotificationBloc, NotificationState>(
              builder: (context, state) {
                if (state is NotificationInitState) {
                  BlocProvider.of<NotificationBloc>(context)
                      .add(GetNotification(type: "seller"));
                }
                if (state is NotificationLoadingState) {
                  return const ShowLoading();
                }

                if (state is NotificationLoadedState) {
                  List<NotificationResponse> data = state.products;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (_, index) {
                        final product = data[index];
                        return NotificationCard(notification: product);
                      },
                    ),
                  );
                }

                return Container();
              },
              listener: (context, state) {
                if (state is NotificationErrorState) {
                  showSnackBar(context, 'Something went wrong', state.error,
                      ContentType.failure);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
