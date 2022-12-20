import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_hand_app/widgets/show_snack_bar.dart';

import '../bloc/offer_detail/offer_detail_bloc.dart';
import '../bloc/offer_detail/offer_detail_event.dart';

class ActionButton extends StatelessWidget {
  final String status;
  final String orderId;
  final String? phoneNumber;
  final String? message;
  const ActionButton(
      {super.key,
      required this.status,
      required this.orderId,
      this.phoneNumber,
      this.message});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (status == 'accepted') ...[
          ElevatedButton(
              onPressed: () {
                if (phoneNumber!.isNotEmpty) {
                  BlocProvider.of<OfferDetailBloc>(context)
                      .add(OpenWhatsApp("62$phoneNumber", message ?? "null"));
                } else {
                  showSnackBar(context, "Something went wrong...",
                      "buyer doesn't have phone number", ContentType.warning);
                }
              },
              child: const Text('Contact buyer'))
        ] else if (status == 'declined') ...[
          const Text('Offer Declined')
        ] else if (status == 'pending') ...[
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: ElevatedButton(
                onPressed: () {
                  BlocProvider.of<OfferDetailBloc>(context)
                      .add(PatchOffer(orderId, 'declined'));
                },
                child: const Text('Decline')),
          ),
          ElevatedButton(
              onPressed: () {
                BlocProvider.of<OfferDetailBloc>(context)
                    .add(PatchOffer(orderId, 'accepted'));
              },
              child: const Text('Accept'))
        ]
      ],
    );
  }
}
