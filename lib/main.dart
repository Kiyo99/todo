import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo/presentation/custom_widget.dart';
import 'package:todo/presentation/new_task.dart';
import 'package:todo/presentation/view_tasks.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;
int numm = 0;
final num2 = useState(0);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends HookWidget {

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      _firestore.collection('Personal').snapshots().length.then((value) => num2.value);
      print('Home number: ${num2.value}');
      print('');
      return;
    }, const []);



    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To Do',
      home: MyHomePage(
      ),
    );
  }
}

class MyHomePage extends HookWidget {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var nn = useState(0);

    _firestore.collection('Home').snapshots().length.then((value) => nn.value = value);
    print('Home numberrrr: ${nn.value}');

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(40),
        child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          future: _firestore.collection('Personal').get(),
          builder: (context, snapshot) {
            return Column(
              children: [
                ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: [
                    CustomWidget(
                      categoryName: 'Home',
                      categoryNum: nn.value,
                      ontap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ViewTasks(cat: 'Home',),
                          ),
                        );
                      },
                    ),
                    CustomWidget(
                      categoryName: 'Today',
                      categoryNum: 2,
                      ontap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ViewTasks(cat: 'Today',),
                          ),
                        );
                      },
                    ),
                    CustomWidget(
                      categoryName: 'Personal',
                      categoryNum: 2,
                      ontap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ViewTasks(cat: 'Personal',),
                          ),
                        );
                      },
                    ),
                    CustomWidget(
                      categoryName: 'Work',
                      categoryNum: 12,
                      ontap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ViewTasks(cat: 'Work',),
                          ),
                        );
                      },
                    ),
                    CustomWidget(
                      categoryName: 'Home',
                      categoryNum: 1,
                      ontap: () {},
                    ),
                    CustomWidget(
                      categoryName: 'Home',
                      categoryNum: 12,
                      ontap: () {},
                    ),
                  ],
                ),
               CustomWidget(
                    categoryName: 'Create new list',
                    categoryNum: 0,
                    ontap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => NewTask(),
                        ),
                      );
                    },
                  ),
              ],
            );
          }
        ),
      ),
    );
  }
}

//listview where