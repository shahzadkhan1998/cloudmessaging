import 'package:flutter/material.dart';
class One extends StatefulWidget {
  const One({ Key? key }) : super(key: key);

  @override
  _OneState createState() => _OneState();
}

class _OneState extends State<One> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.green,
      
    );
  }
}