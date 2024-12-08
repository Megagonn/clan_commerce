// import 'dart:developer';

import 'package:clan_commerce/models/cart_model.dart';
import 'package:clan_commerce/providers/cart_provider.dart';
import 'package:clan_commerce/themes/global_themes.dart';
import 'package:clan_commerce/utils/size_utils.dart';
import 'package:clan_commerce/views/success.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets.dart';

class CartPage extends StatefulWidget {
  ///The cart page displays all items in cart
  ///Item can be removed, increased or decreased.
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    context.read<CartProvider>().getTotal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColors.white,
      appBar: AppBar(
        leading: Container(
          margin: getPadding(left: 20),
          child: ActionButton(
              iconData: CupertinoIcons.back,
              color: GlobalColors.primary,
              hasShadow: true,
              callBack: () {
                Navigator.pop(context);
              }),
        ),
        leadingWidth: 80,
        title: Text(
          "My cart",
          style: Theme.of(context).textTheme.displayLarge,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: GlobalColors.white,
        actions: [
          ActionButton(
            iconData: CupertinoIcons.ellipsis,
            color: GlobalColors.primary,
            callBack: () async {
              _clearCartMenuDialog(context);
            },
            hasShadow: true,
          ),
        ],
      ),
      body: ListView(
        children: [
          Consumer<CartProvider>(
            builder: (context, value, _) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: getVerticalSize(20),
                ),
                Visibility(
                  ///If the cart is empty, this UI is displayed.
                  visible: value.cart.isEmpty,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: getVerticalSize(50),
                        ),
                        const Icon(
                          CupertinoIcons.cart,
                          size: 100,
                          color: GlobalColors.primary,
                        ),
                        Text(
                          'Your cart is empty.',
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Goto Products")),
                      ],
                    ),
                  ),
                ),
                ...List.generate(value.cart.length, (i) {
                  CartItemModel model = CartItemModel.fromJson(value.cart[i]);

                  return _cartTile(context, model);
                })
              ],
            ),
          ),
          // const Spacer(),
          _promocode(context),
          Column(
            children: [
              _totalTile('Subtotal',
                  "\$${(context.watch<CartProvider>().total).toStringAsFixed(2)}"),
              SizedBox(
                height: getVerticalSize(10),
              ),
              _totalTile('Delivery fee',
                  context.watch<CartProvider>().total > 0 ? "\$5.00" : "0.0"),
              SizedBox(
                height: getVerticalSize(10),
              ),
              _totalTile('Discount', "40%"),
              SizedBox(
                height: getVerticalSize(10),
              ),
            ],
          ),
          const Divider(
            color: GlobalColors.gray,
          ),
          Container(
            margin: getMargin(left: 20, right: 20),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: context.watch<CartProvider>().total <= 0
                        ? null
                        : () async {
                            await context.read<CartProvider>().clearCart();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CCSuccess()));
                          },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        context.watch<CartProvider>().total <= 0
                            ? GlobalColors.gray
                            : GlobalColors.green,
                      ),
                      padding: WidgetStatePropertyAll(
                          getPadding(top: 20, bottom: 20)),
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
                      "Checkout for \$${(context.watch<CartProvider>().total + (context.watch<CartProvider>().total > 0 ? 5 : 0)).toStringAsFixed(2)}",
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(
                              color: context.watch<CartProvider>().total <= 0
                                  ? GlobalColors.textLight
                                  : GlobalColors.white,
                              fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: getVerticalSize(30),
          ),
        ],
      ),
    );
  }

  Future<dynamic> _clearCartMenuDialog(BuildContext context) {
    return showMenu(
        context: context,
        position: RelativeRect.fromDirectional(
            textDirection: TextDirection.ltr,
            start: 200,
            top: 0,
            end: 0,
            bottom: 0),
        items: [
          PopupMenuItem(
            child: TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    // color: GlobalColors.transparent,
                    content: Container(
                      padding: getPadding(all: 15),
                      // margin: getMargin(all: 20),
                      // height: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: GlobalColors.white),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                              "Do you want to clear your cart? All items will be removed."),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Cancel")),
                              TextButton(
                                  onPressed: () async {
                                    await context
                                        .read<CartProvider>()
                                        .clearCart();
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    "Continue",
                                    style: TextStyle(color: GlobalColors.red),
                                  )),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
              child: Text(
                "Clear cart",
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(color: GlobalColors.red),
              ),
            ),
          ),
        ]);
  }

  Widget _totalTile(String label, String value) {
    return Container(
      margin: getMargin(left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$label:"),
          Text(
            value,
            style: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  Widget _promocode(BuildContext context) {
    return Container(
      padding: getPadding(all: 15),
      margin: getMargin(all: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: GlobalColors.gray),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "ADKJDLK",
            style: Theme.of(context).textTheme.displayMedium,
          ),
          Row(
            children: [
              Text(
                "Promocode applied  ",
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(color: GlobalColors.green),
              ),
              const Icon(
                CupertinoIcons.checkmark_alt_circle_fill,
                color: GlobalColors.green,
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _cartTile(BuildContext context, CartItemModel model) {
    return Column(
      children: [
        Container(
          margin: getMargin(left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: getPadding(all: 10),
                margin: getMargin(bottom: 10),
                width: MediaQuery.of(context).size.width * .3,
                height: MediaQuery.of(context).size.width * .3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: GlobalColors.gray,
                ),
                child: Image.asset(
                  model.image,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: getHorizontalSize(20),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: getMargin(bottom: 20),
                    width: MediaQuery.of(context).size.width * .5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              model.name,
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                            InkWell(
                              onTap: () async {
                                await context
                                    .read<CartProvider>()
                                    .remove(model.itemId);
                              },
                              child: const Icon(
                                CupertinoIcons.clear,
                                color: GlobalColors.textLight,
                                size: 14,
                              ),
                            )
                          ],
                        ),
                        Text(
                          model.specs[0] ?? "",
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(color: GlobalColors.textLight),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "\$${model.discountPrice}",
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CartButton(
                              action: () async {
                                await context
                                    .read<CartProvider>()
                                    .decrement(model.itemId);
                              },
                              color: GlobalColors.textLight,
                              iconData: CupertinoIcons.minus,
                              iconColor: GlobalColors.primary,
                            ),
                            Padding(
                              padding: getPadding(all: 10),
                              child: Text(
                                model.count.toString(),
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                            ),
                            CartButton(
                              action: () async {
                                await context
                                    .read<CartProvider>()
                                    .increment(model.itemId);
                              },
                              color: GlobalColors.green,
                              iconData: CupertinoIcons.add,
                              // iconColor: GlobalColors.green,
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        Container(
          margin: getMargin(left: 20, right: 20),
          child: const Divider(
            color: GlobalColors.gray,
          ),
        )
      ],
    );
  }
}
