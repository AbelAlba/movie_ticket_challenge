import 'package:flutter/material.dart';

import 'package:movie_ticket_challenge/src/style/theme.dart' as Style;

class ScheduleWidget extends StatefulWidget {
  ScheduleWidget({Key key}) : super(key: key);

  @override
  _ScheduleWidgetState createState() => _ScheduleWidgetState();
}

class _ScheduleWidgetState extends State<ScheduleWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(top:10,bottom:10),
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
       children: <Widget>[
         _available(),
         _available(),
         _available(),
         _selected(),
         _available(),
         _available(),
         _available(),
         _available(),
         _available(),
         _available(),
         _available(),
         _available(),
         _available(),
         _available(),
         _available(),
       ],
    );
  }
  _available(){
    return Container(
      padding: EdgeInsets.only(top:10,bottom: 10),
           decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Style.Colors.emphasisBlack,
           ),
           height: 200,
           width: 60,
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
             Text('9',style: TextStyle(
               fontSize: 20,
               fontWeight: FontWeight.w900,
               color: Style.Colors.emphasisWhite
             )),
             Text('TH',style: TextStyle(
               color: Style.Colors.emphasisWhite.withOpacity(0.4),
               fontWeight: FontWeight.w100,
               fontSize: 16
             ))
           ],)
         );
  }

  _selected(){
    return Container(
      padding: EdgeInsets.only(top:10,bottom: 10),
           decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Style.Colors.emphasisYellow,
           ),
           height: 200,
           width: 60,
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
             Text('9',style: TextStyle(
               fontSize: 20,
               fontWeight: FontWeight.w900,
               color: Style.Colors.emphasisBlack
             )),
             Text('TH',style: TextStyle(
               color: Style.Colors.emphasisBlack,
               fontWeight: FontWeight.w100,
               fontSize: 16
             ))
           ],)
         );
  }
}