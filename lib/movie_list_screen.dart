import 'package:flutter/material.dart';
import 'package:flutter_app_test/models/movie.dart';
import 'data_sourcres/Api_Services.dart';

class MovieList extends StatefulWidget {
  const MovieList({super.key});

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Popular List'),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 64, 63, 63),
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.height,
          child: FutureBuilder<List<Movie>>(
              future: ApiServices().fetchMovie_dio(),
              builder: (context, snapshot) {
                if ((snapshot.hasError) || (!snapshot.hasData)) {
                  return Container(
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                List<Movie>? movieList = snapshot.data;
                return GridView.builder(
                    padding: const EdgeInsets.all(10),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio:
                          0.6, // Tỉ lệ chiều-ngang/chiều-rộng của một item trong grid, ở đây width = 1.6 * height
                      crossAxisCount: 2, // Số item trên một hàng ngang
                      crossAxisSpacing:
                          20, // Khoảng cách giữa các item trong hàng ngang
                      mainAxisSpacing:
                          1, // Khoảng cách giữa các hàng (giữa các item trong cột dọc)
                    ),
                    itemCount: movieList!.length, // Số lượng item
                    itemBuilder: (BuildContext context, int index) {
                      return movieItem(
                        movie: movieList[index],
                      );
                    });
              }),
        ),
      ),
    );
  }
}

class movieItem extends StatelessWidget {
  Movie? movie;
  movieItem({super.key, this.movie});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        margin: const EdgeInsets.only(top: 20),
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
              movie!.release_date!.substring(0, 4),
              style: const TextStyle(
                fontSize: 15.0,
                color: Colors.white,
              ),
            ),
            Text(
              "${movie!.title}",
              style: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
      Container(
        margin: const EdgeInsets.only(left: 140, top: 25),
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
        child: Text(
          "${movie!.vote_average}",
          style: const TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      )
    ]);
  }
}
