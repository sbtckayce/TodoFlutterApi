import 'package:flutter/material.dart';
import 'package:todo_api/constants/coloors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key, required this.hintText, required this.title, required this.controller, this.readOnly, this.icon});
  final String hintText;
  final String title;
  final TextEditingController controller;
  final bool? readOnly;
  final Widget? icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          TextFormField(
            controller: controller,
            readOnly: readOnly ?? false,
            decoration: InputDecoration(hintText: hintText,
            hintStyle: Theme.of(context).textTheme.titleSmall,
            suffixIcon: icon,
            enabledBorder:const UnderlineInputBorder(borderSide: BorderSide(color: Coloors.greenColors),
            ),focusedBorder:const UnderlineInputBorder(borderSide: BorderSide(color: Coloors.pinkColors),
            )),
           
          ),
        ],
      ),
    );
  }
}
