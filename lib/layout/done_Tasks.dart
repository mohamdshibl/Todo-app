import 'package:flutter/cupertino.dart';

class DoneTasksScreen extends StatelessWidget {
  const DoneTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Text(
      'DoneTask',
      style: TextStyle
        (
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
