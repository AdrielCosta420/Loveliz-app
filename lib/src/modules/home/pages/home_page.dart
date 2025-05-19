import 'package:flutter/material.dart';

import '../../dashboard/ui/pages/dashboard_page.dart';
import '../../products/presentation/pages/collections_product_page.dart';
import '../../sales/presentation/pages/sales_page.dart';
// Removed unused import

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          onPageChanged: (page) {
            setState(() {
              _selectedIndex = page;
            });
          },
          children: const [
            DashboardPage(),
            CollectionsProductPage(),
            SalesPage(),
            Text('Relatórios'),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 75,
        child: BottomNavigationBar(
          onTap: _onTappedBar,
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag),
              label: 'Produtos',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.sell), label: 'Vendas'),
            BottomNavigationBarItem(
              icon: Icon(Icons.pie_chart),
              label: 'Relatórios',
            ),
          ],
        ),
      ),
    );
  }

  void _onTappedBar(int value) {
    setState(() {
      _selectedIndex = value;
    });
    _pageController.jumpToPage(value);
  }
}
