import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:tharacart_web/sidemenu.dart';
import 'package:tharacart_web/tabs/dashboard/dashboard.dart';
import 'package:tharacart_web/tabs/manage/manage.dart';
import 'package:tharacart_web/tabs/orders/b2b/b2bOrders.dart';
import 'package:tharacart_web/tabs/orders/b2c/b2cOrders.dart';
import 'package:tharacart_web/tabs/orders/failedOrders.dart';
import 'package:tharacart_web/tabs/orders/orders.dart';
import 'package:tharacart_web/tabs/orders/returnOrders.dart';
import 'package:tharacart_web/tabs/products/addBrands.dart';
import 'package:tharacart_web/tabs/products/addProducts.dart';
import 'package:tharacart_web/tabs/products/category.dart';
import 'package:tharacart_web/tabs/products/productList.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(vsync: this, length: 10, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ResponsiveBuilder(
        builder: (context, sizingInformation) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SideMenu(tabController: _tabController,),
              Expanded(
                child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: _tabController,
                    children: [
                      Dashboard(),//0
                      Manage(),//1
                      B2COrders(),//2
                      B2BOrders(),//3
                      ReturnOrders(),//4
                      FailedOrders(),//5
                      AddProduct(),//6
                      ProductList(),//7
                      AddCategory(),//8
                      AddBrand()//9
                    ]),
              )
            ],
          );
        },
      ),
    );
  }
}
