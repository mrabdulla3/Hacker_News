import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hacker_news/controllers/signup_controller.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F3E8),
      body: SingleChildScrollView(
        child: GetBuilder<SignupController>(
          builder: (controller) => Form(
            key: controller.formKey,
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.1),
                // Logo
                Center(
                  child: Image.asset(
                    'assets/hackerNews.png',
                    height: screenHeight * 0.10,
                    width: screenWidth * 0.3,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),

                const Text(
                  "Create Account",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),

                SizedBox(height: screenHeight * 0.03),

                // Sign-Up Form Container
                Container(
                  width: screenWidth * 0.85,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Sign Up",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 15),
                      _buildTextField("Email", controller.mailController,
                          Icons.email, false, false,
                          keyboardType: TextInputType.emailAddress),
                      _buildTextField("Username", controller.nameController,
                          Icons.account_circle, false, false),
                      _buildTextField("Password", controller.passwordController,
                          Icons.lock, true, false),
                      _buildTextField(
                          "Confirm Password",
                          controller.confirmPasswordController,
                          Icons.lock,
                          false,
                          true),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            controller.register();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(213, 249, 92, 53),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: const Text("Create Account",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16)),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),

                SizedBox(height: screenHeight * 0.02),

                const Text("Already have an account?"),
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      IconData icon, bool isPassword, isConfirmPassword,
      {TextInputType keyboardType = TextInputType.text}) {
    return GetBuilder<SignupController>(
      builder: (con) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: TextFormField(
          controller: controller,
          obscureText: isPassword
              ? con.passwordVisible
              : (isConfirmPassword ? con.confPasswordVisible : false),
          keyboardType: keyboardType,
          decoration: InputDecoration(
            prefixIcon: Icon(icon),
            labelText: label,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      con.passwordVisible
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                    onPressed: () {
                      con.passwordTogle(con.passwordVisible);
                    },
                  )
                : (isConfirmPassword
                        ? IconButton(
                            icon: Icon(
                              con.confPasswordVisible
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                            ),
                            onPressed: () {
                              con.confPasswordTogle(con.confPasswordVisible);
                            },
                          )
                        : null
                    ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) return "$label is required";
            if (label == "Email" &&
                !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
              return "Enter a valid email";
            }

            if (label == "Mobile Number" &&
                !RegExp(r'^[0-9]{10}$').hasMatch(value)) {
              return "Enter a valid mobile number";
            }

            if (label == "Password" && value.length < 6) {
              return "Password must be at least 6 characters";
            }

            /*   if (label == "Confirm Password" && value != passwordController.text) {
              return "Passwords do not match";
            }*/

            return null;
          },
        ),
      ),
    );
  }
}
