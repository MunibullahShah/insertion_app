import 'package:flutter/material.dart';

class ParcelsScreen extends StatefulWidget {
  const ParcelsScreen({Key? key}) : super(key: key);

  @override
  State<ParcelsScreen> createState() => _ParcelsScreenState();
}

class _ParcelsScreenState extends State<ParcelsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Parcels"),
      ),
      body: Container(),
    ));
  }
}
