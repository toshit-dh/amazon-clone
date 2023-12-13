// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:amazoncloneapp/constants/error.dart';
import 'package:amazoncloneapp/constants/utils.dart';
import 'package:amazoncloneapp/common/widgets/bottom_bar_user.dart';
import 'package:amazoncloneapp/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:amazoncloneapp/providers/user_provider.dart';
import '../../../constants/globals.dart';

class AuthService {
  void signup({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
          id: '',
          name: name,
          email: email,
          password: password,
          address: '',
          type: '',
          token: '',
          cart: []);
      http.Response res = await http.post(Uri.parse('$uri/api/signup'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });
      httpError(
          response: res,
          context: context,
          onSucess: () {
            showSnackBar(context,
                "Accout has been created. Login with same credentials.");
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void login({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      BuildContext currentContext = context;
      http.Response res = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({'email': email, 'password': password}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );
      httpError(
          response: res,
          context: currentContext,
          onSucess: () {
            onLogin(currentContext, res);
            Navigator.pushNamedAndRemoveUntil(
                currentContext, BottomBar.routeName, (route) => false);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void onLogin(BuildContext currentContext, http.Response res) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Provider.of<UserProvider>(currentContext, listen: false).setUser(res.body);
    await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
  }

  void getuserData(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      if (token == null) {
        prefs.setString('x-auth-token', '');
      }
      var tokenRes = await http.post(Uri.parse('$uri/tokenisValid'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token!
          });
      var response = jsonDecode(tokenRes.body);
      if (response == true) {
        http.Response userresponse = await http.get(Uri.parse('$uri/'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'x-auth-token': token
            });
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userresponse.body);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
