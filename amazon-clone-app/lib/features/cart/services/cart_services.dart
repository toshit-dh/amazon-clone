// ignore_for_file: use_build_context_synchronously

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:amazoncloneapp/constants/error.dart';
import 'package:amazoncloneapp/constants/utils.dart';
import 'package:amazoncloneapp/models/product.dart';
import 'package:amazoncloneapp/models/user.dart';
import 'package:amazoncloneapp/providers/user_provider.dart';
import 'package:amazoncloneapp/constants/globals.dart';
import 'dart:convert';

class CartServices {
  void removeFromCartProduct({
    required BuildContext context,
    required Product product,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response response = await http.delete(
        Uri.parse('$uri/api/remove-product-from-cart/${product.id}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token
        },
      );
      httpError(
          response: response,
          context: context,
          onSucess: () {
            User user = userProvider.user
                .copyWith(cart: jsonDecode(response.body)['cart']);
            userProvider.setUserFromModel(user);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
