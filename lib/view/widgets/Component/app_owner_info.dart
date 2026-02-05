import 'package:flutter/material.dart';

class AppOwnerInfo extends StatelessWidget {
  const AppOwnerInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 30),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// drag handle
          Center(
            child: Container(
              height: 4,
              width: 40,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),

          /// App name
          Text(
            "CityHub",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 6),

          /// short description
          Text(
            "A smart city platform connecting citizens with city services, "
                "complaints, and real-time updates.",
            style: Theme.of(context).textTheme.bodyMedium,
          ),

          const SizedBox(height: 16),

          /// divider
          Divider(color: Colors.grey.shade300),

          const SizedBox(height: 10),

          /// owner info
          _infoRow("Developer", "Aditya Kumar"),
          _infoRow("Role", "Flutter & Spring Boot Developer"),
          _infoRow("Version", "0.0.1"),

          const SizedBox(height: 20),

          /// footer
          Center(
            child: Text(
              "© 2026 CityHub",
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
