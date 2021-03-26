import 'package:flutter/material.dart';
import 'package:taste/models/task.dart';
import 'package:taste/state/observable.dart';
import 'package:taste/state/observer.dart';

class TasteScreen extends StatelessWidget {
  final obs = Observable();

  openAddTask(_) {
    showModalBottomSheet(
      context: _,
      builder: (context) {
        final taskController = TextEditingController();
        return SingleChildScrollView(
          child: Container(
            height: 600,
            child: Column(
              children: [
                Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("ADD TASK"),
                )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: taskController,
                    decoration: InputDecoration(labelText: "Your Task"),
                  ),
                ),
                RaisedButton(
                  onPressed: () {
                    if (taskController.text.isEmpty) return;
                    obs
                      ..data.tasks.add(Task(taskController.text))
                      ..notify();
                    taskController.clear();
                    Navigator.of(context).pop();
                  },
                  child: Text("Add Task"),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tasks"),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10),
          ),
          Expanded(
            child: Observer(
              observable: obs,
              builder: (_) => ListView.separated(
                itemCount: obs.data.tasks.length,
                separatorBuilder: (BuildContext context, int index) {
                  return Divider();
                },
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ListTile(
                      tileColor: Colors.grey,
                      title: Text(obs.data.tasks[index].name),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          obs
                            ..data.tasks.removeAt(index)
                            ..notify();
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openAddTask(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
