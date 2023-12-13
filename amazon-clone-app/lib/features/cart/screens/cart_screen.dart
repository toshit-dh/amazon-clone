import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:amazoncloneapp/common/widgets/buttons.dart';
import 'package:amazoncloneapp/constants/globals.dart';
import 'package:amazoncloneapp/features/address/screens/address_screen.dart';
import 'package:amazoncloneapp/features/cart/widgets/cart_product.dart';
import 'package:amazoncloneapp/features/cart/widgets/cart_subtotal.dart';
import 'package:amazoncloneapp/features/home/widgets/address_box.dart';
import 'package:amazoncloneapp/features/search/screens/search_screen.dart';
import 'package:amazoncloneapp/providers/user_provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void navigatetoSearch(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  void navigatetoAddress(int sum) {
    Navigator.pushNamed(context, AddressScreen.routeName,
        arguments: sum.toString());
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    int sum = 0;
    user.cart
        .map((e) => sum += e['quantity'] * e['product']['price'] as int)
        .toList();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  margin: const EdgeInsets.only(left: 15),
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      onFieldSubmitted: navigatetoSearch,
                      decoration: InputDecoration(
                          prefixIcon: InkWell(
                            onTap: () {},
                            child: const Padding(
                              padding: EdgeInsets.only(left: 6),
                              child: Icon(
                                Icons.search,
                                color: Colors.black,
                                size: 23,
                              ),
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.only(top: 10),
                          border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(7),
                              ),
                              borderSide: BorderSide.none),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(7),
                            ),
                            borderSide:
                                BorderSide(color: Colors.black38, width: 1),
                          ),
                          hintText: 'Search Amazon.in',
                          hintStyle: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 17)),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.transparent,
                height: 42,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: const Icon(
                  Icons.mic,
                  size: 25,
                  color: Colors.black,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Icon(Icons.notifications_outlined),
                    ),
                  ],
                ),
              ),
            ],
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(gradient: Globals.appBarGradient),
          ),
        ),
      ),
      body: user.cart.isEmpty
          ? const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Cart is empty. ",
                style: TextStyle(fontSize: 20),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  const AddressBox(),
                  const CartTotal(),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Button(
                      onpressed: () => navigatetoAddress(sum),
                      buttonText: 'Proceed to buy (${user.cart.length}) items',
                      color: Colors.yellow,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    color: Colors.black12.withOpacity(0.08),
                    height: 1,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: user.cart.length,
                      itemBuilder: (context, index) {
                        return CartProduct(index: index);
                      })
                ],
              ),
            ),
    );
  }
}
