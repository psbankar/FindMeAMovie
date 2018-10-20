
import 'package:flutter/material.dart';
import 'package:flutter_app/person_class.dart';

class SearchResults extends StatefulWidget {
  @override
  SearchResultsState createState() {
    return new SearchResultsState();
  }
}

class SearchResultsState extends State<SearchResults> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, AsyncSnapshot<List<Results>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.connectionState == ConnectionState.done)
          return Expanded(
              child: GridView.builder(
                  itemCount: snapshot == null ? 0 : snapshot.data.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? 3
                          : 4,
                      mainAxisSpacing: 8.0,
                      crossAxisSpacing: 8.0),
                  itemBuilder: (context, index) {
                    if (snapshot.data.isNotEmpty) {
                      return Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: GestureDetector(
                          child: Container(
                            child: Center(
                                child: Text(
                              snapshot.data.elementAt(index).name,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            )),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    fit: BoxFit.fitWidth,
                                    colorFilter: ColorFilter.mode(
                                        Colors.black26, BlendMode.darken),
                                    image: NetworkImage(snapshot.data
                                                .elementAt(index)
                                                .profilePath ==
                                            null
                                        ? "https://heimtextil.messefrankfurt.com/content/dam/messefrankfurt-redaktion/ebu23/team-photos/Placeholder_Person.png"
                                        : "https://image.tmdb.org/t/p/w185${snapshot.data.elementAt(index).profilePath}"))),
                          ),
                        ),
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  }));
      },
    );
  }
}
