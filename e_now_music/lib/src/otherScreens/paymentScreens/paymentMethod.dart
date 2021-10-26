import 'package:e_now_music/src/otherScreens/models/paymentModel.dart';
import 'package:e_now_music/src/otherScreens/paymentScreens/paymentInfo.dart';
import 'package:e_now_music/src/utils/customUsage.dart';
import 'package:flutter/material.dart';
import 'package:e_now_music/src/utils/navigators.dart';
import 'package:ionicons/ionicons.dart';

class SelectPaymentMethod extends StatefulWidget {
  const SelectPaymentMethod({Key? key}) : super(key: key);

  @override
  _SelectPaymentMethodState createState() => _SelectPaymentMethodState();
}

class _SelectPaymentMethodState extends State<SelectPaymentMethod> {
  List<Map<String, dynamic>> radioItems = [
    {'name': 'Paypal', 'icon': 'Ionicons.logo_paypal'},
    {'name': 'Credit Card', 'icon': 'Icons.payment'},
    {'name': 'Google Pay', 'icon': 'Ionicons.logo_google'},
    {'name': 'Mobile payment', 'icon': ''}
  ];
  List sammy = ['a', 'b'];
  List<PaymentDetails> data = [];

  String? radioItemvalue;

  ValueChanged<String?> _paymentMethod() {
    return (value) => setState(() => radioItemvalue = value!);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarPreferred(context: context, appBarName: 'Payment Method'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30.0,
            ),
            Text('Select your payment method',
                style: context.textTheme.button!
                    .copyWith(fontWeight: FontWeight.bold)),
            SizedBox(
              height: 30,
            ),
            Text(
              'Add a new credit/debit method',
              style: context.textTheme.caption,
            ),
            SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                return _paymentMethod().call('1');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Ionicons.logo_paypal),
                      SizedBox(
                        width: 30.0,
                      ),
                      Text(
                        'PayPal',
                        style: context.textTheme.bodyText2,
                      ),
                    ],
                  ),
                  Radio(
                      value: '1',
                      groupValue: radioItemvalue,
                      onChanged: _paymentMethod())
                ],
              ),
            ),
            InkWell(
              onTap: () {
                return _paymentMethod().call('2');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.payment),
                      SizedBox(
                        width: 30.0,
                      ),
                      Text('Credit Card'),
                    ],
                  ),
                  Radio(
                      value: '2',
                      groupValue: radioItemvalue,
                      onChanged: _paymentMethod())
                ],
              ),
            ),
            InkWell(
              onTap: () {
                return _paymentMethod().call('3');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Ionicons.logo_google),
                      SizedBox(
                        width: 30.0,
                      ),
                      Text('Google Pay'),
                    ],
                  ),
                  Radio(
                      value: '3',
                      groupValue: radioItemvalue,
                      onChanged: _paymentMethod())
                ],
              ),
            ),
            InkWell(
              onTap: () {
                return _paymentMethod().call('4');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.phone_android),
                      SizedBox(
                        width: 30.0,
                      ),
                      Text('Mobile Payment'),
                    ],
                  ),
                  Radio(
                      value: '4',
                      groupValue: radioItemvalue,
                      onChanged: _paymentMethod())
                ],
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
            SizedBox(
                width: 319,
                height: 49,
                child: ElevatedButton(
                  onPressed: () {
                    if (radioItemvalue == null) {
                      showSnackError(context, error: 'Select a payment method');
                    } else {
                      context.push(screen: PaymentInfo());
                    }
                  },
                  child: Text('Add'),
                  style: buttonStyle.copyWith(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)))),
                ))
          ],
        ),
      ),
    );
  }
}
