import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class BottomNavigationbar extends StatelessWidget {
  const BottomNavigationbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: NavigationBar(
        backgroundColor: const Color.fromARGB(255, 245, 243, 243),
        elevation: 2,
        // shadowColor: Colors.grey,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        selectedIndex: 0,
        destinations: [
          NavigationDestination(
              icon: Icon(
                IconlyBold.home,
                color: Theme.of(context).primaryColor,
              ),
              label: 'Home'),
          const NavigationDestination(
              icon: Icon(
                IconlyLight.discovery,
              ),
              label: 'Discovery'),
          const NavigationDestination(
              icon: Icon(
                IconlyLight.bookmark,
              ),
              label: 'Bookmark'),
          const NavigationDestination(
            icon: Icon(
              IconlyLight.profile,
            ),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
