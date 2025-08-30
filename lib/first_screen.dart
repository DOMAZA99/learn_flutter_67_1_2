// Step 2: Install loading app screen
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:async';

// Step 3: check internet
import 'package:connectivity_plus/connectivity_plus.dart';
// Step 4: show toast massage
import 'package:fluttertoast/fluttertoast.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  void initState() {
    super.initState();

    checkInternetConnection();
  }

  // Step 3: check internet
  void checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.mobile)) {
      // Mobile network available.
      _showToast(context, "Mobile network available");
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
      // Wi-fi is available.
      // Note for Android:
      // When both mobile and Wi-Fi are turned on system will return Wi-Fi only as active network type
      _showToast(context, "Wi-fi is available");
    } else if (connectivityResult.contains(ConnectivityResult.ethernet)) {
      // Ethernet connection available.
      _showToast(context, "Ethernet connection available");
    } else if (connectivityResult.contains(ConnectivityResult.vpn)) {
      // Vpn connection active.
      // Note for iOS and macOS:
      // There is no separate network interface type for [vpn].
      // It returns [other] on any device (also simulator)
      _showToast(context, "Vpn connection active");
    } else if (connectivityResult.contains(ConnectivityResult.bluetooth)) {
      // Bluetooth connection available.
      _showToast(context, "Bluetooth connection available");
    } else if (connectivityResult.contains(ConnectivityResult.other)) {
      // Connected to a network which is not in the above mentioned networks.
      _showToast(context, "Connected to other network");
    } else if (connectivityResult.contains(ConnectivityResult.none)) {
      // No available network types
      setState(() {
        _showAlertDialog(
          context, "No internet connection", "Please check your internetconnectivity and try again.",
        );
    });
  }
}

  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple, Color.fromARGB(255, 58, 62, 183)],
          begin: FractionalOffset(0, 0),
          end: FractionalOffset(0.5, 0.6),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              './android/assets/images/screen.png',
              width: 200,
            ),
          ),

          const SizedBox(height: 20),
          const SpinKitSpinningLines(color: Colors.pinkAccent),
        ],
      ),
    );
  }
}

//step 4 : check internet
void timer(BuildContext context) {
  Timer(
    const Duration(seconds: 3),
    () => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Secondscreen()),
    ),
  );
}

//step 4 : show toast massage
void _showToast(BuildContext context, String msg) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: const Color.fromARGB(136, 76, 235, 78),
    textColor: Colors.white,
    fontSize: 24.0,
  );
  timer(context);
}

//step 4 : show toast massage

void _showAlertDialog(BuildContext context, String title, String msg) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            color: Color.fromARGB(255, 228, 13, 20),
            fontWeight: FontWeight.w500,
            fontFamily: "Alike",
          ),
        ),
        content: Text(msg),
        actions: <Widget>[
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(
                const Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "OK",
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 46, 67, 159),
                fontWeight: FontWeight.w500,
                fontFamily: "Alike",
              ),
            ),
          ),
        ],
      );
    },
  );
}

class Secondscreen extends StatelessWidget {
  const Secondscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Second Screen')),
      body: const Center(
        child: Text(
          'This is the second screen',
          style: TextStyle(
            fontSize: 24,
            color: Color.fromARGB(255, 183, 255, 0),
            fontWeight: FontWeight.w500,
            fontFamily: "Alike",
          ),
        ),
      ),
    );
  }
}
