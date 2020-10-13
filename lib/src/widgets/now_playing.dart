import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:movie_ticket_challenge/src/widgets/descrpition_playing.dart';
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

  int _index = 0;
  PageController pageController;
  double viewPortFraction = 0.6;
  double pageOffset = 0;

  @override
  void initState(){    
    super.initState();
    pageController = PageController(initialPage: 0,viewportFraction: viewPortFraction)
    ..addListener(() { 
      setState((){
        pageOffset = pageController.page;
      });
    });
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
          return _buildAnimatedPage(snapshot.data);
        } else if (snapshot.hasError){
          return _buildErrorWidget(snapshot.error);
        } else {
          return _buildLoadingWidget();
        }
      }
    );
  }
  
  Widget _buildAnimatedPage(MovieResponse data){
    List<Movie> movies = data.movies;
    if(movies.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text('Películas no disponibles')
          ],
        )
      );
    } else return Stack(      
      children: [
        AnimatedContainer(
                duration: Duration(milliseconds: 300),
                alignment: Alignment.bottomCenter,
                height:MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  boxShadow: [BoxShadow(
                          color: Style.Colors.emphasisBlack.withOpacity(0.4),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 5), // changes position of shadow
                        ),],
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                    alignment: Alignment.center,
                    fit: BoxFit.fitHeight,
                    image:NetworkImage('https://image.tmdb.org/t/p/original/'+movies[_index+10].backPoster)
                  )
                ),
              ),
        ShowDescription(),
        Container(
          width: MediaQuery.of(context).size.width,
          child: PageIndicatorContainer(
            shape: IndicatorShape.circle(size: 6.0),
            child: PageView.builder(     
              onPageChanged: (int index){
                setState((){
                  print("Current Page: " + index.toString());
                  _index = index;
                  int previousPage = index;
                  if(index != 0) previousPage--;
                  else previousPage = 2;
                  print("Previous page: $previousPage");
                });
              },
              controller: pageController,
              scrollDirection: Axis.horizontal,
              itemCount: movies.take(8).length,
              itemBuilder: (context, index){
                double scale = max(viewPortFraction,(1 - (pageOffset - index).abs()) + viewPortFraction );
                
                return Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: <Widget>[
                      AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.linear,
                    alignment: Alignment.bottomCenter,
                    margin: EdgeInsets.only(bottom: 0+scale*35),
                    height: 300,
                    width: 190,
                    decoration: BoxDecoration(
                      boxShadow: [BoxShadow(
                              color: Style.Colors.emphasisBlack.withOpacity(0.4),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 5), // changes position of shadow
                            ),],
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(30),
                      image: DecorationImage(
                        alignment: Alignment.center,
                        fit: BoxFit.fitHeight,                    
                        image:NetworkImage('https://image.tmdb.org/t/p/original/'+movies[index+10].backPoster)
                      )
                    ),
                  ),
                  ],
                );
              },
            ),
            align: IndicatorAlign.bottom,
            indicatorSpace: 5.0,
            padding: EdgeInsets.only(bottom: 20),
            indicatorColor: Style.Colors.emphasisBlack,
            indicatorSelectorColor: Style.Colors.emphasisYellow,
            length: movies.take(8).length,
          ),
          
        ),
      ],
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
              valueColor: AlwaysStoppedAnimation<Color>(Style.Colors.emphasisYellow),
              strokeWidth: 4.0,
            ),
          )
        ],
      ),
    );
  }
}