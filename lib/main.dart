import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shoppi/di/di.dart';
import 'package:shoppi/model/local/hive/user_model.dart';
import 'package:shoppi/services/user_service.dart';
import 'package:uuid/uuid.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependency();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: TaskList());
  }
}

class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  final TextEditingController _taskController = TextEditingController();
  final UserService userService = di.get<UserService>();
  final uuid = const Uuid();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Task List')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    decoration: const InputDecoration(labelText: 'Task'),
                  ),
                ),
                IconButton(
                    onPressed: () async {
                      final userId = uuid.v4();
                      final user = UserModel(
                        id: userId,
                        userName: _taskController.text,
                        password: '123456',
                      );
                      await userService.addUser(user);
                      _taskController.clear();
                    },
                    icon: const Icon(Icons.add)),
              ],
            ),
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: userService.listenable(),
              builder: (context, Box<UserModel> box, _) {
                if (box.isEmpty) {
                  return const Center(child: Text('No tasks'));
                } else {
                  return ListView.builder(
                    itemCount: box.length,
                    itemBuilder: (context, index) {
                      final task = box.getAt(index)!;
                      return ListTile(
                        title: Text(
                          task.userName,
                          style: const TextStyle(
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        leading: Checkbox(
                          value: task.isCompleted,
                          onChanged: (_) => userService.enableUser(index),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => userService.deleteUser(index),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
