import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_otp_authentication/cubits/auth_cubit/auth_cubit.dart';
import 'package:flutter_bloc_otp_authentication/cubits/auth_cubit/auth_state.dart';
import 'package:flutter_bloc_otp_authentication/screens/home_screen.dart';
import 'package:flutter_bloc_otp_authentication/screens/sign_in_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: MaterialApp(
        home: BlocBuilder<AuthCubit, AuthState>(
          buildWhen: (previousState, currentState) {
            return previousState is AuthInitialState;
          },
          builder: (context, state) {
            if (state is AuthLoggedOutState) {
              return SignInScreen();
            } else if (state is AuthLoggedInState) {
              return const HomeScreen();
            } else {
              return const Scaffold(
                body: Center(
                  child: Text('hetaaaka'),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
