import 'package:flutter/cupertino.dart';

class PaymentDetails {
  String? name;
  IconData? icon;

  PaymentDetails({this.name, this.icon});

  PaymentDetails.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['icon'] = this.icon;
    return data;
  }
}
