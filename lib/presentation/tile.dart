import 'package:flutter/material.dart';

class SmallTile extends StatefulWidget {
  const SmallTile({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<SmallTile> createState() => _SmallTileState();
}

class _SmallTileState extends State<SmallTile> {
  bool _throwShotAway = false;
  Color _color = Color(0xff828588);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Theme(
          data: Theme.of(context).copyWith(
            unselectedWidgetColor: _color,
          ),
          child: Checkbox(
            value: _throwShotAway,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            activeColor: Colors.black,
            onChanged: (bool? newValue) {
              setState(() {
                _throwShotAway = newValue!;
              });
            },
          ),
        ),
        Text(
          widget.title,
          style: TextStyle(
              color: Color(0xffA8ACB1),
              fontWeight: FontWeight.bold,
              decoration: _throwShotAway? TextDecoration.lineThrough : null),
        ),
      ],
    );
  }
}
