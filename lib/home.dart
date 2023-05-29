import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:tharacart_web/sidemenu.dart';
import 'package:tharacart_web/tabs/AdminUsers/adminUsersList.dart';
import 'package:tharacart_web/tabs/b2bRequest/b2bRequest.dart';
import 'package:tharacart_web/tabs/banner/b2bBanner.dart';
import 'package:tharacart_web/tabs/banner/b2cBanner.dart';
import 'package:tharacart_web/tabs/dashboard/dashboard.dart';
import 'package:tharacart_web/tabs/deals/deals.dart';
import 'package:tharacart_web/tabs/documents/coupons.dart';
import 'package:tharacart_web/tabs/documents/orderList.dart';
import 'package:tharacart_web/tabs/logistics.dart';
import 'package:tharacart_web/tabs/manage/manage.dart';
import 'package:tharacart_web/tabs/orders/b2b/b2bOrders.dart';
import 'package:tharacart_web/tabs/orders/b2c/b2cOrders.dart';
import 'package:tharacart_web/tabs/orders/failedOrders/failedOrders.dart';
import 'package:tharacart_web/tabs/orders/orders.dart';

import 'package:tharacart_web/tabs/orders/quotation/quotationList.dart';
import 'package:tharacart_web/tabs/orders/returnOrders/returnOrders.dart';
import 'package:tharacart_web/tabs/products/addBrand/addBrands.dart';
import 'package:tharacart_web/tabs/products/addBrand/brandList.dart';
import 'package:tharacart_web/tabs/products/addCategory/categoryList.dart';
import 'package:tharacart_web/tabs/products/addProducts/addProducts.dart';
import 'package:tharacart_web/tabs/products/addCategory/category.dart';
import 'package:tharacart_web/tabs/products/addProducts/productList.dart';
import 'package:tharacart_web/tabs/refferralRequest/refferralRequest.dart';
import 'package:tharacart_web/tabs/reports/b2bReports.dart';
import 'package:tharacart_web/tabs/reports/b2c/b2cReports.dart';
import 'package:tharacart_web/tabs/settings/addAnnouncement.dart';
import 'package:tharacart_web/tabs/settings/addContact.dart';
import 'package:tharacart_web/tabs/settings/addNotification.dart';
import 'package:tharacart_web/tabs/settings/group/addGroup.dart';
import 'package:tharacart_web/tabs/settings/medal.dart';
import 'package:tharacart_web/tabs/settings/runningMessage.dart';
import 'package:tharacart_web/tabs/settings/smtp.dart';
import 'package:tharacart_web/tabs/settings/survey/addSurvey.dart';
import 'package:tharacart_web/tabs/settings/survey/surveyList.dart';
import 'package:tharacart_web/tabs/users/deletedUsers/deletedUsers.dart';
import 'package:tharacart_web/tabs/users/users/Users.dart';


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
    _tabController = TabController(vsync: this, length: 32, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    final sWidth=MediaQuery.of(context).size.width;
    return sWidth>768? Scaffold(
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
                      //dashBoard select- tab 0
                      Dashboard(),//0
                      //Orders- select tab 1
                      B2COrders(),//1
                      B2BOrders(),//2
                      ReturnOrders(),//3
                      FailedOrders(), //4
                      QuotationList(),//5
                      //Products- select tab 2
                      AddProduct(),//6
                      ProductList(),//7
                      AddCategory(),//8
                      CatoryList(),//9
                      AddBrand(),//10
                      BrandList(),//11
                      //banner- select tab 3
                      AddB2bBanner(),//12
                      B2cBanner(),//13
                      //adminusers- select tab 4
                      AdminUsers(),//14
                      //users- select tab 5
                      Users(),//15
                      DeletedUsers(),//16
                      //b2bRequest - select tab 6
                      B2bRequest(),//17
                      //logistics - select tab 7
                      Logistics(),//18
                      //refferral Request - select tab 8
                      RefferralRequestList(),//19
                      //Documents - select tab 9
                      Coupons(),//20
                      //reprts select tap 10
                      B2cReports(),//21
                      B2bReports(),//22
                      //settings select tap 11
                      AddGroupWidget(),//23
                      SMTP(),//24
                      Medal(),//25
                      AddMessage(),//26
                      AddContact(),//27
                      AddNotification(),//28
                      AddAnnoucement(),//29
                      AddSurvey(),//30
                      SurveyList(),//31
                    ]),
              )
            ],
          );
        },
      ),
    ):SizedBox();
  }
}
