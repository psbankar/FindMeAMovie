import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/api_key.dart';
import 'package:flutter_app/genres_json.dart';
import 'package:flutter_app/pages/final_results.dart';
import 'package:flutter_app/person_class.dart';
import 'package:http/http.dart' as http;

class GenreSelectionPage extends StatefulWidget {
  List<Results> selected;

  GenreSelectionPage({this.selected});

  @override
  GenreSelectionPageState createState() {
    return new GenreSelectionPageState();
  }
}

class GenreSelectionPageState extends State<GenreSelectionPage> {
  List<Genres> data = new List();

  List<Genres> selectedGenre;
  var uri =
      "https://api.themoviedb.org/3/genre/movie/list?api_key=${ApiKey.key}&language=en-US";

  Future<String> fetch() async {
    var response = await http.get(uri);
    data = GenreJson.fromJson(jsonDecode(response.body)).genres;
    setState(() {});
    return "Success";
  }

  @override
  void initState() {
    fetch();
    selectedGenre = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: selectedGenre.isEmpty && widget.selected.isEmpty
          ? null
          : FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FinalResults(
                              selectedCast: widget.selected,
                              selectedGenre: selectedGenre,
                            )));
              },
              icon: Icon(
                Icons.navigate_next,
                size: 0.0,
              ),
              label: Text("Next")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            "Select upto 5 Genres which you would like to watch",
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          Center(
              child: Wrap(
            spacing: 8.0,
            runSpacing: 5.0,
            alignment: WrapAlignment.center,
            children: data.map(getChips).toList(),
          )),
        ],
      ),
    );
  }

  Widget getChips(Genres g) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: FilterChip(
        label: Text(g.name),
        selected: selectedGenre.contains(g),
        onSelected: (sel) {
          setState(() {
            if (sel && !selectedGenre.contains(g) && selectedGenre.length < 5)
              selectedGenre.add(g);
            else
              selectedGenre.remove(g);
          });
        },
        selectedColor: Theme.of(context).accentColor,
      ),
    );
  }
}
