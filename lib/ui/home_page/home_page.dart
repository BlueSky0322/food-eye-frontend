import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:food_eye_fyp/data/model/item_response.dart';
import 'package:food_eye_fyp/ui/edit_item_page/edit_page.dart';
import 'package:food_eye_fyp/ui/edit_item_page/edit_page_state.dart';
import 'package:food_eye_fyp/components/list_tile.dart';
import 'package:food_eye_fyp/ui/home_page/components/settings_sidebar/settings_sidebar.dart';
import 'package:food_eye_fyp/ui/home_page/home_page_state.dart';
import 'package:food_eye_fyp/ui/items_detail_page/items_detail_page.dart';
import 'package:food_eye_fyp/ui/items_detail_page/items_detail_page_state.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
// import '../../data/model/item.dart';
import '../../utils/constants.dart';
import '../bottom_nav_bar/nav_bar_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<HomePageState>(context);
    return Scaffold(
      backgroundColor: pageBG,
      endDrawer: const SettingsSidebar(),
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
        backgroundColor: appbar,
        elevation: 6,
        toolbarHeight: 70,
        title: const Row(
          children: [
            Text(
              "Welcome Back",
              style: TextStyle(
                fontFamily: 'Outfit',
                fontSize: 28,
                fontWeight: FontWeight.w500,
                color: appbarText,
              ),
            ),
          ],
        ),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: primaryBG,
                    width: 1,
                  ),
                ),
                child: CircleAvatar(
                  radius: 25.0,
                  backgroundColor: primaryBG,
                  backgroundImage:
                      Image.asset('assets/images/avatar.png').image,
                ),
              ),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    'assets/images/card-bg.png',
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 20,
                    offset: const Offset(0, 3),
                  ),
                ],
                borderRadius: const BorderRadius.all(
                  Radius.circular(12.0),
                ),
                color: Colors.white,
              ),
              padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 0, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text.rich(TextSpan(
                            text: "You have",
                            style: const TextStyle(
                              fontFamily: 'Outfit',
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: "  ${state.expItemCount}  ",
                                style: TextStyle(
                                  fontFamily: 'Outfit',
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green.shade700,
                                ),
                              ),
                              const TextSpan(
                                text: "items \nthat are still fresh!",
                                style: TextStyle(
                                  fontFamily: 'Outfit',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ])),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            Text(
                              "Enjoy before  ",
                              style: TextStyle(
                                fontFamily: 'Outfit',
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(4.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.teal.shade200,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.teal.shade500,
                              ),
                              child: Text(
                                DateFormat.yMMMd().format(state.nearestExpDate),
                                style: TextStyle(
                                  fontFamily: 'Outfit',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.teal.shade50,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsetsDirectional.fromSTEB(22, 0, 10, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "All Items",
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: primaryBG,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: primaryBG,
                      width: 2.0,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 12.0,
                    backgroundColor: Colors.transparent,
                    child: Text(
                      state.feItemList.length.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'Outfit',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryBG,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                TextButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          width: 2,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                  onPressed: () {
                    state.showSortingOptions(context);
                  },
                  child: Text(
                    "Sort by: ${state.sortByOption}",
                    style: const TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: primaryBG,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    state.toggleSortingOrder();
                  },
                  icon: Transform.rotate(
                    angle: 90 *
                        3.1415927 /
                        180, // Rotate by 90 degrees (in radians)
                    child: Icon(
                      !state.isDescending.value
                          ? Icons.switch_left_rounded
                          : Icons.switch_right_rounded,
                      size: 30,
                    ),
                  ),
                  color: primaryBG,
                )
              ],
            ),
          ),
          FutureBuilder<List<ItemResponseObject>>(
            future: state.reloadItems(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.data?.isEmpty ?? true) {
                return Expanded(
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
                            final navBarState = Provider.of<NavBarState>(
                                context,
                                listen: false);
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
                );
              } else {
                final sortedItems = state.sortItems(snapshot.data!,
                    state.isDescending.value, state.sortByOption);
                return Expanded(
                  child: ListView.builder(
                    itemCount: sortedItems.length,
                    itemBuilder: (context, index) {
                      final item = sortedItems[index];
                      return ValueListenableBuilder<bool>(
                        valueListenable: state.isDescending,
                        builder: (context, isDescending, _) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ChangeNotifierProvider(
                                    create: (context) =>
                                        ItemDetailState(sortedItems[index]),
                                    child: const ItemDetail(),
                                  ),
                                ),
                              );
                            },
                            child: Slidable(
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
                                                context, item.itemID!),
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
                                      state.deleteItem(item.itemID!);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          showCloseIcon: true,
                                          duration: const Duration(seconds: 2),
                                          content: Text(
                                              "Item '${item.itemName}' deleted successfully!"),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              child: CustomListTile(item: item),
                            ),
                          );
                        },
                      );
                    },
                  ),
                );
              }
            },
          ),
          const SizedBox(
            height: 16,
          )
        ],
      ),
    );
  }
}
