import 'package:flutter/material.dart';
import 'package:food_express/controller/popular_product_controller.dart';
import 'package:food_express/utils/colors.dart';
import 'package:food_express/widgets/big_text.dart';
import 'package:get/get.dart';
import '../../routes/route_helper.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_search_bar_widget.dart';
import '../../widgets/icon_and_text.dart';
import '../../widgets/small_text.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({super.key});

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(
    viewportFraction: 0.99,
  );
  TextEditingController searchBarController = TextEditingController();
  var _currentPageValue = 0.0;
  final double _scaleFactor = 0.9;
  final double _height = Dimensions.pageViewContainer;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentPageValue = pageController.page!;
        print(_currentPageValue);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: Dimensions.height15,
        ),
        AppSearchBarWidget(
          controller: searchBarController,
          hintText: 'Search food',
          icon: Icons.search,
        ),
        SizedBox(
          height: Dimensions.height15,
        ),
        SizedBox(
          height: Dimensions.pageView,
          child: PageView.builder(
            controller: pageController,
            itemCount: 2,
            itemBuilder: (context, position) {
              return _buildPageItem(position);
            },
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width10, bottom: Dimensions.height20, right: Dimensions.width10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BigText(text: "Popular Food", fontWeight: FontWeight.w500),
              SizedBox(
                width: Dimensions.width10,
              ),
              SizedBox(
                width: Dimensions.width10,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: const SmallText(text: "See all", color: AppColors.mainColor, size: 14),
              )
            ],
          ),
        ),
        GetBuilder<PopularProductController>(builder: (popularProductController) {
          return popularProductController.isloaded
              ? ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: popularProductController.popularProductList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getPopularFood(index, 'home'));
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10, bottom: Dimensions.height10),
                        child: Row(
                          children: [
                            //image section
                            Container(
                              width: Dimensions.listViewImgSize,
                              height: Dimensions.listViewImgSize,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                                  image: const DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                        "asset/indian_chicken_biriryani.jpg",
                                      ))),
                            ),
                            //text section
                            Expanded(
                              child: Container(
                                height: Dimensions.listViewTextContSize,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(Dimensions.radius20),
                                        bottomRight: Radius.circular(Dimensions.radius20)),
                                    color: Colors.white),
                                child: Padding(
                                  padding: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      BigText(text: popularProductController.popularProductList[index].name),
                                      SmallText(
                                          text: popularProductController.popularProductList[index].description.length < 24
                                              ? popularProductController.popularProductList[index].description
                                              : "One of the Popular and most rated food"),
                                      SizedBox(
                                        height: Dimensions.height20,
                                      ),
                                      const Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconAndTextWidget(
                                              icon: Icons.circle_sharp, text: "Normal", iconColor: AppColors.iconColor1),
                                          IconAndTextWidget(
                                              icon: Icons.location_on, text: "1.7km", iconColor: AppColors.iconColor2),
                                          IconAndTextWidget(
                                              icon: Icons.access_time_rounded, text: "32 min", iconColor: AppColors.iconColor2),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                )
              : const Center(child: CircularProgressIndicator());
        })
      ],
    );
  }

  Widget _buildPageItem(
    int index,
  ) {
    //Add this args -> ProductModel? popularProduct
    Matrix4 matrix = Matrix4.identity();
    if (index == _currentPageValue.floor()) {
      var currScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currentPageValue.floor() + 1) {
      var currScale = _scaleFactor + (_currentPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currentPageValue.floor() - 1) {
      var currScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.9;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
    }
    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              //Move to Popular Food
            },
            child: Container(
              height: Dimensions.pageViewContainer,
              margin: const EdgeInsets.only(left: 5, right: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius15),
                  color: const Color(0xFF69c5df),
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      "asset/indian_chicken_biriryani.jpg",
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
