import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class UserShimmerListView extends StatelessWidget {
  const UserShimmerListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 20,
          );
        },
        itemCount: 10, // Number of shimmer items to show
        itemBuilder: (context, index) {
          return UserShimmerItem();
        },
      ),
    );
  }
}

class UserShimmerItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 55,
            width: 55,
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.grey[300], // Placeholder color
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(width: 10), // Adjust spacing
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 20,
                  color: Colors.grey[300], // Placeholder color
                ),
                const SizedBox(height: 5),
                Container(
                  height: 15,
                  color: Colors.grey[300], // Placeholder color
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
