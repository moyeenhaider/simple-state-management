import 'package:flutter/material.dart';
import 'package:taste/models/task.dart';
import 'package:taste/page/task_screen.dart';
import 'package:taste/stream_state_manager/state_builder.dart';
import 'package:taste/stream_state_manager/xcontroller.dart';

class TodoStreamPage extends StatelessWidget {
  final bool isWire;

  TodoStreamPage(this.isWire);
  final _xController = XController();

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
                  child: Text("ADD TASK",
                      style: TextStyle(fontSize: 24, color: Colors.indigo)),
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
                    _xController.state.tasks.add(Task(taskController.text));
                    _xController.update();
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
        title: Text("Tasks With Stream"),
        // backgroundColor: Colors.black87,
        actions: [
          Switch(
              value: isWire,
              onChanged: (value) {
                if (isWire) {
                  Navigator.pushReplacement(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new TaskScreen(true)));
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
            child: XStateBuilder(
              controller: _xController,
              builder: (controller) => ListView.separated(
                itemCount: controller.state.tasks.length,
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
                        title: Text("${controller.state.tasks[index].name}",
                            style: TextStyle(color: Colors.white)),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            controller
                              ..state.tasks.removeAt(index)
                              ..update();
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
          openAddTask(
            context,
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
