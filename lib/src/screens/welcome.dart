import 'package:flutter/material.dart';
import 'package:ucar_app/src/screens/background.dart';
import 'package:ucar_app/src/theme/colors.dart';

class Welcome extends StatelessWidget {
  const Welcome({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  const Background(
        child: SingleChildScrollView(child: Text("Funciona",style: TextStyle(color: Colors.white),)),
        
    );
  }
}