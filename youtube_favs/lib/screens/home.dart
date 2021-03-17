import 'package:flutter/material.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

// searchDelegate
import '../delegates/data_search.dart';

// VideosBloc
import '../blocs/video_bloc.dart';

// VideoTile
import '../components/video_tile.dart';

// Video
import '../models/video.dart';

class HomePage extends StatelessWidget {

    @override
    Widget build(BuildContext context) {

        // Getting video bloc
        final _video_bloc = BlocProvider.getBloc<VideosBloc>();
        
        return Scaffold(
            appBar: AppBar(
                title: Container(
                    height: 25,
                    child: Image.asset("assets/images/yt_logo_real.png"),
                ), // Container
                elevation: 0,
                backgroundColor: Colors.black87,
                actions: <Widget>[
                    Align( 
                        alignment: Alignment.center,
                        child: Text("0"),
                    ), // Align
                    IconButton(
                        icon: Icon(Icons.star),
                        onPressed: () {},
                    ), // IconButton
                    IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () async {
                            String result = await showSearch(context: context, 
                                       delegate: DataSearch()) as String ;
                            print("RESULT:${result}");
                            if(result != null) {
                                _video_bloc.inSearch.add(result);
                            }
                        },
                    ), // IconButton
                ], // <Widget>
            ), // AppBar
            backgroundColor: Colors.black,
            body: StreamBuilder(
                stream: _video_bloc.outVideos,
                builder: (context, snapshot){
                    if(snapshot.hasData){
                        return ListView.builder(
                            itemBuilder: (context, index){
                                return VideoTile(snapshot.data[index]);
                            },
                            itemCount: snapshot.data.length,
                        ); // ListView.builder
                    } else {
                        return Container();
                    }
                }, // builder
            ), // StreamBuilder
        ); // Scaffold
    }
}
