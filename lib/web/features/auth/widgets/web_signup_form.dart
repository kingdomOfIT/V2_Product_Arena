// // ignore_for_file: use_key_in_widget_constructors, prefer_typing_uninitialized_variables

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class WebSignUpForm extends StatefulWidget {
//   @override
//   State<WebSignUpForm> createState() => _WebSignUpFormState();
// }

// class _WebSignUpFormState extends State<WebSignUpForm> {
//   final TextEditingController nameController;
//   final TextEditingController surnameController;
//   final TextEditingController birthdateController;
//   final TextEditingController cityController;
//   final TextEditingController phoneController;
//   final TextEditingController emailController;
//   final TextEditingController passwordController;
//   var dropdownValue;
//   final _formKey = GlobalKey<FormState>();

//   _WebSignUpFormState(
//       {required this.nameController,
//       required this.surnameController,
//       required this.birthdateController,
//       required this.cityController,
//       required this.phoneController,
//       required this.emailController,
//       required this.passwordController});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 457,
//       child: Form(
//         key: _formKey,
//         child: Column(
//           children: [
//             //Name
//             Row(
//               children: [
//                 Expanded(
//                   child: TextFormField(
//                     cursorColor: Colors.black,
//                     decoration: InputDecoration(
//                       focusedBorder: const OutlineInputBorder(
//                         borderSide: BorderSide(
//                           color: Colors.black,
//                         ),
//                       ),
//                       focusedErrorBorder: const OutlineInputBorder(
//                         borderSide: BorderSide(
//                           color: Colors.red,
//                         ),
//                       ),
//                       border: const OutlineInputBorder(),
//                       label: Text(
//                         'Name',
//                         style: GoogleFonts.notoSans(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w700,
//                           color: const Color(
//                             0xFF605D66,
//                           ),
//                         ),
//                       ),
//                     ),
//                     controller: nameController,
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return 'Name';
//                       } else {
//                         return null;
//                       }
//                     },
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 //Surname
//                 Expanded(
//                   child: TextFormField(
//                     cursorColor: Colors.black,
//                     decoration: InputDecoration(
//                       focusedBorder: const OutlineInputBorder(
//                         borderSide: BorderSide(
//                           color: Colors.black,
//                         ),
//                       ),
//                       focusedErrorBorder: const OutlineInputBorder(
//                         borderSide: BorderSide(
//                           color: Colors.red,
//                         ),
//                       ),
//                       border: const OutlineInputBorder(),
//                       label: Text(
//                         'Surname',
//                         style: GoogleFonts.notoSans(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w700,
//                           color: const Color(
//                             0xFF605D66,
//                           ),
//                         ),
//                       ),
//                     ),
//                     controller: surnameController,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 30),
//             //Birthdate
//             TextFormField(
//               cursorColor: Colors.black,
//               decoration: InputDecoration(
//                 focusedBorder: const OutlineInputBorder(
//                   borderSide: BorderSide(
//                     color: Colors.black,
//                   ),
//                 ),
//                 focusedErrorBorder: const OutlineInputBorder(
//                   borderSide: BorderSide(
//                     color: Colors.red,
//                   ),
//                 ),
//                 border: const OutlineInputBorder(),
//                 label: Text(
//                   'Birthdate',
//                   style: GoogleFonts.notoSans(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w700,
//                     color: const Color(
//                       0xFF605D66,
//                     ),
//                   ),
//                 ),
//               ),
//               controller: birthdateController,
//             ),
//             const SizedBox(height: 30),
//             //City
//             TextFormField(
//               cursorColor: Colors.black,
//               decoration: InputDecoration(
//                 focusedBorder: const OutlineInputBorder(
//                   borderSide: BorderSide(
//                     color: Colors.black,
//                   ),
//                 ),
//                 focusedErrorBorder: const OutlineInputBorder(
//                   borderSide: BorderSide(
//                     color: Colors.red,
//                   ),
//                 ),
//                 border: const OutlineInputBorder(),
//                 label: Text(
//                   'City',
//                   style: GoogleFonts.notoSans(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w700,
//                     color: const Color(
//                       0xFF605D66,
//                     ),
//                   ),
//                 ),
//               ),
//               controller: cityController,
//             ),
//             const SizedBox(height: 30),
//             //Status
//             SizedBox(
//               height: 56,
//               child: DropdownButtonFormField<String>(
//                 value: dropdownValue,
//                 decoration: InputDecoration(
//                   focusedErrorBorder: const OutlineInputBorder(
//                     borderSide: BorderSide(
//                       color: Colors.red,
//                     ),
//                   ),
//                   border: const OutlineInputBorder(),
//                   focusedBorder: const OutlineInputBorder(
//                     borderSide: BorderSide(
//                       color: Colors.black,
//                       width: 1,
//                     ),
//                   ),
//                   hintText: 'Status',
//                   hintStyle: GoogleFonts.notoSans(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w700,
//                     color: const Color(
//                       0xFF605D66,
//                     ),
//                   ),
//                 ),
//                 dropdownColor: const Color(0xFFF3F3F9),
//                 items: ['Student', 'Employed', 'Unemployed']
//                     .map<DropdownMenuItem<String>>((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(
//                       value,
//                       style: GoogleFonts.notoSans(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w700,
//                         color: const Color(
//                           0xFF605D66,
//                         ),
//                       ),
//                     ),
//                   );
//                 }).toList(),
//                 onChanged: (String? newValue) {
//                   setState(() {
//                     dropdownValue = newValue!;
//                   });
//                 },
//               ),
//             ),

//             const SizedBox(height: 30),
//             //Phone
//             TextFormField(
//               cursorColor: Colors.black,
//               decoration: InputDecoration(
//                 focusedBorder: const OutlineInputBorder(
//                   borderSide: BorderSide(
//                     color: Colors.black,
//                   ),
//                 ),
//                 focusedErrorBorder: const OutlineInputBorder(
//                   borderSide: BorderSide(
//                     color: Colors.red,
//                   ),
//                 ),
//                 border: const OutlineInputBorder(),
//                 label: Text(
//                   'Phone(+123 00 000000)',
//                   style: GoogleFonts.notoSans(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w700,
//                     color: const Color(
//                       0xFF605D66,
//                     ),
//                   ),
//                 ),
//               ),
//               controller: phoneController,
//             ),
//             const SizedBox(height: 30),
//             //email
//             TextFormField(
//               cursorColor: Colors.black,
//               decoration: InputDecoration(
//                 focusedBorder: const OutlineInputBorder(
//                   borderSide: BorderSide(
//                     color: Colors.black,
//                   ),
//                 ),
//                 focusedErrorBorder: const OutlineInputBorder(
//                   borderSide: BorderSide(
//                     color: Colors.red,
//                   ),
//                 ),
//                 border: const OutlineInputBorder(),
//                 label: Text(
//                   'Email',
//                   style: GoogleFonts.notoSans(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w700,
//                     color: const Color(
//                       0xFF605D66,
//                     ),
//                   ),
//                 ),
//               ),
//               controller: emailController,
//             ),
//             const SizedBox(height: 30),
//             //Password
//             TextFormField(
//               cursorColor: Colors.black,
//               decoration: InputDecoration(
//                 focusedBorder: const OutlineInputBorder(
//                   borderSide: BorderSide(
//                     color: Colors.black,
//                   ),
//                 ),
//                 focusedErrorBorder: const OutlineInputBorder(
//                   borderSide: BorderSide(
//                     color: Colors.red,
//                   ),
//                 ),
//                 border: const OutlineInputBorder(),
//                 label: Text(
//                   'Password',
//                   style: GoogleFonts.notoSans(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w700,
//                     color: const Color(
//                       0xFF605D66,
//                     ),
//                   ),
//                 ),
//               ),
//               controller: passwordController,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
