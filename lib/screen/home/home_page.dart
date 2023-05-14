import 'package:flutter/material.dart';
import 'package:flutter_todos_website/data/model/note.dart';
import 'package:flutter_todos_website/data/service/task_controller.dart';
import 'package:flutter_todos_website/data/service/user_controller.dart';
import 'package:flutter_todos_website/util/style/spaces.dart';
import 'package:flutter_todos_website/util/style/textStyle.dart';
import 'package:provider/provider.dart';
import 'package:reorderable_grid/reorderable_grid.dart';
import '../../ID/locator.dart';
import '../../data/local/local_storage.dart';
import '../../util/constant/pathes.dart';
import '../../util/routing/RouterNamed.dart';
import '../../util/routing/RoutingUilites.dart';
import '../../util/style/appColors.dart';
import '../widget/custom_app_bar.dart';
import '../widget/custom_list_tile.dart';
import '../widget/dialog.dart';
import '../widget/edit_dialog.dart';
import '../widget/sort_pop_up_menu.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                          if (addController.text.isNotEmpty) {
                            //  print(DateTime.now().toString());
                            context.read<TaskController>().addNote(
                                user_id:
                                    context.read<UserController>().getUser.id,
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
                        style: TextStyle(fontSize: 35, color: AppColors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SpacesHelper.horizontalSpace(5),
                  SortMenue(
                    sortOnCompletedDate: () {
                      context.read<TaskController>().sortOnCompletedDate();
                      // context.read<TaskController>().tasks.sort((a, b) =>
                      //     a.completedAt?.compareTo(b.completedAt ?? "") ?? 1);
                    },
                    sortOnCreatedDate: () {
                      context.read<TaskController>().sortOnCreatedDate();
                    },
                  ),
                ],
              ),
              SpacesHelper.verticalSpace(15),
              if (context.read<TaskController>().tasks.isEmpty) ...[
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
              ] else if (context.read<TaskController>().tasks.isNotEmpty) ...[
                Expanded(
                  child: ReorderableGridView.extent(
                    clipBehavior: Clip.antiAlias,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    maxCrossAxisExtent: 250,
                    onReorder: context.read<TaskController>().onReorder,
                    childAspectRatio: .90,
                    children: context.watch<TaskController>().tasks.map((item) {
                      return CustomListTile(
                        getPercent: () {
                          return 0; // Provider.of<TaskController>(context).getTaskprogress(item.id);
                        },
                        onTap: () {
                          RoutingUtil.push(RouterName.activitiesScreen,
                              arguments: item);
                        },
                        createdAt: item.createdAt.substring(0, 16),
                        onChanged: (value) {
                          context.read<TaskController>().checkDone(item,
                              context.read<UserController>().getUser.id, value);
                        },
                        isDone: item.isDone ?? false,
                        isCancelled: item.isCancelled ?? false,
                        key: ValueKey(item),
                        title: item.title,
                        deleteOnTap: () {
                          showAlertDialog(context, onPressed: () {
                            context.read<TaskController>().deleteNote(
                                  note_id: item.id,
                                  user_id:
                                      context.read<UserController>().getUser.id,
                                );
                            Navigator.pop(context);
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
                              if (editController.text.isNotEmpty) {
                                context.read<TaskController>().updateNote(
                                    note_id: item.id,
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
                          context.read<TaskController>().cancelOn(
                              item, context.read<UserController>().getUser.id);
                        },
                      );
                    }).toList(),
                  ),
                ),
              ] else ...[
                const Center(
                  child: CircularProgressIndicator(),
                )
              ],
            ],
          ),
        ),
      ),
    );
  }
}
