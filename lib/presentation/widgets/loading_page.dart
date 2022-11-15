import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Lottie.asset(
            'assets/lottie/loader_small.json',
            width: 150,
            height: 150,
          ),
        )
      ],
    );
  }
}


// return Scaffold(
//       backgroundColor: Theme.of(context).primaryColor,
//       body: Container(
//         padding: const EdgeInsets.all(kPadding * 2),
//         decoration: BoxDecoration(
//           borderRadius: const BorderRadius.vertical(
//             top: Radius.circular(kBodyRadius),
//           ),
//           color: MyTheme.of(context).whiteColor,
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Center(
//               child: Lottie.asset(
//                 'assets/lottie/loader_small.json',
//                 width: 150,
//                 height: 150,
//               ),
//             )
//           ],
//         ),
//       ),
//     );