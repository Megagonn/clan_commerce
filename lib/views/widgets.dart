// ignore_for_file: must_be_immutable

import 'package:clan_commerce/models/stock_item_model.dart';
import 'package:clan_commerce/providers/cart_provider.dart';
import 'package:clan_commerce/themes/global_themes.dart';
import 'package:clan_commerce/utils/size_utils.dart';
import 'package:clan_commerce/views/item_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ActionButton extends StatelessWidget {
  ActionButton({
    super.key,
    required this.iconData,
    required this.color,
    required this.callBack,
    this.hasShadow = false,
  });
  final IconData iconData;
  final Color color;
  final VoidCallback callBack;
  bool hasShadow;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callBack,
      child: Container(
        padding: getPadding(all: 10),
        margin: getMargin(right: 20),
        decoration: BoxDecoration(
            boxShadow: hasShadow
                ? [
                    const BoxShadow(
                        color: GlobalColors.primary,
                        spreadRadius: .6,
                        blurRadius: .6,
                        blurStyle: BlurStyle.outer),
                  ]
                : null,
            shape: BoxShape.circle,
            color: GlobalColors.white),
        child: Icon(iconData, color: color),
      ),
    );
  }
}

class CartButton extends StatelessWidget {
  CartButton(
      {super.key,
      required this.action,
      required this.color,
      required this.iconData,
      this.iconColor});
  final VoidCallback action;
  final Color color;
  final IconData iconData;
  Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action,
      child: Container(
        padding: getPadding(all: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: color)),
        child: Icon(
          iconData,
          color: iconColor ?? color,
          size: 14,
        ),
      ),
    );
  }
}

class ItemGrid extends StatelessWidget {
  const ItemGrid({
    super.key,
    required this.context,
    required this.item,
  });

  final BuildContext context;
  final Map item;

  @override
  Widget build(BuildContext context) {
    StockItemModel itemModel = StockItemModel.fromJson(item);
    return InkWell(
      onTap: () async {
        await context.read<CartProvider>().isInCart(itemModel.itemId);
        await context.read<CartProvider>().getEachItemCount(itemModel.itemId);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    StockItemDetails(stockItemModel: itemModel)));
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: getPadding(all: 10),
            margin: getMargin(bottom: 10),
            width: double.maxFinite,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: GlobalColors.gray,
            ),
            child: Image.asset(
              itemModel.image,
              height: getVerticalSize(200),
              fit: BoxFit.contain,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                itemModel.name,
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    color: GlobalColors.textLight, fontWeight: FontWeight.w600),
              ),
              Row(
                children: [
                  const Icon(
                    CupertinoIcons.star_fill,
                    color: Colors.orangeAccent,
                    size: 14,
                  ),
                  SizedBox(
                    width: getHorizontalSize(5),
                  ),
                  Text(
                    itemModel.rates.toString(),
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: getVerticalSize(10),
          ),
          Text(
            "\$${itemModel.discountPrice}",
            style: Theme.of(context).textTheme.displayLarge,
          )
        ],
      ),
    );
  }
}