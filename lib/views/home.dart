// import 'dart:developer';

// import 'package:clan_commerce/models/stock_item_model.dart';
import 'package:clan_commerce/providers/bnb_provider.dart';
import 'package:clan_commerce/providers/cart_provider.dart';
import 'package:clan_commerce/providers/category_provider.dart';
import 'package:clan_commerce/providers/search_provider.dart';
import 'package:clan_commerce/stock.dart';
import 'package:clan_commerce/themes/global_themes.dart';
import 'package:clan_commerce/utils/size_utils.dart';
// import 'package:clan_commerce/views/item_details.dart';
import 'package:clan_commerce/views/search_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import 'cart_page.dart';
import 'widgets.dart';

class CCHome extends StatefulWidget {
  const CCHome({super.key});

  @override
  State<CCHome> createState() => _CCHomeState();
}

class _CCHomeState extends State<CCHome> {
  TextEditingController keyword = TextEditingController();
  String selected = 'all';
  // List items = gadgets;

  @override
  void initState() {
    super.initState();
    context.read<CartProvider>().getItems();
  }

  @override
  Widget build(BuildContext context) {
    List items = Provider.of<CategoryProvider>(context).items;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Discover",
          style: Theme.of(context).textTheme.displayLarge,
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const CartPage()));
            },
            child: Stack(
              children: [
                Container(
                  padding: getPadding(all: 10),
                  margin: getMargin(right: 20),
                  decoration: const BoxDecoration(boxShadow: [
                    BoxShadow(
                        color: GlobalColors.primary,
                        spreadRadius: .6,
                        blurRadius: .6,
                        blurStyle: BlurStyle.outer),
                  ], shape: BoxShape.circle),
                  child: const Icon(CupertinoIcons.bag),
                ),
                Positioned(
                  top: 0,
                  right: 10,
                  child: Consumer<CartProvider>(
                    builder: (context, value, _) => Badge.count(
                      count: value.cart.length,
                      padding: getPadding(all: 3),
                      backgroundColor: GlobalColors.green,
                      textColor: GlobalColors.white,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          ///change the index of the bottom nav bar
          context.read<BNBProvider>().setIndex(value);
        },
        currentIndex: context.watch<BNBProvider>().currentIndex,
        selectedItemColor: GlobalColors.green,
        unselectedItemColor: GlobalColors.primary,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.search), label: "Search"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.heart), label: "Favorites"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person), label: "Profile"),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: getPadding(all: 20),
              child: SearchBar(
                controller: keyword,
                onChanged: (value) {
                  setState(() {});
                },
                onSubmitted: (value) {
                  value.trim().isEmpty
                      ? null
                      : () {
                          context
                              .read<SearchProvider>()
                              .searchItems(keyword.text);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CCSearchPage(keyword: value),
                            ),
                          );
                          keyword.clear();
                        }();
                },
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                elevation: WidgetStateProperty.all(0),
                backgroundColor: WidgetStateProperty.all(GlobalColors.gray),
                hintText: 'Search',
                hintStyle: WidgetStateProperty.all(
                  Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(color: GlobalColors.textLight),
                ),
                trailing: [
                  InkWell(
                    onTap: keyword.text.trim().isEmpty
                        ? null
                        : () {
                            context
                                .read<SearchProvider>()
                                .searchItems(keyword.text);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CCSearchPage(keyword: keyword.text)));
                            keyword.clear();
                          },
                    child: Icon(
                      CupertinoIcons.search,
                      color: keyword.text.trim().isEmpty
                          ? null
                          : GlobalColors.green,
                    ),
                  )
                ],
              ),
            ),
            _hero(context),
            Container(
              margin: getMargin(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Categories",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  TextButton(
                      onPressed: () {
                        context.read<SearchProvider>().searchItems('');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const CCSearchPage(keyword: '')));
                      },
                      child: Text(
                        "See all",
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(color: GlobalColors.green),
                      ))
                ],
              ),
            ),
            _chips(),
            Padding(
              padding: getPadding(left: 20, right: 20),
              child: StaggeredGrid.count(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                children: [
                  ...List.generate(items.length, (i) {
                    return items.isEmpty
                        ? const Text('no item')
                        : ItemGrid(context: context, item: items[i]);
                  })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _hero(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: getMargin(all: 20),
          // padding: getPadding(),
          decoration: BoxDecoration(
            color: GlobalColors.green,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 2,
                padding: getPadding(all: 20),
                child: Column(
                  children: [
                    Text(
                      "Clearance Sales",
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge!
                          .copyWith(color: GlobalColors.white, fontSize: 24),
                    ),
                    SizedBox(
                      height: getVerticalSize(20),
                    ),
                    Container(
                      padding: getPadding(all: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: GlobalColors.white),
                      child: Row(
                        children: [
                          // Icon(
                          //   CupertinoIcons.percent,
                          //   color: GlobalColors.green,
                          // ),
                          Text.rich(
                            TextSpan(text: "÷   ", children: [
                              TextSpan(
                                text: "Up to 15%",
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(
                                      color: GlobalColors.green,
                                    ),
                              )
                            ]),
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                    color: GlobalColors.green,
                                    fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 0,
          top: -90,
          child: SizedBox(
              height: getVerticalSize(400),
              child: Image.asset('assets/images/iphone.png')),
        )
      ],
    );
  }

  Widget _chips() {
    ///Category button group
    ///
    List categories = [];

    gadgets.forEach((element) {
      categories.add(element['category']);
    });
    categories = categories.toSet().toList();
    return Container(
      margin: getMargin(left: 20, bottom: 20),
      height: 40,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            Consumer<CategoryProvider>(
              builder: (context, value, _) => Container(
                margin: getMargin(right: 7),
                child: ElevatedButton(
                  onPressed: () {
                    // selected = "all";
                    context.read<CategoryProvider>().setCategory('all');
                    context.read<CategoryProvider>().getItems();
                    setState(() {});
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                      value.category == "all"
                          ? GlobalColors.green
                          : GlobalColors.white,
                    ),
                    padding: WidgetStateProperty.all(
                      getPadding(
                          top: value.category == "all" ? 2 : 0,
                          bottom: value.category == "all" ? 2 : 0,
                          left: 7,
                          right: 7),
                    ),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        side: value.category != 'all'
                            ? const BorderSide(
                                color: GlobalColors.primary, width: 2)
                            : BorderSide.none,
                        borderRadius: BorderRadius.circular(
                          12,
                        ),
                      ),
                    ),
                  ),
                  child: Text(
                    "All",
                    style: TextStyle(
                        color: value.category == "all"
                            ? GlobalColors.white
                            : GlobalColors.primary,
                        fontFamily: "Aeonik"),
                  ),
                ),
              ),
            ),
            ...List.generate(
                categories.length, (i) => _categoryChipTile(categories, i)),
          ],
        ),
      ),
    );
  }

  Widget _categoryChipTile(List<dynamic> categories, int i) {
    ///category button widget
    return Consumer<CategoryProvider>(
        builder: (context, value, _) => Container(
              margin: getMargin(right: 7),
              child: ElevatedButton(
                onPressed: () {
                  // selected = categories[i];
                  context.read<CategoryProvider>().setCategory(categories[i]);
                  context.read<CategoryProvider>().getItems();
                  setState(() {});
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    value.category == categories[i]
                        ? GlobalColors.green
                        : GlobalColors.white,
                  ),
                  // maximumSize: WidgetStateProperty.all(Size(100, 40)),
                  padding: WidgetStateProperty.all(
                    getPadding(
                      top: value.category == categories[i] ? 2 : 0,
                      bottom: value.category == categories[i] ? 2 : 0,
                      left: 12,
                      right: 12,
                    ),
                  ),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      side: value.category != categories[i]
                          ? const BorderSide(
                              color: GlobalColors.primary, width: 2)
                          : BorderSide.none,
                      borderRadius: BorderRadius.circular(
                        12,
                      ),
                    ),
                  ),
                ),
                child: Text(
                  categories[i],
                  style: TextStyle(
                      color: value.category == categories[i]
                          ? GlobalColors.white
                          : GlobalColors.primary,
                      fontFamily: "Aeonik"),
                ),
              ),
            ));
  }
}
