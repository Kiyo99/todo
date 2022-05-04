import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:todo/presentation/view_task.dart';

class ViewTasks extends HookWidget {
  const ViewTasks({Key? key, required this.cat});

  final String cat;

  @override
  Widget build(BuildContext context) {
    final _mFirestore = FirebaseFirestore.instance;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _mFirestore.collection(cat).snapshots(),
        builder: (context, snapshots) {
          if (!snapshots.hasData) {
            return const Center(
              child: Text(
                'Data not available',
              ),
            );
          }
          final messages = snapshots.data?.docs;
          return ListView.builder(
            itemCount: messages?.length,
            itemBuilder: (context, index) {
              DocumentSnapshot snap = snapshots.data!.docs[index];
              return ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ViewTask(
                        category: cat,
                        selectedDay: snap['Due date'],
                        title: snap['Title'],
                        desc: snap['Description'],
                        docID: snap.id,
                      ),
                    ),
                  );
                },
                title: Text(snap['Title']),
              );
            },
          );
        },
      ),
    );
  }
}
