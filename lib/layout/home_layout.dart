import 'package:amit2/Shared/wedgits/conponents.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../Shared/constants.dart';
import 'archived_Tasks.dart';
import 'done_Tasks.dart';
import 'new_Tasks.dart';
import 'package:intl/intl.dart';

class HomeLayout extends StatefulWidget {
  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  //const HomeLayout({Key? key}) : super(key: key);

   int currentIndex = 0;
   Database? database;
   var scaffoldKey = GlobalKey<ScaffoldState>();
   var formKey = GlobalKey<FormState>();
   bool isBottomSheetShown= false;
   IconData fabIcon = Icons.edit;

   var titleController = TextEditingController();
   var timeController = TextEditingController();
   var dateController = TextEditingController();




  List<Widget> Screans = [
    NewTasksScreen(),
    const DoneTasksScreen(),
    const ArchivedTasksScreen(),
  ];
  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];
  // List<Map> tasks = [];

  @override
  void initState() {

    super.initState();
    createDataBase();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title:  Text(
          titles[currentIndex],
        ),
      ),
      body: tasks.length == 0 ? Center(child: CircularProgressIndicator()) : Screans[currentIndex] ,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          if (isBottomSheetShown){
          if (formKey.currentState!.validate()) {
            insertToDatabase (
              title: titleController.text,
              time: timeController.text,
              date: dateController.text ,
            ).then((value){
               // هل البوتون مفتوح يبقي اقفل ب pop
              Navigator.pop(context);
              isBottomSheetShown = false;
              setState(() {
                fabIcon = Icons.edit;
                titleController.text = "";
                timeController.text = "";
                dateController.text = "";
              });
            });
          }
          }else{
            scaffoldKey.currentState?.showBottomSheet((context) =>
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                    children: [
                      defaultFormField(
                         controller: titleController,
                          type: TextInputType.text,
                          validate: (String value){
                           if (value.isEmpty){
                             return 'title must be not empty';
                           }
                          },
                          label: 'title title',
                          prifix: Icons.title,
                      ),
                      SizedBox(height: 10,),
                      defaultFormField(
                        controller: timeController,
                        type: TextInputType.datetime ,
                        onTap: (){
                          showTimePicker(context: context,
                              initialTime: TimeOfDay.now(),
                          ).then((value) =>
                          timeController.text = value!.format(context).toString());
                          },
                        validate: (String value){
                          if (value.isEmpty){
                            return 'time must be not empty';
                          }
                        },
                        label: 'Task time',
                        prifix: Icons.watch,
                      ),
                      SizedBox(height: 10,),
                      defaultFormField(
                        controller: dateController,
                        type: TextInputType.datetime,
                        onTap: (){
                          showDatePicker(context: context,
                              initialDate: DateTime.now() ,
                              firstDate: DateTime.now(),
                              lastDate: DateTime.parse('2023-05-03'),
                          ).then((value) =>{
                            dateController.text = DateFormat.yMMMd().format(value!),
                          });
                        },
                        validate: (String value){
                          if (value.isEmpty){
                            return 'date must be not empty';
                          }
                        },
                        label: 'Task date',
                        prifix: Icons.calendar_month,
                      ),
                    ],
                    ),
                  ),
                ),
              elevation: 15,
            ).closed.then((value) {
              isBottomSheetShown = false;
              setState(() {
                fabIcon = Icons.edit;
                titleController.text = "";
                timeController.text = "";
                dateController.text = "";
              });});
            isBottomSheetShown = true;
            setState(() {
              fabIcon = Icons.add;
            });
          }


         // insertToDatabase ();
        },
        child: Icon(
            fabIcon
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index)
          {
            setState(() {
              currentIndex = index ;
            });
          },
        items:
        const [
         BottomNavigationBarItem(
           icon: Icon(Icons.menu),
           label: 'Tasks',
         ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check),
            label: 'Done',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.archive_outlined),
            label: 'Archive',
          ),
        ],
      ),
    );
  }

  /// SQfLite
  ///
   /// Create table
  void createDataBase() async {
    database = await openDatabase('todo.db', version: 1,
      onCreate: (database,version){
        print('database created');
        database.execute('create table tasks'
            ' (id INTEGER PRIMARY KEY, title TEXT,date TEXT,time TEXT,status TEXT)').then((value) {
                 print('table created');
        }).catchError((error){
          print('error when create table ${error.toString()}');
        });
      },
      onOpen: (database,){
        getDataFromDatabase(database).then((value) {
          tasks = value;
          print(tasks);
        });
        print('db opened');
      },
    );}

/// insert into table
 Future insertToDatabase (
     {required String title,
       required String time,
       required String date,
     }) async {
    return await database!.transaction((txn)
    {
      txn.rawInsert('Insert into tasks'
          '(title,date,time,status)'
          ' VALUES("$title","$time","$date","NEW")').then((value) {
        print('$value inserted ');
      }).catchError((error){
        print('error when inserting new record ${error.toString()}');
      });
      return Future.value();
    });
  }

/// get data from database
  Future <List<Map>> getDataFromDatabase(database) async{

    return await database!.rawQuery('SELECT * FROM tasks');

  }
}



