part of 'pages.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: accentColor1,
          ),
          SafeArea(child: Container(color: mainColor)),
          Stack(children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height - 291,
              child: LottieBuilder.asset('assets/lottie_food.json'),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  height: 291,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      color: accentColor1,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("L'appetito",
                          style: whiteTextFont.copyWith(fontSize: 24)),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        "Kamu sudah lapar belum? Kalau sudah, bilang ya.\nNanti Kami siapkan, jadi kamu bisa makan.",
                        style: whiteTextFont.copyWith(fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      SizedBox(
                        height: 55,
                        width: 290,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(27.5),
                              ),
                              elevation: 0,
                              primary: accentColor3,
                            ),
                            onPressed: () {
                              context
                                  .read<PageBloc>()
                                  .add(const GoToHomePage());
                            },
                            child: Text(
                              "Let's Order",
                              style: blackTextFont.copyWith(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )),
                      ),
                    ],
                  )),
            ),
          ]),
        ],
      ),
    );
  }
}
