import 'package:flutter/material.dart';
import '../pages/login_page.dart';
import '../repositories/auth_repository.dart';

/// Banner snackbar di bagian atas layar, hilang otomatis setelah 2 detik.
void showTopSnackbar(
    BuildContext context, {
      required String title,
      required String message,
      required bool success,
    }) {
  final overlay = Overlay.of(context);
  final top = MediaQuery.of(context).padding.top + 8;

  late final OverlayEntry entry;
  entry = OverlayEntry(
    builder: (_) => Positioned(
      top: top,
      left: 16,
      right: 16,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: success ? Colors.green : Colors.red,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
              Text(message, style: const TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
    ),
  );

  overlay.insert(entry);
  Future.delayed(const Duration(seconds: 2), () {
    if (entry.mounted) entry.remove();
  });
}

/// Logout: hapus session, tampilkan snackbar, kembali ke Login.
Future<void> logout(BuildContext context) async {
  await AuthRepository().logout();
  if (!context.mounted) return;
  showTopSnackbar(
    context,
    title: 'Success!',
    message: 'Logged out Successfully',
    success: true,
  );
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (_) => const LoginPage()),
        (_) => false,
  );
}