import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Shared/constants.dart';
import '../Shared/wedgits/conponents.dart';

class NewTasksScreen extends StatelessWidget {
 // const NewTasksScreen({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Scaffold(
        body: ListView.separated(
            itemBuilder: (context,index) => buildTaskItem(tasks[index]),
            separatorBuilder: (context,index)=> Container(
              width: double.infinity,
              height: 4,
              color: Colors.grey[300],
            ),
            itemCount: tasks.length,
        ),
      ),
    );
  }
}
