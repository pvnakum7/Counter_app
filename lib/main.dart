import 'dart:async';

import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print("Event--> $event");
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }
}


void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(
    MultiBlocProvider(

      providers: [
        BlocProvider<CounterBloc>(
          builder: (context) => CounterBloc(),
        ),

//        BlocProvider<ThemeBloc>(
//          builder: (context) => ThemeBloc(),
//        ),
      ],
      child:
      MyApp(),
    ),
  );
}





class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    return BlocBuilder(
//      bloc: BlocProvider.of<ThemeBloc>(context),
//      builder: (_, ThemeData theme) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: CounterPage(),
//          theme: theme,
    );
//      },
//    );
  }
}

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CounterBloc counterBloc = BlocProvider.of<CounterBloc>(context);
//    final ThemeBloc themeBloc = BlocProvider.of<ThemeBloc>(context);

    return Scaffold(
        appBar: AppBar(title: Text('Counter')),
        body: BlocBuilder<CounterEvent, int>(
          bloc: counterBloc,
          builder: (BuildContext context, int count) {
            return Container(
              alignment: Alignment.topRight,
              padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 30.0, 10.0),
              decoration: new BoxDecoration(
                  border: new Border.all(color: Colors.orangeAccent)
              ),
              child: Text(
                '$count',textAlign: TextAlign.center,


                style: TextStyle(fontSize: 50.0, color: Colors.redAccent),
              ),
            );
          },
        ),
        floatingActionButton: Container(
          margin: const EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 10.0),
//          EdgeInsets.symmetric(vertical: 11.0,horizontal: 11.0),
          padding:  EdgeInsetsDirectional.fromSTEB(2.0, 2.0, 1.0, 2.0),

          decoration: new BoxDecoration(
              border: new Border.all(color: Colors.blueAccent)
          ),
          child:  Row(

            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,

            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 11.0),
                child: FloatingActionButton(
                  backgroundColor: Colors.green,
                  child: Icon(Icons.add),
                  onPressed: () {
                    counterBloc.dispatch(CounterEvent.increment);
                  },
                ),
              ),
              Padding(
                padding:
//            EdgeInsetsDirectional.fromSTEB(2.0, 2.0, 1.0, 3.0),
                EdgeInsets.symmetric(horizontal: 10.0),

                child: FloatingActionButton(
                  backgroundColor: Colors.pink,
                  child: Icon(Icons.remove),
                  onPressed: () {
                    counterBloc.dispatch(CounterEvent.decrement);
                  },
                ),
              ),
              /* Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: FloatingActionButton(
              child: Icon(Icons.update),
              onPressed: () {
//                themeBloc.dispatch(ThemeEvent.toggle);
              },
            ),
          ),*/
            ],
          ),
        )
    );

  }


}

enum CounterEvent { increment, decrement }

class CounterBloc extends Bloc<CounterEvent, int> {
  @override
  int get initialState => 0;

  @override
  Stream<int> mapEventToState(CounterEvent event) async* {
    switch (event) {
      case CounterEvent.decrement:
        yield currentState - 1;
        break;
      case CounterEvent.increment:
        yield currentState + 1;
        break;
    }
  }
}

/*

enum ThemeEvent { toggle }

class ThemeBloc extends Bloc<ThemeEvent, ThemeData> {
  @override
  ThemeData get initialState => ThemeData.dark();

  @override
  Stream<ThemeData> mapEventToState(ThemeEvent event) async* {
    switch (event) {
      case ThemeEvent.toggle:
        yield currentState == ThemeData.light()
            ? ThemeData.dark()
            : ThemeData.light();
        break;
    }
  }
}

*/
