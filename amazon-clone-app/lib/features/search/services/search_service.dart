// ignore_for_file: use_build_context_synchronously

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:amazoncloneapp/constants/error.dart';
import 'package:amazoncloneapp/constants/utils.dart';
import 'package:amazoncloneapp/models/product.dart';
import 'package:amazoncloneapp/providers/user_provider.dart';
import 'package:amazoncloneapp/constants/globals.dart';
import 'dart:convert';

class SearchServices {
  Future<List<Product>> fetchSearchProduct(
      {required BuildContext context, required String query}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response response = await http
          .get(Uri.parse('$uri/api/products/search/$query'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token
      });
      httpError(
          response: response,
          context: context,
          onSucess: () {
            for (int i = 0; i < jsonDecode(response.body).length; i++) {
              jsonEncode(jsonDecode(response.body)[i]['quantity']);
              productList.add(
                  Product.fromJson(jsonEncode(jsonDecode(response.body)[i])));
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }
}
