import 'package:flutter/material.dart';

abstract class Languages {
  static Languages of(BuildContext context) {
    return Localizations.of<Languages>(context, Languages);
  }

  String get labelSelectLanguage;

  // **********************Drawer **********************//
  String get Login_and_Signup;
  String get about;
  String get terms;
  String get privacy;
  String get JoinUs;
  String get Administartor;
  String get appointements;
  String get next;
  String get getstarted;
  String get skip;

  // **********************Home **********************//

  String get Home;
  String get Nearby;
  String get Appointements;
  String get Favorites;
  String get Profile;
  String get search_hint;
  String get search;
  String get Premium_Beauty_Clinics;
  String get Services_and_Categories;
  String get Premium_Makeup_Artist;
  String get Premium_Salon_Spa;
  String get hello;
  String get fitness;

// **********************SignIn & SignUp **********************//

  String get login;
  String get emailorpassword;
  String get password;
  String get forgetpassword;
  String get signinwith;
  String get signupnow;
  String get donthaveaccount;
  String get alredyhaveaccount;
  String get signup;
  String get repassword;
  String get creatnewaccount;
  String get name_val;
  String get email_val;
  String get mobile_val;
  String get password_val;
  String get password_confirm_val;

// **********************Detail **********************//

  String get Contact;
  String get Review;
  String get showmore;
  String get showless;
  String get service;
  String get review;
  String get gallery;
  String get openinghours;

// **********************Button **********************//

  String get Next;
  String get update_profile;
  String get update_password;

// **********************Profile**********************//

  String get account_information;
  String get notifications;
  String get logout;
  String get name;
  String get mobile;
  String get email;
  String get currentpassword;
  String get newpassword;

// **********************Date**********************//
  String get Monday;
  String get Tuesday;
  String get Wednesday;
  String get Thursday;
  String get Friday;
  String get Saturday;
  String get Sunday;

// **********************Login**********************//

  String get youneedtologin;
  String get pleasewait;
  String get pleaselogin;

// **********************Forget**********************//

  String get Send;
  String get please_enter;
  String get Verification;
  String get Confirm;
  String get resend_password;
  String get resetcodesend;
  String get ok;
  String get pleaseenter4digitcode;
  String get nowresetpassword;
  String get please_enter_new_pass;
  String get reset_pass;
  String get password_reseted;

// **********************Filter**********************//

  String get filter;
  String get rating;
  String get distance;
  String get shortby;
  String get price;
  String get max;
  String get min;
  String get fromatoz;
  String get fromztoa;
  String get costlowtohight;
  String get costhightolow;
  String get km;

// **********************Reviews**********************//

  String get feeling_about_salon;
  String get say_somthings;
  String get thanksforyoursupport;

// **********************appointements**********************//

  String get upcoming;
  String get past;

// **********************Admin**********************//

  String get revenue;
  String get order_no;
  String get active;
  String get history;
  String get status;
  String get Settings;
  String get change_msg_password;
  String get Completed;
  String get Rejected;
  String get Accepted;

// **********************Join us**********************//

  String get join_us;
  String get note;
  String get subject;
  String get pleaseenterthesubject;
  String get pleaseenternotes;
  String get thanksjoin;

// **********************Appoinyements**********************//

  String get sheduleappointements;
  String get selectspecialist;
  String get date;
  String get time;
  String get available;
  String get personne;
  String get appointementsdetails;
  String get Booknow;
  String get bookedsucces;
  String get booked;
  String get continuebooking;
  String get gotoappoin;
  String get totalepay;

// **********************Search**********************//

  String get beautyclinics;
  String get salonspa;
  String get makeupartist;
  String get appointementsempty;
  String get wearecreating;
  String get resetpasscode;

// **********************Favorites**********************//

  String get delete;
  String get remove;
  String get add;
  String get favempty;

// **********************Errors**********************//

  String get Error;
  String get nomatch;

// **********************Diffrents**********************//

  String get mobilenumber;
  String get remindme;
  String get accepted;
  String get pleaseenterthepasscode;
  String get pleasepickservice;
  String get VerifyYourAccount;
  String get resendcode;
  String get GetStarted;
  String get welcome;
  String get find;
  String get style;
  String get descriptionstyle;
  String get descriptionfind;
  String get deleteaccount;
  String get takepicture;
  String get getfromgallery;
  String get ChooseOption;
  String get Premium;
  String get noservice;
  String get selectdate;
  String get beautySupplier;
  String get updateRequired;
  String get updateNow;
  String get product;
  String get more;
  String get addcart;

  String get closed;
  String get open;

  String get cart;

  String get schedule;

  String get confirmDeleteAppointment;

  String get yes;
  String get no;

}
