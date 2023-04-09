import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:salonat/constants/constants.dart';
import 'package:salonat/localisation/language/language.dart';
import 'package:salonat/models/cart.dart';
import 'package:salonat/models/entity.dart';
import 'package:salonat/models/service.dart';
import 'package:salonat/services/api.dart';
import 'package:salonat/services/apiservice.dart';
import 'package:salonat/widget/column_builder.dart';
import 'package:url_launcher/url_launcher.dart';

import 'bottom_bar.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  final _cartBox = Hive.box('cart');
  final Map<String, List<ServiceModel>> _carts = {};
  bool  _isLoading = false;

  @override
  void initState() {
    _cartBox.values.forEach((element) {
      final entity = EntityModel.fromJson(element.entityType, element.entity);
      if (
          !_carts.containsKey(entity.id.toString())) {
           _carts[entity.id.toString()] = [];
      }
           _carts[entity.id.toString()].add(element);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  backgroundcolor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: whiteColor,
            size: 23,
          ),
        ),
        title: Text(
          Languages.of(context).cart,
          style: const TextStyle(
              color: whiteColor, fontSize: 24, fontFamily: 'Calibri_Bold'),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [

          _body(),
        ],
      ),
    );
  }

  Widget _body() {
    return SafeArea(
        child:
            _isLoading
        ? const Center(
          child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(primaryColor),
              ),
        )
        :
            _carts.isEmpty
        ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart, color: primaryColor, size: 50,),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    Languages.of(context).appointementsempty,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold
                    ),
                  )
                ],
              )
            )
         :   ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      physics: const BouncingScrollPhysics(),
      itemCount: _carts.keys.length,
      itemBuilder: (context, index) {
        List<ServiceModel> services = _carts[_carts.keys.toList()[index]];
        EntityModel entity = EntityModel.fromJson(
            services.first.entityType, services.first.entity);
        return _cartItem(entity, services);
      },
    ));
  }

  Widget _cartItem(EntityModel entity, List<ServiceModel> services) {
    double price = .0;
    services.forEach((element) {
      price += element.price * element.qty;
    });
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: 'https://salonat.qa/${entity.image}' ?? '',
                        errorWidget: (_, uu_, uuu) => const Icon(
                            Icons.broken_image_outlined,
                            color: blackColor),
                        width:  API.isPhone ? 100.0 : 200.0,
                        height:   API.isPhone ? 100.0 : 200.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              (Languages.of(context)
                                          .labelSelectLanguage
                                          .startsWith('En')
                                      ? entity.name
                                      : entity.nameAr) ??
                                  'N/A',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize:  API.isPhone ? 20.0 : 30.0,
                              ),
                            ),
                            if (entity.phone != null)
                              InkWell(
                                onTap: () =>
                                    launchUrl(Uri.parse('tel:${entity.phone}')),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                       Icon(
                                        Icons.phone,
                                        color: primaryColor,
                                        size: API.isPhone ? 15.0 : 20.0,
                                      ),
                                       SizedBox(
                                        width: 10,
                                      ),
                                      Text(entity.phone,style: TextStyle(
                                        color:  primaryColor,
                                        fontSize:  API.isPhone ? 20.0 : 30.0,
                                      ),),
                                    ],
                                  ),
                                ),
                              )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child:
                          Text(services.first.entityType.replaceAll('Model', ''),
                          style: TextStyle(
                            color: primaryColor,
                              fontSize: API.isPhone ? 10.0 : 20.0
                          ),),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  '${Languages.of(context).service}:',
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                      fontSize:API.isPhone ? 20.0 : 30.0

                  ).copyWith(color: blackColor),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ColumnBuilder(
                    itemCount: services.length,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Text(
                        '${services[index].qty}X ${Languages.of(context).labelSelectLanguage.startsWith('En') ? services[index].name : services[index].nameAr}',
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: API.isPhone ? 20.0 : 30.0

                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '${Languages.of(context).totalepay}  ${price.toInt()} QAR',
                      style: black10SemiBoldTextStyle.copyWith(color:
                      primaryColor),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      height:  API.isPhone ? 30.0 : 50.0,
                      minWidth:  API.isPhone ? 150.0 : 250.0,
                      onPressed: () async {
                        final schedule = await DatePicker.showDateTimePicker(
                            context,
                            currentTime: DateTime.now(),
                            theme: DatePickerTheme(
                                doneStyle: black12SemiBoldTextStyle.copyWith(
                                    color:  primaryColor, fontSize: 16)),
                            locale: Languages.of(context)
                                    .labelSelectLanguage
                                    .startsWith('En')
                                ? LocaleType.en
                                : LocaleType.ar);
                        if (schedule != null) {
                          setState(() {
                            _isLoading = true;
                            print(schedule);
                            print(schedule.hour.toString().padLeft(2, '0'));
                            print(schedule.minute.toString().padLeft(2, '0'));
                            print(schedule.year.toString());
                            print(schedule.month.toString());
                            print(schedule.day.toString());

                          });
                          final added = await WebService().addToCart(CartModel(date: schedule, services: services));
                          setState(() {
                            _isLoading = false;
                          });
                          await showSuccessDialog(success: added);
                          if (added) {
                            _deleteCarts(entity);


                          }

                        }
                      },
                      textColor: Colors.white,
                      shape: const StadiumBorder(),
                      color:  primaryColor,
                      child: Text(Languages.of(context).schedule,
                      style: TextStyle(
                        fontSize: API.isPhone ? 10.0 : 20.0
                      ),),
                    )
                  ],
                ),
              ],
            ),
            Positioned(
              right: Languages.of(context).labelSelectLanguage.startsWith('En') ? .0 : null,
              left : Languages.of(context).labelSelectLanguage.startsWith('En') ? null : .0,
              top: .0,
              child: InkWell(
                onTap: () {
                  Get.dialog(
                      AlertDialog(
                      backgroundColor: whiteColor,
                      content: Text(Languages.of(context).confirmDeleteAppointment,style: TextStyle(
                       color: primaryColor,fontWeight: FontWeight.bold
                    ),),
                      actions: [
                      TextButton(
                          onPressed: Get.back,
                          child: Text(Languages.of(context).no,style:
                        TextStyle(
                            color:primaryColor
                        ),
                      )
                      ),
                      TextButton(
                          onPressed: () {
                          _deleteCarts(entity);
                          Get.back();

                      },  child: Text(Languages.of(context).yes,style: TextStyle(
                          color: primaryColor
                      ),
                      )
                      )
                    ],
                  )
                  );
                },
                child:  Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Icon(Icons.close, color: Colors.red,size: API.isPhone ? 15.0 : 35.0,),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _deleteCarts(EntityModel entity) async {
    while (_cartBox.values.where((element) => element.entity['id'] ==
        entity.id).isNotEmpty) {
      final index = _cartBox.values.toList().indexWhere(
              (element) =>
          element.entity['id'] ==
              entity.id);
      await _cartBox.deleteAt(index);
    }

    setState(() {
      _carts.remove(entity.id.toString());
      Get.to(()=>BottomBar());
    });
  }
}
