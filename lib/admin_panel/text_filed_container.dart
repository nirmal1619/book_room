import 'package:flutter/material.dart';
class ContainerTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final IconData iconData;

  const ContainerTextField({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.iconData,
  }) : super(key: key);

  @override
  State<ContainerTextField> createState() => _ContainerTextFieldState();
}

class _ContainerTextFieldState extends State<ContainerTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        shape: BoxShape.rectangle,
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 0),
        child: TextField(
          keyboardType: widget.hintText!="Room Description" ? TextInputType.number :  TextInputType.text,
          controller: widget.controller,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: const TextStyle(color: Colors.black),
            border: InputBorder.none,
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 6, top: 0),
              child: Icon(
                widget.iconData,
                color: Colors.grey.shade700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
