import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../widgets/auth_button.dart';
import '../../../../core/constants/app_constants.dart';

class VerifyEmailPage extends StatelessWidget {
  const VerifyEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Email'),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            Navigator.pushReplacementNamed(context, AppConstants.homeRoute);
          } else if (state is AuthSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.mark_email_unread,
                  size: 100,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 20),
                Text(
                  'Verify Your Email',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 16),
                const Text(
                  'We have sent a verification email to your email address. Please check your inbox and click the verification link.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                AuthButton(
                  text: 'Check Verification Status',
                  onPressed: () {
                    context.read<AuthBloc>().add(AuthVerifyEmailRequested());
                  },
                ),
                const SizedBox(height: 16),
                AuthButton(
                  text: 'Resend Verification Email',
                  onPressed: () {
                    context.read<AuthBloc>().add(AuthResendVerificationRequested());
                  },
                  isPrimary: false,
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(AuthLogoutRequested());
                    Navigator.pushReplacementNamed(context, AppConstants.loginRoute);
                  },
                  child: const Text('Back to Login'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
