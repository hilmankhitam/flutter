part of 'pages.dart';

class SearchPage extends StatefulWidget {
  const SearchPage(this.nameUser, {Key? key}) : super(key: key);
  final String nameUser;
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  late SearchBloc searchBloc;

  void onClearTapped() {
    searchController.text = '';
    searchBloc.add(const TextChanged(text: ''));
  }

  @override
  void initState() {
    super.initState();
    searchBloc = context.read<SearchBloc>();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<PageBloc>().add(const GoToHomePage());
        return false;
      },
      child: Scaffold(
        body: Stack(children: [
          Container(
            color: accentColor1,
          ),
          SafeArea(child: Container(color: mainColor)),
          ListView(children: [
            header(context),
            body(),
          ]),
        ]),
      ),
    );
  }

  BlocBuilder<SearchBloc, SearchState> body() {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (_, searchState) {
        if (searchState is SearchStateLoading) {
          return const Center(
            child: SpinKitFadingCircle(color: accentColor1, size: 50),
          );
        }
        if (searchState is SearchStateError) {
          return Center(child: Text(searchState.error));
        }
        if (searchState is SearchStateSuccess) {
          return searchState.items.isEmpty
              ? Center(
                  child: Text('Tidak Ada Hasil',
                      style: blackTextFont.copyWith(fontSize: 18)))
              : Column(
                  children: searchState.items
                      .map((e) => RestaurantList(e, onTap: () {
                            context.read<PageBloc>().add(
                                GoToRestaurantDetailPage(e.id, widget.nameUser));
                          }))
                      .toList());
        }
        return Center(
            child: SizedBox(
                width: MediaQuery.of(context).size.width - 2 * defaultMargin,
                child: Text('Masukkan Nama Restoran, Makanan, atau Kategori',
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: blackTextFont.copyWith(fontSize: 14))));
      },
    );
  }

  Container header(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(defaultMargin, 8, defaultMargin, 12),
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
                context.read<PageBloc>().add(const GoToHomePage());
              },
              child: const Icon(Icons.arrow_back, color: accentColor1),
            ),
          ),
          Container(
            height: 40,
            width: MediaQuery.of(context).size.width - 2 * defaultMargin - 79,
            margin: EdgeInsets.fromLTRB(defaultMargin, 10, defaultMargin, 0),
            decoration: BoxDecoration(
              color: accentColor1,
              borderRadius: BorderRadius.circular(5),
            ),
            child: TextField(
                controller: searchController,
                autocorrect: false,
                onChanged: (text) {
                  searchBloc.add(TextChanged(text: text));
                },
                style: whiteTextFont.copyWith(
                    fontSize: 15, fontWeight: FontWeight.w300),
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: const TextStyle(color: mainColor),
                  prefixIcon: const Icon(Icons.search, color: mainColor),
                  suffixIcon: GestureDetector(
                    onTap: onClearTapped,
                    child: const Icon(Icons.clear, color: mainColor),
                  ),
                  border: InputBorder.none,
                )),
          ),
        ],
      ),
    );
  }
}
