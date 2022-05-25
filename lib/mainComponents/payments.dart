import 'dart:async';
import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:paynow/paynow.dart';
import 'package:sublimed_health/components/constants.dart';
import 'package:sublimed_health/main_menu/pages/appointment_details.dart';
import '../components/constants.dart';


class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final String _status = "";
  var parser = EmojiParser();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "Make Payment",
            style: TextStyle(color: kPrimaryColor),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: kPrimaryColor),
            onPressed: () {
              // passing this to our root
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: Center(

                  child: Column(

                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        'Ecocash',
                        style: TextStyle(
                            fontSize: 30,
                            color: kPrimaryColor
                        ),
                      ),
                      TextField(
                        decoration: const InputDecoration(
                            icon: Icon(Icons.phone),
                            hintText: "Phone Number",
                            hintStyle: TextStyle(
                                color: kPrimaryColor
                            )
                        ),

                        keyboardType: TextInputType.phone,
                        controller: _phoneController,

                      ),
                      TextField(
                        decoration: const InputDecoration(
                            hintText: "150.00",
                            hintStyle: TextStyle(color: kPrimaryColor),
                            icon: Icon(Icons.monetization_on)
                        ),
                        keyboardType: TextInputType.number,
                        controller: _amountController,

                      ),
                      const SizedBox(height: 15,),

                      ArgonTimerButton(
                        height: 50,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.45,
                        minWidth: MediaQuery
                            .of(context)
                            .size
                            .width * 0.30,
                        highlightColor: Colors.transparent,
                        highlightElevation: 0,
                        roundLoadingShape: false,
                        onTap: (startTimer, btnState) {
                          if (btnState == ButtonState.Idle) {
                            startTimer(15);
                          }

                          Paynow paynow = Paynow(
                              integrationKey: " 1c2007b5-d0fa-4a38-8b5f-98a6265d05e5",
                              integrationId: "13539",
                              returnUrl: "http://google.com",
                              resultUrl: "http://google.com");
                          Payment payment = paynow.createPayment(
                              "nashe", "medannashe6@email.com");

                          final itemDescription = PaynowCartItem(
                              title: 'Consultation', amount: 150.0);

                          // add to cart
                          payment.addToCart(itemDescription);


                          // Initiate Mobile Payment
                          paynow.sendMobile(payment, _phoneController.text,
                              MobilePaymentMethod.ecocash).then((
                              InitResponse response) async {
                            // display results
                            if (kDebugMode) {
                              print(response());
                            }
                            await Future.delayed(const Duration(
                                seconds: 20 ~/ 2));
                            // Check Transaction status from pollUrl
                            paynow.checkTransactionStatus(response.pollUrl)
                                .then((StatusResponse status) {
                              if (kDebugMode) {
                                print(status.paid);
                              }
                            });
                          });
                        },
                        loader: (timeLeft) {
                          return Text(
                            "Wait | $timeLeft",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                          );
                        },
                        borderRadius: 28.0,
                        color: kPrimaryColor,
                        elevation: 5,


                        child: const Text(
                          "PAY",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      const SizedBox(height: 10,),


                    ],
                  ),
                ),

              ),

            ]
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const Details();
                },
              ),
            );
          },
          backgroundColor: kPrimaryColor,
          child: const Icon(Icons.done_outline, color: kPrimaryColor2,),
          // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }

}