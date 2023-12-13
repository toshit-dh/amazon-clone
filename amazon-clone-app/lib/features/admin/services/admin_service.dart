// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:amazoncloneapp/constants/error.dart';
import 'package:amazoncloneapp/constants/utils.dart';
import 'package:amazoncloneapp/features/admin/models/sales.dart';
import 'package:amazoncloneapp/models/order.dart';
import 'package:amazoncloneapp/models/product.dart';
import 'package:amazoncloneapp/constants/globals.dart';
import 'package:amazoncloneapp/providers/user_provider.dart';

class AdminServices {
  void sellProduct(
      {required BuildContext context,
      required String name,
      required String description,
      required double price,
      required double quantity,
      required String category,
      required List<File> images}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      final cloudinary = CloudinaryPublic('your-cloudinary-details', 'your-cloudinary-details');
      List<String> imageUrl = [];
      for (var i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary
            .uploadFile(CloudinaryFile.fromFile(images[i].path, folder: name));
        imageUrl.add(res.secureUrl);
      }
      Product product = Product(
          name: name,
          description: description,
          quantity: quantity,
          images: imageUrl,
          category: category,
          price: price);
      http.Response response = await http.post(
        Uri.parse('$uri/admin/add-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token
        },
        body: product.toJson(),
      );
      httpError(
          response: response,
          context: context,
          onSucess: () {
            showSnackBar(context, "Product Added Successfully");
            fetchAllProducts(context);
            Navigator.pop(context);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Product>> fetchAllProducts(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response response =
          await http.get(Uri.parse('$uri/admin/get-product'), headers: {
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

  void deleteProduct(
      {required BuildContext context,
      required Product product,
      required VoidCallback onSuccess}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response response =
          await http.post(Uri.parse('$uri/admin/delete-product'),
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
                'x-auth-token': userProvider.user.token
              },
              body: jsonEncode({'id': product.id}));
      httpError(
          response: response,
          context: context,
          onSucess: () {
            onSuccess();
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Order>> fetchAllOrders(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Order> orderList = [];
    try {
      http.Response response =
          await http.get(Uri.parse('$uri/admin/get-orders'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token
      });
      httpError(
          response: response,
          context: context,
          onSucess: () {
            for (int i = 0; i < jsonDecode(response.body).length; i++) {
              jsonEncode(jsonDecode(response.body)[i]['quantity']);
              orderList.add(
                  Order.fromJson(jsonEncode(jsonDecode(response.body)[i])));
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return orderList;
  }

  void changeOrderStatus(
      {required BuildContext context,
      required Order order,
      required int status,
      required VoidCallback onSuccess}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response response =
          await http.post(Uri.parse('$uri/admin/change-order-status'),
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
                'x-auth-token': userProvider.user.token
              },
              body: jsonEncode({'id': order.id, 'status': status}));
      httpError(
          response: response,
          context: context,
          onSucess: () {
            onSuccess();
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<Map<String, dynamic>> earningsStats(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Sales> sales = [];
    int totalEarnings = 0;
    try {
      http.Response response =
          await http.get(Uri.parse('$uri/admin/analytics'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token
      });
      httpError(
          response: response,
          context: context,
          onSucess: () {
            var res = jsonDecode(response.body);
            totalEarnings = res['totalEarnings'];
            sales = [
              Sales(label: 'Mobiles', earnings: res['mobileEarnings']),
              Sales(label: 'Essentials', earnings: res['essentialsEarnings']),
              Sales(label: 'Appliances', earnings: res['appliancesEarnings']),
              Sales(label: 'Books', earnings: res['booksEarnings']),
              Sales(label: 'Fashion', earnings: res['fashionEarnings']),
            ];
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return {
      'sales': sales,
      'totalEarnings': totalEarnings,
    };
  }
}
