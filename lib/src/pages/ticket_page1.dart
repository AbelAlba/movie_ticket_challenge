import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:movie_ticket_challenge/src/bloc/get_now_playing_bloc.dart';
import 'package:movie_ticket_challenge/src/model/data.dart';

import 'package:movie_ticket_challenge/src/model/data_response.dart';
import 'package:movie_ticket_challenge/src/style/theme.dart' as Style;
import 'package:movie_ticket_challenge/src/widgets/ticket_buy.dart';
import 'home_page.dart';

class TicketPage1 extends StatefulWidget {
  TicketPage1({Key key}) : super(key: key);

  @override
  _TicketPage1State createState() => _TicketPage1State();
}

class _TicketPage1State extends State<TicketPage1> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MovieResponse>(
      stream: nowPlayingMoviesBloc.subject.stream,
      builder: (context, AsyncSnapshot<MovieResponse> snapshot){
        if(snapshot.hasData){
          if(snapshot.data.error != null && snapshot.data.error.length > 0){
            return _buildErrorWidget(snapshot.data.error);
          }
          return _buildTicketPage1(snapshot.data);
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

  Widget _buildTicketPage1(MovieResponse data){   
    List<Movie> movies = data.movies;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Style.Colors.mainColor,
      appBar: AppBar(
        title: Text(movies[7].title,
        style: TextStyle(
                  shadows: <Shadow>[
                    Shadow(
                      offset:Offset(5.0, 5.0),
                      blurRadius: 5.0,
                      color: Color.fromARGB(255, 0, 0, 0),
                    )
                  ],
                  color: Style.Colors.emphasisWhite,
                  fontSize: 12,
              )),
        automaticallyImplyLeading: true,
        elevation: 30,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {Navigator.pop(context, MaterialPageRoute(builder: (context) => HomePage()));},
          child: new Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 1, color: Style.Colors.emphasisWhite)),
                  child: Icon(EvaIcons.arrowIosBack,color: Style.Colors.emphasisWhite)
                )),
          ),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height:MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: BuyTicketWidget(),
          ),
        ],
      ),
    );
  }
}