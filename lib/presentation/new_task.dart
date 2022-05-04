import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:todo/presentation/box_component.dart';
import 'package:todo/presentation/tile.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;

class NewTask extends HookWidget {
  static String id = 'newTask';

  Color _color2 = Color(0xff848587);

  //Firestore items
  String title = '';
  String desc = '';

  @override
  Widget build(BuildContext context) {
    final tileTitle = useState(<String>[]);
    final SingleTileTitle = useState('');
    final category = useState('Home');
    final _selectedDay = useState(DateTime.now());
    return Scaffold(
      // resizeToAvoidBottomInset : false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
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
                  Expanded(
                    child: TextField(
                      onChanged: (String value) {
                        title = value;
                      },
                      style: TextStyle(
                          color: Color(0xff3F3F42),
                          fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Title...',
                        labelStyle: TextStyle(
                          color: Color(0xff3F3F42).withOpacity(0.7),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(20),
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
                            padding: EdgeInsets.fromLTRB(3, 0, 3, 0),
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(Icons.stop_circle,
                                    color: Colors.lightGreen),
                                SizedBox(width: 5),
                                DropdownButton<String>(
                                  value: category.value,
                                  items: <String>[
                                    'Home',
                                    'Today',
                                    'Personal',
                                    'Work'
                                  ].map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (catee) {
                                    category.value = catee!;
                                    print(category);
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
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          // padding: EdgeInsets.all(3),
                          child: TextButton(
                              style: ButtonStyle(),
                              onPressed: () {
                                DatePicker.showDatePicker(context,
                                    showTitleActions: true,
                                    minTime: DateTime(2010, 01, 01),
                                    maxTime: DateTime(2049, 12, 31),
                                    onChanged: (date) {
                                  print('change $date');
                                  _selectedDay.value = date;
                                }, onConfirm: (date) {
                                  print('confirm $date');
                                  _selectedDay.value = date;
                                },
                                    currentTime: DateTime.now(),
                                    locale: LocaleType.en);
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    DateFormat(DateFormat.ABBR_MONTH)
                                            .format(_selectedDay.value) +
                                        ' ' +
                                        _selectedDay.value.day.toString() +
                                        ' ' +
                                        _selectedDay.value.year.toString(),
                                    style: TextStyle(
                                        color: Color(0xff464646),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Icon(Icons.keyboard_arrow_down_outlined,
                                      color: Colors.black),
                                ],
                              )),
                        )
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
                padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
                child: TextField(
                  onChanged: (String value) {
                    desc = value;
                  },
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Write a note...',
                      labelStyle: TextStyle(
                          color: Color(0xffECE3C3),
                          fontWeight: FontWeight.bold)),
                ),
              ),
              SizedBox(height: 8),
              SizedBox(
                height: 200,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 30,
                        child: SmallTile(title: tileTitle.value[index]),
                      );
                    },
                    itemCount: tileTitle.value.length),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          height: 800,
                          color: Color(0xffECE3C3),
                          child: Center(
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  TextField(
                                    onSubmitted: (String value) {
                                      SingleTileTitle.value = value;
                                    },
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        labelText: 'SubTitle...',
                                        labelStyle: TextStyle(
                                            color: Color(0xffA8ACB1),
                                        )),
                                  ),
                                  ElevatedButton(
                                    child: const Text('Add subtask'),
                                    onPressed: () {
                                      if (SingleTileTitle.value == null){
                                        Navigator.pop(context);
                                      }
                                      else {
                                        tileTitle.value = tileTitle.value.toList()
                                          ..add(SingleTileTitle.value);
                                        Navigator.pop(context);
                                      }
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Icon(Icons.add, color: Color(0xffA0A5AB)),
                    SizedBox(width: 10),
                    Text(
                      'Add a subtask',
                      style: TextStyle(
                          color: Color(0xff828588),
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                // child: IconButton(onPressed: (){}, icon: Icon(Icons.add, color: Color(0xffA0A5AB))),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Container(
                    //     decoration: BoxDecoration(
                    //         color: Colors.white,
                    //         borderRadius: BorderRadius.circular(10),
                    //         border: Border.all(color: _color)),
                    //     padding: EdgeInsets.all(5),
                    //     child: Row(
                    //       children: const [
                    //         Icon(Icons.insert_drive_file_outlined,
                    //             color: Color(0xff828588)),
                    //         SizedBox(width: 5),
                    //         Text(
                    //           'Logo manual.pdf',
                    //           style: TextStyle(
                    //               color: Color(0xff828588),
                    //               fontWeight: FontWeight.bold),
                    //         ),
                    //       ],
                    //     )),
                    // SizedBox(height: 10),
                    // Container(
                    //     decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(10),
                    //         color: Colors.white,
                    //         border: Border.all(color: _color)),
                    //     padding: EdgeInsets.all(5),
                    //     child: Row(
                    //       children: const [
                    //         Icon(Icons.insert_drive_file_outlined,
                    //             color: Color(0xff828588)),
                    //         SizedBox(width: 5),
                    //         Text(
                    //           'Logo manual.pdf',
                    //           style: TextStyle(
                    //               color: Color(0xff828588),
                    //               fontWeight: FontWeight.bold),
                    //         ),
                    //       ],
                    //     )),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: TextButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Color(0xffEEF0F2))),
                              onPressed: () {
                                _showToast(context, 'Uploading...');

                                Map<String, Object> db = new Map();
                                db['Title'] = title;
                                db['Description'] = desc;
                                db['Due date'] =
                                    DateFormat(DateFormat.ABBR_MONTH)
                                            .format(_selectedDay.value) +
                                        ' ' +
                                        _selectedDay.value.day.toString() +
                                        ' ' +
                                        _selectedDay.value.year.toString();
                                db['Subtasks'] = tileTitle.value.toList();

                                _firestore
                                    .collection(category.value)
                                    .doc()
                                    .set(db)
                                    .whenComplete(() {
                                  _showToast(context, 'Successfully saved');
                                  Navigator.pop(context);
                                }).onError((error, stackTrace) => () {
                                          _showToast(context, 'Failed to save');
                                        });
                              },
                              child: Text(
                                'Add task',
                                style: TextStyle(color: _color2),
                              )),
                        ),
                        // SizedBox(
                        //   width: 10,
                        // ),
                        // Expanded(
                        //   child: TextButton(
                        //       style: ButtonStyle(
                        //           backgroundColor: MaterialStateProperty.all(
                        //               Color(0xffFCF0F0))),
                        //       onPressed: () {},
                        //       child: Text(
                        //         'Delete task',
                        //         style: TextStyle(color: Color(0xffD38394)),
                        //       )),
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showToast(BuildContext context, String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(message),
        action: SnackBarAction(
            label: 'Got it', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }
}
