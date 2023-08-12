import 'package:flutter/material.dart';
import 'package:food_express/widgets/edit_profile_text_filed_widget.dart';
import 'package:get/get.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';

class LocationPage extends StatelessWidget {
  LocationPage({super.key});

  TextEditingController deliveryAddressController = TextEditingController();
  TextEditingController contactNameController = TextEditingController();
  TextEditingController contactPhoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Dimensions.height20 * 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const AppIcon(
                    icon: Icons.arrow_back_ios_new_outlined,
                    iconColor: Colors.black,
                  ),
                ),
                BigText(
                  text: 'New Address',
                  size: 22,
                  fontWeight: FontWeight.w500,
                  color: AppColors.mainBlackColor,
                ),
                GestureDetector(
                  onTap: () {
                    Get.offNamed(RouteHelper.getInitial(3));
                  },
                  child: const AppIcon(
                    icon: Icons.check_outlined,
                    iconColor: AppColors.mainColor,
                    iconSize: 26,
                  ),
                ),
              ],
            ),
            SizedBox(height: Dimensions.height20),
            Container(
              height: 180,
              width: MediaQuery.of(context).size.width,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(width: 1, color: AppColors.mainColor)),
              child: Stack(children: [
                // GoogleMap(
                //   initialCameraPosition: const CameraPosition(target: LatLng(13.1163, 77.6353), zoom: 17),
                //   zoomControlsEnabled: false,
                //   compassEnabled: false,
                //   indoorViewEnabled: true,
                //   mapToolbarEnabled: false,
                //   onTap: (LatLng) {
                //     Get.toNamed(RouteHelper.getPickAddressMapPage(),
                //         arguments: PickAddressMap(
                //             fromSignUp: false, fromAddress: true, googleMapController: locationController.mapController));
                //   },
                //   onCameraIdle: () {
                //     locationController.updatePosition(_cameraPosition, true);
                //   },
                //   onCameraMove: ((position) => _cameraPosition),
                //   onMapCreated: (GoogleMapController controller) {
                //     locationController.setMapController(controller);
                //   },
                // )
              ]),
            ),
            SizedBox(
              height: Dimensions.height20,
            ),
            SizedBox(
                height: 50,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        //set address type
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: Dimensions.width20),
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.width20, vertical: Dimensions.height10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.radius15),
                            color: Theme.of(context).cardColor,
                            boxShadow: [
                              BoxShadow(color: Colors.grey[200]!, spreadRadius: 1, blurRadius: 5),
                            ]),
                        child: Icon(
                          index == 0
                              ? Icons.home_outlined
                              : index == 1
                                  ? Icons.work_outline
                                  : Icons.location_on_outlined,
                          color: 2 == index ? AppColors.mainColor : Theme.of(context).disabledColor,
                        ),
                      ),
                    );
                  },
                )),
            SizedBox(
              height: Dimensions.height20,
            ),
            EditProfileTextFieldWidget(hintText: 'Delivery Addresss', controller: deliveryAddressController),
            EditProfileTextFieldWidget(hintText: 'Contact Name', controller: deliveryAddressController),
            EditProfileTextFieldWidget(hintText: 'Phone', controller: deliveryAddressController),
          ],
        ),
      ),
    );
  }
}
