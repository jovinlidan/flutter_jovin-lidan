import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:pratikum/model/food_model.dart';
import 'package:pratikum/repositories.dart';
import 'package:pratikum/screen/foods/foods_view_model.dart';
import 'package:provider/provider.dart';

class FoodsScreen extends StatefulWidget {
  const FoodsScreen({Key? key}) : super(key: key);

  @override
  State<FoodsScreen> createState() => _FoodsScreenState();
}

class _FoodsScreenState extends State<FoodsScreen> {
  @override
  void didChangeDependencies() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Provider.of<FoodsViewModel>(context, listen: false).getAllFoods();
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.food_bank),
          onPressed: () => Navigator.pushNamed(context, '/food-counts')),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Row(
                children: const [Icon(Icons.fastfood), SizedBox(width: 16), Text('Foods')],
              ),
            ),
            ListTile(
              title: Row(
                children: const [Icon(Icons.contact_mail), SizedBox(width: 16), Text('Contacts')],
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamedAndRemoveUntil(
                    "/", (route) => route.isCurrent && route.settings.name == "/" ? false : true);
              },
            ),
            ListTile(
              title: Row(
                children: const [Icon(Icons.fastfood), SizedBox(width: 16), Text('Foods')],
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamedAndRemoveUntil("/foods",
                    (route) => route.isCurrent && route.settings.name == "/foods" ? false : true);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text(
          "Foods",
          style: TextStyle(fontSize: 20),
        ),
        centerTitle: false,
      ),
      body: Consumer<FoodsViewModel>(
        builder: ((_, value, __) => value.foods.status == ApiStatus.loading
            ? const Center(
                child: LoadingIndicator(indicatorType: Indicator.ballClipRotatePulse),
              )
            : value.foods.status == ApiStatus.error
                ? Center(child: Text("${value.foods.message}"))
                : ListView(
                    padding: const EdgeInsets.only(top: 8),
                    children: value.foods.data!.map((e) => CustomCard(food: e)).toList(),
                  )),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final Food food;
  const CustomCard({Key? key, required this.food}) : super(key: key);

  // void onNavigateContactDetailScreen(BuildContext context) async {
  //   Navigator.pushNamed(context, '/contact-detail', arguments: food.id);
  // }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      leading: CircleAvatar(
        child: Text(
          food.name.characters.first,
          style: const TextStyle(fontSize: 28, color: Colors.white),
        ),
        radius: 26,
        backgroundColor: Colors.green,
      ),
      title: Text(food.name, style: const TextStyle(fontSize: 20)),
      // onTap: () => onNavigateContactDetailScreen(context),
    );
  }
}
