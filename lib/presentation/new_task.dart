import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo/presentation/box_component.dart';
import 'package:todo/presentation/tile.dart';

class NewTask extends StatefulWidget {
  static String id = 'newTask';

  @override
  State<NewTask> createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  Color _color = Color(0xffEEF0F2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
        child: Column(
          children: [
            Row(
              children: [
                BoxComponent(
                  boxWidth: 22,
                  boxHeight: 22,
                  color: Color(0xffEEF0F2),
                  child: Container(),
                ),
                SizedBox(width: 10),
                Text(
                  'Meeting with John',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10),
                color: Color(0xffEEF0F2),
              ),
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Category',
                        style: TextStyle(
                            color: Color(0xffA8ACB1),
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                          padding: EdgeInsets.all(3),
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.stop_circle, color: Colors.lightGreen),
                              SizedBox(width: 5),
                              DropdownButton<String>(
                                items: <String>['Home', 'Today', 'Personal', 'Work'].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (catee) {
                                  setState(() {
                                    print(catee);
                                  });
                                },
                              )
                            ],
                          )),
                    ],
                  ),
                  SizedBox(height: 11),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Due date',
                        style: TextStyle(
                            color: Color(0xffA8ACB1),
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                          padding: EdgeInsets.all(3),
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              SizedBox(width: 5),
                              Text(
                                'Oct 15 2021',
                                style: TextStyle(
                                    color: Color(0xffA8ACB1),
                                    fontWeight: FontWeight.bold),
                              ),
                              Icon(Icons.keyboard_arrow_down_outlined,
                                  color: Colors.black),
                            ],
                          )),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(15),
                color: Color(0xffFAF6E9),
              ),
              padding: EdgeInsets.all(10),
              child: TextField(
                onChanged: (String value) {},
                decoration: InputDecoration(
                    labelText: 'Write a note...',
                    labelStyle: TextStyle(
                        color: Color(0xffECE3C3), fontWeight: FontWeight.bold)),
              ),
            ),
            SizedBox(height: 8),
            SmallTile(title: 'Finish the designs'),
            SmallTile(title: 'Prepare a presentaion'),
            SmallTile(title: 'Call John'),
            SmallTile(title: 'Do a user testing'),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.add, color: Color(0xffA0A5AB)),
                SizedBox(width: 10),
                Text(
                  'Add a subtask',
                  style: TextStyle(
                      color: Color(0xff828588), fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: _color)),
                    padding: EdgeInsets.all(5),
                    child: Row(
                      children: [
                        Icon(Icons.insert_drive_file_outlined,
                            color: Color(0xff828588)),
                        SizedBox(width: 5),
                        Text(
                          'Logo manual.pdf',
                          style: TextStyle(
                              color: Color(0xff828588),
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
                SizedBox(height: 10),
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        border: Border.all(color: _color)),
                    padding: EdgeInsets.all(5),
                    child: Row(
                      children: [
                        Icon(Icons.insert_drive_file_outlined,
                            color: Color(0xff828588)),
                        SizedBox(width: 5),
                        Text(
                          'Logo manual.pdf',
                          style: TextStyle(
                              color: Color(0xff828588),
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //   Container(
                    //       decoration: BoxDecoration(
                    //           color: Colors.white,
                    //           borderRadius: BorderRadius.circular(10),
                    //           border: Border.all(color: _color)),
                    //       padding: EdgeInsets.all(5),
                    Expanded(
                      child: TextButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0xffEEF0F2))),
                          onPressed: () {},
                          child: Text(
                            'Add a file',
                            style: TextStyle(color: Color(0xff848587)),
                          )),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: TextButton(
                          style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all(Color(0xffFCF0F0))),
                          onPressed: () {},
                          child: Text(
                            'Add a file',
                            style: TextStyle(color: Color(0xffD38394)),
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
