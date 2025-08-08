import 'dart:ui';
import 'package:evo/src/core/colors/app_colors.dart';
import 'package:evo/src/features/add_business/add_business_form.dart';
import 'package:evo/src/features/home/presentation/home_page.dart';
import 'package:evo/src/features/luck_items/luck_items_page.dart';
import 'package:evo/src/features/investment/investment_page.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class CustomBottomNavExact extends StatefulWidget {
  const CustomBottomNavExact({super.key});

  @override
  State<CustomBottomNavExact> createState() => _CustomBottomNavExactState();
}

class _CustomBottomNavExactState extends State<CustomBottomNavExact> {
  int selectedIndex = 0;

  final List<Widget> screens = [
    HomePage(),
    InvestmentPage(),
    LuckItemsPage(),
    AddBusinessForm(
      onSave: () {
        print('Бизнес сохранён');
      },
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        centerTitle: false,
        title: Row(
          children: [
            Text(
              "Evo",
              style: TextStyle(
                color: AppColors.grey,
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
            ),
            Spacer(),
            Image.asset("assets/logo/logo2.png", height: 70),
          ],
        ),
      ),
      extendBody: true,
      body: screens[selectedIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
        child: Row(
          children: [
            // Навбар (GNav) с blur
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: GNav(
                      gap: 8,
                      selectedIndex: selectedIndex,
                      onTabChange: (index) {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      backgroundColor: Colors.transparent,
                      color: Colors.white,
                      activeColor: Colors.white,
                      tabBackgroundColor: Colors.grey.shade600.withOpacity(0.6),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 12),
                      tabs: const [
                        GButton(icon: Icons.home, text: 'Home'),
                        GButton(icon: Icons.bar_chart, text: "Investment"),
                        GButton(icon: Icons.shopping_cart, text: "Basket"),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
            // Отдельная кнопка Settings
            GestureDetector(
              onTap: () {
                setState(() => selectedIndex = 3);
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: selectedIndex == 3
                          ? Colors.white.withOpacity(0.4)
                          : Colors.grey.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(60),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          offset: const Offset(0, 4),
                          blurRadius: 10,
                        )
                      ],
                    ),
                    child: Icon(
                      Icons.add,
                      size: 35,
                      color: selectedIndex == 3 ? Colors.black : Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
