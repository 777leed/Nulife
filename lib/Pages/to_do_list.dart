// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:puzzeled_up/Utils/Chameleon.dart';
import 'package:puzzeled_up/Utils/addstack.dart';
import 'package:puzzeled_up/Utils/sqldatabase.dart';

import '../Utils/myAppBar.dart';

class toDoList extends StatefulWidget {
  const toDoList({super.key});

  @override
  State<toDoList> createState() => _toDoListState();
}

class _toDoListState extends State<toDoList> {
  var taskprompt = TextEditingController();
  sqlDataBase sqldatabase = sqlDataBase();

  Future addtask(TextEditingController textController) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: chameleon.color_hunt[1],
              title: Text("Task Arsenal",
                  style:
                      TextStyle(fontFamily: 'MS Gothic', color: Colors.white)),
              content: TextField(
                cursorColor: chameleon.color_hunt[0],
                controller: textController,
                autofocus: true,
                decoration: InputDecoration(
                  focusColor: chameleon.color_hunt[0],
                  hintText: 'Add Your Task Here',
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      sqldatabase.addtask(textController);
                      textController.text = "";
                      Navigator.of(context).pop();
                      setState(() {});
                    },
                    child: Text("Add"))
              ],
            ));
  }

  Future deleteall() async {
    await sqldatabase.deleteData("DELETE from todolist");
  }

  Future deleteElement(String id) async {
    await sqldatabase.deleteData("DELETE FROM todolist WHERE id= '$id'");
  }

  Future deletedabase() async {
    await sqldatabase.deleteDb();
  }

  Future<List<Map>> readData() async {
    List<Map> response = await sqldatabase.readData("SELECT * FROM todolist");
    if (response.isEmpty) {}
    return response;
  }

  final List color_hunt = chameleon.color_hunt;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color_hunt[0],
      appBar: myAppBar(
        barTitle: "To-do List",
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    child: plusbutton(),
                    onTap: () {
                      addtask(taskprompt);
                    },
                  )
                ],
              ),
              SizedBox(
                height: 100,
              ),

              // there is something wrong with the if statemnet when I don't use it it does return data from snapshot, also there is a problem with list display fix it

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ListView(
                        children: [
                          FutureBuilder(
                              future: readData(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<List<Map>> snapshot) {
                                if (snapshot.hasData) {
                                  if (snapshot.data!.isNotEmpty) {
                                    return ListView.builder(
                                        itemCount: snapshot.data!.length,
                                        shrinkWrap: true,
                                        itemBuilder: ((context, index) {
                                          Text mytitle = Text(
                                            "${snapshot.data![index]['prompt']}",
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: 'MS Gothic',
                                                color: Colors.white),
                                          );
                                          return Card(
                                            color: color_hunt[0],
                                            shadowColor: Colors.transparent,
                                            clipBehavior: Clip.antiAlias,
                                            child: ListTile(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)),
                                              onLongPress: () {
                                                String id =
                                                    "${snapshot.data![index]['id']}";
                                                deleteElement(id);
                                                setState(() {});
                                              },
                                              leading: Icon(Icons.add_task),
                                              title: mytitle,
                                              // isThreeLine: true,
                                              dense: true,
                                              visualDensity:
                                                  VisualDensity(vertical: 3),
                                              tileColor: color_hunt[2],
                                            ),
                                          );
                                        }));
                                  }
                                }

                                return Center(
                                  child: Text(
                                    "NOTHING TO SEE HERE",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                );
                              })
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // GestureDetector(
              //   onTap: deleteall,
              //   child: Container(
              //     alignment: Alignment.center,
              //     decoration: BoxDecoration(
              //         color: color_hunt[3],
              //         borderRadius: BorderRadius.circular(25)),
              //     height: 50,
              //     child: Text("Delete ALL"),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
