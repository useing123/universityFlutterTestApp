// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_tes/screens/tags_screen.dart';
import 'package:intl/intl.dart';

class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  List<Task> tasks = [];
  final TextEditingController taskController = TextEditingController();
  final TextEditingController tagController =
      TextEditingController(); // New TextEditingController for tags
  bool showCompletedTasks = false;

  void addTask(String taskText, List<String> taskTags) {
    String currentTime = DateFormat('HH:mm:ss').format(DateTime.now());
    Task newTask = Task(taskText, currentTime, tags: taskTags);
    setState(() {
      tasks.add(newTask);
      taskController.clear();
      tagController.clear(); // Clear the tag input field after adding a task
    });
  }

  void removeTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  void toggleTaskCompletion(int index) {
    setState(() {
      tasks[index].isCompleted = !tasks[index].isCompleted;
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredTasks = showCompletedTasks
        ? tasks
        : tasks.where((task) => !task.isCompleted).toList();

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: taskController,
            decoration: const InputDecoration(
              hintText: 'Add a new task',
            ),
            onSubmitted: (value) => addTask(
                value, tagController.text.split(',')), // Split tags by comma
          ),
        ),

        // Add a new TextField for entering tags
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: tagController,
            decoration: const InputDecoration(
              hintText: 'Add tags (comma-separated)',
            ),
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () =>
                  addTask(taskController.text, tagController.text.split(',')),
              child: const Text('Add Task', style: TextStyle(fontSize: 16)),
            ),
            const SizedBox(width: 16), // Add spacing between buttons
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TagsScreen(tasks: tasks),
                  ),
                );
              },
              child: const Text('View Tags', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Show Completed Tasks'),
            Switch(
              value: showCompletedTasks,
              onChanged: (value) {
                setState(() {
                  showCompletedTasks = value;
                });
              },
            ),
          ],
        ),
        if (filteredTasks.isEmpty) const Text('No tasks yet.'),
        Expanded(
          child: ListView.builder(
            itemCount: filteredTasks.length,
            itemBuilder: (context, index) {
              final task = filteredTasks[index];
              return Dismissible(
                key: Key(task.id),
                onDismissed: (direction) => removeTask(index),
                child: ListTile(
                  title: Text(task.text),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Created at: ${task.createdAt}'),
                      Text('Tags: ${task.tags.join(', ')}'),
                    ],
                  ),
                  trailing: Checkbox(
                    value: task.isCompleted,
                    onChanged: (value) => toggleTaskCompletion(index),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class Task {
  final String id;
  final String text;
  final String createdAt;
  bool isCompleted;
  List<String> tags;

  Task(this.text, this.createdAt,
      {this.isCompleted = false, this.tags = const []})
      : id = DateTime.now().toString();
}
