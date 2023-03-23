import 'package:flutter/material.dart';
import 'package:flutter_todos_website/data/model/task.dart';
import 'package:flutter_todos_website/util/style/spaces.dart';
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
  final TextEditingController addController = TextEditingController();
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
      body: Center(
        child: Container(
          width: 800,
          height: 800,
          margin: const EdgeInsets.only(left: 40, right: 40, top: 60),
          child: Column(
            children: [
              SpacesHelper.verticalSpace(80),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      showEditDialog(
                        context,
                        controller: addController,
                        title: "Add Note",
                        actionName: "Add",
                        onPressed: () {
                          final task = Task(
                              title: addController.text,
                              id: tasks.length + 1,
                              subTaskList: [],
                              createdAt:
                                  DateTime.now().toString().substring(0, 16));
                          print(task.createdAt);
                          setState(() {
                            tasks.add(task);
                            addController.clear();
                          });
                          Navigator.pop(context);
                        },
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: AppColors.lightGreen),
                      child: const Text(
                        "+",
                        style: TextStyle(fontSize: 35, color: AppColors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
              SpacesHelper.verticalSpace(15),
              Expanded(
                child: ReorderableGridView.extent(
                  clipBehavior: Clip.antiAlias,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  maxCrossAxisExtent: 250,
                  onReorder: _onReorder,
                  childAspectRatio: .90,
                  children: tasks.map((item) {
                    return CustomListTile(
                      createdAt: item.createdAt,
                      onChanged: (value) {
                        setState(() {
                          item.isDone = value!;
                          print("the is Done value ${item.isDone}");
                        });
                      },
                      isDone: item.isDone ?? false,
                      isCancelled: item.isCancelled ?? false,
                      key: ValueKey(item),
                      title: item.title,
                      deleteOnTap: () {
                        showAlertDialog(context, onPressed: () {
                          setState(() {
                            tasks.remove(item);
                            Navigator.pop(context);
                          });
                        });
                      },
                      editOnTap: () {
                        editController.text = item.title;
                        showEditDialog(
                          context,
                          controller: editController,
                          title: "Edit Note",
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
                      cancelOnTap: () {
                        setState(() {
                          item.isCancelled = !item.isCancelled!;
                          item.isDone = item.isDone == true ? false : null;
                          print(
                              "  the cancelled  value is : ${item.isCancelled}");
                          // 3 cases  active => normal style , cancel => red style , done=> green style
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
