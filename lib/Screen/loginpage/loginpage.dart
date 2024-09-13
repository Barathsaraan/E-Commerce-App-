import 'package:e_commerce/Screen/DashboardPage/productPage.dart';
import 'package:e_commerce/Screen/loginpage/app_title.dart';
import 'package:e_commerce/constant/prefs.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:otpless_flutter/otpless_flutter.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final _otplessFlutterPlugin = Otpless();
  var arg = {
    'appId': "DEKMXOOET2TAHCLZLJMF",
    'crossButtonHidden': true,
    'cid': "1IR72HYS6JHXAVY4UG750ZKBRF3Y7QN2",
  };
  var message = "";
  String fcmToken = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var loggedIn = await SharedPrefsHelper.getBool('loggedIn');
      if (loggedIn == true && mounted) {
        Navigator.pushNamed(context, '/home');
        return;
      } else {
        await startOtpLess();
      }
    });
  }

  Future<void> startOtpLess() async {
    await _otplessFlutterPlugin.openLoginPage(
      (result) async {
        if (result['data'] != null) {
          String phoneNumber = result['data']['identities'][0]['identityValue']
              .toString()
              .substring(2);
          SharedPrefsHelper.setString('phone', phoneNumber);
        } else {
          message = result['errorMessage'];
          if (context.mounted && message == "user cancelled") {
            Navigator.pushNamed(context, '/');
          }
        }
      },
      arg,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(11, 102, 195, 1),
        extendBody: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromRGBO(11, 102, 195, 1),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const AppTitle(
                  firstName: "E - Commerce",
                  secondName: "",
                  firstColor: Colors.black,
                  fontSize: 40,
                ),
                const Iconify(MaterialSymbols.check_circle_outline,
                    color: Colors.white, size: 150),
                const SizedBox(height: 50),
                Text(
                  "verified successfully",
                  style: GoogleFonts.figtree(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 200),
                Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: MaterialButton(
                        height: MediaQuery.of(context).size.height * 0.06,
                        color: Colors.green,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ProductPage(),
                              ));
                        },
                        disabledColor: Colors.grey,
                        disabledTextColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: const Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Continue",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 10),
                            Iconify(
                              MaterialSymbols.check_circle_rounded,
                              color: Colors.white,
                              size: 18,
                            )
                          ],
                        )),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
