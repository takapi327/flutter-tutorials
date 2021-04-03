import 'dart:convert';

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
          FloatingActionButton(
              child: Text("決済する"),
              onPressed: () async {
                if (formKey.currentState.validate()) {
                  formKey.currentState.save();
                  final CreditCard _creditCard = CreditCard(
                    number:   card.number,
                    expMonth: card.expMonth,
                    expYear:  card.expYear
                  );
                  final PaymentMethodRequest _paymentMethodRequest = PaymentMethodRequest(
                    card: _creditCard
                  );
                  StripePayment.setOptions(
                    StripeOptions(
                      publishableKey: "pk_test_51IZrtWJd0VKBQGZhjcHLHLyzjVnt850eXPu9GGgyVKgeC0D6QPY30KkaLWtgXcVstMHrUkXYsElC7UdCDzxeihbj00vnFMsF5c"
                    )
                  );
                  StripePayment.createPaymentMethod(_paymentMethodRequest).then((paymentMethod) async {
                    final url     = 'http://10.0.2.2:9000/api/stripe/payment';
                    final headers = {'content-type': 'application/json'};
                    final body    = json.encode({
                      "name":          "TEST TAKAHIKO",
                      "email":         "test-test@ezweb.ne.jp",
                      "phone":         "09000001234",
                      "paymentMethod": paymentMethod.id
                    });
                    http.Response resp = await http.post(
                      url,
                      headers: headers,
                      body:    body
                    );
                    if (resp.statusCode != 200) {
                      print("====================");
                      print(resp.body);
                      print("====================");
                    }
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
