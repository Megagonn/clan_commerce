// import 'package:clan_commerce/models/cart_model.dart';
import 'package:clan_commerce/models/stock_item_model.dart';
import 'package:clan_commerce/providers/cart_provider.dart';
import 'package:clan_commerce/themes/global_themes.dart';
import 'package:clan_commerce/utils/size_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets.dart';

class StockItemDetails extends StatefulWidget {
  ///ItemDetails screen shows the user the details of selected item
  ///user can add the item to cart.
  const StockItemDetails({super.key, required this.stockItemModel});
  final StockItemModel stockItemModel;

  @override
  State<StockItemDetails> createState() => _StockItemDetailsState();
}

class _StockItemDetailsState extends State<StockItemDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColors.gray,
      appBar: AppBar(
        title: ActionButton(
            iconData: CupertinoIcons.back,
            color: GlobalColors.primary,
            callBack: () {
              Navigator.pop(context);
            }),
        automaticallyImplyLeading: false,
        backgroundColor: GlobalColors.gray,
        actions: [
          ActionButton(
            iconData: CupertinoIcons.heart_fill,
            color: GlobalColors.red,
            callBack: () {},
          ),
          ActionButton(
            iconData: CupertinoIcons.share_up,
            color: GlobalColors.primary,
            callBack: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .4,
            child: Image.asset(widget.stockItemModel.image),
          ),
          Expanded(
            child: Container(
              // height: MediaQuery.of(context).size.height / 2,
              padding: getPadding(all: 20),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: GlobalColors.white,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.stockItemModel.name,
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      Container(
                        padding: getPadding(all: 10),
                        decoration: BoxDecoration(
                            color: GlobalColors.red,
                            borderRadius: BorderRadius.circular(12)),
                        child: Text(
                          "÷  On sale",
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(color: GlobalColors.white),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: getVerticalSize(20),
                  ),
                  Row(
                    children: [
                      _smallChip(
                          context,
                          CupertinoIcons.heart_fill,
                          widget.stockItemModel.rates.toString(),
                          Colors.orange),
                      _smallChip(
                          context,
                          CupertinoIcons.hand_thumbsup_fill,
                          widget.stockItemModel.rates.toString(),
                          GlobalColors.green),
                      Text(
                        "${widget.stockItemModel.reviews} reviews",
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(color: GlobalColors.textLight),
                      )
                    ],
                  ),
                  SizedBox(
                    height: getVerticalSize(20),
                  ),
                  Text(
                    widget.stockItemModel.description,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  SizedBox(
                    height: getVerticalSize(20),
                  ),
                  VariantsTile(variants: widget.stockItemModel.specs),
                  const Spacer(),
                  const Divider(
                    color: GlobalColors.gray,
                  ),
                  SizedBox(
                    height: getVerticalSize(10),
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "\$${widget.stockItemModel.price}",
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                    decoration: TextDecoration.lineThrough,
                                    decorationColor: GlobalColors.textLight,
                                    decorationStyle: TextDecorationStyle.solid,
                                    color: GlobalColors.textLight),
                          ),
                          Text(
                            "\$${widget.stockItemModel.discountPrice}",
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: getHorizontalSize(20),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 60,
                          child: context.watch<CartProvider>().inCart

                              ///if the item is in cart already, display increment and decrement buttons
                              ///else the user see the Add to cart button
                              ? Consumer<CartProvider>(
                                  builder: (context, value, _) => Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CartButton(
                                            action: () async {
                                              await context
                                                  .read<CartProvider>()
                                                  .decrement(widget
                                                      .stockItemModel.itemId);
                                            },
                                            color: GlobalColors.textLight,
                                            iconData: CupertinoIcons.minus,
                                            iconColor: GlobalColors.primary,
                                          ),
                                          Padding(
                                            padding: getPadding(all: 10),
                                            child: Text(
                                              value.itemCount.toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displayMedium,
                                            ),
                                          ),
                                          CartButton(
                                            action: () async {
                                              await context
                                                  .read<CartProvider>()
                                                  .increment(widget
                                                      .stockItemModel.itemId);
                                            },
                                            color: GlobalColors.green,
                                            iconData: CupertinoIcons.add,
                                            // iconColor: GlobalColors.green,
                                          )
                                        ],
                                      ))
                              : ElevatedButton(
                                  onPressed: () async {
                                    ///set new item to cart
                                    await context.read<CartProvider>().setcart(
                                        widget.stockItemModel.toJson());
                                    await context
                                        .read<CartProvider>()
                                        .getItems();
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
                                    "Add to cart",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium!
                                        .copyWith(
                                            color: GlobalColors.white,
                                            fontWeight: FontWeight.bold),
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: getVerticalSize(10),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _smallChip(
      BuildContext context, IconData iconData, String label, Color iconColor) {
    return Container(
        padding: getPadding(left: 15, right: 15, top: 10, bottom: 10),
        margin: getMargin(right: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            boxShadow: const [
              BoxShadow(
                  color: GlobalColors.primary,
                  blurRadius: .7,
                  spreadRadius: .7,
                  blurStyle: BlurStyle.outer)
            ]),
        child: Row(
          children: [
            Icon(
              iconData,
              color: iconColor,
              size: 20,
            ),
            SizedBox(
              width: getHorizontalSize(5),
            ),
            Text(
              label,
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ],
        ));
  }
}

class VariantsTile extends StatefulWidget {
  ///It displays the variant of the selected item and nothing 
  ///if no variant ot available
  const VariantsTile({super.key, required this.variants});
  final List variants;

  @override
  State<VariantsTile> createState() => _VariantsTileState();
}

class _VariantsTileState extends State<VariantsTile> {
  String selected = '';
  @override
  void initState() {
    super.initState();
    selected = widget.variants[0];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.variants.length,
        itemBuilder: (context, index) =>
            _variantChipTile(widget.variants[index]),
      ),
    );
  }

  Widget _variantChipTile(String variant) {
    return Container(
      margin: getMargin(right: 7),
      child: ElevatedButton(
        onPressed: () {
          selected = variant;
          setState(() {});
        },
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(
            selected == variant ? GlobalColors.green : GlobalColors.white,
          ),
          padding: WidgetStateProperty.all(
            getPadding(
              top: selected == variant ? 2 : 0,
              bottom: selected == variant ? 2 : 0,
              left: 12,
              right: 12,
            ),
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              side: selected != variant
                  ? const BorderSide(color: GlobalColors.primary, width: 2)
                  : BorderSide.none,
              borderRadius: BorderRadius.circular(
                12,
              ),
            ),
          ),
        ),
        child: Text(
          variant,
          style: TextStyle(
              color: selected == variant
                  ? GlobalColors.white
                  : GlobalColors.primary,
              fontFamily: "Aeonik"),
        ),
      ),
    );
  }
}
