import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:page_indicator/page_indicator.dart';


import 'package:movie_ticket_challenge/src/style/theme.dart' as Style;
import 'package:movie_ticket_challenge/src/bloc/get_now_playing_bloc.dart';
import 'package:movie_ticket_challenge/src/model/data.dart';
import 'package:movie_ticket_challenge/src/model/data_response.dart';

class NowPlaying extends StatefulWidget {
  NowPlaying({Key key}) : super(key: key);

  @override
  _NowPlayingState createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  double _position = 50;
  int _page = 1;

  @override
  void initState(){    
    super.initState();
    nowPlayingMoviesBloc..getMovies();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MovieResponse>(
      stream: nowPlayingMoviesBloc.subject.stream,
      builder: (context, AsyncSnapshot<MovieResponse> snapshot){
        if(snapshot.hasData){
          if(snapshot.data.error != null && snapshot.data.error.length > 0){
            return _buildErrorWidget(snapshot.data.error);
          }
          return _buildNowPlayingWidget(snapshot.data);
        } else if (snapshot.hasError){
          return _buildErrorWidget(snapshot.error);
        } else {
          return _buildLoadingWidget();
        }
      }
    );
  }
  
  Widget _buildNowPlayingWidget(MovieResponse data){
    List<Movie> movies = data.movies;
    if(movies.length == 0){
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text('Películas no disponibles')
          ],
        )
      );
    } else
    return Container(
      height: MediaQuery.of(context).size.height,
      child: PageIndicatorContainer(
        shape: IndicatorShape.circle(size: 6.0),
        child: PageView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: movies.take(5).length,
          itemBuilder: (context, index){
            return Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: <Widget>[Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border.all(),
                  image: DecorationImage(
                    alignment: Alignment.center,
                  fit: BoxFit.fitHeight,
                  colorFilter: ColorFilter.mode(Style.Colors.emphasisBlack.withOpacity(0.2), BlendMode.dstATop),
                  image:NetworkImage('https://image.tmdb.org/t/p/original/'+movies[index].backPoster))
                ),                
              ),
                Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.only(bottom:40),
                height: 300,
                width: 200,
                decoration: BoxDecoration(
                  boxShadow: [BoxShadow(
                          color: Style.Colors.emphasisBlack.withOpacity(0.4),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),],
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                    alignment: Alignment.center,
                    fit: BoxFit.fitHeight,                    
                    image:NetworkImage('https://image.tmdb.org/t/p/original/'+movies[index].backPoster)
                  )
                ),
              ),
              Positioned(
                top:250,
                width: 250,
                child: Container(
                  width: 250,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        movies[index].title,
                        style: TextStyle(
                          height: 1,
                          color: Style.Colors.emphasisWhite,
                          fontWeight: FontWeight.bold,
                          fontSize: 32.0, 
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 350,
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                     Container(
                       alignment: Alignment.center,
                       height: 200,
                       width: 150,                        
                        decoration: BoxDecoration(
                        boxShadow: [BoxShadow(
                          color: Style.Colors.emphasisBlack.withOpacity(0.4),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),],
                        color: Style.Colors.emphasisRed,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10),),
                        child:Text('BUY TICKET',style:TextStyle(
                          height: 1,
                          color: Style.Colors.emphasisWhite,
                          fontWeight: FontWeight.w600,
                          fontSize: 18.0, 
                        ),),
                     ) 
                    ],
                  ),
                ),
              )
              ],
            );
          },
        ),
        align: IndicatorAlign.bottom,
        indicatorSpace: 5.0,
        padding: EdgeInsets.only(bottom: 20),
        indicatorColor: Style.Colors.emphasisBlack,
        indicatorSelectorColor: Style.Colors.emphasisYellow,
        length: movies.take(5).length,
      ),
    );
  }
  
  Widget  _buildErrorWidget(String error){
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
              valueColor: AlwaysStoppedAnimation<Color>(Style.Colors.emphasisWhite),
              strokeWidth: 4.0,
            ),
          )
        ],
      ),
    );
  }
 
}