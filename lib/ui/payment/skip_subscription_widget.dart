// @dart=2.9

import 'package:ente_auth/core/event_bus.dart';
import 'package:ente_auth/events/subscription_purchased_event.dart';
import 'package:ente_auth/models/billing_plan.dart';
import 'package:ente_auth/models/subscription.dart';
import 'package:ente_auth/onboarding/view/onboarding_page.dart';
import 'package:ente_auth/services/billing_service.dart';
import 'package:flutter/material.dart';

class SkipSubscriptionWidget extends StatelessWidget {
  const SkipSubscriptionWidget({
    Key key,
    @required this.freePlan,
  }) : super(key: key);

  final FreePlan freePlan;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 64,
      margin: const EdgeInsets.fromLTRB(0, 30, 0, 0),
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: OutlinedButton(
        style: Theme.of(context).outlinedButtonTheme.style.copyWith(
          textStyle: MaterialStateProperty.resolveWith<TextStyle>(
            (Set<MaterialState> states) {
              return Theme.of(context).textTheme.subtitle1;
            },
          ),
        ),
        onPressed: () async {
          Bus.instance.fire(SubscriptionPurchasedEvent());
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return const OnboardingPage();
              },
            ),
            (route) => false,
          );
          BillingService.instance
              .verifySubscription(freeProductID, "", paymentProvider: "ente");
        },
        child: const Text("Continue on free plan"),
      ),
    );
  }
}