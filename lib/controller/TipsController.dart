import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:winninbets/models/Prediction.dart';

const String apiUrl = 'http://192.168.43.69:8000/api/tips/';

//Get Todays Tips: TODO: filter by date

Future<List<dynamic>> getTips() async {
  var response = await http.get(apiUrl);
  if(response.statusCode == 200) {
    final items = json.decode(response.body).cast<Map<String, dynamic>>();
    List<dynamic> tips = items.map((json) {
      return json['fields'];
    }).toList();
    return tips;
  } else {
    return null;
  }
}

// Get all tips
Future<List<dynamic>> getAllTips() async {
  var response = await http.get(apiUrl);
  if(response.statusCode == 200) {
    final items = json.decode(response.body).cast<Map<String, dynamic>>();
    List<dynamic> tips = items.map((json) {
      return json['fields'];
    }).toList();
    return tips;
  } else {
    return null;
  }
}