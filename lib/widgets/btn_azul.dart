import 'package:flutter/material.dart';
class BotonAzul extends StatelessWidget {

  final String text;
  final Function onPressed;

  const BotonAzul({
    Key key, 
    @required this.text, 
    @required this.onPressed
    }) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
            elevation: 2,
            hoverElevation: 5,
            color: Colors.black,
            shape: StadiumBorder(),
            onPressed: this.onPressed,
            child: Container(
              width: double.infinity,
              height: 55,
              child: Center(
                child: Text(this.text, style: TextStyle(color: Colors.white,fontSize: 17)),
              ),
            ),
          );
  }
}