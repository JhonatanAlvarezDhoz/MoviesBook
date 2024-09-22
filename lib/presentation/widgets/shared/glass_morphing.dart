import 'dart:ui';

import 'package:flutter/material.dart';

class GlassMorphism extends StatelessWidget {
  final double? height;
  final double? width;

  const GlassMorphism({super.key, this.height, this.width});
  @override
  Widget build(BuildContext context) {
    Stream<String> getLoadingIcon() {
      final messages = <String>[
        ' 🍿 ',
        ' 🥤 ',
        ' 🎬 ',
        ' ✅ ',
      ];
      // return one message in interval of time
      return Stream.periodic(const Duration(milliseconds: 500), (step) {
        return messages[step];
        // Take cancel strem
      }).take(messages.length);
    }

    return Stack(
      children: [
        Center(
          child: Container(
            width: width ?? 300,
            height: height ?? 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.white.withOpacity(0.2), // Fondo translúcido
              border: Border.all(
                color: Colors.white.withOpacity(0.4), // Borde claro
                width: 1.5,
              ),
            ),
            child: Stack(
              children: [
                // Filtro de desenfoque
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                    color: Colors.transparent, // Necesario para el desenfoque
                  ),
                ),
                // Contenido del container
                Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        StreamBuilder(
                            stream: getLoadingIcon(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const Text("Esppere por favor...");
                              }

                              return Text(
                                snapshot.data!,
                                style: const TextStyle(fontSize: 120),
                              );
                            })
                      ]),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
