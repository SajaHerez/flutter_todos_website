import 'package:flutter/material.dart';
import 'package:flutter_todos_website/data/service/task_controller.dart';
import 'package:flutter_todos_website/screen/widget/custom_app_bar.dart';
import 'package:flutter_todos_website/util/style/appColors.dart';
import 'package:flutter_todos_website/util/style/textStyle.dart';
import 'package:provider/provider.dart';
import 'package:reorderable_grid/reorderable_grid.dart';
import '../../data/model/task.dart';
import '../../util/routing/RoutingUilites.dart';
import '../../util/style/spaces.dart';
import '../widget/custom_card.dart';
import '../widget/custom_list_tile.dart';
import '../widget/dialog.dart';
import '../widget/edit_dialog.dart';
import '../widget/sort_pop_up_menu.dart';

class ActivitiesScreen extends StatefulWidget {
  ActivitiesScreen({super.key, required this.task});
  Task task;
  @override
  State<ActivitiesScreen> createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> {
  final TextEditingController editController = TextEditingController();
  final TextEditingController addController = TextEditingController();
  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      final element = widget.task.subTaskList.removeAt(oldIndex);
      widget.task.subTaskList.insert(newIndex, element);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<SubTask> list = widget.task.subTaskList;
    return Scaffold(
      appBar: customAppBar(),
      body: Center(
        child: Container(
          width: 800,
          height: 800,
          margin: const EdgeInsets.only(left: 40, right: 40, top: 60),
          child: Column(
            children: [
              SpacesHelper.verticalSpace(80),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            RoutingUtil.pop();
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            size: 28,
                            color: AppColors.white,
                          )),
                      SpacesHelper.horizontalSpace(15),
                      Text(
                        widget.task.title,
                        style: TextStyles.titleStyleLogo,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          showEditDialog(
                            context,
                            controller: addController,
                            title: "Add Task",
                            actionName: "Add",
                            onPressed: () {
                              final task = SubTask(
                                  title: addController.text,
                                  id: widget.task.subTaskList.length + 1,
                                  createdAt: DateTime.now()
                                      .toString()
                                      .substring(0, 16));
                              print(task.createdAt);
                              setState(() {
                                widget.task.subTaskList.add(task);
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
                            style:
                                TextStyle(fontSize: 35, color: AppColors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SpacesHelper.horizontalSpace(5),
                      SortMenue(
                        sortOnCompletedDate: () {
                          setState(() {
                            widget.task.subTaskList.sort((a, b) =>
                                a.completedAt?.compareTo(b.completedAt ?? "") ??
                                1);
                          });
                        },
                        sortOnCreatedDate: () {
                          setState(() {
                            widget.task.subTaskList.sort(
                                (a, b) => -a.createdAt.compareTo(b.createdAt));
                          });
                        },
                      ),
                    ],
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
                  children: list.map((item) {
                    return CustomCard(
                      createdAt: item.createdAt,
                      onChanged: (value) {
                        setState(() {
                          item.isDone = value!;
                          if (item.isDone!) {
                            item.completedAt =
                                DateTime.now().toString().substring(0, 16);
                            print("the is Done value ${item.isDone}");
                          }
                        });
                        Provider.of<TaskController>(context, listen: false)
                            .setTaskprogress(widget.task.id);
                      },
                      isDone: item.isDone ?? false,
                      isCancelled: item.isCancelled ?? false,
                      key: ValueKey(item),
                      title: item.title,
                      deleteOnTap: () {
                        showAlertDialog(context, onPressed: () {
                          setState(() {
                            widget.task.subTaskList.remove(item);
                            Navigator.pop(context);
                          });
                        });
                      },
                      editOnTap: () {
                        editController.text = item.title;
                        showEditDialog(
                          context,
                          controller: editController,
                          title: "Edit Task",
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
                          item.completedAt = null;
                          print(
                              "  the cancelled  value is : ${item.isCancelled}");
                          // 3 cases  active => normal style , cancel => red style , done=> green style
                        });
                        Provider.of<TaskController>(context, listen: false)
                            .setTaskprogress(widget.task.id);
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