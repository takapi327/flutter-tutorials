import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:stripe_payment/stripe_payment.dart';
import 'package:stripe_sdk/stripe_sdk_ui.dart';

class Page3 extends StatelessWidget {
  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();
  final formKey = new GlobalKey<FormState>();
  final card    = new StripeCard();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CardForm(card: card, formKey: formKey),
          TextButton(
              child: Text("決済する"),
              onPressed: () async {
                if (formKey.currentState.validate()) {
                  formKey.currentState.save();
                  final CreditCard _creditCard = CreditCard(
                      number:   card.number,
                      expMonth: card.expMonth,
                      expYear:  card.expYear
                  );
                  StripePayment.createTokenWithCard(_creditCard).then((token) async {
                    final url = 'http://localhost:9000/api/stripe/payment';
                    await http.post(
                        url,
                        body: {
                          'name':          'TEST TOMINAGA',
                          'email':         'test@ezweb.ne.jp',
                          'phone':         '09012345678',
                          'paymentMethod': token
                        }
                    );
                  });
                } else {
                  print('処理が通りませんでした。');
                }
              }
          )
        ],
      )
    );
  }
}
