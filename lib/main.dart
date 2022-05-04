import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo/presentation/custom_widget.dart';
import 'package:todo/presentation/new_task.dart';
import 'package:todo/presentation/view_tasks.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends HookWidget {

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To Do',
      home: MyHomePage(
        title: 'To Do',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(40),
        child: Column(
          children: [
            ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: [
                CustomWidget(
                  categoryName: 'Home',
                  categoryNum: 6,
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
        ),
      ),
    );
  }
}

//listview where