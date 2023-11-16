import 'package:flutter/material.dart';
import 'package:flutter_tes/widgets/tagged_task_list.dart';
import 'package:flutter_tes/widgets/task_list.dart';

class TagsScreen extends StatelessWidget {
  final List<Task> tasks;

  TagsScreen({required this.tasks});

  @override
  Widget build(BuildContext context) {
    List<String> allTags = [];

    tasks.forEach((task) {
      allTags.addAll(task.tags);
    });

    allTags = allTags.toSet().toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Generated Tags'),
      ),
      body: ListView.builder(
        itemCount: allTags.length,
        itemBuilder: (context, index) {
          final tag = allTags[index];
          return ListTile(
            title: Text(tag),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      TaggedTaskList(tasks: tasks, selectedTag: tag),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
