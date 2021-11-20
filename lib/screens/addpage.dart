// ignore_for_file: prefer_const_constructors

import 'package:daily_task/db_helper.dart';
import 'package:daily_task/model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> with SingleTickerProviderStateMixin {
  Dbhelper? db;
  final _formkey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _des = TextEditingController();
  final _hours = TextEditingController();

  var s = "study";
  DateTime selecteddate = DateTime(2021);
  @override
  void initState() {
    super.initState();
    db = Dbhelper.instance;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                TextFormField(
                  controller: _title,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "please enter something";
                    }
                  },
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    enabled: true,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 3.0,
                      ),
                    ),
                    labelText: "what do you want to do?",
                    labelStyle: GoogleFonts.aclonica(
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  controller: _des,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "please enter something";
                    }
                  },
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    enabled: true,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 3.0,
                      ),
                    ),
                    labelText: "Write your decripation",
                    labelStyle: GoogleFonts.aclonica(
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 7,
                      // ignore: avoid_unnecessary_containers
                      child: Container(
                        child: TextFormField(
                          controller: _hours,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "please enter something";
                            }
                          },
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            enabled: true,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 3.0,
                              ),
                            ),
                            labelText: "amount of hours",
                            labelStyle: GoogleFonts.aclonica(
                              color: Colors.white,
                            ),
                            icon: Icon(
                              Icons.timer,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: DropdownButton(
                          value: s,
                          iconSize: 24,
                          iconEnabledColor: Colors.white,
                          // elevation: 16,
                          dropdownColor: Theme.of(context).backgroundColor,
                          style: GoogleFonts.pacifico(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),

                          onChanged: (String? value) {
                            setState(() {
                              s = value!;
                            });
                          },
                          items: const [
                            DropdownMenuItem(
                              child: Text("study"),
                              value: "study",
                            ),
                            DropdownMenuItem(
                              child: Text("play"),
                              value: "play",
                            ),
                            DropdownMenuItem(
                              child: Text("others"),
                              value: "others",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          await showDatePicker(
                            context: context,
                            initialDate: selecteddate,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2025),
                          ).then((value) {
                            setState(() {
                              selecteddate = value!;
                            });
                          });
                        },
                        child: Text(
                          "${selecteddate.year}",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Theme.of(context).primaryColor),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Image.asset("assets/back.png"),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.greenAccent,
        child: const Icon(Icons.done),
        onPressed: () {
          if (_formkey.currentState!.validate()) {
            db!.insertdata(
              Mytodo(
                  title: _title.text,
                  des: _des.text,
                  cat: s,
                  hours: int.parse(_hours.text),
                  d: selecteddate),
            );
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "done !",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
