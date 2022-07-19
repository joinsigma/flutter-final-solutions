import 'package:flutter/material.dart';

class CallHeaderBar extends StatefulWidget {
  const CallHeaderBar({Key? key}) : super(key: key);

  @override
  State<CallHeaderBar> createState() => _CallHeaderBarState();
}

class _CallHeaderBarState extends State<CallHeaderBar> {
  // Custom Toggle Button
  List<bool> isBtnSelected = [true, false];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        // 'Edit' Text button
        GestureDetector(
          onTap: (){},
          child: const Text(
            'Edit',
            style: TextStyle(color: Colors.blue),
          ),
        ),

        // Category Button Bar ('All' & 'Missed')
        Container(
          height: 25,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: ToggleButtons(
            isSelected: isBtnSelected,
            children: const [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 10.0,
                ),
                child: Text(
                  'All',
                  style: TextStyle(fontSize: 12.0),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 10.0,
                ),
                child: Text(
                  'Missed',
                  style: TextStyle(fontSize: 12.0),
                ),
              ),
            ],
            onPressed: (int index) {
              setState(() {
                // unselect all
                for (var i = 0; i < isBtnSelected.length; i++) {
                  isBtnSelected[i] = false;
                }
                // remark current selection
                isBtnSelected[index] = true;
              });
            },
            color: Colors.black,
            fillColor: Colors.white,
            selectedColor: Colors.black,
            borderRadius: BorderRadius.circular(8.0),
            renderBorder: false,
          ),
        ),

        // Add Contact icon
        GestureDetector(
          onTap: (){},
          child: const Icon(
            Icons.add_ic_call_outlined,
            color: Colors.blue,
            size: 18.0,
          ),
        ),
      ],
    );
  }
}
