import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screens/sight_card.dart';

class VisitingScreen extends StatefulWidget {
  const VisitingScreen({Key? key}) : super(key: key);

  @override
  State<VisitingScreen> createState() => _VisitingScreenState();
}

class _VisitingScreenState extends State<VisitingScreen> with TickerProviderStateMixin{

  @override
  Widget build(BuildContext context) => DefaultTabController(
    length: 2,
    child: Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          'Избранное',
          style: Theme.of(context).textTheme.headline1?.copyWith(fontSize: 18),
        ),
        bottom: TabBar(
          indicatorColor: Theme.of(context).iconTheme.color,
          tabs: const [
            Tab(
              text: 'Хочу посетить',
            ),
            Tab(
              text: 'Посетил',
            )
          ],
        ),
      ),
      body: const TabBarView(
        children: [
          WantToVisitPage(),
          VisitedPage(),
        ],
      ),
    ),
  );
}

///Страница мест, которые хотелось посетить
class WantToVisitPage extends StatelessWidget {
  const WantToVisitPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)=>ListView(
    padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 30),
    children: [
      VisitCard(sight: mocks.first,planned: true,)
    ],
  );
}

///Страница посещенных мест
class VisitedPage extends StatelessWidget {
  const VisitedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)=>ListView(
    padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 30),
    children: [
      VisitCard(sight: mocks.last)
    ],
  );
}
