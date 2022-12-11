// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:puzzeled_up/Utils/Chameleon.dart';
import 'package:path_provider/path_provider.dart';
import 'package:puzzeled_up/Utils/Hive.dart';
import '../Utils/sqldatabase.dart';
import 'package:path/path.dart' as Path;

class myProfile extends StatefulWidget {
  const myProfile({super.key});

  @override
  State<myProfile> createState() => _myProfileState();
}

class _myProfileState extends State<myProfile> {
  final box = Hive.box('pfp');
  File? _image;
  final picker = ImagePicker();
  sqlDataBase sqldatabase = sqlDataBase();
  String xp = HiveLab().currentUser!.getXp().toString();

  Future _pickImage(ImageSource source) async {
    try {
      final XFile? image = await picker.pickImage(source: source);

      if (image == null) return;
      File imageFile = File(image.path);
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String appDocPath = appDocDir.path;
      final fileName = Path.basename(imageFile.path);
      final File localImage = await imageFile.copy('$appDocPath/$fileName');
      box.put("imagepath", image.path);
      box.put("exist", true);

      setState(() {
        _image = localImage;
      });
    } on PlatformException catch (e) {
      print(e);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
        backgroundColor: chameleon.color_hunt[0],
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        shadowColor: Colors.transparent,
      ),
      backgroundColor: chameleon.color_hunt[0],
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              renderprofile(),
              SizedBox(
                height: 160,
              ),
              boxPluspicture()
            ],
          ),
        ),
      ),
    );
  }

  Widget boxPluspicture() {
    return Column(
      children: [
        SizedBox(
          height: 70,
          width: 70,
          child: Image.asset('Assets/bionic.png'),
        ),
        renderboxoftext()
      ],
    );
  }

  Widget renderboxoftext() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: chameleon.color_hunt[1],
            borderRadius: BorderRadius.circular(10)),
        child: rendertext(),
      ),
    );
  }

  Widget rendertext() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        textmaker(
            "Tasks accomplished : ${xp}",
            Icon(
              Icons.add_task,
              color: chameleon.color_hunt[0],
            )),
        textmaker(
            "Time Spent: 1h 34m 11s",
            Icon(
              Icons.timelapse,
              color: chameleon.color_hunt[0],
            )),
        textmaker(
            "Abilities : 17 abilities",
            Icon(
              Icons.accessibility_outlined,
              color: chameleon.color_hunt[0],
            ))
      ],
    );
  }

  Widget textmaker(String txt, Icon ico) {
    return ListTile(
      textColor: chameleon.color_hunt[0],
      leading: ico,
      title: Text(txt),
    );
  }

  Widget renderprofile() {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            _pickImage(ImageSource.gallery);
          },
          child: Container(
              height: 100.0,
              width: 100.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.shade200,
              ),
              child: Center(
                child: box.get("exist") == null
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
                        backgroundImage: FileImage(File(box.get("imagepath"))),
                        radius: 200.0,
                      ),
              )),
        ),
        Container(
          alignment: Alignment.center,
          height: 30,
          width: 120,
          decoration: BoxDecoration(
              color: chameleon.color_hunt[4],
              borderRadius: BorderRadius.circular(10)),
          child: Text(
            "${HiveLab().currentUser!.getName()}",
            style: TextStyle(
                color: chameleon.color_hunt[0], fontWeight: FontWeight.w500),
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }
}
