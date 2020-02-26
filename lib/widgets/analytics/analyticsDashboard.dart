import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:monies/data/analyticsProvider.dart';
import 'package:monies/utils/formatters.dart';
import 'package:monies/widgets/categories/categoriesListItem.dart';
import 'package:monies/widgets/controls/donutChart.dart';
import 'package:monies/widgets/expenses/expensesList.dart';
import 'package:provider/provider.dart';

class AnalyticsDashboard extends StatelessWidget {
  final DateTime selectedDate;

  const AnalyticsDashboard({Key key, this.selectedDate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AnalyticsProvider>(
      builder: (context, analyticsProvider, _) {
        final sumByCategories = analyticsProvider.sumByCategory(selectedDate.month, selectedDate.year);
        return Scaffold(
          appBar: AppBar(title: Text("Analyze (${Format.monthAndYear(selectedDate)})")),
          body: Column(
            children: <Widget>[
              SizedBox(
                height: 300,
                width: 400,
                child: DonutPieChart(analyticsProvider.categoriesChartData(selectedDate.month, selectedDate.year), animate: true),
              ),
              ListView.separated(
                shrinkWrap: true,
                itemCount: sumByCategories.length,
                separatorBuilder: (context, index) => Divider(height: 0),
                itemBuilder: (context, index) {
                  final item = sumByCategories.elementAt(index);
                  return InkWell(
                    child: CategoriesListItem(
                      category: item.category,
                      trailing: Text(Format.money(item.sum)),
                    ),
                    onTap: () => Navigator.push(
                        context, MaterialPageRoute(builder: (context) => ExpensesList(selectedDate: selectedDate, categoryFilter: item.category.id))),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}