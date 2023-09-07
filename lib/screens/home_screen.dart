import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_otp_authentication/cubits/auth_cubit/auth_cubit.dart';
import 'package:flutter_bloc_otp_authentication/cubits/auth_cubit/auth_state.dart';
import 'package:flutter_bloc_otp_authentication/screens/sign_in_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Home Screen',
              style: TextStyle(fontSize: 25),
            ),
            const SizedBox(height: 10),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthLoggedOutState) {
                  Navigator.popUntil(
                    context,
                    (route) => route.isFirst,
                  );
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignInScreen(),
                    ),
                  );
                }
              },
              builder: (context, state) {
                return CupertinoButton(
                  color: Colors.blue,
                  child: const Text('Log out'),
                  onPressed: () {
                    BlocProvider.of<AuthCubit>(context).logOut();
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
