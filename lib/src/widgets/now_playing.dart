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
        child: PageView.builder(
          onPageChanged: (int page){
            setState((){
              _position = -300;
              Future.delayed(const Duration(milliseconds : 500), () {

// Here you can write your code

  setState(() {_position = 50;
    // Here you can write your code for open new view
  });

});
            });
          },
          scrollDirection: Axis.horizontal,
          itemCount: movies.take(6).length,
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
              ),Container(
                clipBehavior: Clip.none,
                alignment: Alignment.bottomLeft,
                margin: EdgeInsets.only(bottom: 43,left: 300),
                height: 250,
                width: 166,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                    alignment: Alignment.center,
                    fit: BoxFit.fitHeight,
                    colorFilter: ColorFilter.mode(Style.Colors.emphasisBlack.withOpacity(0.4), BlendMode.dstATop),                    
                    image:NetworkImage('https://image.tmdb.org/t/p/original/'+movies[index+1].backPoster)
                  )
                ),
              ),
                Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.only(bottom:50),
                height: 300,
                width: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                    alignment: Alignment.center,
                    fit: BoxFit.fitHeight,                    
                    image:NetworkImage('https://image.tmdb.org/t/p/original/'+movies[index].backPoster)
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
        length: movies.take(6).length,
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