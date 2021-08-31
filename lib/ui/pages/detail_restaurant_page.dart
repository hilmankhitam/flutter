part of 'pages.dart';

class RestaurantDetailPage extends StatefulWidget {
  final String id;
  final String userName;
  const RestaurantDetailPage(this.id, this.userName, {Key? key})
      : super(key: key);

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  late Future _future;

  @override
  void dispose() {
    NotificationHelper.onNotifications.close();
    super.dispose();
  }

  @override
  initState() {
    super.initState();
    _future = RestaurantServices.getDetails(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    Restaurant restaurant;
    return WillPopScope(
      onWillPop: () async {
        context.read<PageBloc>().add(GoToHomePage());
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              color: accentColor1,
            ),
            SafeArea(child: Container(color: mainColor)),
            ListView(
              children: [
                FutureBuilder(
                    future: _future,
                    builder: (_, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.active:
                        case ConnectionState.waiting:
                          return const Center(
                            child: SpinKitFadingCircle(
                                color: accentColor1, size: 50),
                          );
                        default:
                          if (snapshot.hasData) {
                            RestaurantDetailResult restaurantDetailResult =
                                snapshot.data as RestaurantDetailResult;
                            restaurant =
                                restaurantDetailResult.restaurantDetail;
                            return Column(
                              children: [
                                header(context, restaurant),
                                picture(restaurantDetailResult
                                    .restaurantDetail.pictureId),
                                content(context,
                                    restaurantDetailResult.restaurantDetail),
                              ],
                            );
                          } else {
                            return const Center(
                                child: Text('Failed to load Details'));
                          }
                      }
                    }),
              ],
            ),
            bottomButton(context, widget.id, widget.userName),
          ],
        ),
      ),
    );
  }

  Widget bottomButton(BuildContext context, String id, String name) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 70,
        decoration: const BoxDecoration(
          color: accentColor1,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Container(
          margin: const EdgeInsets.only(top: 10),
          child: Column(children: [
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width - 20,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 0,
                    primary: accentColor3,
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => ShowDialog(
                              id,
                              name,
                            ));
                    setState(() {});
                  },
                  child: Text(
                    "Add Review",
                    style: whiteTextFont.copyWith(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  )),
            ),
          ]),
        ),
      ),
    );
  }

  Widget picture(String pictureId) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: defaultMargin),
      height: 300,
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: NetworkImage(imageBaseURL + 'large/' + pictureId),
                  fit: BoxFit.cover))),
    );
  }

  Container header(BuildContext context, Restaurant restaurant) {
    return Container(
      margin:
          EdgeInsets.fromLTRB(defaultMargin, 20, defaultMargin, defaultMargin),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.black.withOpacity(0.04),
            ),
            child: GestureDetector(
              onTap: () {
                context.read<PageBloc>().add(GoToHomePage());
              },
              child: const Icon(Icons.arrow_back, color: accentColor1),
            ),
          ),
          Text('Details',
              style: blackTextFont.copyWith(
                  fontSize: 18, fontWeight: FontWeight.bold)),
          favoriteButton(restaurant),
        ],
      ),
    );
  }

  BlocBuilder<FavoriteBloc, FavoriteState> favoriteButton(
      Restaurant restaurant) {
    return BlocBuilder<FavoriteBloc, FavoriteState>(
      builder: (_, state) {
        if (state is FavoriteLoaded) {
          List<String> id = state.id;
          return Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.black.withOpacity(0.04),
            ),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  if (id.contains(restaurant.id)) {
                    context
                        .read<FavoriteBloc>()
                        .add(RemoveFavoriteRestaurant(restaurant.id));
                    Flushbar(
                            duration: const Duration(milliseconds: 1500),
                            flushbarPosition: FlushbarPosition.TOP,
                            backgroundColor: accentColor1,
                            message:
                                "${restaurant.name} has been removed from Favorites")
                        .show(context);
                  } else {
                    context
                        .read<FavoriteBloc>()
                        .add(AddFavoriteRestaurant(restaurant.id));
                    Flushbar(
                            duration: const Duration(milliseconds: 1500),
                            flushbarPosition: FlushbarPosition.TOP,
                            backgroundColor: accentColor1,
                            message:
                                "${restaurant.name} has been added to Favorites")
                        .show(context);
                  }
                });
              },
              child: Icon(
                  id.contains(restaurant.id)
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: accentColor1),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget content(BuildContext context, RestaurantDetail restaurantDetail) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 15),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(restaurantDetail.name,
                    style: blackTextFont.copyWith(
                        fontSize: 22, fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: accentColor3,
                      size: 20,
                    ),
                    const SizedBox(width: 5),
                    Text(restaurantDetail.city, style: greyTextFont)
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: restaurantDetail.categories
                      .map((e) => Container(
                          margin: const EdgeInsets.only(right: 5),
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: accentColor1),
                          child: Text(e.name, style: whiteTextFont)))
                      .toList(),
                ),
              ],
            ),
            Row(
              children: [
                const Icon(
                  Icons.star,
                  color: accentColor3,
                  size: 20,
                ),
                const SizedBox(width: 2),
                Text(restaurantDetail.rating.toString(), style: greyTextFont)
              ],
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(restaurantDetail.description,
            textAlign: TextAlign.justify, style: greyTextFont),
        const SizedBox(height: 8),
        Text('Foods', style: blackTextFont.copyWith(fontSize: 18)),
        cardFoods(restaurantDetail.menus),
        const SizedBox(height: 8),
        Text('Drinks', style: blackTextFont.copyWith(fontSize: 18)),
        cardDrinks(restaurantDetail.menus),
        const SizedBox(height: 8),
        Text('Reviewer', style: blackTextFont.copyWith(fontSize: 18)),
        listReviewer(restaurantDetail),
        const SizedBox(height: 70),
      ]),
    );
  }

  Container listReviewer(Restaurant restaurant) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: accentColor1),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
            future: RestaurantServices.getDetails(restaurant.id),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.active:
                case ConnectionState.waiting:
                  return const Center(
                      child:
                          SpinKitFadingCircle(size: 50, color: accentColor1));
                default:
                  if (snapshot.hasData) {
                    RestaurantDetailResult restaurantDetailResult =
                        snapshot.data as RestaurantDetailResult;
                    return Column(
                      children: restaurantDetailResult
                          .restaurantDetail.customerReview
                          .map((review) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const CircleAvatar(
                                radius: 15,
                                backgroundImage:
                                    AssetImage('assets/profile.png'),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(review.name,
                                      style:
                                          whiteTextFont.copyWith(fontSize: 16)),
                                  const SizedBox(height: 5),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width -
                                          2 * defaultMargin -
                                          52,
                                      child: Text(review.review,
                                          textAlign: TextAlign.justify,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: whiteTextFont.copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w300))),
                                ],
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    );
                  } else {
                    return const Center(child: Text('Failed to load Details'));
                  }
              }
            }),
      ),
    );
  }

  SingleChildScrollView cardDrinks(Menu menus) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: menus.drinks
            .map((e) => Container(
                margin: const EdgeInsets.only(right: 10),
                child: Column(
                  children: [
                    Container(
                      height: 85,
                      width: 70,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey[100],
                        borderRadius: BorderRadius.circular(8),
                        image: const DecorationImage(
                          image: AssetImage('assets/drink.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 6),
                        width: 70,
                        height: 40,
                        child: Text(e.name,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: blackTextFont.copyWith(
                                fontSize: 10, fontWeight: FontWeight.w400))),
                  ],
                )))
            .toList(),
      ),
    );
  }

  SingleChildScrollView cardFoods(Menu menus) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: menus.foods
            .map((e) => Container(
                margin: const EdgeInsets.only(right: 10),
                child: Column(
                  children: [
                    Container(
                      height: 85,
                      width: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: const DecorationImage(
                          image: AssetImage('assets/food.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 5),
                        width: 70,
                        height: 40,
                        child: Text(e.name,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: blackTextFont.copyWith(
                                fontSize: 10, fontWeight: FontWeight.w400))),
                  ],
                )))
            .toList(),
      ),
    );
  }
}
