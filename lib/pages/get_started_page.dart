import 'package:flutter/material.dart';

//* Starting Page :D
class GetStartedPage extends StatelessWidget {
  const GetStartedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color(0xff75B6F0),
        body: Stack(children: [
          Positioned(
            bottom: -MediaQuery.of(context).size.height * 0.2,
            left: -MediaQuery.of(context).size.width * 0.2,
            child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.8,
                decoration: const BoxDecoration(
                    color: Color(0XFFA3CEF5), shape: BoxShape.circle)),
          ),
          Positioned(
            top: -MediaQuery.of(context).size.height * 0.2,
            right: -MediaQuery.of(context).size.width * 0.2,
            child: Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.height * 0.6,
                decoration: const BoxDecoration(
                    color: Color(0XFFA3CEF5), shape: BoxShape.circle)),
          ),
          Positioned(
            top: kToolbarHeight * 2,
            right: 30.0,
            left: 30.0,
            child: Column(children: const [
              Text(
                "LOOK FOR YOUR UNIQUE STYLE",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 36.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                "There are many choices of products with various styles and needs",
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
            ]),
          ),
          Positioned(
            bottom: 40.0,
            right: 30.0,
            left: 30.0,
            child: InkWell(
              onTap: () => Navigator.of(context)
                  .pushNamedAndRemoveUntil("auth", (route) => false),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.1,
                decoration: BoxDecoration(
                  border: Border.all(width: 2.0, color: Colors.white),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: const Center(
                  child: Text(
                    " Get Started",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ]),
      );
}
