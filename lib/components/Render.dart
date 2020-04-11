import 'package:flutter/material.dart';

class Render extends StatelessWidget {
  final List<dynamic> results;

  Render(this.results);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: results != null
            ? results.map((res) {
                return Text(
                  "${res["label"]}: ${(res["confidence"] * 100).toStringAsFixed(0)}%",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 30.0,
                  ),
                );
              }).toList()
            : [],
      ),
    );
  }
}
