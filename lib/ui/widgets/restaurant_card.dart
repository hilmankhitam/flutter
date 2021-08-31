part of 'widgets.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;
  final Function onTap;

  const RestaurantCard(this.restaurant, {Key? key, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Stack(
        children: [
          Container(
            width: 230,
            height: 220,
            decoration: BoxDecoration(
              color: accentColor1,
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          Positioned(
            left: 10,
            bottom: 10,
            child: SizedBox(
              width: 210,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(restaurant.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: whiteTextFont.copyWith(fontSize: 16)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: accentColor3,
                            size: 20,
                          ),
                          const SizedBox(width: 5),
                          Text(restaurant.city, style: greyTextFont),
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
                          Text(
                            restaurant.rating.toString(),
                            style: greyTextFont,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 10,
            top: 10,
            child: Stack(
              children: [
                Container(
                  height: 140,
                  width: 210,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                        image: NetworkImage(
                            imageBaseURL + 'medium/' + restaurant.pictureId),
                        fit: BoxFit.cover),
                  ),
                ),
                BlocBuilder<FavoriteBloc, FavoriteState>(
                  builder: (_, state) {
                    if(state is FavoriteLoaded) {
                      List<String> id = state.id;
                      return Positioned(
                      right: 10,
                      bottom: 10,
                      child: Container(
                        width: 35,
                        height: 35,
                        padding: const EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: mainColor,
                        ),
                        child: GestureDetector(
                          onTap: () {
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
                          },
                          child:
                               Icon( id.contains(restaurant.id) ?  Icons.favorite : Icons.favorite_border, color: accentColor1),
                        ),
                      ),
                    );
                    }else{
                      return const SizedBox();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
