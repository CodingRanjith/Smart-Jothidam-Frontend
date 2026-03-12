import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../widgets/auth_textfield.dart';
import '../widgets/auth_button.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/constants/app_constants.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneController = TextEditingController();

  DateTime? _selectedDob;
  TimeOfDay? _selectedBirthTime;
  final _birthPlaceController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    _birthPlaceController.dispose();
    super.dispose();
  }

  void _onRegisterPressed() {
    if (_formKey.currentState!.validate()) {
      String? birthTimeString;
      if (_selectedBirthTime != null) {
        birthTimeString = '${_selectedBirthTime!.hour.toString().padLeft(2, '0')}:${_selectedBirthTime!.minute.toString().padLeft(2, '0')}';
      }

      context.read<AuthBloc>().add(
            AuthRegisterRequested(
              name: _nameController.text.trim(),
              email: _emailController.text.trim(),
              password: _passwordController.text,
              dob: _selectedDob,
              birthTime: birthTimeString,
              birthPlace: _birthPlaceController.text.trim().isNotEmpty ? _birthPlaceController.text.trim() : null,
              phone: _phoneController.text.trim().isNotEmpty ? _phoneController.text.trim() : null,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthVerificationEmailSent) {
            Navigator.pushReplacementNamed(context, AppConstants.verifyEmailRoute);
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  AuthTextField(
                    controller: _nameController,
                    label: 'Name *',
                    validator: Validators.validateName,
                  ),
                  const SizedBox(height: 16),
                  AuthTextField(
                    controller: _emailController,
                    label: 'Email *',
                    keyboardType: TextInputType.emailAddress,
                    validator: Validators.validateEmail,
                  ),
                  const SizedBox(height: 16),
                  AuthTextField(
                    controller: _passwordController,
                    label: 'Password *',
                    obscureText: true,
                    validator: Validators.validatePassword,
                  ),
                  const SizedBox(height: 16),
                  AuthTextField(
                    controller: _confirmPasswordController,
                    label: 'Confirm Password *',
                    obscureText: true,
                    validator: (value) => Validators.validateConfirmPassword(value, _passwordController.text),
                  ),
                  const SizedBox(height: 24),
                  const Divider(),
                  const Text('Optional Information'),
                  const SizedBox(height: 16),
                  AuthTextField(
                    controller: _phoneController,
                    label: 'Phone',
                    keyboardType: TextInputType.phone,
                    validator: Validators.validatePhone,
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    title: Text(_selectedDob == null ? 'Date of Birth' : 'DOB: ${_selectedDob!.toString().split(' ')[0]}'),
                    trailing: const Icon(Icons.calendar_today),
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now().subtract(const Duration(days: 365 * 20)),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (date != null) {
                        setState(() => _selectedDob = date);
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    title: Text(_selectedBirthTime == null ? 'Birth Time' : 'Time: ${_selectedBirthTime!.format(context)}'),
                    trailing: const Icon(Icons.access_time),
                    onTap: () async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (time != null) {
                        setState(() => _selectedBirthTime = time);
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  AuthTextField(
                    controller: _birthPlaceController,
                    label: 'Birth Place',
                  ),
                  const SizedBox(height: 24),
                  AuthButton(
                    text: 'Register',
                    onPressed: _onRegisterPressed,
                    isLoading: state is AuthLoading,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account? '),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, AppConstants.loginRoute);
                        },
                        child: const Text('Login'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
