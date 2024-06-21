import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:secure_access/common/utils/custom_snackbar.dart';
import 'package:secure_access/common/utils/screen_size_util.dart';

class FirstTabScreenCopy extends StatefulWidget {
  const FirstTabScreenCopy({super.key});

  @override
  State<FirstTabScreenCopy> createState() => _FirstTabScreenCopyState();
}

class _FirstTabScreenCopyState extends State<FirstTabScreenCopy> {
  @override
  Widget build(BuildContext context) {
    initializeUtilContexts(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                // image: AssetImage('assets/images/bg_ipad.png'),
                image: AssetImage('assets/images/ipad_bg.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Column(
              children: [
                const SizedBox(height: 140),
                Text(
                  'Welcome To Gegadyne Energy',
                  style: GoogleFonts.inknutAntiqua(
                    textStyle: const TextStyle(
                      color: Color.fromARGB(255, 189, 235, 137),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 90),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 50,
                    ),
                    ZoomIn(
                      duration: const Duration(seconds: 7),
                      child: Image.asset(
                        'assets/images/robo.gif',
                        height: 200,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 130),
                GlassmorphicContainer(
                  width: 300,
                  height: 120,
                  borderRadius: 18,
                  blur: 4,
                  alignment: Alignment.center,
                  border: 0,
                  linearGradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color.fromARGB(255, 243, 239, 238).withAlpha(55),
                      const Color.fromARGB(255, 133, 179, 231).withAlpha(45),
                    ],
                    stops: const [0.3, 1],
                  ),
                  borderGradient: LinearGradient(
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                    colors: [
                      const Color.fromARGB(255, 145, 176, 223).withAlpha(100),
                      const Color.fromARGB(15, 226, 216, 216).withAlpha(55),
                    ],
                    stops: const [0.06, 0.95],
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(40, 40),
                                  backgroundColor:
                                      const Color.fromARGB(255, 243, 237, 237),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                                onPressed: () async {
                                  // Add your onPressed functionality here
                                },
                                child: Text(
                                  'Check In',
                                  style: GoogleFonts.inknutAntiqua(
                                    textStyle: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(40, 40),
                                  backgroundColor:
                                      const Color.fromARGB(255, 43, 41, 41),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                                onPressed: () async {
                                  // Add your onPressed functionality here
                                },
                                child: Text(
                                  'Check Out',
                                  style: GoogleFonts.inknutAntiqua(
                                    textStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void initializeUtilContexts(BuildContext context) {
    ScreenSizeUtil.context = context;
    CustomSnackBar.context = context;
  }
}
