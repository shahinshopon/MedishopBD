import 'package:flutter/material.dart';
import 'package:medishop/ResponsiveDesign/sizeconfig.dart';

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(child: Padding(
        padding:  EdgeInsets.only(left: SizeConfig.screenheight*0.02,right: SizeConfig.screenheight*0.02,top: SizeConfig.screenheight*0.04),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("১. মেডিশপবিডি কি ?",style: TextStyle(fontWeight: FontWeight.bold,fontSize: SizeConfig.screenheight*0.026),),
              Text("মেডিশপবিডি একটি ই-কমার্স এপ্লিকেশন এর মাধম্যে ঘরে বসেই আপনি ঔষুধ কিনতে পারবেন। দোকানের থেকেও কম মূল্যে আমরা ঔষুধ সরবরাহ করে থাকি।",style: TextStyle(fontSize: SizeConfig.screenheight*0.022),),
              SizedBox(height: SizeConfig.screenheight*0.01,),
              Text("২. মেডিশপবিডি এর সার্ভিসটি কোন কোন এরিয়ার জন্য ?",style: TextStyle(fontWeight: FontWeight.bold,fontSize: SizeConfig.screenheight*0.026),),
              Text("এই সার্ভিসটি এই মুহূর্তে আমরা শুধুমাত্র গাজীপুর এর জন্য নির্ধারণ করা হয়েছে।",style: TextStyle(fontSize: SizeConfig.screenheight*0.022),),
              SizedBox(height: SizeConfig.screenheight*0.01,),
              Text("৩. কিভাবে অর্ডার প্লেস করতে হয় ?",style: TextStyle(fontWeight: FontWeight.bold,fontSize: SizeConfig.screenheight*0.026),),
              Text("অর্ডার প্লেস করার জন্য আপনি আপনার পছন্দ মতো ক্যাটাগরি থেকে ঔষুধ সিলেক্ট করতে পারবেন। ঔষুধ এ  ক্লিক করার পর আপনি বেস্ট প্রাইস,ছাড়,এমআরপি,ডেসক্রিপশন দেখতে পারেন, প্লাস এবং মাইনাস ক্লিক করে আপনার দরকার অনুযায়ী কোয়ান্টিটি সিলেক্ট করতে পারবেন। এড টু কার্ট বাটন এ ক্লিক করতেই প্রোডাক্ট টি শপিং কার্ট পেজ এ এড হয়ে যাবে। হোম পেজ থেকে  এডেড টু কার্ট বাটন এ ক্লিক করে সিলেক্টেড প্রোডাক্ট ও টুটাল প্রাইস দেখতে পারবেন। প্লেস অর্ডার বাটন এ ক্লিক করলে একটি ডায়লগ শো হবে সেখানে আপনার সঠিক তথ্য গুলো দিয়ে কন্টিনিউ বাটন এ ক্লিক করলেই আপনার অর্ডার টি প্লেস হয়ে যাবে। পরবর্তীতে আমরা ফোন কল এর মাধ্যমে আপনার সাথে যোগাযোগ করবো। ",style: TextStyle(fontSize: SizeConfig.screenheight*0.022),),
              SizedBox(height: SizeConfig.screenheight*0.01,),
              Text("৪. ডেলিভারির সময় কতক্ষন ?",style: TextStyle(fontWeight: FontWeight.bold,fontSize: SizeConfig.screenheight*0.026),),
              Text("আমরা ২-৬ ঘন্টার মধ্যে ডেলিভারি দেয়ার চেষ্টা করে থাকি।",style: TextStyle(fontSize: SizeConfig.screenheight*0.022),),
              SizedBox(height: SizeConfig.screenheight*0.01,),
              Text("৫. ডেলিভারি চার্জ কত ?",style: TextStyle(fontWeight: FontWeight.bold,fontSize: SizeConfig.screenheight*0.026),),
              Text("৫০০ টাকার নিচে অর্ডার করা হলে ডেলিভারি চার্জ ২০ টাকা। ৫০০ টাকার উপরে অর্ডার করা হলে ডেলিভারি চার্জ একদম ফ্রি।",style: TextStyle(fontSize: SizeConfig.screenheight*0.022),),
              SizedBox(height: SizeConfig.screenheight*0.01,),
              Text("৬. ক্যাশব্যাক অফার ?",style: TextStyle(fontWeight: FontWeight.bold,fontSize: SizeConfig.screenheight*0.026),),
              Text("১০০০-২০০০ টাকার মধ্যে অর্ডার করা হলে ক্যাশব্যাক অফার ১০ টাকা। ২০০০-৩০০০ টাকার মধ্যে অর্ডার করা হলে ক্যাশব্যাক অফার ২০ টাকা। ৩০০০-৪০০০ টাকার মধ্যে অর্ডার করা হলে ক্যাশব্যাক অফার ৩০ টাকা। ৪০০০-৫০০০ টাকার মধ্যে অর্ডার করা হলে ক্যাশব্যাক অফার ৪০ টাকা। ৫০০০-সর্বচ্চো হলে ক্যাশব্যাক অফার ৫০ টাকা।",style: TextStyle(fontSize: SizeConfig.screenheight*0.022),),
              SizedBox(height: SizeConfig.screenheight*0.01,),
              Text("৭. অর্ডার কিভাবে ক্যানসেল করবো ?",style: TextStyle(fontWeight: FontWeight.bold,fontSize: SizeConfig.screenheight*0.026),),
              Text("অর্ডার প্লেস করার পর আমরা আপনার ফোন নাম্বার এ যোগাযোগ করে অর্ডার কনফার্ম করবো। কনফার্ম করার পরেও যদি কোনো কারনে অর্ডার ক্যানসেল করতে হয় সেক্ষেত্রে ৩০-১ ঘন্টার মধ্যে আমাদের সাথে যোগাযোগ করতে হবে।",style: TextStyle(fontSize: SizeConfig.screenheight*0.022),),
              SizedBox(height: SizeConfig.screenheight*0.07,),
            ],
          ),
        ),
      )),

    );
  }
}
