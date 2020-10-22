import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:movie_ticket_challenge/src/bloc/get_now_playing_bloc.dart';
import 'package:movie_ticket_challenge/src/model/data.dart';

import 'package:movie_ticket_challenge/src/model/data_response.dart';
import 'package:movie_ticket_challenge/src/style/theme.dart' as Style;
import 'package:movie_ticket_challenge/src/widgets/schedules.dart';
import 'package:movie_ticket_challenge/src/widgets/ticket_buy.dart';
import 'home_page.dart';

class TicketPage extends StatefulWidget {
  TicketPage({Key key}) : super(key: key);

  @override
  _TicketPageState createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MovieResponse>(
      stream: nowPlayingMoviesBloc.subject.stream,
      builder: (context, AsyncSnapshot<MovieResponse> snapshot){
        if(snapshot.hasData){
          if(snapshot.data.error != null && snapshot.data.error.length > 0){
            return _buildErrorWidget(snapshot.data.error);
          }
          return _buildTicketPage(snapshot.data);
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

  Widget _buildTicketPage(MovieResponse data){    
    List<Movie> movies = data.movies;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Style.Colors.mainColor,
      appBar: AppBar(
        title: Text(movies[6].title,
        style: TextStyle(
                  shadows: <Shadow>[
                    Shadow(
                      offset:Offset(5.0, 5.0),
                      blurRadius: 5.0,
                      color: Color.fromARGB(255, 0, 0, 0),
                    )
                  ],
                  color: Style.Colors.emphasisWhite,
                  fontSize: 16,
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
                )),)
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height:100),
          Container(
            margin: const EdgeInsets.only(left: 20,right: 20),
            height: 120,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(right: 20,left:20),
            decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Style.Colors.emphasisBlack,
            ),
            child: ScheduleWidget(),
          ),
          Container(
            height:300,
            width: MediaQuery.of(context).size.width,
            child: BuyTicketWidget(),
          ),
          
          
        ],
      ),
    );
  }

}