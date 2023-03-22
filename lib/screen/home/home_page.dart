import 'package:flutter/material.dart';
import 'package:flutter_todos_website/util/style/textStyle.dart';
import 'package:reorderable_grid/reorderable_grid.dart';
import '../../data/model/mock/tasks.dart';
import '../../util/constant/pathes.dart';
import '../../util/style/appColors.dart';
import '../widget/custom_list_tile.dart';
import '../widget/dialog.dart';
import '../widget/edit_dialog.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController editController = TextEditingController();
  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      final element = tasks.removeAt(oldIndex);
      tasks.insert(newIndex, element);
    });
  }

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


            
            Expanded(
              child: ReorderableGridView.extent(
                clipBehavior: Clip.antiAlias,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                maxCrossAxisExtent: 200,
                onReorder: _onReorder,
                childAspectRatio: 1,
                children: tasks.map((item) {
                  return CustomListTile(
                    key: ValueKey(item),
                    title: item.title,
                    rightOnTap: () {
                      showAlertDialog(context, onPressed: () {
                        setState(() {
                          tasks.remove(item);
                        });
                      });
                      Navigator.pop(context);
                    },
                    leftOnTap: () {
                      showEditDialog(
                        context,
                        controller: editController,
                        title: "Edit",
                        actionName: "Edit",
                        onPressed: () {
                          setState(() {
                            item.title = editController.text;
                            editController.clear();
                          });
                          Navigator.pop(context);
                        },
                      );
                    },
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
