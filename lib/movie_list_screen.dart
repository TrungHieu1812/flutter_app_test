import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_test/Api_Urls.dart';
import 'package:flutter_app_test/models/movie.dart';
import 'package:flutter_app_test/widgets/itemMovie.dart';

class MovieList extends StatefulWidget {
  const MovieList({super.key});

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  List<Movie> movieList = [];
  bool isLoadingMore = false;
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    getData();
  }

  //hàm get dữ liệu từ api
  Future<void> getData() async {
    try {
      var res = await Dio().get(ApiUrls().API + currentPage.toString());
      if (res.statusCode == 200) {
        final data = res.data["results"] as List;
        setState(() {
          movieList.addAll(data.map((movie) => Movie.fromJson(movie)));
        });
      } else {
        throw Exception("Lỗi xảy ra!!!");
      }
    } catch (e) {
      print(e.toString());
    }
  }

//hàm load more
  Future<void> loadMore() async {
    if (!isLoadingMore) {
      setState(() {
        isLoadingMore = true;
      });
      currentPage++;
      await getData();
      setState(() {
        isLoadingMore = false;
      });
    }
  }

  //hàm làm mới dữ liệu
  Future<void> refreshData() async {
    currentPage++;
    movieList.clear();
    await getData();
  }

  Widget buildLoadMoreIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 10,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () => refreshData(),
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                      )),
                  const Text(
                    "Back",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Padding(
          padding: EdgeInsets.only(left: 15, top: 10, bottom: 5),
          child: Text(
            "Popular list",
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: refreshData,
            child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollNotification) {
                if (!isLoadingMore &&
                    scrollNotification.metrics.pixels ==
                        scrollNotification.metrics.maxScrollExtent) {
                  loadMore();
                }
                return false;
              },
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio:
                      0.6, // Tỉ lệ chiều-ngang/chiều-rộng của một item trong grid, ở đây width = 1.6 * height
                  crossAxisCount: 2, // Số item trên một hàng ngang
                  crossAxisSpacing:
                      10, // Khoảng cách giữa các item trong hàng ngang
                  mainAxisSpacing:
                      1, // Khoảng cách giữa các hàng (giữa các item trong cột dọc)
                ),
                itemCount: movieList.length + 1, // Thêm dòng khi load more
                itemBuilder: (context, index) {
                  if (index < movieList.length) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: movieItem(movie: movieList[index]),
                    );
                  } else if (index == movieList.length) {
                    return isLoadingMore
                        ? buildLoadMoreIndicator()
                        : const SizedBox();
                  }
                  return null;
                },
              ),
            ),
          ),
        ),
      ]),
    ));
  }
}
