import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:pratikum/repositories.dart';
import 'package:pratikum/screen/foods/foods_view_model.dart';
import 'package:provider/provider.dart';

class FoodCountsScreen extends StatefulWidget {
  const FoodCountsScreen({Key? key}) : super(key: key);

  @override
  State<FoodCountsScreen> createState() => _FoodCountsScreenState();
}

class _FoodCountsScreenState extends State<FoodCountsScreen> {
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
      appBar: AppBar(title: const Text("Food Counts")),
      body: Consumer<FoodsViewModel>(
        builder: (_, value, __) => value.foods.status == ApiStatus.success
            ? Center(
                child: Text(
                  "${value.foods.data?.length}",
                  style: const TextStyle(fontSize: 100),
                ),
              )
            : value.foods.status == ApiStatus.loading
                ? const Center(
                    child: LoadingIndicator(indicatorType: Indicator.ballClipRotatePulse),
                  )
                : Center(child: Text("${value.foods.message}")),
      ),
    );
  }
}
