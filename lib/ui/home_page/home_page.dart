import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:food_eye_fyp/components/list_tile.dart';
import 'package:food_eye_fyp/ui/home_page/home_page_state.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
// import '../../data/model/item.dart';
import '../../utils/constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<HomePageState>(context);
    return Scaffold(
      backgroundColor: pageBG,
      appBar: AppBar(
        backgroundColor: appbar,
        elevation: 1,
        toolbarHeight: 70,
        title: Row(
          children: [
            const Text(
              "Welcome Back",
              style: TextStyle(
                fontFamily: 'Outfit',
                fontSize: 28,
                fontWeight: FontWeight.w500,
                color: primaryBG,
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                // Perform avatar icon action
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/splash',
                  (route) => false,
                );
              },
              icon: Container(
                width: 65,
                height: 65,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/images/avatar.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ],
        ),
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
                    'assets/images/card-bg-1.png',
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
                        Text(
                          "You have ${state.expItemCount} items \nthat are still fresh!",
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            fontFamily: 'Outfit',
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text.rich(
                          TextSpan(
                              text: "Enjoy by   ",
                              style: const TextStyle(
                                fontFamily: 'Outfit',
                                fontSize: 15,
                                color: Colors.grey,
                              ),
                              children: [
                                TextSpan(
                                  text: DateFormat.yMd()
                                      .format(state.nearestExpDate),
                                  style: const TextStyle(
                                    fontFamily: 'Outfit',
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 29, 214, 106),
                                  ),
                                )
                              ]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsetsDirectional.fromSTEB(28, 0, 20, 10),
            child: Row(
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
                      state.itemList.length.toString(),
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
                  onPressed: () {
                    state.showSortingOptions(context);
                  },
                  child: Text(
                    "Sort by: ${state.sortByOption}",
                    style: const TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 16,
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
          Expanded(
            child: ListView.builder(
              itemCount: context.watch<HomePageState>().itemList.length,
              itemBuilder: (context, index) {
                final sortedItems = state.sortItems(state.itemList,
                    state.isDescending.value, state.sortByOption);
                final item = sortedItems[index];
                return ValueListenableBuilder<bool>(
                  valueListenable: state.isDescending,
                  builder: (context, isDescending, _) {
                    return Slidable(
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            backgroundColor:
                                const Color.fromARGB(255, 13, 107, 161),
                            icon: Icons.edit,
                            label: "Edit",
                            onPressed: (context) {},
                          ),
                          SlidableAction(
                            backgroundColor: Colors.red.shade700,
                            icon: Icons.delete_outline_rounded,
                            label: "Delete",
                            onPressed: (context) {},
                          ),
                        ],
                      ),
                      child: CustomListTile(
                        item: item,
                      ),
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(
            height: 16,
          )
        ],
      ),
    );
  }
}
