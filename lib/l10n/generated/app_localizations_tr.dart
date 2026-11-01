// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appName => 'Desk Workout';

  @override
  String get languageNativeName => 'Türkçe';

  @override
  String get appTagline => 'Masanda daha iyi hareket et';

  @override
  String get splashTagline => 'Esne · Nefes al · Odaklan';

  @override
  String get navToday => 'Bugün';

  @override
  String get navExercises => 'Egzersizler';

  @override
  String get navEyes => 'Gözler';

  @override
  String get navNutrition => 'Beslenme';

  @override
  String get navProgress => 'İlerleme';

  @override
  String get onbSkip => 'Atla';

  @override
  String get onbNext => 'İleri';

  @override
  String get onbStart => 'Hadi başlayalım';

  @override
  String get onb1Title => 'Masan,\nsenin spor salonun';

  @override
  String get onb1Body => 'Gün boyu masa başında oturanlar için tasarlanmış, bilime dayalı kısa rutinler.';

  @override
  String get onb2Title => 'Ekran duruşunu\ndüzelt';

  @override
  String get onb2Body => 'Boyun, omuz, bilek ve sırt: her hareket adım adım canlandırıldı, böylece doğru yaparsın.';

  @override
  String get onb3Title => 'Gözlerini\ndinlendir';

  @override
  String get onb3Body => '20-20-20 kuralı, göz kırpma ve odak egzersizleri gözlerini dijital yorgunluktan korur.';

  @override
  String get onb4Title => 'İş gününe\nenerji ver';

  @override
  String get onb4Body => 'Suyunu takip et, kafeini kontrol altında tut ve akıllı atıştırmalıklar seç.';

  @override
  String get onbSetupTitle => 'Sana özel yapalım';

  @override
  String get onbSetupBody => 'Bunları ayarlardan istediğin zaman değiştirebilirsin.';

  @override
  String get onbGoalLabel => 'Günlük hareket hedefi';

  @override
  String get onbBreakLabel => 'Hareket hatırlatma sıklığı';

  @override
  String minutesShort(int count) {
    return '$count dk';
  }

  @override
  String everyMinutes(int count) {
    return '$count dk’da bir';
  }

  @override
  String get greetingMorning => 'Günaydın';

  @override
  String get greetingAfternoon => 'İyi günler';

  @override
  String get greetingEvening => 'İyi akşamlar';

  @override
  String get homeSubtitle => 'Hızlı bir yenilenmeye hazır mısın?';

  @override
  String get todayGoal => 'Bugünkü hedef';

  @override
  String minutesOfGoal(int done, int goal) {
    return '$goal dk’nın $done dk’sı';
  }

  @override
  String get goalReached => 'Hedefe ulaştın! 🎉';

  @override
  String streakDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count günlük seri',
      zero: 'Henüz seri yok',
    );
    return '$_temp0';
  }

  @override
  String sittingFor(String time) {
    return '$time süredir oturuyorsun';
  }

  @override
  String get timeToMove => 'Hareket zamanı! 2 dakikalık mola ver.';

  @override
  String sittingOk(String time) {
    return 'Sonraki mola önerisi: $time sonra';
  }

  @override
  String get tookBreak => 'Mola verdim';

  @override
  String get quickBreak => '2 dakikalık yenilenme';

  @override
  String get quickBreakDesc => 'Boyun, omuz, bilek ve sırt tek bir hızlı akışta.';

  @override
  String get startNow => 'Hemen başla';

  @override
  String get programs => 'Programlar';

  @override
  String get programsSubtitle => 'Her masa başı sorunu için rehberli rutinler';

  @override
  String get seeAll => 'Tümü';

  @override
  String get tipOfDay => 'Günün ipucu';

  @override
  String get waterToday => 'Bugünkü su';

  @override
  String glassesCount(int count) {
    return '$count bardak';
  }

  @override
  String glassesOfGoal(int count, int goal) {
    return '$count / $goal bardak';
  }

  @override
  String get bodyAreasTitle => 'Bir bölge seç';

  @override
  String hoursMinutes(int h, int m) {
    return '$h sa $m dk';
  }

  @override
  String get libraryTitle => 'Egzersiz kütüphanesi';

  @override
  String get librarySubtitle => 'Her hareket tıbbi kaynaklarla doğrulandı';

  @override
  String get filterAll => 'Tümü';

  @override
  String exercisesCount(int count) {
    return '$count egzersiz';
  }

  @override
  String secondsShort(int count) {
    return '$count sn';
  }

  @override
  String get howTo => 'Nasıl yapılır';

  @override
  String get proTip => 'Uzman ipucu';

  @override
  String get targetAreas => 'Hedef bölgeler';

  @override
  String get startExercise => 'Egzersize başla';

  @override
  String get sourceLabel => 'Kaynak';

  @override
  String get standingLabel => 'Ayakta';

  @override
  String get seatedLabel => 'Oturarak';

  @override
  String get safetyNote =>
      'Nazikçe hareket et ve ağrısız kal. Bir yerin acırsa dur; ağrı devam ederse bir sağlık uzmanına danış.';

  @override
  String get routineStart => 'Programa başla';

  @override
  String get routineIncludes => 'İçerik';

  @override
  String get areaNeck => 'Boyun';

  @override
  String get areaShoulders => 'Omuzlar';

  @override
  String get areaUpperBack => 'Üst sırt';

  @override
  String get areaChest => 'Göğüs';

  @override
  String get areaArms => 'Kollar';

  @override
  String get areaWrists => 'Bilekler';

  @override
  String get areaLowerBack => 'Bel';

  @override
  String get areaCore => 'Karın';

  @override
  String get areaHips => 'Kalça';

  @override
  String get areaHamstrings => 'Arka bacak';

  @override
  String get areaQuads => 'Uyluk';

  @override
  String get areaCalves => 'Baldır';

  @override
  String get areaAnkles => 'Ayak bileği';

  @override
  String get areaEyes => 'Gözler';

  @override
  String get areaLungs => 'Solunum';

  @override
  String get getReady => 'Hazırlan';

  @override
  String get upNext => 'Sıradaki';

  @override
  String get restLabel => 'Dinlen';

  @override
  String get pausedLabel => 'Duraklatıldı';

  @override
  String exerciseOf(int current, int total) {
    return '$total egzersizden $current.';
  }

  @override
  String get workoutComplete => 'Antrenman tamamlandı!';

  @override
  String get completeBody => 'Vücudun sana teşekkür ediyor. Küçük molalar büyük değişimlere dönüşür.';

  @override
  String get minutesLabel => 'Dakika';

  @override
  String get exercisesLabel => 'Egzersiz';

  @override
  String get streakLabel => 'Seri';

  @override
  String get backHome => 'Tamam';

  @override
  String get doAgain => 'Tekrar yap';

  @override
  String get exitTitle => 'Antrenman bitirilsin mi?';

  @override
  String get exitBody => 'Bu seansın ilerlemesi kaydedilmeyecek.';

  @override
  String get exitConfirm => 'Bitir';

  @override
  String get keepGoing => 'Devam et';

  @override
  String get stepsLabel => 'Adımlar';

  @override
  String get cueInhale => 'Nefes al';

  @override
  String get cueHold => 'Tut';

  @override
  String get cueExhale => 'Nefes ver';

  @override
  String get cueRelax => 'Gevşe';

  @override
  String get cueLeftSide => 'Sol taraf';

  @override
  String get cueRightSide => 'Sağ taraf';

  @override
  String get cueLook => 'Odaklan';

  @override
  String get cueBlink => 'Gözlerini kapat';

  @override
  String get eyeTitle => 'Göz ve duruş bakımı';

  @override
  String get eyeSubtitle => 'Gözlerini koru, masanı doğru kur';

  @override
  String get rule20Title => '20-20-20 zamanlayıcı';

  @override
  String get rule20Body => 'Her 20 dakikada bir, 20 saniye boyunca 6 m (20 ft) uzağa bak.';

  @override
  String get startTimer => 'Zamanlayıcıyı başlat';

  @override
  String get stopTimer => 'Durdur';

  @override
  String get nextEyeBreakIn => 'Sonraki göz molası';

  @override
  String get eyeBreakNow => 'Göz molası! Uzağa bak';

  @override
  String get eyeBreakDone => 'Harika, gözlerin dinlendi!';

  @override
  String get keepAppOpen => 'Zamanlayıcı çalışırken uygulamayı açık tut.';

  @override
  String get eyeExercises => 'Göz egzersizleri';

  @override
  String get ergoTitle => 'Ergonomik masa düzeni';

  @override
  String get ergoSubtitle => 'Küçük ayarlar, gün boyu daha az zorlanma';

  @override
  String get ergoMonitorDistance => 'Ekran 50–100 cm uzakta – yaklaşık bir kol boyu';

  @override
  String get ergoMonitorHeight => 'Ekranın üst kenarı göz hizasında ya da biraz altında';

  @override
  String get ergoElbows => 'Dirsekler vücuda yakın, 90–120° bükülü';

  @override
  String get ergoWrists => 'Bilekler düz, yere yaklaşık paralel';

  @override
  String get ergoBack => 'Sırt bel desteğiyle tamamen destekli';

  @override
  String get ergoFeet => 'Ayaklar yerde düz, dizler yaklaşık kalça hizasında';

  @override
  String get blinkFactTitle => 'Biliyor muydun?';

  @override
  String get blinkFactBody =>
      'Normalde dakikada yaklaşık 15 kez göz kırparız; ekran başında bu sayı yaklaşık yarıya düşer. Ekran başında gözlerin kurumasının nedeni budur.';

  @override
  String get eyeDisclaimer =>
      'Göz egzersizleri tıbbi tedavi değil, rahatlama rutinleridir. Şikayetler sürerse bir göz doktoruna başvur.';

  @override
  String get nutritionTitle => 'Masa başı beslenme';

  @override
  String get nutritionSubtitle => 'Öğleden sonra çöküşü olmadan dengeli enerji';

  @override
  String get waterTitle => 'Su takibi';

  @override
  String get waterBody =>
      'EFSA, tüm içecek ve yiyeceklerden günde yaklaşık 2,0 L (kadın) ile 2,5 L (erkek) su almayı önerir.';

  @override
  String get glassSize => '1 bardak = 250 ml';

  @override
  String get waterGoalLabel => 'Günlük hedef';

  @override
  String get caffeineTitle => 'Kafein kontrolü';

  @override
  String get caffeineBody =>
      'Sağlıklı yetişkinlerin çoğu için günde 400 mg’a kadar kafein güvenli kabul edilir (FDA, EFSA) – yaklaşık 4 fincan filtre kahve. Tek seferde yaklaşık 200 mg’ı aşma.';

  @override
  String get caffeineTip => 'Uykunu korumak için günün geç saatlerinde kafeinden kaçın.';

  @override
  String get snacksTitle => 'Akıllı masa atıştırmalıkları';

  @override
  String get snacksSubtitle => 'Protein + lif seni tok ve odaklı tutar';

  @override
  String get snackNuts => 'Tuzsuz kuruyemiş';

  @override
  String get snackNutsDesc => 'Küçük bir avuç – sağlıklı yağ ve protein.';

  @override
  String get snackFruit => 'Bütün meyve';

  @override
  String get snackFruitDesc => 'Elma ya da armut lif ve doğal tatlılık sağlar.';

  @override
  String get snackYogurt => 'Süzme yoğurt ve orman meyveleri';

  @override
  String get snackYogurtDesc => 'Protein ve antioksidan için sade yoğurt ve meyve.';

  @override
  String get snackVeggies => 'Sebze ve humus';

  @override
  String get snackVeggiesDesc => 'Havuç ya da salatalık çubukları ve humus.';

  @override
  String get snackEggs => 'Haşlanmış yumurta';

  @override
  String get snackEggsDesc => 'Hazırlaması kolay, kaliteli protein.';

  @override
  String get snackChickpeas => 'Kavrulmuş nohut (leblebi)';

  @override
  String get snackChickpeasDesc => 'Çıtır lif ve bitkisel protein.';

  @override
  String get habitsTitle => 'Sağlıklı çalışma alışkanlıkları';

  @override
  String get habit1Title => 'Önce su iç';

  @override
  String get habit1Body => 'Acıktın mı? Susuzluk çoğu zaman açlıkla karışır.';

  @override
  String get habit2Title => 'Masadan uzakta ye';

  @override
  String get habit2Body => 'E-postalardan uzaklaş ve farkındalıkla ye; bu aynı zamanda bir hareket molasıdır.';

  @override
  String get habit3Title => 'Atıştırmalıkları porsiyonla';

  @override
  String get habit3Body => 'Paketten doğrudan yememek için küçük porsiyonları önceden hazırla.';

  @override
  String get habit4Title => 'Şekerli içecekleri atla';

  @override
  String get habit4Body => 'Su, çay ya da kahve seç; meyve suyunu günde bir küçük bardakla sınırla.';

  @override
  String get habit5Title => 'Protein + lif';

  @override
  String get habit5Body => 'İkisini birlikte almak kan şekerini dengede, odağını keskin tutar.';

  @override
  String get habit6Title => 'Barlara dikkat';

  @override
  String get habit6Body => 'Birçok “protein” bar şeker doludur – etiketi oku.';

  @override
  String get progressTitle => 'İlerlemen';

  @override
  String get progressSubtitle => 'Süreklilik yoğunluktan iyidir';

  @override
  String get statStreak => 'Güncel seri';

  @override
  String get statBest => 'En iyi seri';

  @override
  String get statMinutes => 'Aktif dakika';

  @override
  String get statSessions => 'Seans';

  @override
  String daysCount(int count) {
    return '$count gün';
  }

  @override
  String get thisWeek => 'Bu hafta';

  @override
  String weekMinutes(int count) {
    return 'Bu hafta $count dk';
  }

  @override
  String get achievements => 'Başarılar';

  @override
  String get badgeFirst => 'İlk adım';

  @override
  String get badgeFirstDesc => 'İlk seansını tamamla';

  @override
  String get badgeStreak3 => 'Seri başladı';

  @override
  String get badgeStreak3Desc => '3 günlük seriye ulaş';

  @override
  String get badgeStreak7 => 'Durdurulamaz';

  @override
  String get badgeStreak7Desc => '7 günlük seriye ulaş';

  @override
  String get badgeSessions10 => 'Masa atleti';

  @override
  String get badgeSessions10Desc => '10 seans tamamla';

  @override
  String get badgeMinutes60 => 'Güç saati';

  @override
  String get badgeMinutes60Desc => 'Toplam 60 dakika hareket et';

  @override
  String get badgeWater => 'Su kahramanı';

  @override
  String get badgeWaterDesc => 'Bir günde 8 bardak su iç';

  @override
  String get emptyProgress => 'Serini başlatmak için ilk rutinini tamamla.';

  @override
  String get settingsTitle => 'Ayarlar';

  @override
  String get languageLabel => 'Dil';

  @override
  String get languageSystem => 'Cihaz dili';

  @override
  String get dailyGoalLabel => 'Günlük hareket hedefi';

  @override
  String get breakReminderLabel => 'Mola aralığı';

  @override
  String get breakReminderDesc => 'Bugün ekranındaki oturma sayacı tarafından kullanılır.';

  @override
  String get waterGoalSetting => 'Su hedefi';

  @override
  String get resetProgress => 'İlerlemeyi sıfırla';

  @override
  String get resetConfirmTitle => 'Tüm ilerleme sıfırlansın mı?';

  @override
  String get resetConfirmBody => 'Seriler, dakikalar ve su kayıtları silinecek.';

  @override
  String get cancel => 'Vazgeç';

  @override
  String get resetAction => 'Sıfırla';

  @override
  String get aboutTitle => 'Hakkında';

  @override
  String get aboutBody =>
      'Desk Workout, masa başı çalışanların kısa ve rehberli rutinlerle hareket etmesine, esnemesine ve gözlerini dinlendirmesine yardım eder. Tüm çizimler ve animasyonlar kodla çizilmiştir.';

  @override
  String get disclaimerTitle => 'Sağlık uyarısı';

  @override
  String get disclaimerBody =>
      'Bu uygulama genel sağlıklı yaşam bilgisi sunar ve tıbbi tavsiye değildir. Bir sakatlığın, ağrın ya da sağlık sorunun varsa bir uzmana danış.';

  @override
  String get sourcesTitle => 'Kaynaklar';

  @override
  String get sourcesBody =>
      'Mayo Clinic, Harvard Health, Cleveland Clinic, NHS, HSS, OSHA, Amerikan Oftalmoloji Akademisi, DSÖ, EFSA, FDA.';

  @override
  String versionLabel(String version) {
    return 'Sürüm $version';
  }

  @override
  String get saved => 'Kaydedildi';

  @override
  String get catNeck => 'Boyun';

  @override
  String get catNeckDesc => 'Ekran boynunu rahatlat';

  @override
  String get catShoulders => 'Omuzlar';

  @override
  String get catShouldersDesc => 'Öne düşen omuzları aç';

  @override
  String get catWrists => 'Bilek ve eller';

  @override
  String get catWristsDesc => 'Klavye ve fare kullanımı için';

  @override
  String get catBack => 'Sırt ve omurga';

  @override
  String get catBackDesc => 'Tutulmuş sırtı hareketlendir';

  @override
  String get catLegs => 'Kalça ve bacaklar';

  @override
  String get catLegsDesc => 'Kan dolaşımını canlandır';

  @override
  String get catEyes => 'Gözler';

  @override
  String get catEyesDesc => 'Dijital göz yorgunluğunu yen';

  @override
  String get catBreathing => 'Nefes';

  @override
  String get catBreathingDesc => 'Sakinleş ve yeniden odaklan';

  @override
  String get rtQuickName => '2 Dakikalık Yenilenme';

  @override
  String get rtQuickDesc => 'Toplantılar arasında mükemmel mikro mola.';

  @override
  String get rtNeckName => 'Boyun ve Omuz Rahatlatma';

  @override
  String get rtNeckDesc => 'Saatlerce ekran başında kalmanın gerginliğini erit.';

  @override
  String get rtWristName => 'Bilek ve El Bakımı';

  @override
  String get rtWristDesc => 'Gün boyu yazan ve tıklayan ellerini koru.';

  @override
  String get rtBackName => 'Bel Kurtarma';

  @override
  String get rtBackDesc => 'Omurgayı rahatlat, gergin kalçaları gevşet.';

  @override
  String get rtEyeName => 'Göz Şarjı';

  @override
  String get rtEyeDesc => 'Yorgun ve kuru ekran gözlerini tazele.';

  @override
  String get rtEnergyName => 'Enerji Patlaması';

  @override
  String get rtEnergyDesc => 'Nabzını yükselt, yorgunluğu yen.';

  @override
  String get rtPostureName => 'Duruş Düzeltme';

  @override
  String get rtPostureDesc => 'Kamburluğu düzelt, daha dik dur.';

  @override
  String get rtCalmName => 'Sakinleş';

  @override
  String get rtCalmDesc => 'Stresi sıfırlamak için nefes ve esneme.';

  @override
  String get rtFullName => 'Tam Masa Antrenmanı';

  @override
  String get rtFullDesc => 'Öğle arası için baştan ayağa eksiksiz bir seans.';

  @override
  String doseReps(int count) {
    return '$count tekrar';
  }

  @override
  String doseRepsEachSide(int count) {
    return 'Her taraf $count tekrar';
  }

  @override
  String doseHold(int count) {
    return '$count sn tut';
  }

  @override
  String doseHoldEachSide(int count) {
    return 'Her taraf $count sn tut';
  }

  @override
  String doseBreaths(int count) {
    return '$count yavaş nefes';
  }

  @override
  String doseSeconds(int count) {
    return '$count saniye';
  }

  @override
  String doseRounds(int count) {
    return '$count tur';
  }

  @override
  String get tip1 => 'Oturmayı her 30 dakikada bir böl; kısa bir yürüyüş bile kan şekerine ve tansiyonuna iyi gelir.';

  @override
  String get tip2 => 'DSÖ yetişkinler için haftada 150–300 dakika orta yoğunlukta aktivite önerir.';

  @override
  String get tip3 => 'Yaklaşık her 15 dakikada bir pozisyonunu değiştir; sadece oturuşunu değiştirmek bile işe yarar.';

  @override
  String get tip4 => 'Monitörünün üst kenarını göz hizana ya da biraz altına yerleştir.';

  @override
  String get tip5 => 'Telefon görüşmelerini ayakta yap; bedava harekettir.';

  @override
  String get tip6 => 'Masanda bir su şişesi bulundur; her doldurma bir mini moladır.';

  @override
  String get tip7 => 'Merdiveni kullan ve mesaj atmak yerine iş arkadaşına yürü.';

  @override
  String get tip8 => 'Yazarken bileklerini düz tut, dirseklerin vücuduna yakın dursun.';

  @override
  String get exChinTuckName => 'Çene Geri Çekme';

  @override
  String get exChinTuckSummary => 'Başını düz bir şekilde geriye kaydırarak “ekran boynunu” düzelt.';

  @override
  String get exChinTuckSteps =>
      'Ayakların yerde, omuzların gevşek şekilde dik otur.\nGözlerin ileriye bakarken çeneni ve başını düz bir çizgide geriye kaydır; hafif bir çift çene oluşsun.\nKafatasının alt kısmında gerilmeyi hissederek 5 saniye bekle.\nYavaşça bırak ve tekrarla.';

  @override
  String get exChinTuckTip => 'Küçük bir harekettir: başını yukarı ya da aşağı eğme.';

  @override
  String get exNeckSideTiltName => 'Boyun Yana Eğme';

  @override
  String get exNeckSideTiltSummary => 'Boynun yan kaslarındaki gerginliği azalt.';

  @override
  String get exNeckSideTiltSteps =>
      'Dik otur ve omuzlarını kulaklarından uzaklaştırarak bırak.\nYüzün karşıya bakarken bir kulağını yavaşça aynı taraftaki omzuna doğru eğ.\nSakin nefes alarak 15–30 saniye bekle.\nOrtaya dön ve diğer tarafa tekrarla.';

  @override
  String get exNeckSideTiltTip => 'Omzunu kulağına doğru kaldırma ve asla esneterek yaylanma.';

  @override
  String get exNeckRotationName => 'Boyun Döndürme';

  @override
  String get exNeckRotationSummary => 'Omzunun üzerinden rahatça bakabilme yeteneğini geri kazan.';

  @override
  String get exNeckRotationSteps =>
      'Omuzların aşağıda, dik otur ve tam karşıya bak.\nÇenen yere paralel kalarak başını rahat olduğu kadar bir omzuna doğru yavaşça çevir.\n5 saniye bekle.\nOrtaya dön ve diğer tarafa çevir.';

  @override
  String get exNeckRotationTip => 'Yavaş hareket et ve omuzlarını sabit tut.';

  @override
  String get exLevatorStretchName => 'Levator Skapula Esnetmesi';

  @override
  String get exLevatorStretchSummary => 'Boyun ile kürek kemiği arasındaki inatçı düğümü hedefle.';

  @override
  String get exLevatorStretchSteps =>
      'Esnetmek istediğin taraftaki elinle sandalyenin kenarını tut.\nBaşını o taraftan yaklaşık 45° uzağa çevir.\nKarşı koltuk altına doğru aşağı bak.\nDiğer elini hafif destek için başının arkasına koy ve bekle.';

  @override
  String get exLevatorStretchTip => 'Elin sadece başının üzerinde dursun, asla çekme.';

  @override
  String get exUpperTrapStretchName => 'Üst Trapez Esnetmesi';

  @override
  String get exUpperTrapStretchSummary => 'Stresi omuzlarında taşıyan kasları gevşet.';

  @override
  String get exUpperTrapStretchSteps =>
      'Omzunu aşağıda tutmak için esneteceğin taraftaki elinle oturağı tut.\nYüzün karşıya bakarken kulağını karşı omzuna doğru eğ.\nHafif bir baskı için karşı elini başının üstüne koy.\n10–30 saniye bekle ve taraf değiştir.';

  @override
  String get exUpperTrapStretchTip => 'Ağrı, karıncalanma ya da uyuşma hissedersen dur.';

  @override
  String get exShoulderShrugsName => 'Omuz Silkme';

  @override
  String get exShoulderShrugsSummary => 'Yorgun omuzlarını saniyeler içinde canlandır.';

  @override
  String get exShoulderShrugsSteps =>
      'Kolların gevşek şekilde sarkarken dik otur.\nİki omzunu da düz bir şekilde kulaklarına doğru kaldır.\nEn üstte 1–2 saniye bekle.\nOmuzlarını tamamen bırak ve gevşe.';

  @override
  String get exShoulderShrugsTip => 'Yuvarlamadan düz yukarı kaldır ve boynunu uzun tut.';

  @override
  String get exShoulderRollsName => 'Omuz Çevirme';

  @override
  String get exShoulderRollsSummary => 'Tüm omuz kuşağını gevşeten büyük ve yavaş daireler.';

  @override
  String get exShoulderRollsSteps =>
      'Kolların gevşek, dik otur.\nOmuzlarınla büyük daireler çiz: yukarı, geri, aşağı ve ileri.\nHer daireyi yavaş ve akıcı yap.\nTekrarların yarısından sonra yönü değiştir.';

  @override
  String get exShoulderRollsTip => 'Başını sabit tut, sadece omuzların hareket etsin.';

  @override
  String get exScapularSqueezeName => 'Kürek Kemiği Sıkıştırma';

  @override
  String get exScapularSqueezeSummary => 'Öne düşen omuzları dengele ve sırtının üst kısmını çalıştır.';

  @override
  String get exScapularSqueezeSteps =>
      'Sırtını yaslamadan dik otur, dirsekler bükülü ve yanlarında olsun.\nKürek kemiklerini geriye ve birbirine doğru, hafifçe aşağı çek.\nGöğsün açık şekilde 3–5 saniye bekle.\nYavaşça bırak.';

  @override
  String get exScapularSqueezeTip => 'Omuzlarını kaldırma ve belini çukurlaştırma.';

  @override
  String get exCrossBodyStretchName => 'Göğüs Önünden Omuz Esnetme';

  @override
  String get exCrossBodyStretchSummary => 'Uzun fare kullanımından sonra omzun arka kısmını esnet.';

  @override
  String get exCrossBodyStretchSteps =>
      'Omuzların aşağıda, dik otur.\nBir kolunu düz şekilde omuz hizasında göğsünün önünden karşıya götür.\nDiğer elinle dirseği kavra ve nazikçe kendine doğru çek.\n10–30 saniye bekle ve kol değiştir.';

  @override
  String get exCrossBodyStretchTip => 'Gövden karşıya baksın; kolla birlikte dönme.';

  @override
  String get exTricepsStretchName => 'Baş Üstü Triseps Esnetme';

  @override
  String get exTricepsStretchSummary => 'Kolun arka kısmını ve göğsün yan tarafını aç.';

  @override
  String get exTricepsStretchSteps =>
      'Bir kolunu kaldır ve dirseğini bükerek elini başının arkasına indir.\nDirseğin tavanı, avucun sırtının üst kısmını göstersin.\nDiğer elinle dirseği nazikçe geriye doğru bastır.\nHer kol için yaklaşık 20 saniye bekle.';

  @override
  String get exTricepsStretchTip => 'Başını dik tut, öne doğru itme.';

  @override
  String get exChestOpenerName => 'Oturarak Göğüs Açma';

  @override
  String get exChestOpenerSummary => 'Kamburluğu tersine çevir: göğsü ve omuzların ön kısmını aç.';

  @override
  String get exChestOpenerSteps =>
      'Oturağın ön kısmına otur ve omuzlarını aşağı ve geriye yuvarla.\nAvuçların vücuduna bakacak şekilde parmaklarını arkanda birleştir.\nKollarını düzleştir ve gerilme hissedene kadar ellerini nazikçe kaldır.\nDerin nefes alarak 10–30 saniye bekle.';

  @override
  String get exChestOpenerTip => 'Ellerini birleştiremiyorsan önkollarını ya da dirseklerini tut.';

  @override
  String get exThoracicExtensionName => 'Torakal Ekstansiyon';

  @override
  String get exThoracicExtensionSummary => 'Sertleşmiş sırt üst bölgesini sandalye sırtlığı üzerinde ters yöne esnet.';

  @override
  String get exThoracicExtensionSteps =>
      'Ayakların yerde, sırtının ortası sırtlığın üst kenarına gelecek şekilde otur.\nEllerinle enseni destekle, dirsekler önde olsun.\nGöğsünü kaldırıp yukarı bakarak sırtlığın üzerinden geriye yaslan.\n3–5 saniye bekle ve yavaşça geri gel.';

  @override
  String get exThoracicExtensionTip => 'Hareketi boyundan değil sırtın üst kısmından yap. Sağlam bir sandalye kullan.';

  @override
  String get exOverheadSideBendName => 'Baş Üstü Yana Eğilme';

  @override
  String get exOverheadSideBendSummary => 'Gövdenin yanlarını uzat ve daha derin nefes al.';

  @override
  String get exOverheadSideBendSteps =>
      'İki kalçan da oturağa basacak şekilde dik otur.\nKollarını başının üzerine kaldır ve ellerini birleştir.\nBelinden yavaşça bir yana doğru eğil.\nOrtaya dön ve diğer tarafa eğil.';

  @override
  String get exOverheadSideBendTip => 'Tek düzlemde kal: öne eğilme ve iki kalçanı da sandalyede tut.';

  @override
  String get exSpinalTwistName => 'Oturarak Omurga Burgusu';

  @override
  String get exSpinalTwistSummary => 'Omurganı hareketlendir ve tutulmuş sırtını rahatlat.';

  @override
  String get exSpinalTwistSteps =>
      'Ayakların yerde, kolların göğsünde çapraz şekilde dik otur.\nKalçaların ve dizlerin karşıya baksın.\nGövdenin üst kısmını bir yana çevir ve 5 saniye bekle.\nOrtaya dön ve diğer yöne çevir.';

  @override
  String get exSpinalTwistTip => 'Dönmeden önce omurganı uzat ve hareketin sonunu asla zorlama.';

  @override
  String get exCatCowName => 'Oturarak Kedi-İnek';

  @override
  String get exCatCowSummary => 'Nefesinle uyumlu, akıcı bir omurga dalgası.';

  @override
  String get exCatCowSteps =>
      'Ayakların yerde, ellerin uyluklarında dik otur.\nNefes al (inek): sırtını çukurlaştır, göğsünü kaldır, kürek kemiklerini birleştir.\nNefes ver (kedi): sırtını yuvarla, leğenini içeri al, çeneni göğsüne yaklaştır.\nİkisi arasında yavaşça akış sağla.';

  @override
  String get exCatCowTip => 'Çeneni öne itme ve başını geriye düşürme.';

  @override
  String get exForwardFoldName => 'Oturarak Öne Eğilme';

  @override
  String get exForwardFoldSummary => 'Sırtının rahatlamasına ve zihninin yavaşlamasına izin ver.';

  @override
  String get exForwardFoldSteps =>
      'Ayakların yerde ve aralık, dik otur.\nNefes vererek öne eğil ve önkollarını uyluklarına koy.\nBaşın, boynun ve omurgan tek uzun bir çizgi oluştursun.\nYavaşça nefes al, sonra omur omur yavaşça doğrul.';

  @override
  String get exForwardFoldTip => 'Yavaş kalk; hafif baş dönmesi hissedebilirsin.';

  @override
  String get exWristFlexorStretchName => 'Bilek Fleksör Esnetme';

  @override
  String get exWristFlexorStretchSummary => 'Gün boyu yazı yazan ve tıklayan önkollarını rahatlat.';

  @override
  String get exWristFlexorStretchSteps =>
      'Bir kolunu avucun yukarı bakacak şekilde öne doğru düz uzat.\nDiğer elinle parmakları nazikçe yere doğru çek.\nDirseğini düz tut ve 15–30 saniye bekle.\nEl değiştir.';

  @override
  String get exWristFlexorStretchTip => 'Nazikçe çek; gerilme hissetmelisin, asla ağrı değil.';

  @override
  String get exWristExtensorStretchName => 'Bilek Ekstansör Esnetme';

  @override
  String get exWristExtensorStretchSummary => 'Önkolun üst kısmını esnet; fare koluna klasik çözüm.';

  @override
  String get exWristExtensorStretchSteps =>
      'Bir kolunu avucun aşağı bakacak şekilde öne doğru düz uzat.\nBileğini parmakların yeri gösterecek şekilde bük.\nDiğer elinle elinin üst kısmını nazikçe kendine doğru bastır.\n15–30 saniye bekle ve değiştir.';

  @override
  String get exWristExtensorStretchTip => 'Önkol boyunca hissetmek için dirseğini düz tut.';

  @override
  String get exWristCirclesName => 'Bilek Çevirme';

  @override
  String get exWristCirclesSummary => 'Yazı yazmadan önce ve sonra tutulmuş bileklerini ısıt.';

  @override
  String get exWristCirclesSteps =>
      'İki kolunu öne uzat ve ellerini gevşekçe yumruk yap.\nÖnkollarını sabit tut.\nBileklerini yavaşça dışa doğru çevir.\nTekrarların yarısından sonra içe doğru çevir.';

  @override
  String get exWristCirclesTip => 'Sadece eller hareket etsin, hareket akıcı olsun.';

  @override
  String get exPrayerStretchName => 'Dua Esnetmesi';

  @override
  String get exPrayerStretchSummary => 'Avuçlar ve önkolun iç kısmı için nazik bir esneme.';

  @override
  String get exPrayerStretchSteps =>
      'Göğsünün önünde avuçlarını birbirine bastır, parmaklar yukarı baksın.\nAvuçlar birleşik kalırken ellerini yavaşça beline doğru indir.\nDirseklerinin yanlara açılmasına izin ver.\nHafif bir gerilmeyle 15–30 saniye bekle.';

  @override
  String get exPrayerStretchTip => 'Hafif bir gerginlik hedefle, asla ağrı değil.';

  @override
  String get exFigureFourName => 'Oturarak 4 Esnetmesi';

  @override
  String get exFigureFourSummary => 'Uzun oturmaktan gerilen kalça ve kalça kaslarını gevşet.';

  @override
  String get exFigureFourSteps =>
      'Oturağın ön kenarına yakın, iki ayağın yerde dik otur.\nBir ayak bileğini karşı dizinin üzerine koy.\nSırtını düz tutarak dış kalçanda hissedene kadar hafifçe öne eğil.\n30–45 saniye bekle ve bacak değiştir.';

  @override
  String get exFigureFourTip => 'Dizin rahatsız olursa öne eğilmeden sadece bacak bacak üstündeki pozisyonda kal.';

  @override
  String get exLegExtensionName => 'Oturarak Bacak Uzatma';

  @override
  String get exLegExtensionSummary => 'Sandalyeden kalkmadan uyluklarını çalıştır.';

  @override
  String get exLegExtensionSteps =>
      'Uylukların yere paralel, dik otur.\nAyak parmakların sana dönük olacak şekilde bir dizini yavaşça düzleştir.\nEn üstte kısa bir an bekle, sonra kontrollü şekilde indir.\nTekrarları tamamla ve bacak değiştir.';

  @override
  String get exLegExtensionTip => 'Yukarıda dizini kilitleme.';

  @override
  String get exHamstringStretchName => 'Oturarak Arka Bacak Esnetme';

  @override
  String get exHamstringStretchSummary => 'Oturunca kısalan uylukların arka kısmını uzat.';

  @override
  String get exHamstringStretchSteps =>
      'Sandalyenin ön kenarına otur.\nBir bacağını topuk yerde, parmaklar yukarı bakacak şekilde düzleştir.\nSırtını düz tutarak kalçandan öne eğil.\n30–45 saniye bekle ve bacak değiştir.';

  @override
  String get exHamstringStretchTip => 'Kalçadan eğil, sırtını yuvarlama.';

  @override
  String get exAnklePumpsName => 'Ayak Bileği Pompası';

  @override
  String get exAnklePumpsSummary => 'Baldırlarının kanı bacaklarından yukarı pompalamasına yardım et.';

  @override
  String get exAnklePumpsSteps =>
      'Dik otur ve bir ayağını yerden hafifçe kaldır.\nAyak parmaklarını ileri doğru uzat.\nSonra parmaklarını kendine doğru çek.\nAkıcı şekilde tekrarla ve ayak değiştir.';

  @override
  String get exAnklePumpsTip => 'Sadece ayak hareket etsin, kaval kemiğini sabit tut.';

  @override
  String get exSeatedMarchingName => 'Oturarak Yürüyüş';

  @override
  String get exSeatedMarchingSummary => 'Öğleden sonra düşüşünü yenmek için hızlı bir kardiyo.';

  @override
  String get exSeatedMarchingSteps =>
      'Sırtlığa yaslanmadan dik otur.\nSandalyenin yanlarından tut.\nBükülü bir dizini rahat olduğu kadar yükselt, sonra kontrollü şekilde indir.\nDüzenli bir ritimle bacak değiştir.';

  @override
  String get exSeatedMarchingTip => 'Kaldırırken geriye yaslanma.';

  @override
  String get exCalfRaisesName => 'Ayakta Parmak Ucuna Yükselme';

  @override
  String get exCalfRaisesSummary => 'Baldırlarını güçlendir ve kan dolaşımını hızlandır.';

  @override
  String get exCalfRaisesSteps =>
      'Masana dönük dur ve ellerini hafifçe üzerine koy.\nYavaşça parmak uçlarına yüksel.\nEn üstte kısa bir an bekle.\nTopuklarını kontrollü şekilde indir.';

  @override
  String get exCalfRaisesTip => 'Daha zor olsun istersen ellerinle destek almadan yap.';

  @override
  String get exHipFlexorStretchName => 'Ayakta Kalça Fleksör Esnetme';

  @override
  String get exHipFlexorStretchSummary => 'Oturmaktan gerilen kalçanın ön kısmını aç.';

  @override
  String get exHipFlexorStretchSteps =>
      'Esneteceğin bacak bir adım geride olacak şekilde ayaklarını öne-arkaya aç.\nÖndeki dizini hafifçe bük ve sırtını düz tut.\nKuyruk sokumunu içeri al ve arkadaki kalçanı nazikçe öne it.\n20–30 saniye bekle ve taraf değiştir.';

  @override
  String get exHipFlexorStretchTip => 'Denge için masana tutun ve belini çukurlaştırma.';

  @override
  String get exChairSquatName => 'Sandalyeden Kalkıp Oturma';

  @override
  String get exChairSquatSummary => 'Masa başı çalışanlar için en pratik bacak egzersizi.';

  @override
  String get exChairSquatSteps =>
      'Sağlam bir sandalyenin kenarına otur, ayakların kalça genişliğinde olsun.\nKollarını göğsünde çaprazla ve hafifçe öne eğil.\nKarşıya bakarak bacak gücünle ayağa kalk.\nYavaş ve kontrollü şekilde geri otur.';

  @override
  String get exChairSquatTip => 'Tekerleksiz bir sandalye kullan ya da sandalyeyi duvara dayayarak sabitle.';

  @override
  String get exDeskPushUpName => 'Masada Şınav';

  @override
  String get exDeskPushUpSummary => 'Masanı kullanarak göğüs, omuz ve kollarını güçlendir.';

  @override
  String get exDeskPushUpSteps =>
      'Ellerini omuz genişliğinde sağlam bir masanın kenarına koy.\nVücudun düz bir çizgi oluşturana kadar ayaklarınla geriye yürü.\nDirseklerini bükerek göğsünü masaya doğru indir.\nKollarını düzleştirerek geri it.';

  @override
  String get exDeskPushUpTip => 'Karın kaslarını sıkı tut ve masanın kaymayacağından emin ol.';

  @override
  String get exRule202020Name => '20-20-20 Göz Molası';

  @override
  String get exRule202020Summary => 'Yorgun ekran gözleri için göz doktorlarının kuralı.';

  @override
  String get exRule202020Steps =>
      'Her 20 dakikada bir gözlerini ekrandan ayır.\nYaklaşık 6 metre (20 feet) uzaktaki bir şeye odaklan.\nEn az 20 saniye boyunca bakmaya devam et.\nİşe dönmeden önce birkaç kez tam olarak göz kırp.';

  @override
  String get exRule202020Tip => 'Pencere manzarası mükemmeldir; uzağa odaklanmak göz kaslarını gevşetir.';

  @override
  String get exNearFarFocusName => 'Yakın–Uzak Odak';

  @override
  String get exNearFarFocusSummary => 'Gözlerini odak değiştirmeye alıştır.';

  @override
  String get exNearFarFocusSteps =>
      'Başparmağını yüzünden yaklaşık 25 cm uzakta tut.\nBirkaç saniye ona odaklan.\nSonra odağını uzaktaki bir nesneye kaydır.\nYakın ve uzak arasında yavaşça geçiş yapmaya devam et.';

  @override
  String get exNearFarFocusTip => 'Başını sabit tut ve normal nefes al.';

  @override
  String get exEyeMovementsName => 'Göz Hareketleri';

  @override
  String get exEyeMovementsSummary => 'Yorgun gözler için nazik bir rahatlama rutini.';

  @override
  String get exEyeMovementsSteps =>
      'Rahatça otur ve başını sabit tut.\nYavaşça yukarı, sonra aşağı bak.\nYavaşça sola, sonra sağa bak.\nGözlerini kapat ve bir an gevşe.';

  @override
  String get exEyeMovementsTip => 'Bu bir tedavi değil, rahatlama rutinidir. Rahatsızlık verirse dur.';

  @override
  String get exPalmingName => 'Avuçlama (Palming)';

  @override
  String get exPalmingSummary => 'Gözleri tamamen dinlendirmek için sıcak karanlık.';

  @override
  String get exPalmingSteps =>
      'Ellerini ovuşturarak ısıt.\nGözlerini kapat.\nAvuçlarını bastırmadan çukur şekilde gözlerinin üzerine kapat.\n20–30 saniye yavaşça nefes al.';

  @override
  String get exPalmingTip => 'Göz kürelerine baskı yapma; avuçlar sadece elmacık kemiklerine dayansın.';

  @override
  String get exBlinkingName => 'Bilinçli Göz Kırpma';

  @override
  String get exBlinkingSummary => 'Ekranların kuruttuğu gözyaşı tabakasını yenile.';

  @override
  String get exBlinkingSteps =>
      'Gözlerini 2 saniye nazikçe kapat.\nAç.\nTekrar 2 saniye kapat.\nSonra 2 saniye hafifçe sık ve aç.';

  @override
  String get exBlinkingTip =>
      'Ekran başında yaklaşık yarı yarıya daha az göz kırparız; bunu her 20 dakikada bir tekrarla.';

  @override
  String get exBoxBreathingName => 'Kutu Nefesi';

  @override
  String get exBoxBreathingSummary => 'Yoğun bir zihni sakinleştiren dört eşit kenar.';

  @override
  String get exBoxBreathingSteps =>
      'Nefesini tamamen ver.\nBurnundan 4 saniye nefes al.\n4 saniye tut.\n4 saniye nefes ver, sonra 4 saniye tut.';

  @override
  String get exBoxBreathingTip => 'Zorlanırsan süreleri kısalt.';

  @override
  String get exBellyBreathingName => 'Karın Nefesi';

  @override
  String get exBellyBreathingSummary => 'Omuz gerginliğini azaltan diyafram nefesi.';

  @override
  String get exBellyBreathingSteps =>
      'Omuzların gevşek şekilde otur.\nBir elini göğsüne, diğerini kaburgalarının hemen altına koy.\nBurnundan nefes al; karnın alttaki elini dışarı itsin.\nBüzülmüş dudaklardan yavaşça nefes ver.';

  @override
  String get exBellyBreathingTip => 'Sadece alttaki el hareket etmeli; göğsün sakin kalır.';
}
