import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ministry/constants/constants.dart';

Future getUserComplaints(String track) async {
  debugPrint(track);

  final response = await http.get(
    Uri.https("new.ked-datacenter.com", 'api/$track'),
  );
  debugPrint(response.body);
  if (response.statusCode == 200) {
    Constants.userComplaints = (jsonDecode(response.body));
  } else {
    throw Exception('Faild to load Posts');
  }
}
