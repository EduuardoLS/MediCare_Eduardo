import 'package:flutter/material.dart';

class CartaoHorizontal extends StatelessWidget {
  final String label;
  final String imgPath;

  const CartaoHorizontal({
    super.key, 
    required this.label, 
    required this.imgPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      margin: const EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: AssetImage(imgPath), 
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 0, left: 0, right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.85), 
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15), 
                  bottomRight: Radius.circular(15),
                )
              ),
              child: Text(
                label, 
                textAlign: TextAlign.center, 
                style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}