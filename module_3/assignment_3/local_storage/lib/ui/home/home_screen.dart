import 'package:flutter/material.dart';
import 'package:local_storage/data/network/rest_api_service.dart';
import 'package:local_storage/ui/login/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final RestApiService _restApiService = RestApiService();
  bool isLogoutError = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
        actions: [
          GestureDetector(
            onTap: () async {
              ///Trigger logout
              final result = await _restApiService.logout();
              if (!mounted) return;
              if (result) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              } else {
                setState(() {
                  isLogoutError = true;
                });
              }
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.logout),
            ),
          )
        ],
      ),
      body: isLogoutError
          ? const Text('Unable to Logout')
          : FutureBuilder(
              future: _restApiService.pingServer(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }
                  return Center(
                    child: Text(snapshot.data!),
                  );
                } else {
                  return Container();
                }
              },
            ),
    );
  }
}
