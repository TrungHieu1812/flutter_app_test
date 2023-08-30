import 'package:flutter/material.dart';
import 'package:flutter_app_test/models/movie.dart';

class movieItem extends StatelessWidget {
  movieItem({super.key, this.movie});

  Movie? movie;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.all(5),
        width: 200,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  "https://image.tmdb.org/t/p/w400/${movie!.picture}"),
              fit: BoxFit.fill),
          borderRadius: const BorderRadius.all(
            Radius.circular(7),
          ),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 30, 30, 30).withOpacity(0.6),
              spreadRadius: 3,
              blurRadius: 7,
              offset: const Offset(0, 5), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              movie!.release_date.substring(0, 4),
              style: const TextStyle(
                fontSize: 15.0,
                color: Colors.white,
              ),
            ),
            Text(
              movie!.title,
              style: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
      Container(
        margin: const EdgeInsets.only(left: 125, top: 20),
        alignment: Alignment.center,
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(40),
            ),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.orange,
                Color.fromARGB(255, 249, 2, 117),
              ],
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              movie!.vote_average.toString().substring(0, 1),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                movie!.vote_average.toString().substring(1, 3),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
            ),
          ],
        ),

        // Text(
        //   "${movie!.vote_average}",
        //   style: const TextStyle(
        //     fontSize: 20.0,
        //     color: Colors.white,
        //   ),
        // ),
      )
    ]);
  }
}
