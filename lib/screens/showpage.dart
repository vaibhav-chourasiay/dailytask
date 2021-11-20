// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:daily_task/db_helper.dart';
import 'package:daily_task/model.dart';
import 'package:daily_task/utilties/mytheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowPage extends StatefulWidget {
  const ShowPage({Key? key}) : super(key: key);

  @override
  _ShowPageState createState() => _ShowPageState();
}

class _ShowPageState extends State<ShowPage>
    with SingleTickerProviderStateMixin {
  Animation? animation;
  AnimationController? animationController;
  List i = List.generate(10, (index) => "$index");
  List? l;
  Dbhelper? db;
  @override
  void initState() {
    super.initState();
    db = Dbhelper.instance;
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    animation = Tween(begin: 1.0, end: 20.0).animate(animationController!);
    animationController!.addListener(() {
      setState(() {});
    });
    animationController!.forward();
  }

  Widget userdata() {
    return FutureBuilder(
      builder: (context, AsyncSnapshot projectSnap) {
        if (!projectSnap.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        // print(sdata);
        else {
          var sdata = projectSnap.data;

          return Align(
            alignment: Alignment.topCenter,
            child: ListView.builder(
              reverse: true,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        backgroundColor: Theme.of(context).backgroundColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                          ),
                        ),
                        builder: (context) {
                          return Container(
                            height: 300.0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Your Description",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          "${sdata[index]["des"]}",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.lato(
                                            color: Colors.white,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                        Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    child: Icon(Icons.done))
                              ],
                            ),
                          );
                        });
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation:
                        (animation!.value != null) ? animation!.value : 0.0,
                    color: MyColors.backgroundc,
                    child: ListTile(
                      leading: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.av_timer,
                            color: Theme.of(context).primaryColor,
                          ),
                          Text(
                            "${sdata[index]["hours"]}",
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      title: Text(
                        "Title ${sdata[index]["title"]}  ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: (animation!.value != null)
                              ? animation!.value
                              : 0.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            "${sdata[index]["d"]}".substring(0, 11),
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      trailing: GestureDetector(
                        onTap: () {
                          db!.deletevalue(sdata[index]["id"]);
                          setState(() {});
                        },
                        child: Icon(
                          Icons.delete,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                );
              },
              itemCount: projectSnap.data.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
            ),
          );
        }
      },
      future: db!.retrive(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            userdata(),
          ],
        ),
      ),
    );
  }
}
