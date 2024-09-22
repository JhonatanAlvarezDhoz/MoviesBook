import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        bottom: false,
        child: LayoutBuilder(builder: (context, BoxConstraints constraints) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: constraints.maxWidth,
            child: Row(
              children: [
                SizedBox(
                  height: 50,
                  width: 50,
                  child: Image.asset("assets/images/logo.png"),
                ),
                SizedBox(
                    height: 20,
                    width: 260,
                    child: Image.asset("assets/images/title.png")),
                const Spacer(),
                // IconButton(
                //   onPressed: () {},
                //   icon: const Icon(Icons.search),
                // )
                const Icon(Icons.search)
              ],
            ),
          );
        }));
  }
}
