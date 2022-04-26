import 'package:flutter/material.dart';
import 'package:todo/presentation/custom_widget.dart';
import 'package:todo/presentation/new_task.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
                  categoryNum: 12,
                  ontap: () {},
                ),
                CustomWidget(
                  categoryName: 'Today',
                  categoryNum: 12,
                  ontap: () {},
                ),
                CustomWidget(
                  categoryName: 'Personal',
                  categoryNum: 12,
                  ontap: () {},
                ),
                CustomWidget(
                  categoryName: 'Home',
                  categoryNum: 12,
                  ontap: () {},
                ),
                CustomWidget(
                  categoryName: 'Home',
                  categoryNum: 12,
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
