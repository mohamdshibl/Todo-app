import 'package:flutter/cupertino.dart';

import '../Shared/constants.dart';
import '../Shared/wedgits/conponents.dart';

class ArchivedTasksScreen extends StatelessWidget {
  const ArchivedTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
         buildTaskItem(tasks[0]),

        ],
      ),
    );
  }
}
