import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';
import 'package:amazoncloneapp/common/widgets/form_fields.dart';
import 'package:amazoncloneapp/constants/globals.dart';
import 'package:amazoncloneapp/constants/utils.dart';
import 'package:amazoncloneapp/features/address/services/address.services.dart';
import 'package:amazoncloneapp/providers/user_provider.dart';

class AddressScreen extends StatefulWidget {
  static const routeName = '/address-screen';
  final String totalAmount;
  const AddressScreen({super.key, required this.totalAmount});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController flatc = TextEditingController();
  final TextEditingController areac = TextEditingController();
  final TextEditingController pincodec = TextEditingController();
  final TextEditingController townc = TextEditingController();
  final AddressServices addressServices = AddressServices();
  final adressformkey = GlobalKey<FormState>();
  String addressUsed = '';
  final Future<PaymentConfiguration> _googlePayConfigFuture =
      PaymentConfiguration.fromAsset('gpay.json');
  @override
  void initState() {
    super.initState();
    paymentItems.add(PaymentItem(
        amount: widget.totalAmount,
        label: 'Total Amount',
        status: PaymentItemStatus.final_price));
  }

  void payPressed(String addressfrompro) {
    addressUsed = '';
    bool isForm = flatc.text.isNotEmpty ||
        areac.text.isNotEmpty ||
        pincodec.text.isNotEmpty ||
        townc.text.isNotEmpty;
    if (isForm) {
      if (adressformkey.currentState!.validate()) {
        addressUsed =
            '${flatc.text} ${areac.text} ${townc.text} - ${pincodec.text} ';
      } else {
        throw Exception('Please Enter All The Values');
      }
    } else if (addressfrompro.isNotEmpty) {
      addressUsed = addressfrompro;
    } else {
      showSnackBar(context, 'Error');
      throw Exception('Please Enter All The Values');
    }
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveAddress(context: context, address: addressUsed);
    }
    addressServices.placeOrder(
        context: context,
        address: addressUsed,
        totalAmount: double.parse(widget.totalAmount));
    throw Exception('Done');
  }

  @override
  void dispose() {
    super.dispose();
    flatc.dispose();
    areac.dispose();
    pincodec.dispose();
    townc.dispose();
  }

  List<PaymentItem> paymentItems = [];
  void onGpayRes(res) {}

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(gradient: Globals.appBarGradient),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (address.isNotEmpty)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          address,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "OR",
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              Form(
                key: adressformkey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: flatc,
                      hintText: 'Flat, House no, Building',
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: areac,
                      hintText: 'Area, Street',
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: pincodec,
                      hintText: 'Pincode',
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: townc,
                      hintText: 'Town/City',
                    ),
                  ],
                ),
              ),
              FutureBuilder<PaymentConfiguration>(
                  future: _googlePayConfigFuture,
                  builder: (context, snapshot) => snapshot.hasData
                      ? GooglePayButton(
                          onPressed: () => payPressed(address),
                          paymentConfiguration: snapshot.data!,
                          paymentItems: paymentItems,
                          type: GooglePayButtonType.buy,
                          margin: const EdgeInsets.only(top: 15.0),
                          onPaymentResult: onGpayRes,
                          loadingIndicator: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : const SizedBox.shrink()),
            ],
          ),
        ),
      ),
    );
  }
}
