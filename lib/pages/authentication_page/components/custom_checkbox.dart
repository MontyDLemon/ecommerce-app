import 'package:flutter/material.dart';

class CustomCheckbox extends StatefulWidget {
  final Function(bool) onCheck;
  const CustomCheckbox({
    Key? key,
    required this.onCheck,
  }) : super(key: key);

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) => Checkbox(
        value: isChecked,
        onChanged: (newVal) => setState(() {
          isChecked = !isChecked;
          widget.onCheck(isChecked);
        }),
      );
}
