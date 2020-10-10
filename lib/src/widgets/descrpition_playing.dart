import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_ticket_challenge/src/model/data.dart';

import 'package:movie_ticket_challenge/src/style/theme.dart' as Style;
import 'package:movie_ticket_challenge/src/model/data_response.dart';
import 'package:movie_ticket_challenge/src/bloc/get_now_playing_bloc.dart';

class ShowDescription extends StatefulWidget {
  ShowDescription({Key key}) : super(key: key);

  @override
  _ShowDescriptionState createState() => _ShowDescriptionState();
}

class _ShowDescriptionState extends State<ShowDescription> {
  @override
  Widget build(BuildContext context) {return StreamBuilder<MovieResponse>(
      stream: nowPlayingMoviesBloc.subject.stream,
      builder: (context, AsyncSnapshot<MovieResponse> snapshot){
        if(snapshot.hasData){
          if(snapshot.data.error != null && snapshot.data.error.length > 0){
            return _buildErrorWidget(snapshot.data.error);
          }
          return _buildDescription(snapshot.data);
        } else if (snapshot.hasError){
          return _buildErrorWidget(snapshot.error);
        } else {
          return _buildLoadingWidget();
        }
      }
    );
  }
  
  Widget _buildDescription(MovieResponse data){
    List<Movie> movies = data.movies;
    return Stack(
      children: <Widget>[
        Container(
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
                    image:NetworkImage('https://image.tmdb.org/t/p/original/'+movies[10].backPoster)
                  )
                ),
              ),
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
                child:Text('Popular with friends',style: TextStyle(fontSize: 12,color: Colors.white))
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
                child:Text('15+',style: TextStyle(fontSize: 12,color: Colors.white))
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
              child:Divider(color:Style.Colors.emphasisRed.withOpacity(0.4),thickness: 0.8, height: 10,)),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [FlatButton(onPressed: (){},
              child: Container(
              child: Center(
                child:Text('BUY TICKET',style: TextStyle(fontSize: 12,color: Colors.white))
              ),
              alignment: Alignment.center,
              height: 45,
              width: 120,
              margin: EdgeInsets.only(bottom:50),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),color: Style.Colors.emphasisRed.withOpacity(0.9),
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