part of 'pages.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage(this.userName, {Key? key}) : super(key: key);
  final String userName;

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          children: [
            Container(
                margin: EdgeInsets.symmetric(vertical: defaultMargin),
                child: Text('Favorites',
                    style: blackTextFont.copyWith(
                        fontSize: 18, fontWeight: FontWeight.bold))),
            favoriteList(),
            const SizedBox(height: 70),
          ],
        ),
      ],
    );
  }

  BlocBuilder<FavoriteBloc, FavoriteState> favoriteList() {
    return BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (_, favoriteState) {
      if (favoriteState is FavoriteLoading) {
        return const Center(
            child: SpinKitFadingCircle(size: 50, color: accentColor1));
      }
      if (favoriteState is FavoriteLoaded) {
        if (favoriteState.id.isNotEmpty) {
          return Column(
              children: favoriteState.id
                  .map((e) => FavoriteList(
                        e,
                        onTap: () {
                          context.read<PageBloc>().add(
                              GoToRestaurantDetailPage(e, widget.userName));
                        },
                        onTapDelete: () {
                          context
                              .read<FavoriteBloc>()
                              .add(RemoveFavoriteRestaurant(e));

                          Flushbar(
                                  duration: const Duration(milliseconds: 3000),
                                  flushbarPosition: FlushbarPosition.TOP,
                                  backgroundColor: accentColor1,
                                  message: "Has been removed from Favorites")
                              .show(context);
                        },
                      ))
                  .toList());
        } else {
          return Center(
              child: Text('Belum ada Daftar Favorit', style: blackTextFont));
        }
      } else {
        return Text('Something went wrong', style: blackTextFont);
      }
    });
  }
}
