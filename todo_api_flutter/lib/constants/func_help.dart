import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'coloors.dart';

void showMessage(String message) {
  Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.redAccent,
      textColor: Colors.white,
      fontSize: 16.0);
}

void showLoadingDialog(BuildContext context, String message) async {
  return await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          Row(
            children: [
              const CircularProgressIndicator(
                color: Coloors.greenColors,
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                  child: Text(
                message,
                style:const TextStyle(
                    fontSize: 15, color: Coloors.greenColors, height: 1.5),
              ))
            ],
          )
        ]),
      );
    },
  );
}
bool vaildationAdd(String title, String description,DateTime dateTime) {
  if (title.isEmpty && description.isEmpty) {
    showMessage("title , description   not empty");
    return false;
  } else if (title.isEmpty) {
    showMessage("title is Empty");
    return false;
  } else if (description.isEmpty) {
    showMessage("description is Empty");
    return false;
  } 
  
  else {
    return true;
  }
}