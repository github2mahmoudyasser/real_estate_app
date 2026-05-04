import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBack;
  final VoidCallback? onSearch;
  final VoidCallback? onCart;

  const CustomAppBar({
    super.key,
    required this.title,
    this.onBack,
    this.onSearch,
    this.onCart,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 1);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Column(
        children: [
          AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.white,

            // 🔹 Back button with border
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: onBack ?? () => Navigator.pop(context),
                borderRadius: BorderRadius.circular(24),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: const Icon(
                    Icons.arrow_back,
                    size: 24,
                    color: Colors.black,
                  ),
                ),
              ),
            ),

            title: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            // actions: [
            //   IconButton(
            //     icon: const Icon(Icons.search, color: Colors.black),
            //     onPressed: onSearch,
            //   ),
            //   IconButton(
            //     icon: const Icon(Icons.shopping_cart_outlined,
            //         color: Colors.black),
            //     onPressed: onCart,
            //   ),
            // ],
          ),

          Container(height: 1, color: Colors.grey.shade200),
        ],
      ),
    );
  }
}
