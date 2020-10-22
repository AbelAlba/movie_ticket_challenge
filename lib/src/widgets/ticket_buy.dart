import 'package:flutter/material.dart';

import 'package:movie_ticket_challenge/src/style/theme.dart' as Style;

class BuyTicketWidget extends StatefulWidget {
  BuyTicketWidget({Key key}) : super(key: key);

  @override
  _BuyTicketWidgetState createState() => _BuyTicketWidgetState();
}

class _BuyTicketWidgetState extends State<BuyTicketWidget> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
            primary: false,
            padding: const EdgeInsets.only(top:10,left: 50,right:50),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 9,
            children: <Widget>[
              SizedBox(height:20),
              _createAvailableSit(),
              _createAvailableSit(),
              _createAvailableSit(),
              SizedBox(height:20),
              SizedBox(height:20),
              _createAvailableSit(),
              _createAvailableSit(),
              SizedBox(height:20),
              _createAvailableSit(),
              _createAvailableSit(),
              _createAvailableSit(),
              _createAvailableSit(),
              SizedBox(height:20),
              SizedBox(height:20),
              _createSelectedSit(),
              _createAvailableSit(),
              _createAvailableSit(),
              _createAvailableSit(),
              _createAvailableSit(),
              _createAvailableSit(),
              _createAvailableSit(),
              SizedBox(height:20),
              SizedBox(height:20),
              _createAvailableSit(),
              _createSelectedSit(),
              _createSelectedSit(),
              _createAvailableSit(),
              _createUnavailableSit(),
              _createUnavailableSit(),
              _createUnavailableSit(),
              SizedBox(height:20),
              SizedBox(height:20),
              _createAvailableSit(),
              _createAvailableSit(),
              _createAvailableSit(),
              _createAvailableSit(),
              _createAvailableSit(),
              _createAvailableSit(),
              _createAvailableSit(),
              SizedBox(height:20),
              SizedBox(height:20),
              _createAvailableSit(),
              _createAvailableSit(),
              _createAvailableSit(),
              _createAvailableSit(),
              _createAvailableSit(),
              _createAvailableSit(),
              _createAvailableSit(),
              SizedBox(height:20),
              SizedBox(height:20),
              _createAvailableSit(),
              _createAvailableSit(),
              _createAvailableSit(),
              SizedBox(height:20),
              _createAvailableSit(),
              _createAvailableSit(),
              _createAvailableSit(),
              SizedBox(height:20),
              SizedBox(height:20),
              _createAvailableSit(),
              _createAvailableSit(),
              SizedBox(height:20),
            ],
          );
  }

  _createAvailableSit(){
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: Style.Colors.emphasisWhite,width: 1,),
          top:  BorderSide(color: Style.Colors.emphasisWhite,width: 1,),
          bottom: BorderSide(color: Style.Colors.emphasisWhite,width: 1,), 
          right: BorderSide(color: Style.Colors.emphasisWhite,width: 1,), 
        ),
        borderRadius: BorderRadius.circular(3),
        color: Style.Colors.mainColor,
        
      ),
    );
  }

  _createSelectedSit(){
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: Style.Colors.emphasisWhite,width: 1,),
          top:  BorderSide(color: Style.Colors.emphasisWhite,width: 1,),
          bottom: BorderSide(color: Style.Colors.emphasisWhite,width: 1,), 
          right: BorderSide(color: Style.Colors.emphasisWhite,width: 1,), 
        ),
        borderRadius: BorderRadius.circular(3),
        color: Style.Colors.emphasisWhite,
        
      ),
    );
  }

  _createUnavailableSit(){
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color: Style.Colors.emphasisYellow
      ),
    );
  }
}