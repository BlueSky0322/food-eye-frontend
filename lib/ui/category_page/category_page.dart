import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:food_eye_fyp/components/list_tile.dart';
import 'package:food_eye_fyp/data/model/item_response.dart';
import 'package:food_eye_fyp/ui/category_page/category_page_state.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:provider/provider.dart';

import '../../utils/constants.dart';
import '../bottom_nav_bar/nav_bar_state.dart';
import '../edit_item_page/edit_page.dart';
import '../edit_item_page/edit_page_state.dart';

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AnalyticsPageState>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        onPressed: () {
          state.toggleView();
        },
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 3,
            color: Colors.teal.shade100,
          ),
          borderRadius: BorderRadius.circular(100),
        ),
        tooltip: "Swap Views",
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(
          Icons.view_module_rounded,
          color: appbarText,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      backgroundColor: pageBG,
      appBar: AppBar(
        backgroundColor: appbar,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
        elevation: 0,
        toolbarHeight: 70,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.view_comfortable_rounded,
              color: appbarText,
              size: 40,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "View Items",
              style: TextStyle(
                fontFamily: 'Outfit',
                fontSize: 28,
                fontWeight: FontWeight.w500,
                color: appbarText,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: state.feItemList.isEmpty
            ? Center(
                child: Container(
                  width: double.infinity,
                  color: Colors.black.withOpacity(0.1),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 110,
                        height: 110,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/images/empty-list.png'),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Your list is currently empty! ",
                        style: TextStyle(
                          fontFamily: 'Outfit',
                          fontSize: 15,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          final navBarState =
                              Provider.of<NavBarState>(context, listen: false);
                          navBarState.navigateToAddItemPage();
                        },
                        child: const Text(
                          "Add some items",
                          style: TextStyle(
                            color: primaryBG,
                            fontSize: 16,
                            fontFamily: 'Outfit',
                            decoration: TextDecoration.underline,
                            decorationColor: primaryBG,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : state.swapView.value
                ? GroupedListView<ItemResponseObject, String>(
                    useStickyGroupSeparators: true,
                    elements: state.feItemList,
                    groupBy: (element) => element.storedAt!,
                    groupSeparatorBuilder: (value) {
                      return ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          color: primaryBG,
                          child: Text(
                            value,
                            style: const TextStyle(
                              fontFamily: 'Outfit',
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: appbarText,
                            ),
                          ),
                        ),
                      );
                    },
                    itemBuilder: (context, element) {
                      return Slidable(
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              backgroundColor: appbar,
                              icon: Icons.edit,
                              label: "Edit",
                              onPressed: (context) {
                                Navigator.push<bool>(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ChangeNotifierProvider(
                                      create: (context) => EditItemState(
                                          context, element.itemID!),
                                      child: const EditItem(),
                                    ),
                                  ),
                                ).then((shouldUpdate) {
                                  if (shouldUpdate == true) {
                                    state.loadItems();
                                  }
                                });
                              },
                            ),
                            SlidableAction(
                              backgroundColor: Colors.red.shade700,
                              icon: Icons.delete_outline_rounded,
                              label: "Delete",
                              onPressed: (context) {
                                state.deleteItem(element.itemID!);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    showCloseIcon: true,
                                    duration: const Duration(seconds: 2),
                                    content: Text(
                                        "Item '${element.itemName}' deleted successfully!"),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        child: CustomListTile(item: element),
                      );
                    },
                    // itemBuilder: (context, element) => CustomListTile(item: element),
                  )
                : GroupedListView<ItemResponseObject, String>(
                    useStickyGroupSeparators: true,
                    elements: state.feItemList,
                    groupBy: (element) => element.itemType!,
                    groupSeparatorBuilder: (value) => ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        color: primaryBG,
                        child: Text(
                          value,
                          style: const TextStyle(
                            fontFamily: 'Outfit',
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: appbarText,
                          ),
                        ),
                      ),
                    ),
                    itemBuilder: (context, element) {
                      return Slidable(
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              backgroundColor: appbar,
                              icon: Icons.edit,
                              label: "Edit",
                              onPressed: (context) {
                                Navigator.push<bool>(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ChangeNotifierProvider(
                                      create: (context) => EditItemState(
                                          context, element.itemID!),
                                      child: const EditItem(),
                                    ),
                                  ),
                                ).then((shouldUpdate) {
                                  if (shouldUpdate == true) {
                                    state.loadItems();
                                  }
                                });
                              },
                            ),
                            SlidableAction(
                              backgroundColor: Colors.red.shade700,
                              icon: Icons.delete_outline_rounded,
                              label: "Delete",
                              onPressed: (context) {
                                state.deleteItem(element.itemID!);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    showCloseIcon: true,
                                    duration: const Duration(seconds: 2),
                                    content: Text(
                                        "Item '${element.itemName}' deleted successfully!"),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        child: CustomListTile(item: element),
                      );
                    },
                  ),
      ),
    );
  }
}
