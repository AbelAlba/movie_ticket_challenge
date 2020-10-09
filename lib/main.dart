import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:movie_ticket_challenge/src/pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Ticket Challenge',
      theme: ThemeData(fontFamily: 'NotoSansJP'),
      localizationsDelegates: [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
 ],
      supportedLocales: [
          const Locale('en',''),
          const Locale('es','ES')
      ],
      debugShowCheckedModeBanner: false,
      initialRoute:'home',
      routes: getApplicationRoutes(),
    );
  }
  
  Map<String, WidgetBuilder> getApplicationRoutes(){
    return <String,WidgetBuilder> {
          'home'       : ( BuildContext context ) => HomePage(),
  };
}
}
