import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'poppins_text.dart';
import 'rounded_button.dart';
import 'show_snack_bar.dart';

import '../bloc/offer_detail/offer_detail_bloc.dart';
import '../bloc/offer_detail/offer_detail_event.dart';

class ActionButton extends StatelessWidget {
  const ActionButton(
      {super.key,
      required this.status,
      required this.orderId,
      this.phoneNumber,
      this.message});

  final String? message;
  final String orderId;
  final String? phoneNumber;
  final String status;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (status == 'accepted') ...[
          RoundedButton(
              onPressed: () {
                if (phoneNumber!.isNotEmpty) {
                  BlocProvider.of<OfferDetailBloc>(context).add(
                    OpenWhatsApp("$phoneNumber", message ?? "null"),
                  );
                } else {
                  showSnackBar(context, "Something went wrong...",
                      "buyer doesn't have phone number", ContentType.warning);
                }
              },
              text: 'Contact buyer')
        ] else if (status == 'declined') ...[
          const PoppinsText(text: 'Offer Declined')
        ] else if (status == 'pending') ...[
          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(0, 0, 8 * fem, 0),
              child: RoundedButton(
                  onPressed: () {
                    BlocProvider.of<OfferDetailBloc>(context).add(
                      PatchOffer(orderId, 'declined'),
                    );
                  },
                  text: 'Decline'),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(0, 0, 8 * fem, 0),
              child: RoundedButton(
                  onPressed: () {
                    BlocProvider.of<OfferDetailBloc>(context).add(
                      PatchOffer(orderId, 'accepted'),
                    );
                  },
                  text: 'Accept'),
            ),
          )
        ]
      ],
    );
  }
}
