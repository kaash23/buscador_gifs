import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String _search;
  int _offset = 0;

  Future<Map> _getGifs() async {
    http.Response response;

    if (_search == null)
      response = await http.get("https://api.giphy.com/v1/gifs/trending?api_key=Tpediafryx2M9rucPo9uzLjkXJW7opAs&limit=25&rating=G");
    else
      response = await http.get("https://api.giphy.com/v1/gifs/search?api_key=Tpediafryx2M9rucPo9uzLjkXJW7opAs&q=d$_search&limit=$_offset&offset=25&rating=G&lang=en");

    return json.decode(response.body);
  }

  @override
  void initState(){
    super.initState();

    _getGifs().then((map){
      print(map);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.network("https://media.giphy.com/media/3o6gbbuLW76jkt8vIc/giphy.gif"),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Pesquise aqui!!",
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(),
              ),
              style: TextStyle(color: Colors.white, fontSize: 18.0),
              textAlign: TextAlign.center,
            )
          ),
          Expanded(
            child: FutureBuilder(
                future: _getGifs(),
                builder: (context, snapshot){
                  switch(snapshot.connectionState){
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return Container(
                        width: 200.0,
                        height: 200.0,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          strokeWidth: 5.0,
                        ),
                      );
                    default:
                      if (snapshot.hasError) return Container();
                      else return _createGifTable(context, snapshot);
                  }
                },
            )
          ),
        ],
      ),
    );
  }
}

Widget _createGifTable (BuildContext context, AsyncSnapshot snapshot){
  return GridView.builder(
      padding: EdgeInsets.all(10.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0),
      itemCount: snapshot.data["data"].length,
      itemBuilder: (context, index){
       return GestureDetector(
         child: Image.network(snapshot.data["data"][index]["images"]["fixed_height"]["url"],
         height: 300.0,
         fit: BoxFit.cover,),
       );
      }
      );
}