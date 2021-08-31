part of 'widgets.dart';

class FavoriteList extends StatelessWidget {
  final String id;
  final Function onTap;
  final Function onTapDelete;

  const FavoriteList(this.id,
      {Key? key, required this.onTap, required this.onTapDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: RestaurantServices.getDetails(id),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          RestaurantDetailResult restaurantDetailResult = snapshot.data as RestaurantDetailResult;
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: Container(
              padding: const EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width - 2 * defaultMargin,
              height: 160,
              decoration: BoxDecoration(
                color: accentColor1,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      onTap();
                    },
                    child: Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width -
                          2 * defaultMargin -
                          20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                            image: NetworkImage(
                                imageBaseURL + 'small/' + restaurantDetailResult.restaurantDetail.pictureId),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(restaurantDetailResult.restaurantDetail.name,
                            style: whiteTextFont.copyWith(fontSize: 16)),
                        GestureDetector(
                          onTap: () {
                            onTapDelete();
                          },
                          child: const Icon(Icons.delete, color: mainColor),
                        )
                      ]),
                ],
              ),
            ),
          );
        } else {
          return const Center(
              child: SpinKitFadingCircle(size: 50, color: accentColor1));
        }
      },
    );
  }
}
