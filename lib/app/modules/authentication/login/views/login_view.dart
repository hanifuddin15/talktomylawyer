import 'package:flutter/material.dart';
import 'package:talktomylawyer/app/core/config/core_validator.dart';
import 'package:talktomylawyer/app/core/widgets/buttons/primary_button.dart';
import 'package:talktomylawyer/app/core/widgets/input_fields/primary_text_form_field.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),
                // Header
                Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.balance, // Placeholder for Scales of Justice
                        size: 64,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Welcome Back',
                        style: GoogleFonts.outfit(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1A1A1A),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        controller.isClient.value
                            ? 'Sign in as Client'
                            : 'Sign in as Lawyer',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),

                // Role Toggle
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F7FA),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildRoleButton(
                          title: 'Client',
                          isSelected: controller.isClient.value,
                          onTap: () => controller.toggleRole(true),
                        ),
                      ),
                      Expanded(
                        child: _buildRoleButton(
                          title: 'Lawyer',
                          isSelected: !controller.isClient.value,
                          onTap: () => controller.toggleRole(false),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                Form(
                  key: controller.loginFormKey,
                  child: Column(
                    children: [
                      AuthTextFormField(
                        prefixIcon: Icons.email_outlined,
                        labelText: 'Email',
                        textController: controller.userIdController,
                        validator: (value) => CoreValidator.requiredField(
                          value,
                          fieldName: 'Email',
                        ),
                      ),
                      const SizedBox(height: 20),
                      AuthTextFormField(
                        prefixIcon: Icons.lock_outline,
                        labelText: 'Password',
                        textController: controller.passwordController,
                        isPassword: controller.obscureText.value,
                        validator: CoreValidator.passwordField,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                PrimaryButton(
                  onPressed: controller.onPressedLogin,
                  text: 'Sign In',
                  // Add style customization if needed to match design
                ),

                const SizedBox(height: 24),
                Row(
                  children: [
                    const Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'or',
                        style: GoogleFonts.inter(color: Colors.grey),
                      ),
                    ),
                    const Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 24),

                OutlinedButton(
                  onPressed: controller.onPressedCreateAccount,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    side: const BorderSide(color: Color(0xFF1A237E)),
                  ),
                  child: Text(
                    'Create New Account',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1A237E),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                TextButton(
                  onPressed: controller.onPressedChangePassword,
                  child: Text(
                    'Change Password',
                    style: GoogleFonts.inter(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRoleButton({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1A237E) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : Colors.grey.shade600,
          ),
        ),
      ),
    );
  }
}
