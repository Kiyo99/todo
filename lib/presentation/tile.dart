import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SmallTile extends HookWidget {
  SmallTile({Key? key, required this.title});

  final String title;
  static late bool checkStatuss = false;
  @override
  Widget build(BuildContext context) {

    final checkStatus = useState(checkStatuss);

    Color _color = Color(0xff828588);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Theme(
          data: Theme.of(context).copyWith(
            unselectedWidgetColor: _color,
          ),
          child: Checkbox(
            value: checkStatus.value,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            activeColor: Colors.black,
            onChanged: (bool? newValue) {
                checkStatus.value = newValue!;
                checkStatuss = true;
                print('New value: $newValue');
                print('ini: ${checkStatus.value}');
            },
          ),
        ),
        Text(
          title,
          style: TextStyle(
              color: Color(0xffA8ACB1),
              fontWeight: FontWeight.bold,
              decoration: checkStatus.value? TextDecoration.lineThrough : null),
        ),
      ],
    );
  }
}
