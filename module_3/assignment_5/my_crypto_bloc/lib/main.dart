import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:my_crypto_bloc/injection_container.dart';
import 'package:my_crypto_bloc/ui/home/home_screen.dart';
import 'package:my_crypto_bloc/ui/search/bloc/search_crypto_bloc.dart';

void main() {
  initKiwi();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late SearchCryptoBloc _searchCryptoBloc;

  @override
  void initState() {
    _searchCryptoBloc = kiwi.KiwiContainer().resolve<SearchCryptoBloc>();
    super.initState();
  }

  @override
  void dispose() {
    _searchCryptoBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchCryptoBloc>(
      create: (context) => _searchCryptoBloc,
      child: MaterialApp(
        title: 'My Crypto',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: const HomeScreen(),
      ),
    );
  }
}

/// Todo 1: Import necessary packages for bloc implementation
/// 
/// - run command [ flutter pub add bloc flutter_bloc kiwi equatable ] in terminal
/// - you can verify the installed packages in [ pubspec.yaml ]

/// Todo 2: Create custom exceptions class for REST API Service
/// 
/// - create file [ data/network/exceptions.dart ]
/// - create exceptions classes

/// Todo 3: Implement the created exceptions in REST API service. 

/// Todo 4: Prepare bloc events and states for each feature
/// - total 3 features: Homepage show popular cryptos, Search cryptos, Get crypto details
/// - create a bloc for each of the feature 
