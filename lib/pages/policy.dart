// it's okay
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trader/components/profile_widgets.dart';
import 'package:trader/pages/signup.dart';
import 'package:trader/variables/myvariables.dart';

class Policy extends StatefulWidget {
  const Policy({
    Key? key,
  }) : super(key: key);

  @override
  _PolicyState createState() => _PolicyState();
}

class _PolicyState extends State<Policy> {
  bool? _isAccepted = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(color41),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.all(width * 0.05),
            padding: EdgeInsets.all(width * 0.1),
            width: width * 0.9,
            height: height * 0.7,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color(color41),
              border: Border.all(
                color: Color(color42),
              ),
            ),
            child: ListView(
              children: [
                policyText(
                    "کاربر گرامی لطفا پس از مطالعه دقیق موارد زیر در صورت تایید بر روی دکمه ادامه بزنید"),
                policyText(
                    "تریدمستر یک اپلیکیشن خرید و فروش اینترنتی است که کاربران میتوانند کلیه کالا و خدمات مجاز مورد نظر خود را در سرتاسر کشور توسط این اپلیکیشن خریداری نمایند"),
                policyText(
                    "اپلیکیشن تریدمستر فقط و فقط با نیت خرید و فروش تمامی کالاها و خدمات مجاز و مطابق با قوانین جمهوری اسلامی ایران در جهت توسعه و گسترش روز افزون کسب کارهای کشور طراحی شده است و هرگونه تخلف و عمل مغایر با قوانین کشوری فقط و فقط متوجه فروشنده و یا خریدار متخلف است و تریدمستر تنها تامین کننده بستر خرید و فروش کالاهای مجاز میباشد"),
                policyText(
                    "در این نسخه از برنامه کابران تنها امکانات مرتبط با خرید کالا و خدمات را دارند و افتتاح مغازه برای فروش کالا و خدمات به عنوان فروشنده از طریق نسخه فروشندگان برنامه انجام میشود که توضیحات مرتبط با نحوه ثبت نام به عنوان فروشنده در اپلیکیشن مرتبط و وبسایت تریدمستر قرار داده شده است"),
                policyText("""
                  پرداخت وجه در تریدمستر از طریق کارت های بانکی و شبکه شتاب با ورود به درگاه بانکی صورت میگیرد
                    بطوری که مبلغ اجناس و پیک به حساب مغازه دار و حق واسط که درصد جزیی از مبلغ کالا است 
                    به حساب تریدمستر تا حداکثر 3 الی 4 روز کاری از طریق درگاه شاپرک صورت میگیرد
                  """),
                policyText("""
                    هزینه پیک برای تحویل کالا درصورت تمایل مغازه دار درفاکتور اجناس مغازه مربوطه اعمال میشود
                    و تحویل سفارشات و کلیه مسئولیت های مرتبط با تحویل سفارشات بر عهده مغازه دار میباشد و تریدمستر تنها فراهم آورنده زمینه خرید و فروش اجناس و خدمات میباشد
                  """),
                policyText("""
              فاکتور های خرید ابتدا در بخش اعلان ها در مرحله اول خرید ایجاد میشود و مراحل پیشرفت آن نیز قابل مشاهده است. در صورت موفقیت تهیه و ارسال فاکتور در قسمت سوابق و تاریخچه با تمامی جزییات از جمله کد پیگیری ذخیره میشود
              """),
                policyText("""
               فاکتورهای ثبت شده توسط خریداران ابتدا در بخش اعلان ها هم توسط مشتری و هم فروشنده قابل دسترس است و سپس در صورت موفق بودن پرداخت و تحویل در تاریخچه و یا سوابق قابل مشاهده است
                    لازم به ذکر است که درصورت ناموفق بودن فاکتور ها در تحویل و یا عدم وجود اجناس و خدمات از سوی فروشنده فاکتور حذف میگردد و ارجاع مبلغ برعهده خود فروشنده و پیگیری خریدار است
              """),
                policyText(
                    "مدت زمان تحویل سفارشات وابسته به نوع کالا و فروشگاهی که کابر سفارش خود را در آن ایجاد میکند میباشد و پیگیری های مرتبط با تحویل برعهده مشتری و مغازه دار میباشد"),
                policyText("دسترسی های مورد نیاز توسط اپلیکیشن تریدمستر"),
                policyText(
                    "دسترسی به موقعیت شما جهت نشان دادن نزدیک ترین مغازه‌ها"),
                policyText(
                    "دسترسی به دوربین و یا گالری شما در صورت مالکیت مغازه مجازی در این اپلیکیشن جهت انتخاب و ارسال عکس اجناس در صورت تمایل"),
                policyText("اطلاعات دریافتی خاص"),
                policyText(
                    "همچنین برای ثبت نام شما و ارتباط از طریق پیامک تریدمستر شماره موبایل و ایمیل شما را هنگام ثبت‌نام دریافت خواهد کرد"),
                policyText(
                    "درصورت ثبت مغازه برای فروش کالا و اجناس در تریدمستر شماره شبا و کارت بانکی شما برای واریز مبلغ پرداخت شده توسط مشتریان دریافت خواهد شد"),
                policyText("""
                  لازم به ذکر است که تمامی اطلاعات فوق در پایگاه داده‌های تریدمستر ذخیره خواهد شد. همچنین پسورد انتخاب شده توسط کاربر به صورت هشینگ و فقط قابل تشخیص برای خود کاربر ذخیره سازی میشود
                  """),
                policyText("""
             : ایمیل و تلفن های پشتیبانی
                    trademastercontacts@gmail.com
                    00989199882920
                    00989010352466
              """),
                policyText(
                    "به امید فردایی روشن و پیشرفت روز افزون برای تمامی کسب و کارهای کشور عزیزمان"),
              ],
            ),
          ),
          SizedBox(
            width: width * 0.9,
            height: height * 0.1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Checkbox(
                  value: _isAccepted,
                  activeColor: Color(color42),
                  onChanged: (accepted) {
                    setState(
                      () {
                        _isAccepted = accepted;
                      },
                    );
                  },
                ),
                Text(
                  "در صورت تایید قوانین و ضوابط کلیک کنید",
                  style: TextStyle(
                    color: Color(color42),
                    fontFamily: fontfamily,
                  ),
                ),
              ],
            ),
          ),
          _isAccepted == false
              ? const Center()
              : myButton(
                  width * 0.9,
                  "ادامه",
                  () {
                    Get.to(() => const Signup());
                  },
                  Color(color42),
                  Color(color42),
                  Colors.white,
                )
        ],
      ),
    );
  }

  Widget policyText(String text) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Text(
        text,
        textAlign: TextAlign.right,
        style: TextStyle(
          color: Color(color42),
          fontFamily: fontfamily,
        ),
      ),
    );
  }
}
