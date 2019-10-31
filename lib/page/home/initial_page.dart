

import 'package:flutter/material.dart';

import '../../drawer_list.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _debugLabelString = "";
  String _emailAddress;
  String _externalUserId;
  bool _enableConsentButton = false;

  // CHANGE THIS parameter to true if you want to test GDPR privacy consent
  bool _requireConsent = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
      ),
      body: _body(),
      drawer: DrawerList(),
    );
  }

  _body() {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: new Table(
          children: [
            new TableRow(
              children: [
                Text("Bem - vindo")
              ]
            )
    ])));
  }
}