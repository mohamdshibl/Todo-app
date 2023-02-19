import 'package:flutter/material.dart';

Widget defaultButton({
  double width =double.infinity,
  Color background = Colors.blue,
  required Function function,
  required String text,

}) => Container(
  width: width,
  color: background,
  child: MaterialButton(
    onPressed: (){
       function;
    },
    child: Text(
      text,
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  ),
);


 Widget defaultFormField({
  required TextEditingController controller,
  double width =double.infinity,
 // Color background = Colors.grey,
  required TextInputType type,
   String? text,
   required Function validate,
  required String label,
  required IconData prifix,
  //Function? onSubmit ,
  //Function? onChange ,
   VoidCallback? onTap,

 }) => TextFormField(
  controller : controller,
  keyboardType: type,
  //onFieldSubmitted:  (value) => onSubmit!(value),
  // onChanged: (value) => onChange!(value),
   onTap: onTap,
   validator: (value) => validate(value),
  decoration: InputDecoration(
    labelText: label,
    prefixIcon: Icon(prifix),
    border: OutlineInputBorder(),
  ),
);

 Widget buildTaskItem(Map model) => Column(
   children: [
     Container(
       decoration: BoxDecoration(
         borderRadius: BorderRadius.circular(20),
         color: Colors.blue[100],
       ),
       child: ListTile(
         /// title
         title:Text(
             '${model['title']}',
             style: TextStyle
               (fontSize: 20, fontWeight: FontWeight.bold,)),
         /// date
         subtitle: Text(
             '${model['date']}',
             style: TextStyle
               (fontSize: 16,)),
         /// time
         trailing: Text(
           '${model['time']}',
           style: TextStyle
             (fontSize: 16, color:Colors.brown),),
       ),
     ),
   ],
 );