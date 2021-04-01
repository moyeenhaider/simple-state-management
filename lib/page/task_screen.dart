import 'package:flutter/material.dart';
import 'package:taste/models/task.dart';
import 'package:taste/state/observable.dart';
import 'package:taste/state/observer.dart';
import 'package:taste/stream_page/todo_page.dart';

class TaskScreen extends StatelessWidget {
  final bool isWire;
  TaskScreen(this.isWire);
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
                  child: Text(
                    "ADD TASK",
                    style: TextStyle(fontSize: 24, color: Colors.indigo),
                  ),
                )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: taskController,
                    decoration: InputDecoration(
                      labelText: "Your Task",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                RaisedButton(
                  color: Colors.indigo,
                  onPressed: () {
                    if (taskController.text.isEmpty) return;
                    obs
                      ..data.tasks.add(Task(taskController.text))
                      ..notify();
                    taskController.clear();
                    Navigator.of(context).pop();
                  },
                  child:
                      Text("Add Task", style: TextStyle(color: Colors.white)),
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
        // backgroundColor: Colors.indigo,
        actions: [
          Switch(
              value: !isWire,
              onChanged: (value) {
                if (isWire) {
                  Navigator.pushReplacement(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new TodoStreamPage(true)));
                }
              })
        ],
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
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: ListTile(
                        tileColor: Colors.blueGrey,
                        title: Text(
                          obs.data.tasks[index].name,
                          style: TextStyle(color: Colors.white),
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            obs
                              ..data.tasks.removeAt(index)
                              ..notify();
                          },
                        ),
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
