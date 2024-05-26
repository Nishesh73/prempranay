import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

//for appbar title
Text myText(String text) {
  return Text(
    text,
    style: TextStyle(
        fontWeight: FontWeight.bold, fontSize: 20, color: Colors.purple),
  );
}

//for reg/login icon
Icon myIcon(IconData iconData) {
  return Icon(
    iconData,
    size: 45,
  );
}

//for textfield
myTextField(bool textSecure, String hinttext,
    TextEditingController textEditingController) {
  return Flexible(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
        child: TextField(
          obscureText: textSecure,
          controller: textEditingController,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hinttext,
            filled: true,
            fillColor: Colors.grey[300],
          ),
        ),
      ),
    ),
  );
}

//for login/singin button, reusable widget
myButton(String text, Function call) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
      height: 45,
      width: double.maxFinite,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              )),
          onPressed: () {
            call();
          },
          child: Text(
            text,
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
    ),
  );
}

//for small textbutton below signup or signin buttomn
myTextButton(String firstText, String secondText, Function tap) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(firstText),
        InkWell(
            onTap: () {
              tap();
            },
            child: Text(
              secondText,
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            )),
      ],
    ),
  );
}
//dialogbox

showDialogBox(
    BuildContext context, bool isBariierDismiss, String message) async {
  showDialog(
      barrierDismissible: isBariierDismiss,
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          content: Text(message),
        );
      });
}
//dialog for camera gallery option

showDialogBoxGalCamOpt(BuildContext context, String message,
    VoidCallback cameraCallback, VoidCallback galleryCallBack) async {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          title: Text(message),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {
                  galleryCallBack();
                },
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.file_copy),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Gallery"),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  cameraCallback();
                  //for camera
                  // pickImageFromCamera(imagePicker, context);
                },
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.camera),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Camera"),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.cancel),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Cancel"),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      });
}

//pick from camera
