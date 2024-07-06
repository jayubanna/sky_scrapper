import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.delayed(
      Duration(seconds: 4),
      () {
        Navigator.pushReplacementNamed(context, "home_page");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2C494F),
      body:
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 200,
              child: Image.asset("asset/weather_logo.png"),
            ),
            Text("𝕎𝕖𝕒𝕥𝕙𝕖𝕣",style: TextStyle(color: Colors.white,fontSize: 30)),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}







// Column(
// mainAxisAlignment: MainAxisAlignment.center,
// crossAxisAlignment: CrossAxisAlignment.center,
// children: [
// Image.asset(
// "asset/weather_logo.png",
// height: 200,
// ),
// Container(
// padding: EdgeInsets.only(left: 500),
// width: double.infinity,
// child: Text("𝕎𝕖𝕒𝕥𝕙𝕖𝕣",style: TextStyle(color: Colors.white,fontSize: 30),),
// ),
// ],
// ),