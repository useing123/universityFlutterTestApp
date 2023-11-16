import 'package:flutter/material.dart';
import 'package:flutter_tes/widgets/task_list.dart';

class TaggedTaskList extends StatelessWidget {
  final List<Task> tasks;
  final String selectedTag;

  TaggedTaskList({required this.tasks, required this.selectedTag});

  @override
  Widget build(BuildContext context) {
    final filteredTasks =
        tasks.where((task) => task.tags.contains(selectedTag)).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks with Tag: $selectedTag'),
      ),
      body: ListView.builder(
        itemCount: filteredTasks.length,
        itemBuilder: (context, index) {
          final task = filteredTasks[index];
          return ListTile(
            title: Text(task.text),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Created at: ${task.createdAt}'),
                Text('Tags: ${task.tags.join(', ')}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
