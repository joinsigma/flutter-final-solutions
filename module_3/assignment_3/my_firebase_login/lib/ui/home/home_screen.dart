import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:my_firebase_login/ui/authentication_screen.dart';
import 'package:my_firebase_login/ui/logout/bloc/logout_bloc.dart';
import 'package:my_firebase_login/ui/logout/bloc/logout_event.dart';
import 'package:my_firebase_login/ui/logout/bloc/logout_state.dart';

/// Todo 23: Create home screen to display after logged in
///   - implement logout_bloc for logout feature
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late LogoutBloc _logoutBloc;

  @override
  void initState() {
    _logoutBloc = kiwi.KiwiContainer().resolve<LogoutBloc>();
    super.initState();
  }

  @override
  void dispose() {
    _logoutBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => _logoutBloc,
        child: BlocConsumer<LogoutBloc, LogoutState>(
          listener: (context, state) {
            if (state is LogoutSuccessful) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const AuthenticationScreen(),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is LogoutLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is LogoutFailed) {
              return Text(state.errorMsg);
            } else if (state is LogoutInitial) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('You have logged in'),
                    const SizedBox(height: 40.0),
                    ElevatedButton(
                      child: const Text('Logout'),
                      onPressed: () {
                        _logoutBloc.add(TriggerLogout());
                      },
                    ),
                  ],
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
