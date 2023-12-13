import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:amazoncloneapp/common/widgets/buttons.dart';
import 'package:amazoncloneapp/common/widgets/form_fields.dart';
import 'package:amazoncloneapp/constants/globals.dart';
import 'package:amazoncloneapp/constants/utils.dart';
import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:amazoncloneapp/features/admin/services/admin_service.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = './add-product';
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController productnamec = TextEditingController();
  final TextEditingController descriptionc = TextEditingController();
  final TextEditingController pricec = TextEditingController();
  final TextEditingController quantityc = TextEditingController();
  String category = 'Mobiles';
  List<String> types = [
    'Mobiles',
    'Essentials',
    'Appliances',
    'Books',
    'Fashion'
  ];
  List<File> images = [];
  final AdminServices adminServices = AdminServices();
  final _addProductFormKey = GlobalKey<FormState>();
  void selectImage() async {
    var res = await pickImage();
    setState(() {
      images = res;
    });
  }

  void sellProduct() {
    if (_addProductFormKey.currentState!.validate() && images.isNotEmpty) {
      adminServices.sellProduct(
          context: context,
          name: productnamec.text,
          description: descriptionc.text,
          price: double.parse(pricec.text),
          quantity: double.parse(quantityc.text),
          category: category,
          images: images);
    }
  }

  @override
  void dispose() {
    super.dispose();
    productnamec.dispose();
    descriptionc.dispose();
    pricec.dispose();
    quantityc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          title: const Center(
            child: Text(
              "Add Product",
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(gradient: Globals.appBarGradient),
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Form(
              key: _addProductFormKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    images.isNotEmpty
                        ? CarouselSlider(
                            items: images.map((e) {
                              return Builder(
                                  builder: (BuildContext context) => Image.file(
                                        e,
                                        fit: BoxFit.cover,
                                        height: 200,
                                      ));
                            }).toList(),
                            options: CarouselOptions(
                                viewportFraction: 1, height: 200))
                        : GestureDetector(
                            onTap: selectImage,
                            child: DottedBorder(
                              strokeCap: StrokeCap.round,
                              dashPattern: const [10, 4],
                              radius: const Radius.circular(10),
                              borderType: BorderType.RRect,
                              child: Container(
                                width: double.infinity,
                                height: 150,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.folder_open,
                                      size: 40,
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      "Select Product Images",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey.shade400),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomTextField(
                        controller: productnamec, hintText: "Product Name"),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      controller: descriptionc,
                      hintText: "Description",
                      maxlines: 7,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(controller: pricec, hintText: "Price"),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                        controller: quantityc, hintText: "Quantity"),
                    SizedBox(
                      width: double.infinity,
                      child: DropdownButton(
                        value: category,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        onChanged: (String? newvalue) {
                          setState(() {
                            category = newvalue!;
                          });
                        },
                        items: types.map((String item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Button(onpressed: sellProduct, buttonText: "Sell")
                  ],
                ),
              ))),
    );
  }
}
