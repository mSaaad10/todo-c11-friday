import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_c11_thursday/core/utils/date_formatter.dart';
import 'package:todo_c11_thursday/core/utils/dialog_utils.dart';
import 'package:todo_c11_thursday/database_manager/model/task.dart';
import 'package:todo_c11_thursday/database_manager/tasks_dao.dart';
import 'package:todo_c11_thursday/providers/app_auth_provider.dart';
import 'package:todo_c11_thursday/ui/widgets/custom_text_form_field.dart';

class AddTaskBottomSheet extends StatefulWidget {
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var taskTitleController = TextEditingController();

  var taskDescController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Add Task',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).primaryColor),
            ),
            CustomTextFormField(
              hint: 'Task Title',
              keyboardType: TextInputType.text,
              controller: taskTitleController,
              validator: (input) {
                if (input == null || input.trim().isEmpty) {
                  return 'Plz, enter task title';
                }
                return null;
              },
            ),
            CustomTextFormField(
              hint: 'Task Description',
              keyboardType: TextInputType.text,
              controller: taskDescController,
              validator: (input) {
                if (input == null || input.trim().isEmpty) {
                  return 'Plz, enter task description';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
              child: Text(
                'Select Date',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).primaryColor),
              ),
            ),
            InkWell(
              onTap: () {
                chooseTaskDate(context);
              },
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: Text(
                    formatDate(finalSelectedDate),
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  )),
            ),
            ElevatedButton(
                onPressed: () {
                  createTask();
                },
                child: Text('Create Task'))
          ],
        ),
      ),
    );
  }

  void createTask() async {
    var authProvider = Provider.of<AppAuthProvider>(context, listen: false);
    // validate form
    if (formKey.currentState?.validate() == false) return;

    // add task to firestore
    Task task = Task(
      id: authProvider.databaseUser!.id!,
      title: taskTitleController.text,
      description: taskDescController.text,
      taskDate: Timestamp.fromMillisecondsSinceEpoch(
          finalSelectedDate.millisecondsSinceEpoch),
    );

    DialogUtils.showLoadingDialog(context, message: 'Creating Task...');
    await TasksDao.addTask(task, authProvider.databaseUser!.id!);
    DialogUtils.hideDialog(context);
    DialogUtils.showMessageDialog(context,
        message: 'Task Created Successfully',
        posActionTitle: 'Ok', posAction: () {
      Navigator.pop(context);
    });
  }

  var finalSelectedDate = DateTime.now();

  void chooseTaskDate(BuildContext context) async {
    DateTime? userSelectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(
          days: 365,
        )));
    if (userSelectedDate != null) {
      finalSelectedDate = userSelectedDate;
      setState(() {});
    }
  }
}
