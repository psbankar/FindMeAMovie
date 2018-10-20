import 'package:flutter/material.dart';
import 'package:flutter_app/pages/final_results.dart';
import 'package:flutter_app/ui/home_page_ui.dart';
import 'cast_selection_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Button(
                "Search A Movie",
                () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CastSelectionPage()))),
            Button(
                "Popular Choice",
                () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FinalResults()))),
          ],
        ),
      ),
    );
  }
}
