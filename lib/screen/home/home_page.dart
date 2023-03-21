import 'package:flutter/material.dart';
import 'package:flutter_todos_website/util/style/textStyle.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';
import 'package:reorderables/reorderables.dart';

import '../../data/model/mock/tasks.dart';
import '../../util/constant/pathes.dart';
import '../../util/style/appColors.dart';
import '../widget/custom_list_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();
  final _gridViewKey = GlobalKey();
  List<Widget> listOfWidgets = List.generate(
      tasks.length,
      (index) => CustomListTile(
            key: UniqueKey(),
            title: tasks[index].title,
            rightOnTap: () {},
            leftOnTap: () {},
          ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leadingWidth: 85,
          leading: Column(
            children: [
              Container(
                  margin: const EdgeInsets.only(left: 30),
                  child:
                      Image.asset("${Pathes.iconPath}noteX74${Extension.png}")),
            ],
          ),
          title: Text(
            "NoteY",
            style: TextStyles.titleStyleLogo,
          ),
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: <Color>[
                  AppColors.simeblue,
                  AppColors.lightGreen,
                ])),
          )),
      body: Container(
        width: 800,
        height: 800,
        margin: const EdgeInsets.only(left: 40, right: 40, top: 60),
        child: Column(
          children: [
            // ReorderableGridView(),

            // ReorderableGridView.count(
            //   key: _gridViewKey,
            //   // controller: ScrollController(),
            //   crossAxisSpacing: 15,
            //   mainAxisSpacing: 15,
            //   crossAxisCount: 4,
            //   shrinkWrap: true,
            //   restrictDragScope: true,
            //   children: listOfWidgets,
            //   onReorder: (oldIndex, newIndex) {
            //     print("Hi");
            //     setState(() {
            //       final element = tasks.removeAt(oldIndex);
            //       tasks.insert(newIndex, element);
            //     });
            //   },
            //   footer: [
            //     Card(
            //       child: Center(
            //         child: Icon(Icons.add),
            //       ),
            //     ),
            //   ],
            // ),
            ReorderableWrap(
                spacing: 8.0,
                runSpacing: 4.0,
                padding: const EdgeInsets.all(8),
                children: listOfWidgets,
                onReorder: (oldIndex, newIndex) {
                  final element = tasks.removeAt(oldIndex);
                  tasks.insert(newIndex, element);
                  setState(() {});
                },
                onNoReorder: (int index) {
                  //this callback is optional
                  debugPrint(
                      '${DateTime.now().toString().substring(5, 22)} reorder cancelled. index:$index');
                },
                onReorderStarted: (int index) {
                  //this callback is optional
                  debugPrint(
                      '${DateTime.now().toString().substring(5, 22)} reorder started: index:$index');
                })

            // ReorderableGridView.extent(
            //   maxCrossAxisExtent: 250,
            // onReorder: (oldIndex, newIndex) {
            //   setState(() {
            //     final element = tasks.removeAt(oldIndex);
            //     tasks.insert(newIndex, element);
            //   });
            // },
            //   childAspectRatio: 1,
            //   children: listOfWidgets,
            // ),

            // ReorderableGridView.count(
            //   crossAxisSpacing: 10,
            //   mainAxisSpacing: 10,
            //   crossAxisCount: 3,
            // onReorder: (oldIndex, newIndex) {
            //   setState(() {
            //     final element = tasks.removeAt(oldIndex);
            //     tasks.insert(newIndex, element);
            //   });
            // },
            //   footer: const [
            //     Card(
            //       child: Center(
            //         child: Icon(Icons.add),
            //       ),
            //     ),
            //   ],
            //   children: listOfWidgets.toList(),
            // ),

            // ReorderableBuilder(
            //     scrollController: _scrollController,
            //     onReorder: (List<OrderUpdateEntity> orderUpdateEntities) {
            //       for (final orderUpdateEntity in orderUpdateEntities) {
            //         final task = tasks.removeAt(orderUpdateEntity.oldIndex);
            //         tasks.insert(orderUpdateEntity.newIndex, task);
            //       }
            //     },
            //     builder: (children) {
            //       return GridView(
            //         shrinkWrap: true,
            //         key: _gridViewKey,
            //         controller: _scrollController,
            //         gridDelegate:
            //             const SliverGridDelegateWithFixedCrossAxisCount(
            //           crossAxisCount: 4,
            //           childAspectRatio: 2,
            //           mainAxisSpacing: 15.0,
            //           crossAxisSpacing: 15.0,
            //         ),
            //         children: children,
            //       );
            //     },
            //     children: listOfWidgets)

            // GridView.builder(
            // shrinkWrap: true,
            // itemCount: tasks.length,
            // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //   crossAxisCount: 4,
            //   childAspectRatio: 1.7,
            //   mainAxisSpacing: 15.0,
            //   crossAxisSpacing: 15.0,
            //     ),
            //     itemBuilder: (BuildContext context, int index) {
            //       return CustomListTile(
            //         title: tasks[index].title,
            //         rightOnTap: () {},
            //         leftOnTap: () {},
            //       );
            //     })
          ],
        ),
      ),
    );
  }
}
