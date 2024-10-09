import 'package:flutter/material.dart';
import 'package:flutter_flix/pages/movie_detail.dart';
import 'package:flutter_flix/providers/theme_manager.dart';
import 'package:flutter_flix/utils/shared_preferences.dart';
import 'package:flutter_flix/widgets/watch_list_movie_item.dart';
import 'package:provider/provider.dart';
import '../models/movie.dart';
import '../widgets/tool_bar.dart';

class WatchListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WatchListPage();
  }
}

class _WatchListPage extends State<WatchListPage> {
  List<Movie> mMovies = [];

  @override
  void initState() {
    super.initState();
    getMoviesFromSp();
  }

  Future<void> getMoviesFromSp() async {
    List<Movie> movies = await getMovies();
    setState(() {
      mMovies = movies;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = context.watch<ThemeManager>().themeMode == ThemeMode.dark;
    Color color = isDark ? Colors.white : Colors.black;
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
      color: Theme.of(context).colorScheme.primary,
      child: RefreshIndicator(
        onRefresh: getMoviesFromSp,
        child: Column(children: [
          const ToolBar(null, "Watch List", null),
          const SizedBox(height: 20),
          Expanded(
            child: mMovies.isEmpty
                ? Center(
                    child: Text("No Movie Found!", style: TextStyle(
                      color: color
                    ),),
                  )
                : ListView.builder(
                    itemCount: mMovies.length, // Number of items in the list
                    itemBuilder: (context, index) {
                      if (mMovies.isEmpty) {
                        return const SizedBox(height: 140);
                      }
                      return SizedBox(
                        height: 140,
                        child: Column(
                          children: [
                            WatchListMovieItem(mMovies[index], onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) => MovieDetailPage(
                                          mMovies[index].id ?? 1)));
                            }),
                            const SizedBox(height: 20),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ]),
      ),
    );
  }
}
