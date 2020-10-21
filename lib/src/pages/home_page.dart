import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import 'package:movie_ticket_challenge/src/style/theme.dart' as Style;
import 'package:movie_ticket_challenge/src/widgets/now_playing.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Style.Colors.mainColor,
      appBar: AppBar(
        elevation: 30,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: Icon(EvaIcons.menuOutline,color: Style.Colors.emphasisWhite),
        actions: <Widget>[
          IconButton(icon: Icon(EvaIcons.searchOutline, color: Style.Colors.emphasisWhite),onPressed: (){print('Search');})
        ],
      ),
      body: Stack(
        children: <Widget>[           
          NowPlaying(),
        ],
      ),
    );
  }
}