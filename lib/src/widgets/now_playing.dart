import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:movie_ticket_challenge/src/style/theme.dart' as Style;
import 'package:movie_ticket_challenge/src/bloc/get_now_playing_bloc.dart';
import 'package:movie_ticket_challenge/src/model/data.dart';
import 'package:movie_ticket_challenge/src/model/data_response.dart';
import 'package:movie_ticket_challenge/src/pages/ticket_page0.dart';
import 'package:movie_ticket_challenge/src/pages/ticket_page1.dart';
import 'package:movie_ticket_challenge/src/pages/ticket_page2.dart';
import 'package:movie_ticket_challenge/src/pages/ticket_page3.dart';
import 'package:movie_ticket_challenge/src/pages/ticket_page4.dart';
import 'package:movie_ticket_challenge/src/pages/ticket_page5.dart';
import 'package:movie_ticket_challenge/src/pages/ticket_page6.dart';
import 'package:movie_ticket_challenge/src/pages/ticket_page7.dart';
import 'package:page_indicator/page_indicator.dart';

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
                    image:NetworkImage('https://image.tmdb.org/t/p/original/'+movies[_index+6].backPoster)
                  )
                ),
              ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:[
                Container(
              padding: EdgeInsets.only(top: 140),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Text(movies[_index+6].title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  shadows: <Shadow>[
                    Shadow(
                      offset:Offset(5.0, 5.0),
                      blurRadius: 5.0,
                      color: Color.fromARGB(255, 0, 0, 0),
                    )
                  ],
                  color: Style.Colors.emphasisWhite,
                  fontSize: 35,
              )),
            ),]
            ),
            ]
        ),
        Stack(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
              Container(
              child: Center(
                child:Text(movies[_index].title,style: TextStyle(fontSize: 12,color: Colors.white))
              ),
              alignment: Alignment.center,
              height: 45,
              width: MediaQuery.of(context).size.width/2,
              margin: EdgeInsets.only(left:10,right:10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),color: Style.Colors.mainColor.withOpacity(1),
                boxShadow: [BoxShadow(
                color: Style.Colors.emphasisBlack.withOpacity(0.8),
                spreadRadius: 5,
                blurRadius: 30,
                offset: Offset(0, 3), // changes position of shadow
                ),
              ],),
            ),
            Container(
              child: Center(
                child:Text(movies[_index].popularity.toString(),style: TextStyle(fontSize: 12,color: Colors.white))
              ),
              alignment: Alignment.center,
              height: 45,
              width: MediaQuery.of(context).size.width/7,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),color: Style.Colors.mainColor.withOpacity(1),
                
                boxShadow: [BoxShadow(
                color: Style.Colors.emphasisBlack.withOpacity(0.8),
                spreadRadius: 5,
                blurRadius: 30,
                offset: Offset(0, 3), // changes position of shadow
                ),
              ],),
            ),
            FlatButton(onPressed: (){},
              child: Container(
              child: Center(
                child:Text('5.0',style: TextStyle(fontWeight: FontWeight.w900,fontSize: 12,color: Colors.black))
              ),
              alignment: Alignment.center,
              height: 45,
              width: MediaQuery.of(context).size.width/5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),color: Style.Colors.emphasisYellow.withOpacity(1),
                boxShadow: [BoxShadow(
                color: Style.Colors.emphasisBlack.withOpacity(0.8),
                spreadRadius: 5,
                blurRadius: 30,
                offset: Offset(0, 3), // changes position of shadow
                ),
              ],),
            ),
          )
            ]
            ),            
            SizedBox(height: 20),
            Container(
              child: Center(
                child:Text(
                  'First parameter ∙ Second Parameter ∙ Third Paramater',
                  style: TextStyle(fontSize: 12,color: Colors.white))
              ),
              alignment: Alignment.center,
              height: 45,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(left:10,right:10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),color: Style.Colors.mainColor.withOpacity(0.4),
                boxShadow: [BoxShadow(
                color: Style.Colors.emphasisBlack.withOpacity(0.7),
                spreadRadius: 5,
                blurRadius: 30,
                offset: Offset(0, 3), // changes position of shadow
                ),
              ],),
            ),
            SizedBox(height: 15),
            Container(width: 300,
              child:Divider(color:Style.Colors.emphasisRed.withOpacity(0.6),thickness: 0.8, height: 10,)),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [FlatButton(onPressed: (){
                _buildTicketPage();
              },
              child: Container(
              child: Center(
                child:Text('BUY TICKET',style: TextStyle(fontSize: 12,color: Colors.white))
              ),
              alignment: Alignment.center,
              height: 45,
              width: 120,
              margin: EdgeInsets.only(bottom:50),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),color: Colors.red.withOpacity(0.6),
                boxShadow: [BoxShadow(
                color: Style.Colors.emphasisBlack.withOpacity(0.8),
                spreadRadius: 10,
                blurRadius: 30,
                offset: Offset(0, 3), // changes position of shadow
                ),
              ],),
            ),
          )
              ],
            )
        ],
        ),
      ],
    ),
        Positioned(
          bottom: 20,
          height: MediaQuery.of(context).size.height/2.6,
          width: MediaQuery.of(context).size.width,
          child: PageIndicatorContainer(
            align: IndicatorAlign.bottom,
            indicatorSpace: 5.0,
            padding: EdgeInsets.only(bottom: 20),
            indicatorColor: Style.Colors.emphasisBlack,
            indicatorSelectorColor: Style.Colors.emphasisYellow,
            length: movies.take(8).length,
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
                        image:NetworkImage('https://image.tmdb.org/t/p/original/'+movies[index+6].backPoster)
                      )
                    ),
                  ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
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


   _buildTicketPage(){
     if (_index == 0){
       Navigator.push(context, MaterialPageRoute(builder: (context) => TicketPage()));
     } else if (_index == 1){
       Navigator.push(context, MaterialPageRoute(builder: (context) => TicketPage1()));
     } else if (_index == 2){
       Navigator.push(context, MaterialPageRoute(builder: (context) => TicketPage2()));
     } else if (_index == 3){
       Navigator.push(context, MaterialPageRoute(builder: (context) => TicketPage3()));
     } else if (_index == 4){
       Navigator.push(context, MaterialPageRoute(builder: (context) => TicketPage4()));
     } else if (_index == 5){
       Navigator.push(context, MaterialPageRoute(builder: (context) => TicketPage5()));
     } else if (_index == 6){
       Navigator.push(context, MaterialPageRoute(builder: (context) => TicketPage6()));
     } else if (_index == 7){
       Navigator.push(context, MaterialPageRoute(builder: (context) => TicketPage7()));
     }
   }
}