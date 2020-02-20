import 'package:flutter/material.dart';

class GifPage extends StatelessWidget {

final Map _GifData;
GifPage(this._GifData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_GifData["title"]),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Image.network(_GifData["images"]["fixed_height"]["url"])
      )
    );
  }
}
