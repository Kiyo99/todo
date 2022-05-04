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

class ViewTask extends HookWidget {
  ViewTask({
    required this.category,
    required this.title,
    required this.desc,
    required this.selectedDay,
    required this.docID,
  });

  static String id = 'newTask';
  String category;
  String title;
  String desc;
  String selectedDay;
  String docID;

  // DocumentReference snapp = _firestore.collection(category).doc(docID);

  Color _color = const Color(0xffEEF0F2);
  Color _color2 = const Color(0xff848587);
  Color _color3 = const Color(0xffD38394);

  @override
  Widget build(BuildContext context) {
    //firebase stuff
    Future<List<DocumentSnapshot>> getData() async {
      QuerySnapshot qn = await _firestore.collection("UserTransactions").get();
      return qn.docs;
    }

    print(docID);
    useEffect(() {
      FirebaseFirestore.instance
          .collection(category)
          .doc(docID)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          print('Document data: ${documentSnapshot.data()}');
        } else {
          print('Document doesnt exists on the database');
        }
      });
      return;
    }, const []);

    final tileTitle = useState(<String>[]);
    final SingleTileTitle = useState('');
    final category2 = useState(category);
    final _selectedDay = useState(DateTime.now());
    final dateChanged = useState(false);
    return Scaffold(
      // resizeToAvoidBottomInset : false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: GestureDetector(

        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          BoxComponent(
                            boxWidth: 22,
                            boxHeight: 22,
                            color: const Color(0xffEEF0F2),
                            child: Container(),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                              onChanged: (String value) {
                                title = value;
                              },
                              initialValue: title,
                              style: const TextStyle(
                                  color: Color(0xff3F3F42),
                                  fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelStyle: TextStyle(
                                  color: const Color(0xff3F3F42).withOpacity(0.7),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0xffEEF0F2),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Category',
                                  style: TextStyle(
                                      color: Color(0xffA8ACB1),
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(
                                    padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const Icon(Icons.stop_circle,
                                            color: Colors.lightGreen),
                                        const SizedBox(width: 5),
                                        DropdownButton<String>(
                                          value: category2.value,
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
                                            category2.value = catee!;
                                            print(category);
                                          },
                                        )
                                      ],
                                    )),
                              ],
                            ),
                            const SizedBox(height: 11),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Due date',
                                  style: const TextStyle(
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
                                      style: const ButtonStyle(),
                                      onPressed: () {
                                        DatePicker.showDatePicker(context,
                                            showTitleActions: true,
                                            minTime: DateTime(2010, 01, 01),
                                            maxTime: DateTime(2049, 12, 31),
                                            onChanged: (date) {
                                              print('change $date');
                                              _selectedDay.value = date;
                                              dateChanged.value = true;
                                            }, onConfirm: (date) {
                                              print('confirm $date');
                                              dateChanged.value = true;
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
                                            dateChanged.value
                                                ? DateFormat(DateFormat.ABBR_MONTH)
                                                .format(_selectedDay.value) +
                                                ' ' +
                                                _selectedDay.value.day.toString() +
                                                ' ' +
                                                _selectedDay.value.year.toString()
                                                : selectedDay,
                                            style: const TextStyle(
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
                      const SizedBox(height: 10),
                      Container(
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(15),
                          color: const Color(0xffFAF6E9),
                        ),
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                        child: TextFormField(
                          onChanged: (String value) {
                            desc = value;
                          },
                          initialValue: desc,
                          style: const TextStyle(
                            color: Color(0xffaaa3d3),
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                        future: FirebaseFirestore.instance
                            .collection(category)
                            .doc(docID)
                            .get(),
                        builder: (context, snapshots) {
                          if (snapshots.hasData) {
                            final messages = snapshots.data?.data();


                            // tileTitle.value = List.from(messages!['Subtasks']);
                            print('Hello: ${tileTitle.value}');

                            if (messages!.containsKey('Subtasks')) {
                              return ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                physics: const ClampingScrollPhysics(),
                                itemCount: messages['Subtasks'].length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    height: 30,
                                    child:
                                    SmallTile(title: messages['Subtasks'][index]),
                                  );
                                },
                              );
                            }
                          }

                          return const Center(
                            child: Text('Data not available'),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  height: 800,
                                  color: const Color(0xffECE3C3),
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
                                            decoration: const InputDecoration(
                                                border: InputBorder.none,
                                                labelText: 'SubTitle...',
                                                labelStyle: const TextStyle(
                                                  color: Color(0xffA8ACB1),
                                                )),
                                          ),
                                          ElevatedButton(
                                            child: const Text('Add subtask'),
                                            onPressed: () {
                                              if (SingleTileTitle.value == null) {
                                                Navigator.pop(context);
                                              } else {
                                                Map<String, Object> db = new Map();

                                                tileTitle.value = tileTitle.value
                                                    .toList()
                                                  ..add(SingleTileTitle.value);

                                                db['Subtasks'] =
                                                    tileTitle.value.toList();
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
                      )
                    ],
                  ),
                ),
              ),
              Column(
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
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: TextButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    const Color(0xffEEF0F2))),
                            onPressed: () {
                              _showToast(context, 'Updating...');

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
                                      .collection(category2.value)
                                      .doc(docID)
                                      .update(db)
                                      .whenComplete(() {
                                    _showToast(context, 'Successfully Updated');
                                    Navigator.pop(context);
                                  }).onError((error, stackTrace) => () {
                                    _showToast(
                                        context, 'Failed to delete');
                                  });
                            },
                            child: Text(
                              'Update task',
                              style: TextStyle(color: _color2),
                            )),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    const Color(0xffFCF0F0))),
                            onPressed: () {
                              _showToast(context, 'Deleting...');
                              _firestore
                                  .collection(category2.value)
                                  .doc(docID)
                                  .delete()
                                  .whenComplete(() {
                                _showToast(context, 'Successfully deleted');
                                Navigator.pop(context);
                              }).onError((error, stackTrace) => () {
                                _showToast(
                                    context, 'Failed to delete');
                              });
                            },
                            child: const Text(
                              'Delete task',
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
