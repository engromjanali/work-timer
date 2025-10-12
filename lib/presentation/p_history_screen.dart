import 'package:flutter/material.dart';
import 'package:work_timer/core/constants/extentions/w_extention.dart';
import 'package:work_timer/core/constants/my_color.dart';
import 'package:work_timer/core/constants/my_dimention.dart';

class PHistory extends StatelessWidget {
  const PHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("History")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search_sharp),
              hintText: "Search Task Here",
              suffixIcon: IconButton(
                onPressed: () {},
                icon: Icon(Icons.tune_rounded),
              ),
            ),
          ),
          Expanded(
            child: CustomScrollView(
              slivers: [
                // todays task
                spaceY().asSliverBox,
                SliverToBoxAdapter(
                  child: Text(
                    "Todays Task",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                SliverList.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return WListTile(
                      index: index,
                      onTap: () async {},
                      title: "Mobile App Reacharch",
                    );
                  },
                ),
                // Tommorrow task
                spaceY().asSliverBox,
                SliverToBoxAdapter(
                  child: Text(
                    "Tommorrow Task",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                SliverList.builder(
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return WListTile(
                      onTap: () {},
                      title: "Mobile App Reacharch",
                      index: index,
                    );
                  },
                ),
                // spacific day task
                spaceY().asSliverBox,
                SliverToBoxAdapter(
                  child: Text(
                    "10-10-2025 Task",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                SliverList.builder(
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return WListTile(
                      onTap: () {},
                      index: index,
                      title: "Mobile App Reacharch",
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ).padAll(),
    );
  }
}

class WListTile extends StatelessWidget {
  final String title;
  final int index;
  final Function() onTap;
  const WListTile({
    super.key,
    required this.title,
    required this.onTap,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: () {
        _showPopupMenu(context, index);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(MyDimension.borderRadius),
        child: Container(
          decoration: BoxDecoration(color: MyColor.cardColor),
          child: IntrinsicHeight(
            child: Row(
              children: [
                Container(width: 10, color: Colors.blue),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title),
                      Row(
                        children: [
                          Icon(Icons.calendar_month),
                          Text("4 oct | 08:07 AM | 03:30:20"),
                        ],
                      ),
                    ],
                  ).padAll(),
                ),
              ],
            ),
          ),
        ),
      ).padY(val: 5),
    );
  }

  void _showPopupMenu(BuildContext context, int index) {
    final RenderBox renderBox =
        context.findRenderObject() as RenderBox; // get parent/tile's position.
    final Offset offset = renderBox.localToGlobal(
      Offset.zero,
    ); // get the parent/tile's top-left corner.

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx + renderBox.size.width, // Position from right
        offset.dy + renderBox.size.height / 2, // Center vertically
        offset.dx + renderBox.size.width, // Right edge
        offset.dy + renderBox.size.height, // Bottom edge
      ),

      color: Colors.transparent,
      elevation: 0,
      
      items: [
        PopupMenuItem(
          value: 'edit',
          padding: EdgeInsets.symmetric(vertical: 2),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(MyDimension.boarderRadius),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.edit, size: 20, color: Colors.blue),
                  SizedBox(width: 8),
                  Text('Edit'),
                ],
              ).padAll(),
            ),
          ),
        ),
        PopupMenuItem(
          value: 'Duplicate',
          padding:  EdgeInsets.symmetric(vertical: 2),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(MyDimension.boarderRadius),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.copy, size: 20, color: Colors.green),
                  SizedBox(width: 8),
                  Text('Duplicate'),
                ],
              ).padAll(),
            ),
          ),
        ),
        PopupMenuItem(
          padding: EdgeInsets.symmetric(vertical: 2),
          value: 'Delete',
          child: Container(
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(MyDimension.boarderRadius),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.delete, size: 20, color: Colors.black),
                  SizedBox(width: 8),
                  Text('Delete'),
                ],
              ).padAll(),
            ),
          ),
        ),
      ],
    ).then((value) {
      if (value != null) {
        // done some opration here.
      }
    });
  }
}
