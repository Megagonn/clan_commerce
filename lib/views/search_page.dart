// import 'package:clan_commerce/models/stock_item_model.dart';
import 'package:clan_commerce/providers/search_provider.dart';
import 'package:clan_commerce/themes/global_themes.dart';
import 'package:clan_commerce/utils/size_utils.dart';
import 'package:clan_commerce/views/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class CCSearchPage extends StatefulWidget {
  /// Search screen displays the list of items from search result.
  const CCSearchPage({super.key, required this.keyword});
  final String keyword;

  @override
  State<CCSearchPage> createState() => _CCSearchPageState();
}

class _CCSearchPageState extends State<CCSearchPage> {
  TextEditingController keyword = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    keyword.text = widget.keyword;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 40,
        title: Container(
          padding: getPadding(all: 20),
          child: SearchBar(
            controller: keyword,
            onChanged: (value) {
              ///onChanged of the user's input, the search result also changes.
              context.read<SearchProvider>().searchItems(keyword.text);
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
            trailing: const [Icon(CupertinoIcons.search)],
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Consumer<SearchProvider>(builder: (context, value, _) {
        return Column(
          children: [
            SizedBox(
              height: getVerticalSize(50),
            ),

            /// Displayed if the search result is empty
            Visibility(
              visible: value.searchResult.isEmpty,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: getVerticalSize(50),
                    ),
                    const Icon(
                      CupertinoIcons.minus_circle,
                      size: 100,
                      color: GlobalColors.primary,
                    ),
                    Text(
                      "We couldn't get a match for  you.",
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
            Padding(
              padding: getPadding(left: 20, right: 20),
              child: StaggeredGrid.count(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                children: [
                  ...List.generate(value.searchResult.length, (i) {
                    // StockItemModel model =
                    //     StockItemModel.fromJson(value.searchResult[i]);

                    return ItemGrid(
                        context: context, item: value.searchResult[i]);
                  })
                ],
              ),
            ),
            SizedBox(
              height: getVerticalSize(50),
            ),
          ],
        );
      })),
    );
  }
}
