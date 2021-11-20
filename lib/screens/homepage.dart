// ignore_for_file: prefer_const_constructors

import 'package:daily_task/mydrawer.dart';
import 'package:daily_task/screens/addpage.dart';
import 'package:daily_task/screens/showpage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text(
          "Daily Task",
          style: GoogleFonts.pacifico(),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      drawer: MyDrawer(),
      body: TabBarView(
        children: const [
          ShowPage(),
          AddPage(),
        ],
        controller: _tabController,
      ),
      bottomNavigationBar: Material(
        color: Theme.of(context).primaryColor,
        child: TabBar(
          indicatorColor: Theme.of(context).backgroundColor,
          tabs: const [
            Tab(
              icon: Icon(Icons.show_chart),
            ),
            Tab(
              icon: Icon(Icons.add),
            )
          ],
          controller: _tabController,
        ),
      ),
    );
  }
}
