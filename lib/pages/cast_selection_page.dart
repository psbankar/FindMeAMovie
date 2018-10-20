import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/api_key.dart';
import 'package:flutter_app/person_class.dart';
import 'package:http/http.dart' as http;
import 'genre_selection_page.dart';

class CastSelectionPage extends StatefulWidget {
  @override
  CastSelectionPageState createState() {
    return new CastSelectionPageState();
  }
}

class CastSelectionPageState extends State<CastSelectionPage> {
  List<Results> selected = new List();

  static String uri;

  List<Results> results;

  fetch(query) async {
    if (query == null) {
      uri =
          "http://api.themoviedb.org/3/person/popular?api_key=${ApiKey.key}";
    } else {
      uri =
          "http://api.themoviedb.org/3/search/person?api_key=${ApiKey.key}&query=$query";
    }
    var response = await http.get(uri);
    setState(() {
      print(response);
      results = PersonClass.fromJson(json.decode(response.body)).results;
    });
  }

  @override
  void initState() {
    super.initState();
    fetch(null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: new Fab(selected: selected),
      body: Column(
        children: <Widget>[
          searchBar(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Select a maximum of 3 celebrities",
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ),
          Divider(),
          selectedItems(),
          searchResults(),
        ],
      ),
    );
  }

  searchResults() {
    return results != null
        ? Expanded(
            child: GridView(
              children: results.map(addChildren).toList(),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 130.0,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0),
            ),
          )
        : Center(child: CircularProgressIndicator());
  }

  searchBar() {
    return SafeArea(
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(100.0))),
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: TextField(
            textCapitalization: TextCapitalization.words,
            style: TextStyle(fontSize: 18.0),
            onSubmitted: (search) {
              setState(() {
                fetch(search);
              });
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(
                Icons.arrow_forward_ios,
                size: 0.0,
              ),
              suffixIcon: Icon(Icons.search),
              hintText: "Search",
            )
            //suffixIcon: Icon(Icons.search)),
            ),
      ),
    );
  }

  selectedItems() {
    if (selected.isNotEmpty) {
      return Container(
        height: 88.0,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                "Selected",
                style: TextStyle(height: 0.4),
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: selected == null ? 0 : selected.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: GestureDetector(
                      onTap: () {
                        selected.removeAt(index);
                        setState(() {});
                      },
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 48.0,
                            width: 48.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    fit: BoxFit.fitWidth,
                                    colorFilter: ColorFilter.mode(
                                        Colors.black26, BlendMode.darken),
                                    image: NetworkImage(selected
                                                .elementAt(index)
                                                .profilePath ==
                                            null
                                        ? "https://heimtextil.messefrankfurt.com/content/dam/messefrankfurt-redaktion/ebu23/team-photos/Placeholder_Person.png"
                                        : "https://image.tmdb.org/t/p/w185${selected.elementAt(index).profilePath}"))),
                          ),
                          Text(
                            selected.elementAt(index).name,
                            maxLines: 1,
                          )
                        ],
                      ),
                    ),
                  );
                },
                scrollDirection: Axis.horizontal,
              ),
            ),
          ],
        ),
      );
    } else
      return Container();
  }

  Widget addChildren(Results results) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (selected.length < 3 && selected.indexOf(results) == -1)
            selected.add(results);
        });
      },
      child: Container(
        child: Center(
            child: Text(
          results.name,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        )),
        decoration: BoxDecoration(
            color: Colors.black54,
            shape: BoxShape.circle,
            image: DecorationImage(
                fit: BoxFit.fitWidth,
                colorFilter: ColorFilter.mode(Colors.black38, BlendMode.darken),
                image: NetworkImage(results.profilePath == null
                    ? "https://heimtextil.messefrankfurt.com/content/dam/messefrankfurt-redaktion/ebu23/team-photos/Placeholder_Person.png"
                    : "https://image.tmdb.org/t/p/w185${results.profilePath}"))),
      ),
    );
  }
}

class Fab extends StatelessWidget {
  const Fab({
    Key key,
    @required this.selected,
  }) : super(key: key);

  final List<Results> selected;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      icon: Icon(
        null,
        size: 0.0,
      ),
      label: selected.length == 0 ? Text("Skip") : Text("Next"),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => GenreSelectionPage(selected: selected)));
      },
    );
  }
}
