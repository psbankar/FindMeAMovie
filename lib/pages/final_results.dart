import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/api_key.dart';
import 'package:flutter_app/genres_json.dart';
import 'package:flutter_app/person_class.dart';
import 'package:flutter_app/ui/film_card_ui.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/movies_json.dart' as movies;

class FinalResults extends StatefulWidget {
  List<Results> selectedCast = [];
  List<Genres> selectedGenre = [];

  FinalResults({this.selectedCast, this.selectedGenre});

  @override
  FinalResultsState createState() {
    return new FinalResultsState();
  }
}

class FinalResultsState extends State<FinalResults> {
  Uri uri;

  String codes = "";
  String genres = "";
  String url;
  List<movies.Results> results = [];

  fetch() async {
    url = Uri.decodeFull(
        "https://api.themoviedb.org/3/discover/movie?api_key=${ApiKey.key}&with_cast=$codes&with_genres=$genres");
    print(url);
    var response = await http.get(url);
    setState(() {
      results = movies.MoviesJson.fromJson(json.decode(response.body)).results;
    });
  }

  @override
  void initState() {
    if (widget.selectedCast != null) {
      for (int i = 0; i < widget.selectedCast.length; i++) {
        if (i == widget.selectedCast.length - 1)
          codes = codes + widget.selectedCast.elementAt(i).id.toString();
        else
          codes = codes + widget.selectedCast.elementAt(i).id.toString() + ",";
      }
    }
    if (widget.selectedCast != null) {
      for (int i = 0; i < widget.selectedGenre.length; i++) {
        if (i == widget.selectedGenre.length - 1)
          genres = genres + widget.selectedGenre.elementAt(i).id.toString();
        else
          genres =
              genres + widget.selectedGenre.elementAt(i).id.toString() + "|";
      }
    }
    fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Here are your movies!!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            Expanded(
              child: GridView.builder(
                  itemCount: results == null ? 0 : results.length,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 150.0,
                      mainAxisSpacing: 16.0,
                      crossAxisSpacing: 16.0,
                      childAspectRatio: 0.55),
                  itemBuilder: (context, index) {
                    return FilmCard(results, index);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class CastList extends StatelessWidget {
  var subsets;

  CastList(this.subsets);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, index) {
      List temp = [];
      for (int i = 0; i < subsets[index].length; i++) {
        if (subsets[index].elementAt(i) != null)
          temp.add(subsets[index].elementAt(i));
      }
      return Card(child: Text(temp.toString()));
    });
  }
}
/*

class FinalResultsState extends State<FinalResults> {
  Subsets subsets;

  Uri uri;

  @override
  void initState() {
    subsets = Subsets(widget.selectedCast);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageView.builder(
          itemCount: subsets.length.toInt(),
          itemBuilder: (context, index) {
            List temp = [];
            for (int i = 0; i < subsets[index].length; i++) {
              if (subsets[index].elementAt(i) != null)
                temp.add(subsets[index].elementAt(i));
            }
            return addCard(temp);
          },
        ),
      ),
    );
  }

  Widget addCard(List subset) {
    List<movies.Results> results;
    String names = "";
    String codes = "";
    for (int i = 0; i < subset.length; i++) {
      names = names + subset.elementAt(i).name + " & ";
      codes = codes + subset.elementAt(i).id.toString() + "&";
    }

    fetch() async {
      uri = Uri.http("api.themoviedb.org", "/3/discover/movie",
          {"api_key": "65d4bd1d3ca5da828324d20b60298de6", "with_cast": codes});
      print(uri);
      var response = await http.get(uri);
      setState(() {
        results = movies.MoviesJson.fromJson(json.decode(response.body)).results;
      });

    }

    fetch();

    return Container(
      height: 150.0,
      child: Card(
        child: Column(children: <Widget>[
          Text("Movies of " + names),
          Expanded(
            child: ListView.builder(
              itemCount: widget.selectedGenre.length,
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    Text(widget.selectedGenre.elementAt(index).name),
                    Container(
                      height: 150.0,
                      child: ListView.builder(
                        itemCount: results == null ? 0 : results.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Text(results.elementAt(index).title);
                          }),
                    )
                  ],
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}
*/
