import 'package:flutter/material.dart';
import 'package:amazoncloneapp/constants/globals.dart';
import 'package:amazoncloneapp/features/home/screens/category_product.dart';

class Category extends StatelessWidget {
  const Category({super.key});
  void navigatetoCategory(BuildContext context, String category) {
    Navigator.pushNamed(context, CategoryProduct.routeName,
        arguments: category);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
          itemExtent: 75,
          scrollDirection: Axis.horizontal,
          itemCount: Globals.categoryImages.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => navigatetoCategory(
                  context, Globals.categoryImages[index]['title']!),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        Globals.categoryImages[index]['image']!,
                        fit: BoxFit.cover,
                        height: 40,
                        width: 40,
                      ),
                    ),
                  ),
                  Text(
                    Globals.categoryImages[index]['title']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
