import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:salonat/services/apiservice.dart';
import '../models/about.dart';
import '../models/allsalonmodel.dart';
import '../models/artistmodel.dart';
import '../models/cat.dart';
import '../models/category.dart';
import '../models/clinicsmodel.dart';
import '../models/privacymodels.dart';
import '../models/salonmodels.dart';
import '../models/service_filter.dart';
import '../models/slider_model.dart';
import '../models/terms.dart';
import '../models/vendormodel.dart';

class DataReposotory with ChangeNotifier {
  final WebService webservice = WebService();
  int _salonpageindex = 0;
  int _clinicspageindex = 0;
  int _artistpageindex = 0;
  int _vendorpageindex = 0;
  bool _isloading=false;

  List<AboutModel> _about = [];
  List<PrivacyModel> _privacy = [];
  List<TermsModel> _terms = [];

  List<ClinicModel> _clinics = [];
  List<SalonModel> _salons = [];
  List<allsalonmodel> _allsalon = [];
  List<SalonModel> _salonsall = [];
  List<SalonModel> _getsalonbycatandtype = [];
  List<VendorModel> _vendors = [];
  List<ArtistModel> _artist = [];
  List<ArtistModel> _fitness = [];
  List<SliderModel> _slidersalon = [];
  List<SliderModel> _sliderartist = [];
  List<SliderModel> _slidervendor = [];
  List<SliderModel> _sliderclinics = [];
  List<ServiceFilterModel> _gategoriesbysalonid = [];
  List<Cat> _cat = [];

  List<AboutModel> get aboutlist => _about;
  List<PrivacyModel> get privacylist => _privacy;
  List<TermsModel> get termslist => _terms;


  List<ClinicModel> get clinicsList => _clinics;
  List<SliderModel> get sliders => _sliderclinics;
  List<SalonModel> get salonList => _salons;
  List<SalonModel> get salonlistall => _salonsall;

  List<SliderModel> get slidersalon => _slidersalon;
  List<ArtistModel> get artist => _artist;
  List<ArtistModel> get fitness => _fitness;
  List<SliderModel> get sliderartistlist => _sliderartist;
  List<VendorModel> get vendorList => _vendors;
  List<SliderModel> get slidervendorlist => _slidervendor;
  List<SalonModel> get salonbyid => _salons;
  List<ClinicModel> get clinicsbyid => _clinics;
  List<Cat> get categories => _cat;
  List<ServiceFilterModel> get gategoriesbysalonid => _gategoriesbysalonid;
  List<SalonModel> get getsalonbycatandtype => _getsalonbycatandtype;



  Future<void> getclinics() async {
    try {
      List<ClinicModel> cilincs = await webservice.getclinics(type: 'Clinic',page: _clinicspageindex);
      _clinics.addAll(cilincs);
      _clinicspageindex++;
      notifyListeners();
    } on Response catch (response) {
      if (kDebugMode) {
        print('Error:${response.statusMessage}');
      }
      rethrow;
    }
  }

  Future<void> getabout() async {
    try {
      List<AboutModel> about = await webservice.getcontent();
      _about.addAll(about);
      notifyListeners();
    } on Response catch (response) {
      if (kDebugMode) {
        print('Error:${response.statusMessage}');
      }
      rethrow;
    }
  }
  Future<void> getprivacy() async {
    try {
      List<PrivacyModel> about = await webservice.getcontentprivacy();
      _privacy.addAll(about);
      notifyListeners();
    } on Response catch (response) {
      if (kDebugMode) {
        print('Error:${response.statusMessage}');
      }
      rethrow;
    }
  }
  Future<void> getterms() async {
    try {
      List<TermsModel> about = await webservice.getcontentterms();
      _terms.addAll(about);
      notifyListeners();
    } on Response catch (response) {
      if (kDebugMode) {
        print('Error:${response.statusMessage}');
      }
      rethrow;
    }
  }

  Future<void> getcategories() async {
    try {
      List<Cat> categories = await webservice.getcategory();
      _cat.addAll(categories);
      notifyListeners();
    } on Response catch (response) {
      if (kDebugMode) {
        print('Error:${response.statusMessage}');
      }
      rethrow;
    }
  }

  Future<void> getsliderclinics() async {
    try {
      List<SliderModel> sliders = await webservice.getclinicssliders(0);
      _sliderclinics.addAll(sliders);
      notifyListeners();
    } on Response catch (response) {
      if (kDebugMode) {
        print('Error:${response.statusMessage}');
      }
      rethrow;
    }
  }

  Future<void> getsalonlist() async {
    try {
      List<SalonModel> salons = await webservice.getsalon(type: 'Salon', page: _salonpageindex);
      _salons.addAll(salons);
      print('salon isss   ${_salons.length}');
      _salonpageindex++;
      notifyListeners();
    } on Response catch (response) {
      if (kDebugMode) {
        print('Error:${response.statusMessage}');
      }
      rethrow;
    }
  }
  Future<void> getsalonlistbycategoryandtype(String type,String category) async {
    try {
      List<SalonModel> salons = await webservice.
      getsalonbycategoryandtype(type: type, category:category );
      _salons.addAll(salons);
      print('salon isss   ${_salons[0].name}');
      _salonpageindex=_salonpageindex+1;
      notifyListeners();
    } on Response catch (response) {
      if (kDebugMode) {
        print('Error:${response.statusMessage}');
      }
      rethrow;
    }
  }


  Future<void> getslidersalon() async {
    try {
      List<SliderModel> sliders = await webservice.getslidersalon(0);
      _slidersalon.addAll(sliders);
      notifyListeners();
    } on Response catch (response) {
      if (kDebugMode) {
        print('Error:${response.statusMessage}');
      }
      rethrow;
    }
  }

  Future<void> getartists() async {
    try {
      List<ArtistModel> artist = await webservice.getartist(type: 'Artist',);
      _artist.addAll(artist);

      notifyListeners();
    } on Response catch (response) {
      if (kDebugMode) {
        print('Error:${response.statusMessage}');
      }
      rethrow;
    }
  }
  Future<void> getfitness() async {
    try {
      List<ArtistModel> fitness =
      await webservice.getfitness(type: 'Fitness',);
      _fitness.addAll(fitness);

      notifyListeners();
    } on Response catch (response) {
      if (kDebugMode) {
        print('Error:${response.statusMessage}');
      }
      rethrow;
    }
  }

  Future<void> getsliderartists() async {
    try {
      List<SliderModel> sliders = await webservice.getindividualslider(0);
      _sliderartist.addAll(sliders);
      notifyListeners();
    } on Response catch (response) {
      if (kDebugMode) {
        print('Error:${response.statusMessage}');
      }
      rethrow;
    }
  }

  Future<void> getvendors() async {
    try {
      List<VendorModel> vendor = await webservice.getvendor(type: 'Vendor',);
      _vendors.addAll(vendor);
      //_vendorpageindex++;
      notifyListeners();
    } on Response catch (response) {
      if (kDebugMode) {
        print('Error:${response.statusMessage}');
      }
      rethrow;
    }
  }

  Future<void> getslidervendor() async {
    try {
      List<SliderModel> sliders = await webservice.getvendorsslider(0);
      _slidervendor.addAll(sliders);
      notifyListeners();
    } on Response catch (response) {
      if (kDebugMode) {
        print('Error:${response.statusMessage}');
      }
      rethrow;
    }
  }

/*  Future<void> getsalonbyid() async {
    try {
      List<SalonModel> salon = await webservice.getEntityById();
      _salons.addAll(salon);
      notifyListeners();
    } on Response catch (response) {
      if (kDebugMode) {
        print('Error:${response.statusMessage}');
      }
      rethrow;
    }
  }*/

  Future<void> getclinicsbyid() async {
    try {
      List<ClinicModel> clinic = await webservice.getclinicsbyid();
      _clinics.addAll(clinic);
      notifyListeners();
    } on Response catch (response) {
      if (kDebugMode) {
        print('Error:${response.statusMessage}');
      }
      rethrow;
    }
  }

  Future<void> getcategorybysalonid() async {
    try {
      List<ServiceFilterModel> categorie =
          await webservice.getcategorybysalonid();
      _gategoriesbysalonid.addAll(categorie);
      notifyListeners();
    } on Response catch (response) {
      if (kDebugMode) {
        print('Error:${response.statusMessage}');
      }
      rethrow;
    }
  }

  Future<void> initData() async {

    await Future.wait([

      getcategories(),
      getclinics(),
      getsliderclinics(),
      getslidervendor(),
      getvendors(),
      getsalonlist(),
      getslidersalon(),
      getartists(),
      getfitness(),
      getsliderartists(),
      getabout(),
      getprivacy(),
      getterms(),



    ]);
  }
}
