import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:loginauth/navigate.dart';

class HttpService {
  static final _client = http.Client();

  static final _loginUrl = Uri.parse('http://10.0.2.2:5000/login');

  static login(email, password, context) async {

    http.Response response = await _client.post(_loginUrl, body: {
      "email": email,
      "password": password,
    });
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      var json = jsonDecode(response.body);

      if (json[0] == 'success') {
        await EasyLoading.showSuccess(json[0]);
        await Navigator.push(
            context, MaterialPageRoute(builder: (context) => navigate()));
      } else {
        EasyLoading.showError(json[0]);
      }
    } else {
      await EasyLoading.showError(
          "Error Code : ${response.statusCode.toString()}");
    }
  }
}