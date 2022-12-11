// using your method of getting an image
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:puzzeled_up/Utils/Chameleon.dart';

class Imagepicker extends StatefulWidget {
  const Imagepicker({super.key});

  @override
  State<Imagepicker> createState() => _ImagepickerState();
}

class _ImagepickerState extends State<Imagepicker> {
  File? _image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  _pickImage(ImageSource.camera);
                },
                child: Container(
                    height: 200.0,
                    width: 200.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.shade200,
                    ),
                    child: Center(
                      child: _image == null
                          ? Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      color: chameleon.color_hunt[1],
                                      borderRadius: BorderRadius.circular(100)),
                                ),
                                SizedBox(
                                  height: 70,
                                  width: 70,
                                  child: Image.asset('Assets/man.png'),
                                )
                              ],
                            )
                          : CircleAvatar(
                              backgroundImage: FileImage(_image!),
                              radius: 200.0,
                            ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().getImage(source: source);
      if (image == null) return;
      File? img = File(image.path);
      setState(() {
        _image = img;
        Navigator.of(context).pop();
      });
    } on PlatformException catch (e) {
      print(e);
      Navigator.of(context).pop();
    }
  }
}
