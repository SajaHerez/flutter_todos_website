import 'package:flutter/material.dart';
import 'package:flutter_todos_website/data/service/task_controller.dart';
import 'package:flutter_todos_website/screen/widget/custom_app_bar.dart';
import 'package:flutter_todos_website/util/style/appColors.dart';
import 'package:flutter_todos_website/util/style/textStyle.dart';
import 'package:provider/provider.dart';
import 'package:reorderable_grid/reorderable_grid.dart';
import '../../data/model/note.dart';
import '../../data/model/subNote.dart';
import '../../data/service/sub_task_controller.dart';
import '../../data/service/user_controller.dart';
import '../../util/constant/pathes.dart';
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      body: Center(
        child: Container(
          width: 800,
          height: 800,
          margin: const EdgeInsets.only(left: 40, right: 40, top: 30),
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
                              if (addController.text.isNotEmpty) {
                                context.read<SubTaskController>().addSubNote(
                                    user_id: context
                                        .read<UserController>()
                                        .getUser
                                        .id,
                                    note_id: widget.task.id,
                                    completedAt: "",
                                    createdAt: DateTime.now().toString(),
                                    title: addController.text,
                                    isCancelled: false,
                                    isDone: false);
                                addController.clear();
                              }
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
                          context
                              .read<SubTaskController>()
                              .sortOnCompletedDate();
                        },
                        sortOnCreatedDate: () {
                          context.read<SubTaskController>().sortOnCreatedDate();
                        },
                      ),
                    ],
                  )
                ],
              ),
              SpacesHelper.verticalSpace(15),
              if (context
                  .watch<SubTaskController>()
                  .getSubTaskList
                  .isEmpty) ...[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "${Pathes.imagePath}createNote${Extension.png}",
                    ),
                    Text(
                      "Create You  First Note",
                      style: TextStyles.descriptionTextStyle,
                    )
                  ],
                )
              ] else if (context
                  .watch<SubTaskController>()
                  .getSubTaskList
                  .isNotEmpty) ...[
                Expanded(
                  child: ReorderableGridView.extent(
                    clipBehavior: Clip.antiAlias,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    maxCrossAxisExtent: 250,
                    onReorder: context.read<SubTaskController>().onReorder,
                    childAspectRatio: .90,
                    children: context
                        .watch<SubTaskController>()
                        .getSubTaskList
                        .map((item) {
                      return CustomCard(
                        createdAt: item.createdAt.substring(0, 16),
                        onChanged: (value) {
                          context.read<SubTaskController>().checkDone(
                              item: item,
                              user_id:
                                  context.read<UserController>().getUser.id,
                              note_id: widget.task.id,
                              value: value);
                        },
                        isDone: item.isDone ?? false,
                        isCancelled: item.isCancelled ?? false,
                        key: ValueKey(item),
                        title: item.title,
                        deleteOnTap: () {
                          showAlertDialog(context, onPressed: () {
                            context.read<SubTaskController>().deleteSubNote(
                                user_id:
                                    context.read<UserController>().getUser.id,
                                note_id: widget.task.id,
                                subNote_id: item.id);
                            Navigator.pop(context);
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
                              if (editController.text.isNotEmpty) {
                                context.read<SubTaskController>().UpdateSubNote(
                                    subNote_id: item.id,
                                    note_id: widget.task.id,
                                    user_id: context
                                        .read<UserController>()
                                        .getUser
                                        .id,
                                    completedAt: item.completedAt ?? "",
                                    createdAt: item.createdAt,
                                    title: editController.text,
                                    isCancelled: item.isCancelled ?? false,
                                    isDone: item.isDone ?? false);
                                editController.clear();
                                Navigator.pop(context);
                              }
                            },
                          );
                        },
                        cancelOnTap: () {
                          context.read<SubTaskController>().cancelOn(
                              item,
                              context.read<UserController>().getUser.id,
                              widget.task.id);
                          // Provider.of<TaskController>(context, listen: false)
                          //     .setTaskprogress(widget.task.id);
                          // Provider.of<TaskController>(context, listen: false)
                          //     .setTodayProgress();
                        },
                      );
                    }).toList(),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
