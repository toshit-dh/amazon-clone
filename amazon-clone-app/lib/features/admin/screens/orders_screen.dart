import 'package:flutter/material.dart';
import 'package:amazoncloneapp/common/widgets/loader.dart';
import 'package:amazoncloneapp/constants/globals.dart';
import 'package:amazoncloneapp/features/account/widgets/product.dart';
import 'package:amazoncloneapp/features/admin/services/admin_service.dart';
import 'package:amazoncloneapp/features/orderDetails/screens/order_details_screen.dart';
import 'package:amazoncloneapp/models/order.dart';

class OrdersScreenAdmin extends StatefulWidget {
  const OrdersScreenAdmin({super.key});

  @override
  State<OrdersScreenAdmin> createState() => _OrdersScreenAdminState();
}

class _OrdersScreenAdminState extends State<OrdersScreenAdmin> {
  final AdminServices adminServices = AdminServices();
  List<Order>? orderList;
  @override
  void initState() {
    super.initState();
    fetchAllOrders();
  }

  void fetchAllOrders() async {
    orderList = await adminServices.fetchAllOrders(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  'assets/images/amazon_in.png',
                  width: 120,
                  height: 45,
                  color: Colors.black,
                ),
              ),
              const Text(
                "Admin",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              )
            ],
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(gradient: Globals.appBarGradient),
          ),
        ),
      ),
      body: orderList == null
          ? const Loader()
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                itemCount: orderList!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  final orderData = orderList![index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, OrderDetailsScreen.routeName,
                          arguments: orderData);
                    },
                    child: SizedBox(
                      height: 140,
                      child: Products(
                        image: orderData.products[0].images[0],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
