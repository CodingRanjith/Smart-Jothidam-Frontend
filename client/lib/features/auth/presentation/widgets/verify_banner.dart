import 'package:flutter/material.dart';

class VerifyBanner extends StatelessWidget {
  final VoidCallback onResendPressed;
  final VoidCallback onDismissPressed;

  const VerifyBanner({
    super.key,
    required this.onResendPressed,
    required this.onDismissPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      color: Colors.orange[100],
      child: Row(
        children: [
          const Icon(Icons.warning, color: Colors.orange),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Please verify your email address',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          TextButton(
            onPressed: onResendPressed,
            child: const Text('Resend'),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: onDismissPressed,
          ),
        ],
      ),
    );
  }
}
