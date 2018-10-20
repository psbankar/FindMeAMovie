import 'package:flutter/material.dart';

class FilmCard extends StatelessWidget {
  var index;

  var results;

  FilmCard(this.results, this.index);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Stack(
          children: <Widget>[
            Image.network(
                "https://image.tmdb.org/t/p/w154${results.elementAt(index).posterPath}"),
            Text(
              results.elementAt(index).voteAverage.toString(),
              style: TextStyle(
                fontStyle: FontStyle.italic,
                letterSpacing: 1.5,
                fontSize: 15.0,
                background: Paint()..color = Colors.black,
              ),
            )
          ],
        ),
        Expanded(
          child: Center(
            child: Text(
              results.elementAt(index).title,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    ));
  }
}
