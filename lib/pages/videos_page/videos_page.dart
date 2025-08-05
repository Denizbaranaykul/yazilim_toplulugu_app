import 'package:flutter/material.dart';
import 'package:yazilim_toplulugu_app/pages/videos_page/appbar_video_page.dart';
import 'package:yazilim_toplulugu_app/pages/videos_page/videos_page_play_card.dart';

class video_page extends StatelessWidget {
  const video_page({super.key});
  @override
  Widget build(BuildContext context) {
    List<String> youtubeLink = List.filled(21, '', growable: false);
    youtubeLink[0] =
        "https://www.youtube.com/watch?v=Zzyuj46RQq0&list=PLdIXP9DRjvBg-v84o-i3rAyPhj5llv0ii";
    youtubeLink[1] =
        "https://www.youtube.com/watch?v=_bD-a5-hNQs&list=PLdIXP9DRjvBg-v84o-i3rAyPhj5llv0ii&index=2";
    youtubeLink[2] =
        "https://www.youtube.com/watch?v=HcaaMbFGJwQ&list=PLdIXP9DRjvBg-v84o-i3rAyPhj5llv0ii&index=3";
    youtubeLink[3] =
        "https://www.youtube.com/watch?v=gvn2CDUkZR8&list=PLdIXP9DRjvBg-v84o-i3rAyPhj5llv0ii&index=4";
    youtubeLink[4] =
        "https://www.youtube.com/watch?v=pgSuZbID8fY&list=PLdIXP9DRjvBg-v84o-i3rAyPhj5llv0ii&index=5";
    youtubeLink[5] =
        "https://www.youtube.com/watch?v=UBsdhUHuUF4&list=PLdIXP9DRjvBg-v84o-i3rAyPhj5llv0ii&index=6";
    youtubeLink[6] =
        "https://www.youtube.com/watch?v=iSYX3iGbJYo&list=PLdIXP9DRjvBg-v84o-i3rAyPhj5llv0ii&index=7";
    youtubeLink[7] =
        "https://www.youtube.com/watch?v=L5jJljMS7KY&list=PLdIXP9DRjvBg-v84o-i3rAyPhj5llv0ii&index=8";
    youtubeLink[8] =
        "https://www.youtube.com/watch?v=Tx4nGxDhCVc&list=PLdIXP9DRjvBg-v84o-i3rAyPhj5llv0ii&index=9";
    youtubeLink[9] =
        "https://www.youtube.com/watch?v=1uX201lv5TU&list=PLdIXP9DRjvBg-v84o-i3rAyPhj5llv0ii&index=10";
    youtubeLink[10] =
        "https://www.youtube.com/watch?v=IXNtQHbd0Vg&list=PLdIXP9DRjvBg-v84o-i3rAyPhj5llv0ii&index=11";
    youtubeLink[11] =
        "https://www.youtube.com/watch?v=H600H7z164U&list=PLdIXP9DRjvBg-v84o-i3rAyPhj5llv0ii&index=12";
    youtubeLink[12] =
        "https://www.youtube.com/watch?v=8RmhSxaN7GQ&list=PLdIXP9DRjvBg-v84o-i3rAyPhj5llv0ii&index=13";
    youtubeLink[13] =
        "https://www.youtube.com/watch?v=-NnztOoj0dM&list=PLdIXP9DRjvBg-v84o-i3rAyPhj5llv0ii&index=14";
    youtubeLink[14] =
        "https://www.youtube.com/watch?v=-K7jEODwwFU&list=PLdIXP9DRjvBg-v84o-i3rAyPhj5llv0ii&index=15";
    youtubeLink[15] =
        "https://www.youtube.com/watch?v=IusqC2hwt3Y&list=PLdIXP9DRjvBg-v84o-i3rAyPhj5llv0ii&index=16";
    youtubeLink[16] =
        "https://www.youtube.com/watch?v=0MvehWu5jto&list=PLdIXP9DRjvBg-v84o-i3rAyPhj5llv0ii&index=17";
    youtubeLink[17] =
        "https://www.youtube.com/watch?v=T4BX1SPVp_0&list=PLdIXP9DRjvBg-v84o-i3rAyPhj5llv0ii&index=18";
    youtubeLink[18] =
        "https://www.youtube.com/watch?v=cCojeZUcWNU&list=PLdIXP9DRjvBg-v84o-i3rAyPhj5llv0ii&index=19";
    youtubeLink[19] =
        "https://www.youtube.com/watch?v=q-q4NSmoLPw&list=PLdIXP9DRjvBg-v84o-i3rAyPhj5llv0ii&index=20";
    youtubeLink[20] =
        "https://www.youtube.com/watch?v=z8GByubiLD8&list=PLdIXP9DRjvBg-v84o-i3rAyPhj5llv0ii&index=21";

    return Scaffold(
      appBar: appbar_video_page(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            play_card("vsCode kurulumu", youtubeLink[0]),
            play_card("yorum satırı ve önemi", youtubeLink[1]),
            play_card("değişkenler", youtubeLink[2]),
            play_card("veri türleri", youtubeLink[3]),
            play_card("format belirliyiciler -C", youtubeLink[4]),
            play_card("constat yapısı", youtubeLink[5]),
            play_card("aritmetik operatörler", youtubeLink[6]),
            play_card("atama operatörleri", youtubeLink[7]),
            play_card("Veri alma scanf", youtubeLink[8]),
            play_card("matematiksel fonksiyonlar", youtubeLink[9]),
            play_card("Dairenin çevresi ve alanı-örenk", youtubeLink[10]),
            play_card("Üçgenin hipotenüsü-örnek", youtubeLink[11]),
            play_card("if-else-else if", youtubeLink[12]),
            play_card(
              "Sıcaklık birimini çeviren program-örenk",
              youtubeLink[13],
            ),
            play_card("&& operatörü", youtubeLink[14]),
            play_card("|| operatörü", youtubeLink[15]),
            play_card("!= operatörü", youtubeLink[16]),
            play_card("Fonksiyonlara giriş", youtubeLink[17]),
            play_card("Fonksiyonlarda parametre alma", youtubeLink[18]),
            play_card("Fonksiyonlarda Return", youtubeLink[19]),
            play_card("Koşul operatörü ?", youtubeLink[20]),
          ],
        ),
      ),
    );
  }
}
