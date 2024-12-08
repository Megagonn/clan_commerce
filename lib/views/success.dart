import 'package:clan_commerce/themes/global_themes.dart';
import 'package:clan_commerce/utils/size_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CCSuccess extends StatelessWidget {
  const CCSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              CupertinoIcons.checkmark_alt_circle,
              size: 150,
              color: GlobalColors.green,
            ),
            SizedBox(
              height: getVerticalSize(50),
            ),
            Text(
              "Checkout successful",
              style: Theme.of(context).textTheme.displayMedium,
            ),
            SizedBox(
              height: getVerticalSize(100),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                  GlobalColors.green,
                ),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    side: BorderSide.none,
                    borderRadius: BorderRadius.circular(
                      12,
                    ),
                  ),
                ),
              ),
              child: Text(
                "Home",
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(color: GlobalColors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
