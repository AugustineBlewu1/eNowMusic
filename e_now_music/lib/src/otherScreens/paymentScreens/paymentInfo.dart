import 'package:e_now_music/src/otherScreens/music/musicUpload.dart';
import 'package:e_now_music/src/utils/customUsage.dart';
import 'package:flutter/material.dart';
import 'package:e_now_music/src/utils/navigators.dart';
import 'package:intl/intl.dart';

class PaymentInfo extends StatefulWidget {
  const PaymentInfo({Key? key}) : super(key: key);

  @override
  _PaymentInfoState createState() => _PaymentInfoState();
}

class _PaymentInfoState extends State<PaymentInfo> {
  bool switchButton = false;

  TextEditingController dateInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarPreferred(appBarName: 'Payment Info', context: context),
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 33.0),
            child: Column(
              children: [
                SizedBox(
                  height: 30.0,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    hintText: 'Card Name',
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    hintText: 'Card Number',
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 95.0,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          hintText: 'CVV',
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 189.0,
                      child: TextFormField(
                          controller: dateInput,
                          decoration: InputDecoration(
                              hintText: 'Expired date',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0))),
                          onTap: () async {
                            DateTime? datepicker = await showDatePicker(
                              context: context,
                              firstDate: DateTime(1980),
                              lastDate: DateTime(2044),
                              initialDate: DateTime.now(),
                            );

                            if (datepicker != null) {
                              setState(() {
                                String formattedDate =
                                    DateFormat('dd-MM-yyyy').format(datepicker);
                                dateInput.text = formattedDate;
                              });
                            } else {
                              return;
                            }
                          }),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Save your card information'),
                    Switch(
                        value: switchButton,
                        onChanged: (value) {
                          setState(() {
                            switchButton = !switchButton;
                          });
                        })
                  ],
                ),
                SizedBox(
                  height: 30.0,
                ),
                SizedBox(
                    width: 319,
                    height: 49,
                    child: ElevatedButton(
                      onPressed: () {
                        context.push(screen: MusicUpload());
                      },
                      child: Text('Save'),
                      style: buttonStyle.copyWith(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)))),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
