import 'package:flutter/material.dart';
import 'package:amazoncloneapp/features/account/services/account_services.dart';
import 'package:amazoncloneapp/features/account/widgets/buttons.dart';

class TopButtons extends StatelessWidget {
  const TopButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final AccountServices accountServices = AccountServices();
    return Column(
      children: [
        Row(
          children: [
            AccountButtons(text: 'Your Orders', onTap: () {}),
            AccountButtons(text: 'Turn Seller', onTap: () {}),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            AccountButtons(
                text: 'Log Out', onTap: () => accountServices.logout(context)),
            AccountButtons(text: 'Your Wishlist', onTap: () {}),
          ],
        ),
      ],
    );
  }
}
