import 'package:flutter/material.dart';
import 'package:amazoncloneapp/features/address/screens/address_screen.dart';
import 'package:amazoncloneapp/features/admin/screens/add_product_screen.dart';
import 'package:amazoncloneapp/features/auth/screens/auth_screen.dart';
import 'package:amazoncloneapp/features/home/screens/category_product.dart';
import 'package:amazoncloneapp/features/home/screens/home_screen.dart';
import 'package:amazoncloneapp/common/widgets/bottom_bar_user.dart';
import 'package:amazoncloneapp/features/orderDetails/screens/order_details_screen.dart';
import 'package:amazoncloneapp/features/search/screens/search_screen.dart';
import 'package:amazoncloneapp/models/order.dart';
import 'package:amazoncloneapp/models/product.dart';
import 'package:amazoncloneapp/product_details/screens/product_details.dart';

Route<dynamic> generateRoutes(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const AuthScreen());
    case HomeScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const HomeScreen());
    case BottomBar.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const BottomBar());
    case AddProductScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const AddProductScreen());
    case CategoryProduct.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => CategoryProduct(category: category));
    case SearchScreen.routeName:
      var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => SearchScreen(searchQuery: searchQuery));
    case ProductDetails.routeName:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => ProductDetails(product: product));
    case AddressScreen.routeName:
      var totalAmount = routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => AddressScreen(
                totalAmount: totalAmount,
              ));
    case OrderDetailsScreen.routeName:
      var order = routeSettings.arguments as Order;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => OrderDetailsScreen(order: order));
    default:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const Scaffold(
                body: Center(
                  child: Text("Screen doesn't exists!"),
                ),
              ));
  }
}
