import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:movie_ticket_challenge/src/bloc/get_now_playing_bloc.dart';

import 'package:movie_ticket_challenge/src/model/data_response.dart';
import 'package:movie_ticket_challenge/src/style/theme.dart' as Style;
import 'home_page.dart';

class TicketPage6 extends StatefulWidget {
  TicketPage6({Key key}) : super(key: key);

  @override
  _TicketPage6State createState() => _TicketPage6State();
}

class _TicketPage6State extends State<TicketPage6> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MovieResponse>(
      stream: nowPlayingMoviesBloc.subject.stream,
      builder: (context, AsyncSnapshot<MovieResponse> snapshot){
        if(snapshot.hasData){
          if(snapshot.data.error != null && snapshot.data.error.length > 0){
            return _buildErrorWidget(snapshot.data.error);
          }
          return _buildTicketPage6(snapshot.data);
        } else if (snapshot.hasError){
          return _buildErrorWidget(snapshot.error);
        } else {
          return _buildLoadingWidget();
        }
      }
    );
  }
  Widget _buildErrorWidget(String error){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Error identificado: $error')
        ],
      ),
    );
  }
  
  Widget _buildLoadingWidget(){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 25.0,
            width: 25.0,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Style.Colors.emphasisYellow),
              strokeWidth: 4.0,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTicketPage6(MovieResponse data){
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Style.Colors.mainColor,
      appBar: AppBar(
        title: Text('6'),
        automaticallyImplyLeading: true,
        elevation: 30,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));},
          child: Icon(EvaIcons.arrowIosBack,color: Style.Colors.emphasisWhite),),
        
      ),
    );
  }
}