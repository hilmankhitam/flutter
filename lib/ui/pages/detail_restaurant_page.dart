part of 'pages.dart';

class RestaurantDetailPage extends StatefulWidget {
  static const routeName = '/detail_restaurant_page';
  final Restaurant restaurant;
  final String userName;
  const RestaurantDetailPage(this.restaurant, this.userName, {Key? key})
      : super(key: key);

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  @override
  Widget build(BuildContext context) {
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
                    future: RestaurantServices.getDetails(widget.restaurant.id),
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

                            return Column(
                              children: [
                                header(context),
                                picture(restaurantDetailResult
                                    .restaurantDetail.pictureId),
                                content(
                                    context,
                                    restaurantDetailResult
                                        .restaurantDetail.name,
                                    restaurantDetailResult
                                        .restaurantDetail.city,
                                    restaurantDetailResult
                                        .restaurantDetail.categories,
                                    restaurantDetailResult
                                        .restaurantDetail.rating,
                                    restaurantDetailResult
                                        .restaurantDetail.description,
                                    restaurantDetailResult
                                        .restaurantDetail.menus,
                                    restaurantDetailResult
                                        .restaurantDetail.customerReview),
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
            bottomButton(context, widget.restaurant.id, widget.userName),
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
              child: RaisedButton(
                  elevation: 0,
                  color: accentColor3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => ShowDialog(id, name,));
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

  Container header(BuildContext context) {
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
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.black.withOpacity(0.04),
            ),
            child: GestureDetector(
              onTap: () {},
              child: const Icon(Icons.settings, color: accentColor1),
            ),
          ),
        ],
      ),
    );
  }

  Widget content(
      BuildContext context,
      String name,
      String city,
      List<Categories> categories,
      double rating,
      String description,
      Menu menus,
      List<CustomerReview> reviewer) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 15),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
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
                    Text(city, style: greyTextFont)
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: categories
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
                Text(rating.toString(), style: greyTextFont)
              ],
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(description, textAlign: TextAlign.justify, style: greyTextFont),
        const SizedBox(height: 8),
        Text('Foods', style: blackTextFont.copyWith(fontSize: 18)),
        listFoods(menus),
        const SizedBox(height: 8),
        Text('Drinks', style: blackTextFont.copyWith(fontSize: 18)),
        listDrinks(menus),
        const SizedBox(height: 8),
        Text('Reviewer', style: blackTextFont.copyWith(fontSize: 18)),
        listReviewer(reviewer, context),
        const SizedBox(height: 70),
      ]),
    );
  }

  Container listReviewer(List<CustomerReview> reviewer, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: accentColor1),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: reviewer.map((review) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const CircleAvatar(
                    radius: 15,
                    backgroundImage: AssetImage('assets/profile.png'),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(review.name,
                          style: whiteTextFont.copyWith(fontSize: 16)),
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
                                  fontSize: 14, fontWeight: FontWeight.w300))),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  SingleChildScrollView listDrinks(Menu menus) {
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

  SingleChildScrollView listFoods(Menu menus) {
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

class ShowDialog extends StatefulWidget {
  final String id;
  final String name;
  const ShowDialog(this.id, this.name, {Key? key})
      : super(key: key);

  @override
  State<ShowDialog> createState() => _ShowDialogState();
}

class _ShowDialogState extends State<ShowDialog> {
  TextEditingController reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 330,
        height: 200,
        decoration: const BoxDecoration(
          color: mainColor,
        ),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              controller: reviewController,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                labelText: 'Review',
                hintText: 'Review',
              ),
            ),
          ),
          const SizedBox(height: 30),
          SizedBox(
            height: 50,
            width: 200,
            child: RaisedButton(
                elevation: 0,
                color: accentColor1,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                onPressed: () {
                  RestaurantServices.addReview(
                      widget.id, widget.name, reviewController.text);
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Add Review",
                  style: whiteTextFont.copyWith(
                      fontSize: 16, fontWeight: FontWeight.bold),
                )),
          ),
        ]),
      ),
    );
  }
}
