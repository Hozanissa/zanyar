import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zanyar/admin/admin_panel.dart';
import 'package:zanyar/theme/app_theme.dart';
import 'package:zanyar/widgets/auth_toggles.dart';

import 'register_new_account.dart';
import 'reset_password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obsecureText = true;
  bool _isLoading = false;
  bool _isAdmin = false;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final adminNameController = TextEditingController();
  final adminIdController = TextEditingController();
  final adminEmailController = TextEditingController(
    text: 'hozanissa98@gmail.com',
  );
  final adminPasswordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    adminNameController.dispose();
    adminIdController.dispose();
    adminEmailController.dispose();
    adminPasswordController.dispose();
    super.dispose();
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
      );
  }

  Future<void> login() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    try {
      if (_isAdmin) {
        final name = adminNameController.text.trim();
        final id = adminIdController.text.trim();
        final email = adminEmailController.text.trim();
        final adminRef = FirebaseFirestore.instance.collection('admins').doc(email);
        final adminSnapshot = await adminRef.get();
        final adminData = adminSnapshot.data();
        if (adminData == null ||
            adminData['name'] != name ||
            adminData['id'] != id ||
            adminData['enabled'] != true) {
          _showMessage('Invalid admin name or ID.');
          return;
        }
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: adminPasswordController.text,
        );
        final adminUser = credential.user;
        if (adminUser == null || adminUser.email != email) {
          await FirebaseAuth.instance.signOut();
          _showMessage('The admin account email did not match.');
          return;
        }
        await adminRef.set({'uid': adminUser.uid}, SetOptions(merge: true));
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('userRole', 'admin');
        if (mounted) Get.offAll(() => const AdminPanel());
      } else {
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text,
        );
        final accountIsActive = await _ensureUserProfile(credential.user!);
        if (!accountIsActive) {
          await FirebaseAuth.instance.signOut();
          _showMessage('This account has been suspended. Contact support.');
          return;
        }
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('userRole', 'user');
        if (mounted) Get.offAllNamed('/homeScreen');
      }
    } on FirebaseAuthException catch (error) {
      _showMessage(error.message ?? 'Unable to sign in. Check your details.');
    } on FirebaseException catch (error) {
      _showMessage(error.message ?? 'Unable to verify admin details.');
    } catch (_) {
      _showMessage('Unable to sign in. Please try again.');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<bool> _ensureUserProfile(User user) async {
    final profile = FirebaseFirestore.instance.collection('users').doc(user.uid);
    try {
      final snapshot = await profile.get();
      if (snapshot.exists) {
        return snapshot.data()?['status'] != 'suspended';
      }

      final nameParts = (user.displayName ?? '').trim().split(RegExp(r'\s+'));
      await profile.set({
        'uid': user.uid,
        'firstName': nameParts.isEmpty ? '' : nameParts.first,
        'lastName': nameParts.length < 2 ? '' : nameParts.skip(1).join(' '),
        'phone': user.phoneNumber ?? '',
        'email': user.email ?? '',
        'status': 'active',
        'createdAt': user.metadata.creationTime == null
            ? FieldValue.serverTimestamp()
            : Timestamp.fromDate(user.metadata.creationTime!),
      });
      return true;
    } on FirebaseException catch (error) {
      // Keep login working even if profile sync is blocked by Firestore rules.
      debugPrint('Could not create user profile in Firestore: ${error.message}');
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final accent = AppTheme.teal;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Padding(
                padding: EdgeInsetsDirectional.only(end: 8, top: 4),
                child: AuthToggles(),
              ),
            ),
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'welcome_to_zanyar'.tr,
                        style: TextStyle(
                          fontSize: 16,
                          color: isDark ? Colors.grey[400] : Colors.grey[700],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'login_to_continue'.tr,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lora(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.terracotta,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'journey_starts'.tr,
                        style: TextStyle(
                          fontSize: 14,
                          color: isDark ? Colors.grey[500] : Colors.grey[600],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: accent, width: 1.2),
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                SegmentedButton<bool>(
                                  segments: [
                                    ButtonSegment(
                                      value: false,
                                      label: Text('User'),
                                      icon: const Icon(Icons.person_outline),
                                    ),
                                    ButtonSegment(
                                      value: true,
                                      label: Text('Admin'),
                                      icon: const Icon(
                                        Icons.admin_panel_settings_outlined,
                                      ),
                                    ),
                                  ],
                                  selected: {_isAdmin},
                                  onSelectionChanged: (selection) =>
                                      setState(() {
                                        _isAdmin = selection.first;
                                        _formKey.currentState?.reset();
                                      }),
                                ),
                                const SizedBox(height: 20),
                                if (_isAdmin) ...[
                                  TextFormField(
                                    controller: adminNameController,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      border: const OutlineInputBorder(),
                                      labelText: 'Admin name',
                                      prefixIcon: Icon(
                                        Icons.person,
                                        color: accent,
                                      ),
                                    ),
                                    validator: (v) =>
                                        (v == null || v.trim().isEmpty)
                                        ? 'Admin name is required.'
                                        : null,
                                  ),
                                  const SizedBox(height: 20),
                                  TextFormField(
                                    controller: adminIdController,
                                    decoration: InputDecoration(
                                      border: const OutlineInputBorder(),
                                      labelText: 'Admin ID',
                                      prefixIcon: Icon(
                                        Icons.badge,
                                        color: accent,
                                      ),
                                    ),
                                    validator: (v) =>
                                        (v == null || v.trim().isEmpty)
                                        ? 'Admin ID is required.'
                                        : null,
                                  ),
                                  const SizedBox(height: 20),
                                  TextFormField(
                                    controller: adminEmailController,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      border: const OutlineInputBorder(),
                                      labelText: 'Admin Firebase email',
                                      prefixIcon: Icon(Icons.email, color: accent),
                                    ),
                                    validator: (v) => (v == null || !GetUtils.isEmail(v.trim()))
                                        ? 'Enter the admin Firebase email.'
                                        : null,
                                  ),
                                  const SizedBox(height: 20),
                                  TextFormField(
                                    controller: adminPasswordController,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      border: const OutlineInputBorder(),
                                      labelText: 'Admin Firebase password',
                                      prefixIcon: Icon(Icons.lock, color: accent),
                                    ),
                                    validator: (v) => (v == null || v.isEmpty)
                                        ? 'Admin password is required.'
                                        : null,
                                  ),
                                ] else ...[
                                  TextFormField(
                                    controller: emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      border: const OutlineInputBorder(),
                                      hintText: 'enter_email'.tr,
                                      labelText: 'email'.tr,
                                      prefixIcon: Icon(
                                        Icons.email,
                                        color: accent,
                                      ),
                                    ),
                                    validator: (v) =>
                                        (v == null ||
                                            !GetUtils.isEmail(v.trim()))
                                        ? 'invalid_email'.tr
                                        : null,
                                  ),
                                  const SizedBox(height: 20),
                                  TextFormField(
                                    controller: passwordController,
                                    obscureText: _obsecureText,
                                    decoration: InputDecoration(
                                      border: const OutlineInputBorder(),
                                      hintText: 'enter_password'.tr,
                                      labelText: 'password'.tr,
                                      prefixIcon: Icon(
                                        Icons.lock,
                                        color: accent,
                                      ),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _obsecureText
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          color: accent,
                                        ),
                                        onPressed: () => setState(
                                          () => _obsecureText = !_obsecureText,
                                        ),
                                      ),
                                    ),
                                    validator: (v) => (v == null || v.isEmpty)
                                        ? 'password_required'.tr
                                        : null,
                                  ),
                                ],
                                const SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: _isLoading ? null : login,
                                  child: _isLoading
                                      ? const SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                          ),
                                        )
                                      : Text(
                                          'login'.tr,
                                          style: const TextStyle(
                                            color: AppTheme.terracotta,
                                          ),
                                        ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      if (!_isAdmin) ...[
                        Wrap(
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () =>
                                  Get.off(() => const RegisterNewAccount()),
                              child: Text(
                                'sign_up'.tr,
                                style: const TextStyle(
                                  color: AppTheme.terracotta,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text('to_register'.tr),
                          ],
                        ),
                        Wrap(
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text('forgot_password'.tr),
                            TextButton(
                              onPressed: () =>
                                  Get.off(() => const ResetPassword()),
                              child: Text(
                                'reset_password'.tr,
                                style: const TextStyle(
                                  color: AppTheme.terracotta,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
