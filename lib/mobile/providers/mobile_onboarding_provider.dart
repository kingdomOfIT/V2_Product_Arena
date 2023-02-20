import 'package:flutter/material.dart';

class MobileOnboarding with ChangeNotifier {
//   final List<String> s1 =[];
//  Future<void> submitOnboarding(List<String> s1, List<String> s2) async {
//     await signInUser();

//     try {
//       final restOperation = Amplify.API.post("/api/onboarding/submit",
//           body: HttpPayload.json({
//             "date": "Feb2023",
//             "roles": s1,
//             "answers": {
//               // answers are in the same order as questions, null if not answered
//               "0": s2[0],
//               "1": s2[1],
//               "2": s2[2],
//               "3": s2[3],
//               "4": s2[4],
//               "5": s2[5],
//               "6": s2[6],
//             },
//           }),
//           apiName: "userDataInitAlfa");
//       final response = await restOperation.response;
//       Map<String, dynamic> responseMap = jsonDecode(response.decodeBody());
//       print('POST call succeeded');
//       print(responseMap['lectures']);
//     } on ApiException catch (e) {
//       print('POST call failed: $e');
//     }
//   }

}
