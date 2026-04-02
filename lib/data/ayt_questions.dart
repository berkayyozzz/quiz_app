import '../models/question.dart';
import 'ayt_new_questions_1.dart';
import 'ayt_new_questions_2.dart';
import 'ayt_new_questions_3.dart';
import 'ayt_new_questions_4.dart';

final List<Question> aytQuestions = [
  // ─────────────── AYT MATEMATİK ───────────────
  Question(
      id: 101,
      examType: 'AYT',
      subject: 'Matematik',
      questionText:
          'f(x) fonksiyonu gerçel sayılar kümesinde türevlenebilir bir fonksiyon olmak üzere,\nlim (x → 2) [f(x) - f(2)] / (x - 2) = 4\nolduğu bilinmektedir.\n\nBuna göre g(x) = x² · f(x) fonksiyonunun x = 2 noktasındaki türevinin (g\'(2)) değeri aşağıdakilerden hangisine eşittir? (f(2) = 3 olarak verilmiştir)',
      options: ['12', '16', '24', '28'],
      correctIndex: 3), // f'(2) = 4, f(2) = 3. g'(x) = 2x*f(x) + x²*f'(x) => g'(2) = 4*3 + 4*4 = 12 + 16 = 28.
  Question(
      id: 102,
      examType: 'AYT',
      subject: 'Matematik',
      questionText:
          'Gerçel sayılar kümesi üzerinde tanımlı f(x) parabolü x eksenini x = 1 ve x = 5 noktalarında kesmektedir. Fonksiyonun grafiği y eksenini (0, 10) noktasında kestiğine göre, bu parabolün tepe noktasının ordinatı (y) kaçtır?',
      options: ['-4', '-8', '6', '12'],
      correctIndex: 1), // f(x) = a(x-1)(x-5). f(0) = a(-1)(-5) = 5a = 10 => a = 2. Tepe noktası r = (1+5)/2 = 3. k = f(3) = 2(2)(-2) = -8.
  Question(
      id: 103,
      examType: 'AYT',
      subject: 'Matematik',
      questionText:
          'Bir öğrenci, kökleri x₁ ve x₂ olan x² - mx + n = 0 ikinci dereceden denklemini çözerken yanlışlıkla kökler toplamını x₁·x₂, kökler çarpımını ise x₁ + x₂ olarak hesaplamıştır. Öğrencinin bulduğu bu yeni denklem x² - 8x + 15 = 0 olduğuna göre, m + n toplamı kaçtır?',
      options: ['15', '23', '24', '30'],
      correctIndex: 1), // Hatalı denklemde kökler toplamı T' = 8, kökler çarpımı Ç' = 15. T' = n (gerçek Ç), Ç' = m (gerçek T). O halde n = 8, m = 15. Toplam m+n = 23.
  Question(
      id: 104,
      examType: 'AYT',
      subject: 'Matematik',
      questionText:
          'P(x) = x³ + ax² + bx + c polinomunun (x - 1)² ile bölümünden kalan 2x - 1\'dir. P(x) polinomunun katsayılar toplamı kaçtır?',
      options: ['1', '2', '3', '4'],
      correctIndex: 0), // P(x) = Q(x)*(x-1)² + 2x-1. Katsayılar toplamı = P(1). P(1) = 0 + 2(1)-1 = 1.
  Question(
      id: 105,
      examType: 'AYT',
      subject: 'Matematik',
      questionText:
          'Dik koordinat düzleminde, merkezi x-ekseni üzerinde bulunan ve y = 4 doğrusuna teğet olan bir çember çiziliyor. Çember y eksenini (0, 2) ve (0, m) noktalarında kestiğine göre m kaçtır?',
      options: ['-2', '0', '2', 'Bilinemez'],
      correctIndex: 0), // Merkez M(a, 0). y=4'e teğetse uzaklık = 4 (yarıçap R = 4). Çemberin denklemi: (x-a)² + y² = 16. Y eksenini x=0 => a² + y² = 16 => a²=12 => y²=4 => y=±2. Dolayısıyla y kestiği noktalar 2 ve -2'dir. -> -2.
  Question(
      id: 106,
      examType: 'AYT',
      subject: 'Matematik',
      questionText:
          'A = {1, 2, 3, 4, 5, 6} kümesinin elemanları kullanılarak rakamları tekrarsız üç basamaklı sayılar yazılıyor. Yazılan bu sayıların kaç tanesinde rakamlar soldan sağa doğru artan bir sıradadır?',
      options: ['15', '20', '30', '120'],
      correctIndex: 1), // Sadece 6 elemandan 3 tane seçmek yeterlidir. C(6,3) = (6*5*4)/(3*2*1) = 20. Seçilen her 3 rakam sadece tek bir şekilde küçükten büyüğe sıralanabilir.
  Question(
      id: 107,
      examType: 'AYT',
      subject: 'Matematik',
      questionText:
          'I. x doğrusal hızıyla giden bir hareketlinin zamana göre integrali alınan yolu verir.\nII. Eğri altında kalan alanı hesaplamak için türevkullanılır.\nIII. Türevi sıfır olan her nokta kesinlikle yerel ekstremum noktasıdır.\nYukarıdaki ifadelerden hangileri yanlıştır?',
      options: ['Yalnız I', 'Yalnız II', 'I ve II', 'II ve III'],
      correctIndex: 3), // Alan hesabı için integral kullanılır (II yanlış). x^3 türevi sıfırdır ama ekstremum değildir (III yanlış). Yanlışlar: II ve III.
  Question(
      id: 108,
      examType: 'AYT',
      subject: 'Matematik',
      questionText:
          '(1 + x)⁸ açılımında x⁴ lü terimin katsayısı, x³ lü terimin katsayısından kaç fazladır?',
      options: ['14', '20', '35', '56'],
      correctIndex: 0), // C(8,4) = 70. C(8,3) = 56. 70 - 56 = 14.
  Question(
      id: 109,
      examType: 'AYT',
      subject: 'Matematik',
      questionText:
          'log₂x + log₂(x-2) = 3 denklemini sağlayan x değeri kaçtır?',
      options: ['4', '5', '6', '8'],
      correctIndex: 0), // log₂(x(x-2)) = 3 => x²-2x = 8 => x²-2x-8 = 0 => (x-4)(x+2)=0. x>2 olduğu için x=4.
  Question(
      id: 110,
      examType: 'AYT',
      subject: 'Matematik',
      questionText:
          'Gerçel sayılarda tanımlı sürekli bir f fonksiyonu için ∫₀³ f(x) dx = 10 ve ∫₀³ x·f\'(x) dx = 6 olduğuna göre, f(3) değeri kaçtır?',
      options: ['0', '16/3', '10/3', '5'],
      correctIndex: 1), // Parçalı integral: ∫ x f'(x) dx = [x f(x)] - ∫ f(x) dx. 6 = [3 f(3) - 0] - 10 => 3 f(3) = 16 => f(3) = 16/3.
  Question(
      id: 111,
      examType: 'AYT',
      subject: 'Matematik',
      questionText:
          'Bir (aₙ) aritmetik dizisinde a₃ + a₇ = 24 olduğuna göre, a₅ değeri kaçtır?',
      options: ['6', '8', '12', '24'],
      correctIndex: 2), // a₃ + a₇ = 2a₅ = 24 => a₅ = 12.
  Question(
      id: 112,
      examType: 'AYT',
      subject: 'Matematik',
      questionText:
          '0 ≤ x ≤ π olmak üzere,\nsin²x - cos²x = 1/2 denkleminin sağlayan en küçük x açısı kaç derecedir?',
      options: ['15', '30', '45', '60'],
      correctIndex: 3), // sin²x - cos²x = -cos(2x). -cos(2x) = 1/2 => cos(2x) = -1/2. 2x = 120° => x = 60°.
  Question(
      id: 113,
      examType: 'AYT',
      subject: 'Matematik',
      questionText:
          'Dik koordinat sisteminde, y = 2x - 4 doğrusunun y = x doğrusuna göre simetriğinin denklemi aşağıdakilerden hangisidir?',
      options: ['y = x/2 + 2', 'y = -2x + 4', 'y = x/2 - 2', 'y = 2x + 4'],
      correctIndex: 0), // y=x'e göre simetriği x ve y yer değiştirir. x = 2y - 4 => 2y = x + 4 => y = x/2 + 2.
  Question(
      id: 114,
      examType: 'AYT',
      subject: 'Matematik',
      questionText:
          'Karmaşık sayılar kümesinde i² = -1 olmak üzere,\n(1 - i)¹⁰ işleminin sonucu aşağıdakilerden hangisidir?',
      options: ['32', '-32', '32i', '-32i'],
      correctIndex: 3), // (1-i)² = -2i. (-2i)⁵ = -32 * i⁵ = -32 * i = -32i.
  Question(
      id: 115,
      examType: 'AYT',
      subject: 'Matematik',
      questionText:
          'y = √x eğrisi ile y = x/2 doğrusu arasında kalan kapalı bölgenin alanı kaç birimkaredir?',
      options: ['1/3', '2/3', '4/3', '8/3'],
      correctIndex: 2), // Kesişim x=4. ∫₀⁴ (√x - x/2) dx = (2/3 x^(3/2) - x²/4) |₀⁴ = (16/3 - 4) = 4/3.

  // ─────────────── AYT FİZİK ───────────────
  Question(
      id: 116,
      examType: 'AYT',
      subject: 'Fizik',
      questionText:
          'Sürtünmesiz yatay düzlemde durmakta olan m kütleli bir cisme yatay F kuvveti Δt süre boyunca uygulanıyor. Cismin kazandığı kinetik enerjinin, kazandığı momentuma oranı aşağıdakilerden hangisine eşittir?',
      options: ['v', 'v/2', '2v', 'v²'],
      correctIndex: 1), // K = 1/2 m v² = p² / 2m. p = m v. K/p = (1/2 m v²) / (m v) = v/2.
  Question(
      id: 117,
      examType: 'AYT',
      subject: 'Fizik',
      questionText:
          'Düzgün çembersel hareket yapan bir cisim için;\nI. Çizgisel hız sabittir.\nII. Merkezcil kuvvet iş yapmaz.\nIII. Açısal momentum korunur.\nyargılarından hangileri doğrudur?',
      options: ['Yalnız I', 'I ve II', 'II ve III', 'I, II ve III'],
      correctIndex: 2), // Çizgisel hızın Vektörü DEĞİŞİR (I yanlış). Kuvvet yola diktir, iş yapmaz (II doğru). Dış tork sıfırdır, açısal momentum korunur (III doğru).
  Question(
      id: 118,
      examType: 'AYT',
      subject: 'Fizik',
      questionText:
          'Özdeş K, L ve M lambalarıyla kurulan bir alternatif akım devresinde, K lambasına seri bir sığaç (kondansatör), L lambasına seri bir bobin, M lambasına ise sadece omik bir direnç bağlanmıştır. Alternatif gerilimin frekansı artırıldığında lambaların parlaklıkları nasıl değişir?',
      options: [
        'K artar, L azalır, M değişmez',
        'K azalır, L artar, M değişmez',
        'K artar, L azalır, M artar',
        'K, L ve M azalır'
      ],
      correctIndex: 0), // Kondansatörün Xc = 1 / (2πfC) (f artarsa Xc azalır, akım artar, K parlar). Bobinin Xl = 2πfL (f artarsa Xl artar, L kararır). Direnç R frekansa bağlı değildir (M değişmez).
  Question(
      id: 119,
      examType: 'AYT',
      subject: 'Fizik',
      questionText:
          'Çift yarıkla yapılan girişim (Young) deneyinde, ekran üzerinde oluşan saçak aralığının (Δx) artması için;\nI. Yarıklar arası mesafenin artırılması\nII. Kullanılan ışığın dalga boyunun küçültülmesi\nIII. Yarık düzlemi ile ekran arasındaki suyun boşaltılıp yerine hava doldurulması\nişlemlerinden hangileri tek başına yapılabilir?',
      options: ['Yalnız III', 'I ve II', 'II ve III', 'I, II ve III'],
      correctIndex: 0), // Δx = (L*λ) / (d*n). d artarsa azalır. λ azalırsa azalır. Su yerini havaya bırakırsa n küçülür, Δx artar. Yalnız III.
  Question(
      id: 120,
      examType: 'AYT',
      subject: 'Fizik',
      questionText:
          'Bohr atom modeline göre hidrojen atomunda elektron n=2 yörüngesinden n=4 yörüngesine uyarıldığında aşağıdakilerden hangisi gerçekleşmez?',
      options: [
        'Açısal momentumu h/π kadar artar.',
        'Toplam enerjisi artar.',
        'Çizgisel sürati azalır.',
        'Bağlanma enerjisi artar.'
      ],
      correctIndex: 3), // L = n*h/2π. 2'den 4'e geçince L = 2h/2π = h/π artar. E_n = -13.6/n^2 (artar). V_n = V/n (azalır). Bağlanma enerjisi, elektronu koparmak için gereken enerjidir; elektron çekirdekten uzaklaştıkça bağlanma enerjisi azalır.
  Question(
      id: 121,
      examType: 'AYT',
      subject: 'Fizik',
      questionText:
          'Transformatörler ile ilgili;\nI. Sadece dalgalı akımla (AC) çalışırlar.\nII. Gerilimi alçaltmak veya yükseltmek için kullanılırlar.\nIII. İdeal bir transformatörde giriş gücü her zaman çıkış gücünden büyüktür.\nifadelerinden hangileri doğrudur?',
      options: ['Yalnız II', 'I ve II', 'II ve III', 'I, II ve III'],
      correctIndex: 1), // İdeal bir transformatörde Pf giriş = Pf çıkış. (III yanlış). I ve II doğru.
  Question(
      id: 122,
      examType: 'AYT',
      subject: 'Fizik',
      questionText:
          'Bir fotoelektrik olayında sökülen fotoelektronların maksimum kinetik enerjisinin, yüzeye düşürülen ışığın frekansına bağlı değişim grafiği çiziliyor. Grafiğin eğimi evrensel bir sabit verirken, grafiğin frekans eksenini kestiği nokta aşağıdakilerden hangisidir?',
      options: ['Planck sabiti', 'Işık hızı', 'Eşik frekansı', 'Bağlanma enerjisi'],
      correctIndex: 2), // Eğim Planck sabiti (h). f eksenini kestiği nokta ise K = 0 iken f = f0 'dır, yani eşik frekansıdır.
  Question(
      id: 123,
      examType: 'AYT',
      subject: 'Fizik',
      questionText:
          'Eşit bölmeli homojen bir çubuğun iki ucuna asılan P kütleli cisimler sürtünmesiz ortamda dengededir. Çubuğun asıldığı ipe olan uzaklıklar değiştirildiğinde aşağıdakilerden hangisi kesinlikle değişir?',
      options: ['Sistemin toplam ağırlığı', 'İpteki gerilme kuvveti', 'Denge noktasına göre tork dengesi', 'Çubuğun ağırlık merkezi'],
      correctIndex: 2), // İp üzerindeki denge (tork) eşit kollu değilse bozulur ve çubuk döner. Denge noktasına göre net tork sıfır olmaktan çıkar.
  Question(
      id: 124,
      examType: 'AYT',
      subject: 'Fizik',
      questionText:
          'Kütlesi ihmal edilen yalıtkan iplerle tavana asılı yüklü iki cisim birbirini iterek dengeye gelmiştir. İplerin düşeyle yaptığı açılar sırasıyla α ve β\'dır. Cisimlerin yük miktarları farklı olduğuna göre;\nI. Cisimlere etki eden elektriksel kuvvetlerin büyüklükleri eşittir.\nII. Açılar kütlelere bağlıdır.\nIII. Yükü büyük olanın açısı büyüktür.\nyargılarından hangileri doğrudur?',
      options: ['Yalnız I', 'I ve II', 'II ve III', 'I, II ve III'],
      correctIndex: 1), // Coulomb kuvvetleri etki tepki çiftidir (eşit büyüklüktedir - I doğru). Açı sadece elektriksel kuvvet/kütle oranına bağlıdır (II doğru). Açı yüke değil doğrudan kütleye bağlıdır (III yanlış).
  Question(
      id: 125,
      examType: 'AYT',
      subject: 'Fizik',
      questionText:
          'Michelson-Morley deneyinin bilim dünyasına kazandırdığı en önemli sonuç aşağıdakilerden hangisidir?',
      options: [
        'Ether (esir) maddesinin var olmadığını ve ışık hızının tüm eylemsiz gözlem çerçevelerinde aynı olduğunu kanıtlaması',
        'Fotoelektrik olayının açıklanması',
        'Kuantum mekaniğinin temellerini atması',
        'Kara cisim ışımasının açıklanması'
      ],
      correctIndex: 0),
  Question(
      id: 126,
      examType: 'AYT',
      subject: 'Fizik',
      questionText:
          'Sağ el kuralına göre, bir telden geçen akım başparmak yönünde ise bükülen dört parmağın yönü aşağıdakilerden hangisini verir?',
      options: ['Elektriksel alan yönü', 'Manyetik alan yönü', 'Manyetik kuvvet yönü', 'Elektrik akımı yönü'],
      correctIndex: 1),
  Question(
      id: 127,
      examType: 'AYT',
      subject: 'Fizik',
      questionText:
          'Bir gezegenin Güneş etrafındaki yörüngesi elips şeklindedir (Kepler Kanunları). Gezegen Güneş\'e yaklaştıkça;\nI. Çizgisel hızı artar\nII. Açısal momentumu değişmez\nIII. Kinetik enerjisi azalır\nifadelerinden hangileri doğrudur?',
      options: ['Yalnız I', 'I ve II', 'II ve III', 'I, II ve III'],
      correctIndex: 1), // Yaklaştıkça çizgisel hızı artar (Kinetik enerjisi artar, III yanlış). Açısal momentum sabittir (II doğru).
  Question(
      id: 128,
      examType: 'AYT',
      subject: 'Fizik',
      questionText:
          'Esneklik (Yay) sabiti k ve uzunluğu L olan bir helezon yay tam ortadan ikiye bölünüyor. Elde edilen iki yeni yayın her birinin esneklik sabiti k\' için aşağıdakilerden hangisi doğrudur?',
      options: ['k/2', 'k', '2k', '4k'],
      correctIndex: 2), // Yay kısaldıkça sertleşir. k = 1/L. L yarıya düşerse k iki katına çıkar.
  Question(
      id: 129,
      examType: 'AYT',
      subject: 'Fizik',
      questionText:
          'Compton saçılması deneyinde, bir X-ışını fotonu elektronla çarpıştıktan sonra saçılıyor. Saçılan foton ile ilgili olarak gelen fotona göre aşağıdakilerden hangisi artmıştır?',
      options: ['Enerji', 'Frekans', 'Hız', 'Dalga boyu'],
      correctIndex: 3), // Enerji azalır, frekans azalır, hız değişmez (c). Dalga boyu artar.
  Question(
      id: 130,
      examType: 'AYT',
      subject: 'Fizik',
      questionText:
          'Bağıl hareket konusuyla ilgili olarak doğuya v hızıyla giden K aracından, kuzeye v hızıyla giden L aracına bakan gözlemci L aracını hangi yönde ve hangi hızla gidiyormuş gibi görür?',
      options: ['Kuzeydoğu v√2', 'Kuzeybatı v√2', 'Güneybatı v', 'Kuzeybatı v'],
      correctIndex: 1), // Vk = v_doğu, Vl = v_kuzey. V_k->l = Vl - Vk = v_kuzey - v_doğu = v_kuzey + v_batı = v√2 kuzeybatı.

  // ─────────────── AYT KİMYA ───────────────
  Question(
      id: 131,
      examType: 'AYT',
      subject: 'Kimya',
      questionText:
          'Modern atom teorisine göre, bir elektronun durumu dört kuantum sayısı ile ifade edilir. Baş kuantum sayısı n=3, açısal momentum kuantum sayısı l=2 olan bir orbital türü aşağıdakilerden hangisidir ve en fazla kaç elektron alabilir?',
      options: ['3s, 2 e⁻', '3p, 6 e⁻', '3d, 10 e⁻', '3f, 14 e⁻'],
      correctIndex: 2), // l=0(s), 1(p), 2(d), 3(f). 3d orbitalidir. d orbitalleri 5 alt orbitalden oluşur ve toplam 10 e- alabilir.
  Question(
      id: 132,
      examType: 'AYT',
      subject: 'Kimya',
      questionText:
          'İdeal gaz davranışı gösteren X ve Y gazlarından X\'in mol kütlesi 16 g/mol, Y\'nin mol kütlesi ise 64 g/mol\'dür. Aynı sıcaklıkta küçük bir delikten vakuma efüzyon (yayılma) hızları arasındaki (V_x / V_y) oranı kaçtır?',
      options: ['1/4', '1/2', '2', '4'],
      correctIndex: 2), // Graham Difüzyon Yasası: V_x / V_y = √(M_y / M_x) = √(64/16) = √4 = 2.
  Question(
      id: 133,
      examType: 'AYT',
      subject: 'Kimya',
      questionText:
          '0.2 M 100 mL kurşun(II) nitrat (Pb(NO3)2) çözeltisi ile 0.3 M 100 mL potasyum iyodür (KI) çözeltisi karıştırılıyor. Çökelme tamamlandıktan sonra çözeltideki K⁺ ve NO3⁻ iyon derişimleri sırasıyla kaç M olur? (Hacim değişimi ihmal edilecektir.)',
      options: ['0.15 ve 0.20', '0.30 ve 0.20', '0.15 ve 0.40', '0.10 ve 0.20'],
      correctIndex: 0), // K+ derişimi: n_K = 0.3 * 0.1 = 0.03 mol. V_top = 0.2 L. [K+] = 0.03 / 0.2 = 0.15 M. NO3- derişimi: n_NO3 = 2 * 0.2 * 0.1 = 0.04 mol. [NO3-] = 0.04 / 0.2 = 0.20 M. K ve NO3 seyirci iyonlardır.
  Question(
      id: 134,
      examType: 'AYT',
      subject: 'Kimya',
      questionText:
          'Tepkime hızı ve aktifleşme enerjisi üzerine katalizörün etkisi incelendiğinde;\nI. İleri ve geri tepkimenin aktifleşme enerjisini aynı miktarda düşürür.\nII. Tepkimenin entalpi değişimini (ΔH) değiştirmez.\nIII. Tepkimenin mekanizmasını değiştirebilir.\nyargılarından hangileri doğrudur?',
      options: ['Yalnız I', 'I ve II', 'II ve III', 'I, II ve III'],
      correctIndex: 3), // Üçü de doğrudur. Katalizör entalpiyi değiştirmez, Ea'yı düşürür, mekanizmayı değiştirebilir.
  Question(
      id: 135,
      examType: 'AYT',
      subject: 'Kimya',
      questionText:
          'Kapalı bir kapta gerçekleşen;\nN2(g) + 3H2(g) ⇌ 2NH3(g)   ΔH < 0\ndenge tepkimesinde NH3 verimini artırmak için Le Chatelier ilkesine göre aşağıdakilerden hangisi uygulanmalıdır?',
      options: [
        'Sıcaklığı artırmak ve kabın hacmini büyütmek',
        'Sıcaklığı düşürmek ve kaba sabit hacimde He gazı eklemek',
        'Sıcaklığı düşürmek ve basıncı artırmak',
        'Katalizör eklemek'
      ],
      correctIndex: 2), // Ekzotermik (ΔH<0), düşük sıcaklık ürünlere (sağa) kaydırır. Gaz mol sayısı girenlerde 4, ürünlerde 2. Basıncı artırmak (hacmi küçültmek) mol sayısının az olduğu ürünler yönüne kaydırır. NH3 artar.
  Question(
      id: 136,
      examType: 'AYT',
      subject: 'Kimya',
      questionText:
          'Asitlik sabiti Ka = 1×10⁻⁵ olan zayıf HA asidinin 0.1 M\'lık sulu çözeltisinin pH değeri kaçtır?',
      options: ['2', '3', '4', '5'],
      correctIndex: 1), // [H+] = √(Ka * C) = √(1e-5 * 0.1) = √(1e-6) = 1e-3. pH = -log(1e-3) = 3.
  Question(
      id: 137,
      examType: 'AYT',
      subject: 'Kimya',
      questionText:
          'Suda az çözünen CaF2 tuzunun t °C\'de çözünürlük çarpımı sabiti Kçç = 4×10⁻¹² dir. Buna göre aynı sıcaklıkta CaF2 tuzunun saf sudaki molar çözünürlüğü kaç M\'dir?',
      options: ['10⁻⁴', '2×10⁻⁴', '10⁻⁶', '2×10⁻⁶'],
      correctIndex: 0), // CaF2 ⇌ Ca+2 + 2F-. Kçç = s * (2s)^2 = 4s^3. 4s^3 = 4×10⁻¹² => s^3 = 10⁻¹² => s = 10⁻⁴.
  Question(
      id: 138,
      examType: 'AYT',
      subject: 'Kimya',
      questionText:
          'Standart koşullarda gerçekleşen;\nZn(k) + Cu²⁺(suda) → Zn²⁺(suda) + Cu(k)\npil tepkimesi kendiliğinden ve ekzotermik olarak gerçekleşmektedir. Hücre potansiyelini (E_pil) artırmak için Nernst Eşitliği\'ne göre aşağıdakilerden hangisi yapılmalıdır?',
      options: [
        'Anot yarı hücresine saf su eklemek',
        'Katot yarı hücresine saf su eklemek',
        'Sıcaklığı artırmak',
        'Zn(k) elektrodun kütlesini artırmak'
      ],
      correctIndex: 0), // E_pil = E° - (0.0592/n) * log([Zn2+]/[Cu2+]). [Zn2+] azalırsa log değeri küçülür, E_pil artar. Zn olan taraf anottur, anota su eklemek derişimi azaltır.
  Question(
      id: 139,
      examType: 'AYT',
      subject: 'Kimya',
      questionText:
          'Seri bağlı iki elektroliz kabından birincisinde XCl2, ikincisinde YCl3 ergimiş tuzları aynı süre elektroliz ediliyor. Kapların katotlarında toplanan X kütlesi Y kütlesine eşit ise, elementlerin atom kütleleri oranı (M_X / M_Y) kaçtır?',
      options: ['2/3', '3/2', '1', '1/2'],
      correctIndex: 0), // n_X = q / 2, n_Y = q / 3. Kütleler m_X = m_Y. n_X * M_X = n_Y * M_Y => (q/2) * M_X = (q/3) * M_Y => M_X / M_Y = 2/3.
  Question(
      id: 140,
      examType: 'AYT',
      subject: 'Kimya',
      questionText:
          'CH4 (Metan) molekülünün merkez atomu olan karbon (C) atomunun yaptığı hibritleşme türü ve molekül geometrisi aşağıdakilerden hangisidir?',
      options: [
        'sp² - Düzlem üçgen',
        'sp³ - Düzgün dörtyüzlü (Tetrahedral)',
        'sp - Doğrusal',
        'sp³ - Üçgen piramit'
      ],
      correctIndex: 1), // CH4 tetrahedraldir ve bağ açısı 109.5 derecedir. C atomu sp3 hibritleşmesi yapar.
  Question(
      id: 141,
      examType: 'AYT',
      subject: 'Kimya',
      questionText:
          'Alkenlerle ilgili olarak;\nI. Genel formülleri CnH2n\'dir ve yapılarında en az bir tane pi (π) bağı bulunur.\nII. Karbon tetraklorürdeki (CCl4) bromun (Br2) kızıl-kahverengi rengini giderirler (katılma tepkimesi).\nIII. Suda iyi çözünürler.\nyargılarından hangileri doğrudur?',
      options: ['Yalnız I', 'I ve II', 'II ve III', 'I, II ve III'],
      correctIndex: 1), // Alkenler apolardır ve hidrokarbondur, suda (polar) çözünmezler. (III yanlış). I ve II doğru.
  Question(
      id: 142,
      examType: 'AYT',
      subject: 'Kimya',
      questionText:
          'Bir organik bileşik olan A, yükseltgendiğinde aldehit, aldehit de yükseltgendiğinde karboksilik asit oluşturmaktadır. Buna göre A bileşiğinin sınıfı aşağıdakilerden hangisidir?',
      options: ['Sekonder alkol', 'Primer alkol', 'Tersiyer alkol', 'Keton'],
      correctIndex: 1), // Primer alkoller 1 kademe yükseltgendiğinde aldehit, 2 kademe yükseltgendiğinde karboksilik asit olur. Sekonder alkoller keton oluşturur.
  Question(
      id: 143,
      examType: 'AYT',
      subject: 'Kimya',
      questionText:
          'Benzen (C6H6) molekülü ile ilgili olarak;\nI. Yapısındaki karbon atomları arasındaki bağ uzunlukları birbirine eşittir (rezonans).\nII. Aromatik özellik gösterir.\nIII. Kolaylıkla katılma tepkimesi verirler.\nifadelerinden hangileri doğrudur?',
      options: ['Yalnız I', 'I ve II', 'II ve III', 'I, II ve III'],
      correctIndex: 1), // Aromatik halkalar kararlıdır, katılma yerine yer değiştirme tepkimesine yatkındırlar. (III yanlış).
  Question(
      id: 144,
      examType: 'AYT',
      subject: 'Kimya',
      questionText:
          'Piller ve elektroliz hücreleri karşılaştırıldığında aşağıdakilerden hangisi yanlıştır?',
      options: [
        'Galvanik hücrelerde (pil) sistem dışarıya elektrik enerjisi verir.',
        'Elektroliz hücrelerinde olay istemsizdir ve dışarıdan enerji gerekir.',
        'Her iki sistemde de anotta yükseltgenme, katotta indirgenme olur.',
        'Galvanik hücrede anot (+), elektroliz hücresinde ise anot (-) kutuptur.'
      ],
      correctIndex: 3), // Galvanik pilde anot (-), katot (+) dir. Elektrolizde ise anot (+), katot (-) dir. Tam tersi verilmiş.
  Question(
      id: 145,
      examType: 'AYT',
      subject: 'Kimya',
      questionText:
          'H₂O, NH₃ ve CH₄ moleküllerindeki merkez atomların hibritleşme türleri aynı (sp³) olmasına rağmen bağ açıları sırasıyla 104.5°, 107.3° ve 109.5° dir. Bu durumun temel nedeni aşağıdakilerden hangisidir?',
      options: [
        'Elektrolit olmaları',
        'Halojenlerle girdikleri tepkimelerin farklılığı',
        'Merkez atom üzerindeki ortaklanmamış (bağ yapmamış) elektron çiftlerinin bağlayıcı elektronları daha çok itmesi',
        'Moleküllerin molar kütlelerinin farklı olması'
      ],
      correctIndex: 2), // VSEPR teorisine göre e- çifti itmesi: ortaklanmamış-ortaklanmamış > ortaklanmamış-bağlayıcı > bağlayıcı-bağlayıcı. H2O'da 2 çift, NH3'te 1 çift serbest elektron vardır; açıyı daraltırlar.

  // ─────────────── AYT BİYOLOJİ ───────────────
  Question(
      id: 146,
      examType: 'AYT',
      subject: 'Biyoloji',
      questionText:
          'Bir araştırmacı, hücre zarından madde geçişlerini incelerken bir molekülün hücre içine alınması sırasında ATP harcandığını, geçişin az yoğun ortamdan çok yoğun ortama doğru olduğunu ve taşıyıcı proteinlerin görev aldığını gözlemliyor. Buna göre bu madde geçiş yöntemi aşağıdakilerden hangisidir?',
      options: ['Kolaylaştırmış difüzyon', 'Osmoz', 'Aktif taşıma', 'Ekzositoz'],
      correctIndex: 2), // ATP harcanıyor, taşıyıcı protein var, azdan çoğa: Aktif taşıma. (Ekzositoz hücre dışına ve madde boyutu büyük).
  Question(
      id: 147,
      examType: 'AYT',
      subject: 'Biyoloji',
      questionText:
          'İnsan mide özsuyunda bulunan pepsin enzimi inaktif olan pepsinojen formunda salgılanır ve midedeki HCl ile aktif pepsine dönüşür. Bu durumun (enzimin inaktif salgılanmasının) temel fizyolojik amacı aşağıdakilerden hangisidir?',
      options: [
        'Mide boşluğundaki asidik ortamı nötralize etmek',
        'Proteinlerin sindirimini yavaşlatarak emilimi kolaylaştırmak',
        'Mide mukozasını ve kendi kendini (mide hücrelerini) sindirmesini önlemek',
        'İnce bağırsaktaki sindirime hazırlık yapmak'
      ],
      correctIndex: 2), // Protein sindiren enzimler üretildikleri hücreleri sindirmesin diye inaktif salgılanır.
  Question(
      id: 148,
      examType: 'AYT',
      subject: 'Biyoloji',
      questionText:
          'Bir insanda kan şekerinin (glikoz) normal seviyenin altına düştüğü bir durumda uyarılan pankreas, kana glukagon hormonu salgılar. Glukagonun hedef organı ve bu organdaki temel etkisi aşağıdakilerden hangisinde doğru verilmiştir?',
      options: [
        'Karaciğer - Glikojenin glikoza yıkılarak kana verilmesi',
        'Kaslar - Glikozun kas hücrelerine alınması',
        'Böbrekler - İdrarla glikoz atılımının tamamen durdurulması',
        'Pankreas insülin hücreleri - İnsülin üretiminin artırılması'
      ],
      correctIndex: 0), // Glukagon karaciğeri uyararak depo glikojeni glikoza çevirir ve kana verir, böylece kan şekeri yükselir.
  Question(
      id: 149,
      examType: 'AYT',
      subject: 'Biyoloji',
      questionText:
          'Mitokondrinin iç zarında (krista) yer alan Elektron Taşıma Sistemi (ETS) elemanları, elektronları taşıyarak matriksten zarlar arası boşluğa proton (H⁺) pompalar. Bu durum zarlar arasında bir proton derişimi farkı (eğim) yaratır. Bu elektrokimyasal eğim hangi molekülün sentezlenmesi için doğrudan itici güç sağlar? (Kemiosmotik hipotez)',
      options: ['NADH', 'FADH2', 'Karbondioksit (CO2)', 'ATP (Adenozin Trifosfat)'],
      correctIndex: 3), // Kemiosmotik hipoteze göre protonlar ATP sentazdan geri dönerken ATP sentezlenir.
  Question(
      id: 150,
      examType: 'AYT',
      subject: 'Biyoloji',
      questionText:
          'DNA replikasyonu (kendini eşlemesi) sırasında;\nI. Helikaz enziminin hidrojen bağlarını koparması\nII. DNA polimerazın yeni zincire uygun nükleotitleri eklemesi\nIII. DNA ligazın Okazaki fragmanlarını birleştirmesi\nolaylarının gerçekleşme sırası aşağıdakilerden hangisinde doğru verilmiştir?',
      options: ['I - II - III', 'I - III - II', 'II - I - III', 'III - I - II'],
      correctIndex: 0), // Önce helikaz açar, polimeraz örer, ligaz parçaları birleştirir.
  Question(
      id: 151,
      examType: 'AYT',
      subject: 'Biyoloji',
      questionText:
          'Oksijenli solunum ve laktik asit fermantasyonu yapan iki farklı memeli kas hücresi karşılaştırıldığında;\nI. Glikoliz evresinin sitoplazmada gerçekleşmesi\nII. NAD⁺ koenziminin indirgenmesi\nIII. Karbondioksit (CO2) çıkışının olması\nözelliklerinden hangileri her iki süreç için de ortaktır?',
      options: ['Yalnız I', 'I ve II', 'II ve III', 'I, II ve III'],
      correctIndex: 1), // Glikoliz ortaktır (I). Glikolizde NAD+ NADH'a indirgenir (II). Oksijenlide ve etil alkolde CO2 çıkar ama laktik asit fermantasyonunda CO2 çıkmaz (III yanlış).
  Question(
      id: 152,
      examType: 'AYT',
      subject: 'Biyoloji',
      questionText:
          'İnsan böbreğinde bir nefronun Bowman kapsülünden süzülen sıvı içindeki yararlı maddelerin (örneğin glikozun ve aminoasitlerin %100\'ünün) kana geri emildiği(reabsorpsiyon) ilk ve en yoğun kanal bölümü neresidir?',
      options: ['Henle kulpunun inen kolu', 'Henle kulpunun çıkan kolu', 'Proksimal tüp', 'Distal tüp'],
      correctIndex: 2), // Besin monomerlerinin tamamı proksimal tüpte geri emilir.
  Question(
      id: 153,
      examType: 'AYT',
      subject: 'Biyoloji',
      questionText:
          'Mendel genetiğine göre, AABbCc ve AaBbcc genotipli iki bireyin çaprazlanması sonucunda, tüm karakterler bakımından çekinik (aabbcc) fenotipli bir bireyin oluşma olasılığı kaçtır? (Genler bağımsızdır)',
      options: ['0', '1/8', '1/16', '1/64'],
      correctIndex: 0), // İlk bireyden daima büyük 'A' geni gelir. aa olma ihtimali 0'dır. Bu nedenle aabbcc birey oluşamaz (İhtimal 0).
  Question(
      id: 154,
      examType: 'AYT',
      subject: 'Biyoloji',
      questionText:
          'Çiçekli bitkilerde çift döllenme olayı gerçekleşir. Döllenme sırasında polen tüpünden gelen sperm çekirdeklerinden biri yumurtayı döllerken, diğeri embriyo kesesindeki polar çekirdeklerle birleşir. Polar çekirdeklerin döllenmesi sonucunda oluşan yapı aşağıdakilerden hangisidir?',
      options: ['Embriyo (2n)', 'Tohum kabuğu (2n)', 'Endosperm (Besi doku) (3n)', 'Meyve eti (2n)'],
      correctIndex: 2), // Polar çekirdekler (n+n) + Sperm (n) = Endosperm (3n). Yumurta (n) + Sperm (n) = Zigot (2n).
  Question(
      id: 155,
      examType: 'AYT',
      subject: 'Biyoloji',
      questionText:
          'Bir popülasyon genetiği çalışmasında, Hardy-Weinberg dengesindeki bir popülasyonda çekinik (otozomal resesif) bir hastalığın görülme sıklığı q² = 0.04 olarak hesaplanmıştır. Bu popülasyonda taşıyıcı (heterozigot) bireylerin oranı (2pq) kaçtır?',
      options: ['0.16', '0.32', '0.64', '0.96'],
      correctIndex: 1), // q²=0.04 => q=0.2. p+q=1 => p=0.8. Heterozigot (2pq) = 2 * 0.8 * 0.2 = 0.32 (%32).
  Question(
      id: 156,
      examType: 'AYT',
      subject: 'Biyoloji',
      questionText:
          'İnsan bağışıklık (immün) sisteminde özgül bağışıklığı sağlayan B ve T lenfositleri ile ilgili;\nI. B lenfositleri antikor üreterek sıvısal (hümoral) bağışıklık sağlar.\nII. T lenfositleri enfekte olmuş hücreleri doğrudan yok ederek hücresel bağışıklık sağlar.\nIII. Her ikisi de timüs bezinde olgunlaşır.\nifadelerinden hangileri doğrudur?',
      options: ['Yalnız I', 'Yalnız II', 'I ve II', 'I, II ve III'],
      correctIndex: 2), // B lenfositler kemik iliğinde (Bone marrow), T lenfositler Timüste olgunlaşır. (III yanlış). I ve II doğru.
  Question(
      id: 157,
      examType: 'AYT',
      subject: 'Biyoloji',
      questionText:
          'İskelet kasının (çizgili kasın) kasılması sırasında, Huxley’in "Kayan İplikler Hipotezi"ne göre sarkomerin yapısında meydana gelen değişikliklerle ilgili olarak aşağıdakilerden hangisi yanlıştır?',
      options: [
        'Z çizgileri birbirine yaklaşır.',
        'H bandı daralır veya kaybolur.',
        'Sarkomerin boyu kısalır.',
        'A bandının boyu (Miyozin uzunluğu) kısalır.'
      ],
      correctIndex: 3), // Kasılma sırasında miyozin ve aktin ipliklerin kendi boyları DEĞİŞMEZ. Dolayısıyla A bandının boyu (miyozin boyu) değişmez. Sadece birbirleri üzerinde kayarlar.
  Question(
      id: 158,
      examType: 'AYT',
      subject: 'Biyoloji',
      questionText:
          'Merkezi sinir sisteminde yer alan beynin bölümleri ve görevleriyle ilgili olarak;\nI. Uç beyin (Serebrum): Öğrenme, hafıza, istemli hareketler.\nII. Beyincik (Serebellum): Denge ve kas koordinasyonu.\nIII. Omurilik soğanı (Medulla oblongata): Solunum, dolaşım gibi hayati organların çalışmasını kontrol etme.\neleştirmelerinden hangileri doğrudur?',
      options: ['Yalnız I', 'I ve II', 'II ve III', 'I, II ve III'],
      correctIndex: 3), // Verilen eşleştirmelerin üçü de beynin ilgili kısımlarının temel görevleridir.
  Question(
      id: 159,
      examType: 'AYT',
      subject: 'Biyoloji',
      questionText:
          'Kloroplast organelinde fotosentezin ışığa bağımlı ve ışıktan bağımsız (Kalvin döngüsü) reaksiyonları gerçekleşir.\nBuna göre ışıktan bağımsız reaksiyonlar (Kalvin döngüsü) için;\nI. Stromada gerçekleşir.\nII. CO2 (Karbondioksit) tüketilir.\nIII. Işığa bağımlı evreden gelen ATP ve NADPH molekülleri harcanır.\nyargılarından hangileri doğrudur?',
      options: ['Yalnız I', 'I ve II', 'II ve III', 'I, II ve III'],
      correctIndex: 3), // Üçü de ışığından bağımsız reaksiyonların (karanlık evre) özelliğidir.
  Question(
      id: 160,
      examType: 'AYT',
      subject: 'Biyoloji',
      questionText:
          'Bitkilerde madde taşınmasını sağlayan ksilem (odun borusu) ve floem (soymuk borusu) ile ilgili aşağıdakilerden hangisi yanlıştır?',
      options: [
        'Ksilemde taşıma tek yönlüdür (kökten yapraklara doğru).',
        'Floemde taşıma çift yönlü olabilir (yapraktan köke veya kökten yaprağa).',
        'Ksilem hücreleri ölüdür, floem hücreleri ise canlıdır.',
        'Ksilem borularında inorganik maddeler taşınırken, su taşınması sadece floemde gerçekleşir.'
      ],
      correctIndex: 3), // Suyun ana taşınma yolu ksilemdir, floemde gerçekleşir ifadesi yanlıştır. Ksilem su ve mineralleri, floem ise organik besinleri ve suyu taşır. Ksilem su iletimi için özelleşmiştir.

  // ─────────────── AYT EDEBİYAT ───────────────
  Question(id: 161, examType: 'AYT', subject: 'Edebiyat', questionText: 'Servet-i Fünun dönemi hangi yıllar arasında etkindir?', options: ['1860-1876', '1895-1901', '1911-1923', '1923-1940'], correctIndex: 1),
  Question(id: 162, examType: 'AYT', subject: 'Edebiyat', questionText: 'Halit Ziya Uşaklıgil\'in en önemli romanı hangisidir?', options: ['İnce Memed', 'Aşk-ı Memnu', 'Kiralık Konak', 'Yaban'], correctIndex: 1),
  Question(id: 163, examType: 'AYT', subject: 'Edebiyat', questionText: '"Divan edebiyatı"nın dili ağırlıklı olarak hangisidir?', options: ['Türkçe', 'Arapça-Farsça ağırlıklı Osmanlıca', 'Farsça', 'Arapça'], correctIndex: 1),
  Question(id: 164, examType: 'AYT', subject: 'Edebiyat', questionText: 'Gazel nazım biçiminin kafiye şeması hangisidir?', options: ['aa-bb-cc', 'aa-ba-ca-da', 'ab-ab-cc', 'aabb'], correctIndex: 1),
  Question(id: 165, examType: 'AYT', subject: 'Edebiyat', questionText: 'Tanzimat edebiyatında "halk için sanat" görüşünü savunan isim hangisidir?', options: ['Namık Kemal', 'Şinasi', 'Ziya Paşa', 'Ahmet Mithat Efendi'], correctIndex: 3),
  Question(id: 166, examType: 'AYT', subject: 'Edebiyat', questionText: 'Cumhuriyet dönemi edebiyatında köy romanları akımının öncüsü sayılan yazar kimdir?', options: ['Refik Halit Karay', 'Yakup Kadri Karaosmanoğlu', 'Mahmut Makal', 'Orhan Kemal'], correctIndex: 2),
  Question(id: 167, examType: 'AYT', subject: 'Edebiyat', questionText: 'Hece ölçüsüyle yazılan şiir hangi geleneğe aittir?', options: ['Divan edebiyatı', 'Halk edebiyatı', 'Batı edebiyatı', 'Modern Türk şiiri'], correctIndex: 1),
  Question(id: 168, examType: 'AYT', subject: 'Edebiyat', questionText: 'Yunus Emre hangi edebi geleneğe mensuptur?', options: ['Divan edebiyatı', 'Halk-tasavvuf edebiyatı', 'Tanzimat edebiyatı', 'Milli edebiyat'], correctIndex: 1),
  Question(id: 169, examType: 'AYT', subject: 'Edebiyat', questionText: 'Epik tiyatronun kurucusu kimdir?', options: ['Sofokles', 'Brecht', 'Shakespeare', 'Molière'], correctIndex: 1),
  Question(id: 170, examType: 'AYT', subject: 'Edebiyat', questionText: '"Bilinç akışı" tekniği hangi yazınsal dönemle ilişkilendirilir?', options: ['Realizm', 'Modernizm', 'Romantizm', 'Natüralizm'], correctIndex: 1),

  // ─────────────── AYT TARİH ───────────────
  Question(id: 171, examType: 'AYT', subject: 'Tarih', questionText: 'Magna Carta hangi yılda imzalanmıştır?', options: ['1066', '1215', '1453', '1689'], correctIndex: 1),
  Question(id: 172, examType: 'AYT', subject: 'Tarih', questionText: 'Fransız Devrimi hangi yılda başlamıştır?', options: ['1776', '1789', '1804', '1815'], correctIndex: 1),
  Question(id: 173, examType: 'AYT', subject: 'Tarih', questionText: 'Osmanlı\'da Tanzimat Fermanı hangi padişah döneminde yayımlanmıştır?', options: ['II. Mahmut', 'Abdülmecit', 'Abdülaziz', 'II. Abdülhamit'], correctIndex: 1),
  Question(id: 174, examType: 'AYT', subject: 'Tarih', questionText: 'Birinci Dünya Savaşı\'nı sona erdiren antlaşma hangisidir?', options: ['Versay Antlaşması', 'Lozan Antlaşması', 'Paris Antlaşması', 'Sevr Antlaşması'], correctIndex: 0),
  Question(id: 175, examType: 'AYT', subject: 'Tarih', questionText: 'Türk Bağımsızlık Savaşı hangi antlaşmayla sonuçlandı?', options: ['Mondros', 'Sevr', 'Lausanne (Lozan)', 'Ankara'], correctIndex: 2),
  Question(id: 176, examType: 'AYT', subject: 'Tarih', questionText: 'İkinci Dünya Savaşı hangi yılda sona ermiştir?', options: ['1943', '1944', '1945', '1946'], correctIndex: 2),
  Question(id: 177, examType: 'AYT', subject: 'Tarih', questionText: 'Sanayi Devrimi ilk olarak hangi ülkede başlamıştır?', options: ['Fransa', 'Almanya', 'İngiltere', 'ABD'], correctIndex: 2),
  Question(id: 178, examType: 'AYT', subject: 'Tarih', questionText: 'Osmanlı\'nın Viyana kuşatmasının son başarısız girişimi hangi yıldadır?', options: ['1529', '1683', '1718', '1774'], correctIndex: 1),
  Question(id: 179, examType: 'AYT', subject: 'Tarih', questionText: 'Kurtuluş Savaşı\'nda Büyük Taarruz hangi cephede gerçekleşmiştir?', options: ['Doğu Cephesi', 'Kuzey Cephesi', 'Batı Cephesi', 'Güney Cephesi'], correctIndex: 2),
  Question(id: 180, examType: 'AYT', subject: 'Tarih', questionText: 'Atatürk\'ün ölüm yılı hangisidir?', options: ['1936', '1937', '1938', '1939'], correctIndex: 2),

  // ─────────────── AYT COĞRAFYA ───────────────
  Question(id: 181, examType: 'AYT', subject: 'Coğrafya', questionText: 'Dünyanın en büyük kıtası hangisidir?', options: ['Afrika', 'Kuzey Amerika', 'Asya', 'Avrupa'], correctIndex: 2),
  Question(id: 182, examType: 'AYT', subject: 'Coğrafya', questionText: 'Türkiye\'de yıllık yağış miktarı en yüksek bölge hangisidir?', options: ['İç Anadolu', 'Karadeniz Bölgesi', 'Akdeniz Bölgesi', 'Güneydoğu Anadolu'], correctIndex: 1),
  Question(id: 183, examType: 'AYT', subject: 'Coğrafya', questionText: 'Nil nehrinin döküldüğü okyanus/deniz hangisidir?', options: ['Hint Okyanusu', 'Kızıldeniz', 'Akdeniz', 'Karadeniz'], correctIndex: 2),
  Question(id: 184, examType: 'AYT', subject: 'Coğrafya', questionText: 'Türkiye\'de en fazla hububat yetiştirilen bölge hangisidir?', options: ['Karadeniz', 'İç Anadolu', 'Ege', 'Marmara'], correctIndex: 1),
  Question(id: 185, examType: 'AYT', subject: 'Coğrafya', questionText: 'Amazon havzası hangi kıtada yer alır?', options: ['Afrika', 'Asya', 'Güney Amerika', 'Kuzey Amerika'], correctIndex: 2),
  Question(id: 186, examType: 'AYT', subject: 'Coğrafya', questionText: 'Türkiye\'nin en büyük gölü hangisidir?', options: ['Beyşehir', 'Eğirdir', 'Van', 'Tuz'], correctIndex: 2),
  Question(id: 187, examType: 'AYT', subject: 'Coğrafya', questionText: 'İklim değişikliği eğitiminde "sera etkisi"ne neden olan başlıca gaz hangisidir?', options: ['Oksijen', 'Azot', 'Karbondioksit', 'Argon'], correctIndex: 2),
  Question(id: 188, examType: 'AYT', subject: 'Coğrafya', questionText: 'Çölleşmeyle mücadelede en etkili yöntemlerden biri hangisidir?', options: ['Sulama kanalları azaltmak', 'Ağaçlandırma', 'Nüfus artışı', 'Endüstrileşme'], correctIndex: 1),
  Question(id: 189, examType: 'AYT', subject: 'Coğrafya', questionText: 'Türkiye boğazlarından birinin adı Çanakkale; diğeri hangisidir?', options: ['Süveyş', 'Hürmüz', 'İstanbul (Boğaziçi)', 'Gibraltar'], correctIndex: 2),
  Question(id: 190, examType: 'AYT', subject: 'Coğrafya', questionText: 'Endonezya hangi bölgede yer alır?', options: ['Orta Asya', 'Güneydoğu Asya', 'Güney Asya', 'Doğu Asya'], correctIndex: 1),

  // ─────────────── AYT EK SORULAR ───────────────
  Question(id: 191, examType: 'AYT', subject: 'Matematik', questionText: 'Vektörlerin iç çarpımı (dot product) nasıl hesaplanır? a·b = ?', options: ['|a||b|sinθ', '|a||b|cosθ', '|a|+|b|', '|a|-|b|'], correctIndex: 1),
  Question(id: 192, examType: 'AYT', subject: 'Fizik', questionText: 'Joule neyin birimidir?', options: ['Güç', 'Basınç', 'Enerji', 'Kuvvet'], correctIndex: 2),
  Question(id: 193, examType: 'AYT', subject: 'Kimya', questionText: 'Mol kütlesi en yüksek olan element hangisidir? (periyodik tablo)', options: ['Altın', 'Kurşun', 'Oganesson', 'Uranyum'], correctIndex: 2),
  Question(id: 194, examType: 'AYT', subject: 'Biyoloji', questionText: 'İnsan vücudunda kaç kemik bulunur (yetişkinde)?', options: ['180', '206', '230', '256'], correctIndex: 1),
  Question(id: 195, examType: 'AYT', subject: 'Edebiyat', questionText: 'Şiirde "kafiye" nedir?', options: ['Şiirin başlığı', 'Dizelerin sonundaki ses uyumu', 'Şiirin teması', 'Şiir türü'], correctIndex: 1),
  Question(id: 196, examType: 'AYT', subject: 'Tarih', questionText: 'Osmanlı Devleti kaç yıl hüküm sürmüştür (yaklaşık)?', options: ['400', '500', '600', '700'], correctIndex: 2),
  Question(id: 197, examType: 'AYT', subject: 'Coğrafya', questionText: 'Türkiye\'nin yüzölçümü yaklaşık kaç km²\'dir?', options: ['480.000', '585.000', '780.000', '920.000'], correctIndex: 2),
  Question(id: 198, examType: 'AYT', subject: 'Fizik', questionText: 'p = mv formülünde p neyi temsil eder?', options: ['Güç', 'Basınç', 'Momentum', 'Potansiyel enerji'], correctIndex: 2),
  Question(id: 199, examType: 'AYT', subject: 'Kimya', questionText: 'Demir (Fe) periyodik tabloda kaçıncı grupta yer alır?', options: ['Grup 6', 'Grup 8', 'Grup 10', 'Grup 14'], correctIndex: 1),
  Question(id: 200, examType: 'AYT', subject: 'Biyoloji', questionText: 'Sinir sisteminin temel hücre birimi nedir?', options: ['Akson', 'Nöron', 'Sinaps', 'Miyelin kılıf'], correctIndex: 1),
  Question(id: 201, examType: 'AYT', subject: 'Matematik', questionText: 'Bir fonksiyonun türevi sıfır olan noktalarına ne denir?', options: ['İnfleksiyon noktası', 'Kritik nokta', 'Eksen kesimi', 'Sonsuzluk noktası'], correctIndex: 1),
  Question(id: 202, examType: 'AYT', subject: 'Fizik', questionText: 'Yüzey gerilimi hangi olgu ile ilgilidir?', options: ['Yerçekimi', 'Moleküller arası çekim kuvveti', 'Elektrik yükü', 'Manyetik alan'], correctIndex: 1),
  Question(id: 203, examType: 'AYT', subject: 'Kimya', questionText: 'Reaksiyon hızını etkileyen faktörlerden biri hangisidir?', options: ['Kabın rengi', 'Sıcaklık', 'Laboratuvar konumu', 'Araştırmacı sayısı'], correctIndex: 1),
  Question(id: 204, examType: 'AYT', subject: 'Biyoloji', questionText: 'Bitkilerde su taşıyan doku hangisidir?', options: ['Floem', 'Ksilem', 'Kambiyum', 'Epidermis'], correctIndex: 1),
  Question(id: 205, examType: 'AYT', subject: 'Edebiyat', questionText: 'Roman türünün ilk örnekleri hangi ülkede ortaya çıkmıştır?', options: ['Fransa', 'Almanya', 'İngiltere', 'İtalya'], correctIndex: 2),
  Question(id: 206, examType: 'AYT', subject: 'Tarih', questionText: 'Çanakkale Savaşları hangi yılda yaşanmıştır?', options: ['1914-1915', '1915-1916', '1916-1917', '1917-1918'], correctIndex: 1),
  Question(id: 207, examType: 'AYT', subject: 'Coğrafya', questionText: 'Aktif bir volkanın oluşturduğu en yaygin toprak tipi hangisidir?', options: ['Kil toprağı', 'Volkanik toprak (andosol)', 'Kum toprağı', 'Bataklık toprağı'], correctIndex: 1),
  Question(id: 208, examType: 'AYT', subject: 'Matematik', questionText: 'y = ln(x) fonksiyonunun türevi nedir?', options: ['ln(x)', 'x', '1/x', 'eˣ'], correctIndex: 2),
  Question(id: 209, examType: 'AYT', subject: 'Fizik', questionText: 'Yarıiletkenler hangi iki madde arasında iletkenlik gösterir?', options: ['İletkenler ve yarıiletkenler', 'İletkenler ve yalıtkanlar', 'Yalıtkanlar ve manyetik maddeler', 'Metal ve plastik'], correctIndex: 1),
  Question(id: 210, examType: 'AYT', subject: 'Kimya', questionText: 'Sabunlaşma (saponification) hangi tepkime türüdür?', options: ['Asit-baz tepkimesi', 'Ester hidrolizi', 'Redoks tepkimesi', 'Polimerizasyon'], correctIndex: 1),
  Question(id: 211, examType: 'AYT', subject: 'Biyoloji', questionText: 'Ribozom hangi bileşenlerden oluşur?', options: ['DNA ve protein', 'RNA ve protein', 'Lipid ve protein', 'Karbonhidrat ve protein'], correctIndex: 1),
  Question(id: 212, examType: 'AYT', subject: 'Edebiyat', questionText: 'Türk edebiyatında "Milli edebiyat" akımı hangi dönemde etkindir?', options: ['1860-1895', '1895-1911', '1911-1923', '1923-1950'], correctIndex: 2),
  Question(id: 213, examType: 'AYT', subject: 'Tarih', questionText: 'Osmanlı\'da Divan-ı Hümayun nedir?', options: ['Askeri konsey', 'Devlet meclisi/yüksek mahkeme', 'Dini kurul', 'Mali denetim kurulu'], correctIndex: 1),
  Question(id: 214, examType: 'AYT', subject: 'Coğrafya', questionText: 'Yer altı sularının oluşturduğu mağaralara ne ad verilir?', options: ['Vadi', 'Kanyon', 'Karstik mağara', 'Delta'], correctIndex: 2),
  Question(id: 215, examType: 'AYT', subject: 'Matematik', questionText: 'Karmaşık düzlemde sanal eksen neyi gösterir?', options: ['Gerçel kısmı', 'Sanal kısmı', 'Kompleks sayının büyüklüğünü', 'Açıyı'], correctIndex: 1),
  Question(id: 216, examType: 'AYT', subject: 'Fizik', questionText: 'Fotovoltaik hücreler hangi etkiden yararlanır?', options: ['Termoelektrik etki', 'Fotoelektrik etki', 'Piezoelektrik etki', 'Faraday etkisi'], correctIndex: 1),
  Question(id: 217, examType: 'AYT', subject: 'Kimya', questionText: 'Lewis asidi nedir?', options: ['Proton veren madde', 'Proton alan madde', 'Elektron çifti alan madde', 'Elektron çifti veren madde'], correctIndex: 2),
  Question(id: 218, examType: 'AYT', subject: 'Biyoloji', questionText: 'Bakteri gibi prokaryot hücrelerde çekirdek zarf', options: ['Bulunur', 'Bulunmaz', 'Sadece bölünürken bulunur', 'Kısmen bulunur'], correctIndex: 1),
  Question(id: 219, examType: 'AYT', subject: 'Tarih', questionText: 'Mustafa Kemal Atatürk Samsun\'a hangi tarihte çıkmıştır?', options: ['9 Mayıs 1919', '19 Mayıs 1919', '29 Ekim 1919', '23 Nisan 1919'], correctIndex: 1),
  Question(id: 220, examType: 'AYT', subject: 'Coğrafya', questionText: 'Türkiye\'de en fazla zeytinyağı üretimi hangi bölgede yapılır?', options: ['Karadeniz', 'İç Anadolu', 'Ege', 'Doğu Anadolu'], correctIndex: 2),
  Question(id: 221, examType: 'AYT', subject: 'Matematik', questionText: 'f(x) = sin(x) ise f\'\'(x) = ?', options: ['cos(x)', '-sin(x)', '-cos(x)', 'sin(x)'], correctIndex: 1),
  Question(id: 222, examType: 'AYT', subject: 'Fizik', questionText: 'Fotoelektrik olayda gelen ışığın frekansı artarsa hangisi artar?', options: ['Fotoelektronların hızı', 'Fotoelektronların sayısı', 'Durdurma potansiyeli', 'Metaldeki elektron sayısı'], correctIndex: 2),
  Question(id: 223, examType: 'AYT', subject: 'Kimya', questionText: 'Organik kimyada "alken"lerin genel formülü nedir?', options: ['CnH2n+2', 'CnH2n', 'CnH2n-2', 'CnHn'], correctIndex: 1),
  Question(id: 224, examType: 'AYT', subject: 'Biyoloji', questionText: 'İnsan vücudunda glikojenin fazlası nerede depolanır?', options: ['Mide', 'Karaciğer ve kaslar', 'İnce bağırsak', 'Beyin'], correctIndex: 1),
  Question(id: 225, examType: 'AYT', subject: 'Edebiyat', questionText: 'Modern Türk şiirinin "Garip" akımı temsilcileri kimlerdir?', options: ['O. Veli, M. Cevdet, R. Horozcu', 'N. Fazıl, A. Muhip, Ş. Erkoç', 'C. Süreya, E. Cansever, T. Uyar', 'A. İlhan, T. Yücel, H. Hüseyin'], correctIndex: 0),
  Question(id: 226, examType: 'AYT', subject: 'Tarih', questionText: 'Büyük Selçuklu Devleti ile Bizans arasındaki ilk büyük savaş hangisidir?', options: ['Malazgirt', 'Pasinler', 'Miryokefalon', 'Kösedağ'], correctIndex: 1),
  Question(id: 227, examType: 'AYT', subject: 'Coğrafya', questionText: 'Dünyadaki en derin çukur hangisidir?', options: ['Mariana Çukuru', 'Tonga Çukuru', 'Java Çukuru', 'Philippine Çukuru'], correctIndex: 0),
  Question(id: 228, examType: 'AYT', subject: 'Matematik', questionText: 'log₂(32) + log₂(8) = ?', options: ['5', '8', '13', '40'], correctIndex: 1),
  Question(id: 229, examType: 'AYT', subject: 'Fizik', questionText: 'Bir telin direnci boyuna bağlı mıdır?', options: ['Evet, doğru orantılıdır', 'Evet, ters orantılıdır', 'Hayır, bağlı değildir', 'Sadece voltaja bağlıdır'], correctIndex: 0),
  Question(id: 230, examType: 'AYT', subject: 'Kimya', questionText: 'Suyun oto-iyonizasyon sabiti (Kw) 25°C\'de kaçtır?', options: ['10⁻⁷', '10⁻¹⁴', '10⁷', '10¹⁴'], correctIndex: 1),
  Question(id: 231, examType: 'AYT', subject: 'Biyoloji', questionText: 'DNA replikasyonu hangi enzim tarafından gerçekleştirilir?', options: ['RNA polimeraz', 'Helikaz', 'DNA polimeraz', 'Ligaz'], correctIndex: 2),
  Question(id: 232, examType: 'AYT', subject: 'Edebiyat', questionText: '"Şair-i Azam" olarak bilinen edebiyatçımız kimdir?', options: ['Namık Kemal', 'Abdülhak Hamit Tarhan', 'Tevfik Fikret', 'Yunus Emre'], correctIndex: 1),
  Question(id: 233, examType: 'AYT', subject: 'Tarih', questionText: 'Kutadgu Bilig adlı eserin yazarı kimdir?', options: ['Kaşgarlı Mahmut', 'Edip Ahmet Yükneki', 'Yusuf Has Hacip', 'Ahmet Yesevi'], correctIndex: 2),
  Question(id: 234, examType: 'AYT', subject: 'Coğrafya', questionText: 'Türkiye\'nin kuzey ucu neresidir?', options: ['İnceburun', 'Anamur', 'Iğdır', 'Edirne'], correctIndex: 0),
  Question(id: 235, examType: 'AYT', subject: 'Matematik', questionText: 'Karmaşık sayı i⁴ + i² = ?', options: ['0', '1', '-1', '2i'], correctIndex: 0),
  Question(id: 236, examType: 'AYT', subject: 'Fizik', questionText: 'Transformatörler ne tür akımla çalışır?', options: ['Doğru akım (DC)', 'Alternatif akım (AC)', 'Her ikisi de', 'Pille çalışmaz'], correctIndex: 1),
  Question(id: 237, examType: 'AYT', subject: 'Kimya', questionText: 'Periyodik cetvelde soy gazlar hangi grupta yer alır?', options: ['1A', '2A', '7A', '8A'], correctIndex: 3),
  Question(id: 238, examType: 'AYT', subject: 'Biyoloji', questionText: 'Hücre içindeki protein sentezinden hangi organel sorumludur?', options: ['Sadece çekirdek', 'Ribozom', 'Lizozom', 'Koful'], correctIndex: 1),
  Question(id: 239, examType: 'AYT', subject: 'Edebiyat', questionText: 'Aruz ölçüsünü kullanan ilk Türk şairi kimdir?', options: ['Fuzuli', 'Baki', 'Yusuf Has Hacip', 'Ahmet Paşa'], correctIndex: 2),
  Question(id: 240, examType: 'AYT', subject: 'Tarih', questionText: 'Anadolu Türk birliğini ilk kez kuran beylik hangisidir?', options: ['Osmanoğulları', 'Karesioğulları', 'Selçuklular', 'Dulkadiroğulları'], correctIndex: 2),
  Question(id: 241, examType: 'AYT', subject: 'Coğrafya', questionText: 'Atmosferdeki gazların %78\'ini hangi gaz oluşturur?', options: ['Oksijen', 'Karbon', 'Azot', 'Argon'], correctIndex: 2),
  Question(id: 242, examType: 'AYT', subject: 'Matematik', questionText: 'lim(x→∞) (2x+1)/(x-3) = ?', options: ['0', '1', '2', '∞'], correctIndex: 2),
  Question(id: 243, examType: 'AYT', subject: 'Fizik', questionText: 'Merkezcil kuvvet formülü hangisidir?', options: ['mv/r', 'mv²/r', 'mvr', 'mr/v²'], correctIndex: 1),
  Question(id: 244, examType: 'AYT', subject: 'Kimya', questionText: 'Hangi bağ türü daha zayıftır?', options: ['İyonik bağ', 'Kovalent bağ', 'Hidrojen bağı', 'Metalik bağ'], correctIndex: 2),
  Question(id: 245, examType: 'AYT', subject: 'Biyoloji', questionText: 'Enzim aktivitesini artıran maddelere ne denir?', options: ['İnhibitör', 'Aktivatör', 'Katalizör', 'Vektör'], correctIndex: 1),
  Question(id: 246, examType: 'AYT', subject: 'Edebiyat', questionText: '"Mai ve Siyah" romanının yazarı kimdir?', options: ['Halit Ziya Uşaklıgil', 'Mehmet Rauf', 'Recaizade Mahmut Ekrem', 'Namık Kemal'], correctIndex: 0),
  Question(id: 247, examType: 'AYT', subject: 'Tarih', questionText: 'Cumhuriyet döneminde yapılan ilk demir yolu hattı hangisidir?', options: ['İstanbul-Ankara', 'İzmir-Aydın', 'Ankara-Sivas', 'Kayseri-Erzurum'], correctIndex: 1),
  Question(id: 248, examType: 'AYT', subject: 'Coğrafya', questionText: 'Türkiye\'nin en büyük ovası hangisidir?', options: ['Çukurova', 'Konya Ovası', 'Erzurum-Kars Ovası', 'Gediz Ovası'], correctIndex: 1),
  Question(id: 249, examType: 'AYT', subject: 'Matematik', questionText: 'cos(0) + sin(90) = ?', options: ['0', '1', '2', '-1'], correctIndex: 2),
  Question(id: 250, examType: 'AYT', subject: 'Fizik', questionText: 'Kırılma indisi en büyük olan madde hangisidir (bilinen)?', options: ['Cam', 'Su', 'Elmas', 'Hava'], correctIndex: 2),
  Question(id: 251, examType: 'AYT', subject: 'Kimya', questionText: 'Asetilenin (C₂H₂) sistematik adı nedir?', options: ['Etan', 'Eten', 'Etin', 'Propin'], correctIndex: 2),
  Question(id: 252, examType: 'AYT', subject: 'Biyoloji', questionText: 'Sinir siteminde impuls iletimi nasıldır?', options: ['Sadece elektriksel', 'Sadece kimyasal', 'Elektro-kimyasal', 'Mekanik'], correctIndex: 2),
  Question(id: 253, examType: 'AYT', subject: 'Edebiyat', questionText: 'Divan edebiyatında aşk konulu şiirlere ne ad verilir?', options: ['Mersiye', 'Gazel', 'Kaside', 'Mesnevi'], correctIndex: 1),
  Question(id: 254, examType: 'AYT', subject: 'Tarih', questionText: 'Kurtuluş Savaşı\'nda Güney Cephesi hangi antlaşma ile kapandı?', options: ['Mudanya', 'Moskova', 'Ankara Antlaşması', 'Gümrü Antlaşması'], correctIndex: 2),
  Question(id: 255, examType: 'AYT', subject: 'Coğrafya', questionText: 'Dünyanın kendi etrafındaki dönüş hızı ekvatordan kutuplara doğru nasıl değişir?', options: ['Artar', 'Azalır', 'Değişmez', 'Önce artar sonra azalır'], correctIndex: 1),
  Question(id: 256, examType: 'AYT', subject: 'Matematik', questionText: '∫ sin(x) dx = ?', options: ['cos(x)+C', '-cos(x)+C', 'sin(x)+C', '-sin(x)+C'], correctIndex: 1),
  Question(id: 257, examType: 'AYT', subject: 'Fizik', questionText: 'Momentumun birimi nedir?', options: ['kg m/s', 'kg m²/s²', 'N s/m', 'Watt'], correctIndex: 0),
  Question(id: 258, examType: 'AYT', subject: 'Kimya', questionText: 'Hangisi bir Lewis bazıdır?', options: ['BF3', 'NH3', 'AlCl3', 'H+'], correctIndex: 1),
  Question(id: 259, examType: 'AYT', subject: 'Biyoloji', questionText: 'Pankreastan salgılanan ve kan şekerini düşüren hormon nedir?', options: ['Glukagon', 'İnsülin', 'Adrenalin', 'Tiroksin'], correctIndex: 1),
  Question(id: 260, examType: 'AYT', subject: 'Edebiyat', questionText: '"Çalıkuşu" romanının baş kahramanı kimdir?', options: ['Bihter', 'Feride', 'Eylül', 'Zehra'], correctIndex: 1),
  Question(id: 261, examType: 'AYT', subject: 'Tarih', questionText: 'Osmanlı İmparatorluğu\'nun son padişahı kimdir?', options: ['V. Mehmed Reşad', 'VI. Mehmed Vahdeddin', 'II. Abdülhamid', 'Abdülaziz'], correctIndex: 1),
  Question(id: 262, examType: 'AYT', subject: 'Coğrafya', questionText: 'Türkiye\'de epirojenezin en belirgin örneği hangisidir?', options: ['Ergene Havzası\'nın çökmesi', 'Doğu Anadolu\'nun yükselmesi', 'Delta ovalarının oluşumu', 'Hepsi'], correctIndex: 3),
  Question(id: 263, examType: 'AYT', subject: 'Matematik', questionText: 'e^(ln 5) = ?', options: ['1', '5', 'e', 'ln 5'], correctIndex: 1),
  Question(id: 264, examType: 'AYT', subject: 'Fizik', questionText: 'Potansiyel farkın birimi nedir?', options: ['Amper', 'Volt', 'Watt', 'Ohm'], correctIndex: 1),
  Question(id: 265, examType: 'AYT', subject: 'Kimya', questionText: 'İdeal gazlarda sabit basınçta hacim ve sıcaklık ilişkisine ne denir?', options: ['Boyle Yasası', 'Charles Yasası', 'Gay-Lussac Yasası', 'Avogadro Yasası'], correctIndex: 1),
  Question(id: 266, examType: 'AYT', subject: 'Biyoloji', questionText: 'Vücudumuzdaki en sert doku hangisidir?', options: ['Diş minesi', 'Kemik dokusu', 'Kıkırdak doku', 'Sinir dokusu'], correctIndex: 0),
  Question(id: 267, examType: 'AYT', subject: 'Edebiyat', questionText: 'Ziya Gökalp hangi edebi akıma mensuptur?', options: ['Fecr-i Ati', 'Servet-i Fünun', 'Milli Edebiyat', 'Cumhuriyet'], correctIndex: 2),
  Question(id: 268, examType: 'AYT', subject: 'Tarih', questionText: 'Osmanlı\'da ilk matbaa hangi dönemde kurulmuştur?', options: ['Yükselme Devri', 'Duraklama Devri', 'Lale Devri', 'Tanzimat Devri'], correctIndex: 2),
  Question(id: 269, examType: 'AYT', subject: 'Coğrafya', questionText: 'Engebeli arazilerde hangi enerji üretim potansiyeli yüksektir?', options: ['Güneş enerjisi', 'Rüzgar enerjisi', 'Hidroelektrik enerji', 'Jeotermal enerji'], correctIndex: 2),
  Question(id: 270, examType: 'AYT', subject: 'Matematik', questionText: 'P(A) = 0.3, P(B) = 0.4 ise ve bağımsızlarsa P(A ∩ B) = ?', options: ['0.7', '0.12', '0.1', '0.07'], correctIndex: 1),
  Question(id: 271, examType: 'AYT', subject: 'Edebiyat', questionText: '"Şiir dili" ile "günlük dil" arasındaki temel fark nedir?', options: ['Dilbilgisi kuralları', 'Anlam yoğunluğu ve çarpıcılık', 'Kelime sayısı', 'Yazım biçimi'], correctIndex: 1),
  Question(id: 272, examType: 'AYT', subject: 'Tarih', questionText: 'Fransız İhtilali\'nin öne sürdüğü "üç ilke" hangisidir?', options: ['Eşitlik, özgürlük, barış', 'Özgürlük, eşitlik, kardeşlik', 'Demokrasi, laiklik, cumhuriyet', 'Barış, adalet, özgürlük'], correctIndex: 1),
  Question(id: 273, examType: 'AYT', subject: 'Coğrafya', questionText: 'Türkiye\'de en fazla deprem hangi bölgede görülür?', options: ['Karadeniz', 'İç Anadolu', 'Marmara ve Ege', 'Güneydoğu Anadolu'], correctIndex: 2),
  Question(id: 274, examType: 'AYT', subject: 'Matematik', questionText: 'Bir dairenin yarıçapı 2 kat artarsa alanı kaç kat artar?', options: ['2', '4', '6', '8'], correctIndex: 1),
  Question(id: 275, examType: 'AYT', subject: 'Fizik', questionText: 'Serbest düşüşte yerçekimi ivmesi kaç m/s² dir?', options: ['8', '9.8', '10.2', '11'], correctIndex: 1),
  Question(id: 276, examType: 'AYT', subject: 'Kimya', questionText: 'Mol kavramı nedir?', options: ['6.022 × 10²³ tane parçacık', 'Maddenin kütlesi', 'Maddenin hacmi', 'Maddenin yoğunluğu'], correctIndex: 0),
  Question(id: 277, examType: 'AYT', subject: 'Biyoloji', questionText: 'Hücre bölünmesi sırasında DNA ne zaman eşlenir?', options: ['Profaz', 'Metafaz', 'İnterfaz', 'Anafaz'], correctIndex: 2),
  Question(id: 278, examType: 'AYT', subject: 'Edebiyat', questionText: 'Türk edebiyatında "şiir reformu"nun öncüsü kimdir?', options: ['Namık Kemal', 'Tevfik Fikret', 'Mehmet Akif Ersoy', 'Yahya Kemal'], correctIndex: 1),
  Question(id: 279, examType: 'AYT', subject: 'Tarih', questionText: 'I. Dünya Savaşı\'nı bitiren genel antlaşma hangisidir?', options: ['Versay Antlaşması', 'Lozan Antlaşması', 'Paris Antlaşması', 'Münih Antlaşması'], correctIndex: 0),
  Question(id: 280, examType: 'AYT', subject: 'Coğrafya', questionText: 'Ekvatora yakın bölgelerde hava kütleleri nasıl hareket eder?', options: ['Kutuplara doğru iner', 'Yükselir', 'Yatay kalır', 'İner'], correctIndex: 1),
  Question(id: 281, examType: 'AYT', subject: 'Matematik', questionText: 'sin²(x) + cos²(x) = ?', options: ['0', '1', '2', 'sin(2x)'], correctIndex: 1),
  Question(id: 282, examType: 'AYT', subject: 'Fizik', questionText: 'Ohm\'un yasası nedir?', options: ['V = IR', 'V = I/R', 'V = I²R', 'V = R/I'], correctIndex: 0),
  Question(id: 283, examType: 'AYT', subject: 'Kimya', questionText: 'Elementleri sınıflandıran periyodik cetvel kim tarafından oluşturulmuştur?', options: ['Einstein', 'Newton', 'Mendeleev', 'Bohr'], correctIndex: 2),
  Question(id: 284, examType: 'AYT', subject: 'Biyoloji', questionText: 'İnsan vücudunda kaç çift kromozom bulunur?', options: ['22', '23', '24', '46'], correctIndex: 1),
  Question(id: 285, examType: 'AYT', subject: 'Edebiyat', questionText: '"Hükümsüz Boşluk" adlı eser kimin kaleminden çıkmıştır?', options: ['Orhan Pamuk', 'Yaşar Kemal', 'Oğuz Atay', 'Ahmet Tanpınar'], correctIndex: 3),
  Question(id: 286, examType: 'AYT', subject: 'Tarih', questionText: 'Osmanlı\'da Tanzimat Fermanı hangi padişah döneminde ilan edildi?', options: ['II. Mahmut', 'Abdülmecit', 'Abdülaziz', 'II. Abdülhamit'], correctIndex: 1),
  Question(id: 287, examType: 'AYT', subject: 'Coğrafya', questionText: 'Dünya\'nın en büyük okyanusu hangisidir?', options: ['Atlantik', 'Hint', 'Arktik', 'Pasifik'], correctIndex: 3),
  Question(id: 288, examType: 'AYT', subject: 'Matematik', questionText: 'Bir geometrik dizinin ilk terimi 3, ortak oranı 2 ise 5. terimi kaçtır?', options: ['24', '48', '36', '96'], correctIndex: 1),
  Question(id: 289, examType: 'AYT', subject: 'Fizik', questionText: 'Elektromanyetik dalgaların en kısa dalga boylu olanı hangisidir?', options: ['Radyo dalgaları', 'Kızılötesi', 'Görünür ışık', 'Gama ışınları'], correctIndex: 3),
  Question(id: 290, examType: 'AYT', subject: 'Kimya', questionText: 'NaOH güçlü bir baz mıdır?', options: ['Hayır', 'Evet', 'Zayıf bazdır', 'Asittir'], correctIndex: 1),
  Question(id: 291, examType: 'AYT', subject: 'Biyoloji', questionText: 'Kalıtsal bilginin aktarılmasında görev yapan temel molekül hangisidir?', options: ['Protein', 'RNA', 'DNA', 'Lipid'], correctIndex: 2),
  Question(id: 292, examType: 'AYT', subject: 'Edebiyat', questionText: '"Kırık Bir Aşk Hikayesi" Türk edebiyatı bağlamında hangi döneme aittir?', options: ['Tanzimat', 'Servet-i Fünun', 'Milli Edebiyat', 'Cumhuriyet'], correctIndex: 1),
  Question(id: 293, examType: 'AYT', subject: 'Tarih', questionText: 'Kore Savaşı\'nda Türkiye hangi cephede yer almıştır?', options: ['Kuzey Kore Cephesi', 'Güney Kore Cephesi', 'BM koalisyon kuvvetleri', 'Çin Cephesi'], correctIndex: 2),
  Question(id: 294, examType: 'AYT', subject: 'Coğrafya', questionText: 'Türkiye\'nin hangi bölgesinde muz yetiştirilir?', options: ['Karadeniz', 'Ege', 'Akdeniz (Alanya)', 'Marmara'], correctIndex: 2),
  Question(id: 295, examType: 'AYT', subject: 'Matematik', questionText: 'lim(x→0) sin(x)/x = ?', options: ['0', '∞', '1', 'Tanımsız'], correctIndex: 2),
  Question(id: 296, examType: 'AYT', subject: 'Fizik', questionText: 'Yarıiletkenler hangi materyallerden oluşur?', options: ['Bakır ve demir', 'Silisyum ve germanyum', 'Cam ve plastik', 'Altın ve gümüş'], correctIndex: 1),
  Question(id: 297, examType: 'AYT', subject: 'Kimya', questionText: 'Organik kimyada "ester" hangisinden oluşur?', options: ['Asit + su', 'Alkol + karboksilik asit', 'Amin + asit', 'Eter + baz'], correctIndex: 1),
  Question(id: 298, examType: 'AYT', subject: 'Biyoloji', questionText: 'Hücre zarının temel yapısı nasıldır?', options: ['Tek katlı protein tabakası', 'Çift katlı lipit tabakası (fosfolipit)', 'Selüloz duvarı', 'Kolesterol tabakası'], correctIndex: 1),
  Question(id: 299, examType: 'AYT', subject: 'Edebiyat', questionText: '"Batı etkisinde gelişen Türk edebiyatı" hangi dönemde başlar?', options: ['Divan edebiyatıyla', 'Tanzimat döneminde', 'Cumhuriyet döneminde', 'Futurizm akımıyla'], correctIndex: 1),
  Question(id: 300, examType: 'AYT', subject: 'Tarih', questionText: 'Atatürk\'ün "Nutuk" adlı eseri hangi olayları kapsar?', options: ['Osmanlı tarihi', '1919-1927 arası Kurtuluş Savaşı ve inkılaplar', 'Cumhuriyet dönemi ekonomisi', 'Balkan Savaşları'], correctIndex: 1),
  Question(id: 301, examType: 'AYT', subject: 'Coğrafya', questionText: 'Türkiye\'nin hangi ilinde petrol çıkarılır?', options: ['Erzurum', 'Batman', 'Siirt', 'Hakkari'], correctIndex: 1),
  Question(id: 302, examType: 'AYT', subject: 'Matematik', questionText: '∫ eˣ dx = ?', options: ['eˣ + C', 'xeˣ + C', 'eˣ/x + C', 'eˣ−1 + C'], correctIndex: 0),
  Question(id: 303, examType: 'AYT', subject: 'Fizik', questionText: 'Madde dalgası (de Broglie dalgası) hangi formülle ifade edilir?', options: ['λ = h/mv', 'λ = mv/h', 'λ = hv/m', 'λ = m/hv'], correctIndex: 0),
  Question(id: 304, examType: 'AYT', subject: 'Kimya', questionText: 'Doymamış yağ asidi hangi özelliği taşır?', options: ['C-C tek bağları', 'C=C çift bağları', 'C-O bağları', 'Amin grupları'], correctIndex: 1),
  Question(id: 305, examType: 'AYT', subject: 'Biyoloji', questionText: 'Mitozun hangi evresinde kromozomlar ekvator düzleminde dizilir?', options: ['Profaz', 'Telofaz', 'Metafaz', 'Interfaz'], correctIndex: 2),
  Question(id: 306, examType: 'AYT', subject: 'Edebiyat', questionText: '"Dersaadet\'te Sabah Ezanları" kimin eseridir?', options: ['Yahya Kemal Beyatlı', 'Ahmet Rasim', 'Ömer Seyfettin', 'Refik Halit Karay'], correctIndex: 1),
  Question(id: 307, examType: 'AYT', subject: 'Tarih', questionText: 'Osmanlı\'da "Hatt-ı Hümayun" nedir?', options: ['Bir coğrafi bölge', 'Padişah tarafından yayımlanan ferman', 'Vergi sistemi', 'Askeri taktik'], correctIndex: 1),
  Question(id: 308, examType: 'AYT', subject: 'Coğrafya', questionText: 'Türkiye\'nin hangi bölgesinde karstik arazi en yaygındır?', options: ['Karadeniz', 'Doğu Anadolu', 'Akdeniz (Toroslar)', 'Trakya'], correctIndex: 2),
  Question(id: 309, examType: 'AYT', subject: 'Matematik', questionText: 'tan(45°) = ?', options: ['0', '√2/2', '1', '√3'], correctIndex: 2),
  Question(id: 310, examType: 'AYT', subject: 'Fizik', questionText: 'Bir mıknatısın kuzey kutbu ne tarafı çeker?', options: ['Kuzey kutbunu', 'Güney kutbunu', 'Her iki kutbu', 'Hiçbirini'], correctIndex: 1),
  Question(id: 311, examType: 'AYT', subject: 'Kimya', questionText: 'C + O₂ → CO₂ reaksiyonu ne tür bir reaksiyondur?', options: ['Bozunma', 'Birleşme', 'Yer değiştirme', 'Çifte yer değiştirme'], correctIndex: 1),
  Question(id: 312, examType: 'AYT', subject: 'Biyoloji', questionText: 'Mayoz bölünmede kaç yavru hücre oluşur?', options: ['2', '4', '6', '8'], correctIndex: 1),
  Question(id: 313, examType: 'AYT', subject: 'Edebiyat', questionText: '"Kiralık Konak" romanının yazarı kimdir?', options: ['Halide Edib Adıvar', 'Yakup Kadri Karaosmanoğlu', 'Reşat Nuri Güntekin', 'Peyami Safa'], correctIndex: 1),
  Question(id: 314, examType: 'AYT', subject: 'Tarih', questionText: 'Türkiye NATO\'ya hangi yılda girmiştir?', options: ['1949', '1950', '1952', '1955'], correctIndex: 2),
  Question(id: 315, examType: 'AYT', subject: 'Coğrafya', questionText: 'Taşköprü hangi şehirde bulunur ve ne ile ünlüdür?', options: ['Kastamonu, sarımsak', 'Afyon, haşhaş', 'Isparta, gül', 'Konya, buğday'], correctIndex: 0),
  Question(id: 316, examType: 'AYT', subject: 'Matematik', questionText: 'f(x) = x² için f\'(3) = ?', options: ['3', '6', '9', '12'], correctIndex: 1),
  Question(id: 317, examType: 'AYT', subject: 'Fizik', questionText: 'Ses dalgaları hangi ortamda yayılamaz?', options: ['Katı', 'Sıvı', 'Gaz', 'Vakum'], correctIndex: 3),
  Question(id: 318, examType: 'AYT', subject: 'Kimya', questionText: 'Sülfürik asitin formülü nedir?', options: ['HCl', 'H₂SO₄', 'HNO₃', 'H₃PO₄'], correctIndex: 1),
  Question(id: 319, examType: 'AYT', subject: 'Biyoloji', questionText: 'Kloroplast hangi hücrelerde bulunur?', options: ['Hayvan hücreleri', 'Bitki hücreleri', 'Mantar hücreleri', 'Bakteri hücreleri'], correctIndex: 1),
  Question(id: 320, examType: 'AYT', subject: 'Edebiyat', questionText: 'Türk edebiyatında "Milli Roman"ın öncüsü kimdir?', options: ['Halide Edib', 'Ömer Seyfettin', 'Mehmet Emin Yurdakul', 'Ziya Gökalp'], correctIndex: 0),
  Question(id: 321, examType: 'AYT', subject: 'Tarih', questionText: 'Mondros Ateşkesi hangi yılda imzalanmıştır?', options: ['1917', '1918', '1919', '1920'], correctIndex: 1),
  Question(id: 322, examType: 'AYT', subject: 'Coğrafya', questionText: 'Türkiye\'deki en uzun nehir hangisidir?', options: ['Fırat', 'Dicle', 'Kızılırmak', 'Sakarya'], correctIndex: 0),
  Question(id: 323, examType: 'AYT', subject: 'Matematik', questionText: '∫₀¹ x dx = ?', options: ['0', '1/4', '1/2', '1'], correctIndex: 2),
  Question(id: 324, examType: 'AYT', subject: 'Fizik', questionText: 'Işığın rengi neye bağlıdır?', options: ['Hızına', 'Frekansına', 'Genliğine', 'Kütlesine'], correctIndex: 1),
  Question(id: 325, examType: 'AYT', subject: 'Kimya', questionText: 'Redoks reaksiyonunda yükseltgenen madde ne olur?', options: ['Elektron alır', 'Elektron verir', 'Proton alır', 'Proton verir'], correctIndex: 1),
  Question(id: 326, examType: 'AYT', subject: 'Biyoloji', questionText: 'Transpozisyon nedir?', options: ['Protein sentezi', 'DNA\'nın kendini kopyalaması', 'Hareketli gen dizileri', 'RNA\'dan protein yapımı'], correctIndex: 2),
  Question(id: 327, examType: 'AYT', subject: 'Edebiyat', questionText: 'Fuzuli\'nin eserleri hangi dildedir?', options: ['Yalnızca Türkçe', 'Yalnızca Farsça', 'Türkçe, Farsça ve Arapça', 'Arapça ve Farsça'], correctIndex: 2),
  Question(id: 328, examType: 'AYT', subject: 'Tarih', questionText: 'Atatürk hangi savaşta cephe komutanı olarak ilk büyük zaferi kazanmıştır?', options: ['Çanakkale', 'Sakarya', 'Dumlupınar', 'Kurtuluş'], correctIndex: 0),
  Question(id: 329, examType: 'AYT', subject: 'Coğrafya', questionText: 'Türkiye\'de hangi göl en tuzludur?', options: ['Van Gölü', 'Tuz Gölü', 'Eğirdir', 'İznik'], correctIndex: 1),
  Question(id: 330, examType: 'AYT', subject: 'Matematik', questionText: 'Bir vektörün büyüklüğü |v| = √(a²+b²) formülüyle hesaplanır. a=3, b=4 ise |v| = ?', options: ['3', '4', '5', '7'], correctIndex: 2),
  Question(id: 331, examType: 'AYT', subject: 'Fizik', questionText: 'Bir kondansatörde depolanan enerji formülü nedir?', options: ['E = CV', 'E = CV²', 'E = C²V', 'E = ½CV²'], correctIndex: 3),
  Question(id: 332, examType: 'AYT', subject: 'Kimya', questionText: 'Hangi bileşik iyonik değil kovalent bağlıdır?', options: ['NaCl', 'KBr', 'H₂O', 'MgO'], correctIndex: 2),
  Question(id: 333, examType: 'AYT', subject: 'Biyoloji', questionText: 'Proteinlerin yapı taşları nelerdir?', options: ['Yağ asitleri', 'Monosakkaritler', 'Amino asitler', 'Nükleotidler'], correctIndex: 2),
  Question(id: 334, examType: 'AYT', subject: 'Edebiyat', questionText: '"Yaban" romanının kahramanı hangi meslekten birisidir?', options: ['Öğretmen', 'Doktor', 'Subay', 'Mühendis'], correctIndex: 2),
  Question(id: 335, examType: 'AYT', subject: 'Tarih', questionText: 'İkinci Dünya Savaşı\'nda Türkiye hangi tutumu benimsemiştir?', options: ['Mihver\'e katıldı', 'Müttefik\'e katıldı', 'Tarafsızlık', 'Çatışmalara girdi'], correctIndex: 2),
  Question(id: 336, examType: 'AYT', subject: 'Coğrafya', questionText: 'Türkiye\'de tarım alanında en fazla sulama kullanılan bölge hangisidir?', options: ['Karadeniz', 'Ege', 'İç Anadolu', 'Güneydoğu Anadolu'], correctIndex: 3),
  Question(id: 337, examType: 'AYT', subject: 'Matematik', questionText: 'Kompleks sayı düzleminde (3+4i)\'nin modülü kaçtır?', options: ['3', '4', '5', '7'], correctIndex: 2),
  Question(id: 338, examType: 'AYT', subject: 'Fizik', questionText: 'Çift yarık deneyini hangi fizikçi gerçekleştirmiştir?', options: ['Newton', 'Einstein', 'Thomas Young', 'Bohr'], correctIndex: 2),
  Question(id: 339, examType: 'AYT', subject: 'Kimya', questionText: 'Amonyak\'ın (NH₃) Lewis yapısında kaç bağ çifti ve lone pair vardır?', options: ['3 bağ, 0 pair', '3 bağ, 1 pair', '2 bağ, 2 pair', '4 bağ, 0 pair'], correctIndex: 1),
  Question(id: 340, examType: 'AYT', subject: 'Biyoloji', questionText: 'Enerji üretiminde oksijen kullanılmıyorsa bu sürece ne denir?', options: ['Aerobik solunum', 'Anaerobik solunum', 'Fotosentez', 'Fermantasyon'], correctIndex: 1),
  Question(id: 341, examType: 'AYT', subject: 'Edebiyat', questionText: 'Tanzimat döneminde "didaktik şiir" akımının öncüsü kimdir?', options: ['Şinasi', 'Namık Kemal', 'Ziya Paşa', 'Ahmet Mithat'], correctIndex: 0),
  Question(id: 342, examType: 'AYT', subject: 'Tarih', questionText: 'Osmanlı\'da "Islahat Fermanı" hangi padişah döneminde çıkarılmıştır?', options: ['II. Mahmut', 'Abdülmecit', 'Abdülaziz', 'II. Abdülhamit'], correctIndex: 1),
  Question(id: 343, examType: 'AYT', subject: 'Coğrafya', questionText: 'Doğu Anadolu\'nun en önemli ekonomik faaliyeti nedir?', options: ['Sanayi', 'Turizm', 'Hayvancılık', 'Ormancılık'], correctIndex: 2),
  Question(id: 344, examType: 'AYT', subject: 'Matematik', questionText: 'y = ln(x) fonksiyonunun türevi nedir?', options: ['ln(x)', '1/x', 'x', '1'], correctIndex: 1),
  Question(id: 345, examType: 'AYT', subject: 'Fizik', questionText: 'Bir fotoğraf makinesindeki mercek hangi prensiple çalışır?', options: ['Yansıma', 'Kırılma', 'Saçılma', 'Soğurulma'], correctIndex: 1),
  Question(id: 346, examType: 'AYT', subject: 'Kimya', questionText: 'Alkollerin IUPAC adlandırmasında kullanılan son ek nedir?', options: ['-an', '-en', '-ol', '-al'], correctIndex: 2),
  Question(id: 347, examType: 'AYT', subject: 'Biyoloji', questionText: 'İnsanda otonom sinir sistemi kaç kısımdan oluşur?', options: ['1', '2', '3', '4'], correctIndex: 1),
  Question(id: 348, examType: 'AYT', subject: 'Edebiyat', questionText: '"Safahat" hangi şairin eseridir?', options: ['Yahya Kemal Beyatlı', 'Mehmet Akif Ersoy', 'Tevfik Fikret', 'Namık Kemal'], correctIndex: 1),
  Question(id: 349, examType: 'AYT', subject: 'Tarih', questionText: 'Türkiye Cumhuriyeti\'nin ilk Başbakanı kimdir?', options: ['Atatürk', 'İsmet İnönü', 'Ali Fethi Okyar', 'Kazım Karabekir'], correctIndex: 1),
  Question(id: 350, examType: 'AYT', subject: 'Coğrafya', questionText: 'Türkiye\'nin yüzölçümü itibariyle en büyük ili hangisidir?', options: ['Ankara', 'Konya', 'Sivas', 'Erzurum'], correctIndex: 1),
  Question(id: 351, examType: 'AYT', subject: 'Matematik', questionText: 'Bir fonksiyonun lokal minimum noktasında türevi nasıldır?', options: ['Pozitif', 'Negatif', 'Sıfır', 'Tanımsız'], correctIndex: 2),
  Question(id: 352, examType: 'AYT', subject: 'Fizik', questionText: 'Radyoaktif bozunmada "yarı ömür" nedir?', options: ['Tam bozunma süresi', 'Maddenin yarısının bozunması için gereken süre', 'Enerji salınım süresi', 'Nötron sayısının yarılanması'], correctIndex: 1),
  Question(id: 353, examType: 'AYT', subject: 'Kimya', questionText: 'Glikoz hangi tür karbonhidrattır?', options: ['Disakkarit', 'Polisakkarit', 'Monosakkarit', 'Oligosakkarit'], correctIndex: 2),
  Question(id: 354, examType: 'AYT', subject: 'Biyoloji', questionText: 'Antikorları üreten hücre tipi hangisidir?', options: ['T lenfosit', 'B lenfosit (plazma hücresi)', 'Makrofaj', 'Nötrofil'], correctIndex: 1),
  Question(id: 355, examType: 'AYT', subject: 'Edebiyat', questionText: 'Aşık Veysel hangi bölgede yetişmiştir?', options: ['Karadeniz', 'Ege', 'İç Anadolu (Sivas)', 'Doğu Anadolu'], correctIndex: 2),
  Question(id: 356, examType: 'AYT', subject: 'Tarih', questionText: 'Sovyetler Birliği\'nin dağılması hangi yılda olmuştur?', options: ['1989', '1990', '1991', '1992'], correctIndex: 2),
  Question(id: 357, examType: 'AYT', subject: 'Coğrafya', questionText: 'Türkiye\'deki hangi göl krater gölü değildir?', options: ['Nar Gölü', 'Acıgöl', 'Van Gölü', 'Hazar Gölü'], correctIndex: 2),
  Question(id: 358, examType: 'AYT', subject: 'Matematik', questionText: 'İki doğrunun paralel olması için eğimleri arasındaki ilişki nedir?', options: ['Çarpımları -1', 'Eşit', 'Toplamları 0', 'Farkları 1'], correctIndex: 1),
  Question(id: 359, examType: 'AYT', subject: 'Fizik', questionText: 'Elektrik alanında pozitif yük hangi yönde hareket eder?', options: ['Elektrik alanına zıt yönde', 'Elektrik alanı yönünde', 'Dik yönde', 'Hareket etmez'], correctIndex: 1),
  Question(id: 360, examType: 'AYT', subject: 'Kimya', questionText: 'Le Chatelier İlkesi ne ile ilgilidir?', options: ['Asit-baz reaksiyonları', 'Kimyasal denge ve bozunma', 'Organik bileşikler', 'Elektroliz'], correctIndex: 1),
  Question(id: 361, examType: 'AYT', subject: 'Biyoloji', questionText: 'Bitkinin kök ucundaki meristematik doku ne yapar?', options: ['Fotosentez', 'Hücre bölünmesi ile büyüme', 'Su depolama', 'Mineral soğurma'], correctIndex: 1),
  Question(id: 362, examType: 'AYT', subject: 'Edebiyat', questionText: '"Nutuk" hangi türde bir eserdir?', options: ['Roman', 'Şiir', 'Anı-hitabet', 'Tiyatro'], correctIndex: 2),
  Question(id: 363, examType: 'AYT', subject: 'Tarih', questionText: 'Atatürk "Yurtta sulh, cihanda sulh" sözüyle ne vurgulamak istemiştir?', options: ['İç politika önceliği', 'Barışçıl dış politika', 'Askeri güç', 'Ekonomik kalkınma'], correctIndex: 1),
  Question(id: 364, examType: 'AYT', subject: 'Coğrafya', questionText: 'Türkiye\'deki delta ovalarının en büyüğü hangisidir?', options: ['Gediz Deltası', 'Çukurova Deltası', 'Bafra Deltası', 'Kızılırmak Deltası'], correctIndex: 1),
  Question(id: 365, examType: 'AYT', subject: 'Matematik', questionText: 'Bir koordinat sisteminde (2, 3) noktasının x eksenine olan uzaklığı kaçtır?', options: ['2', '3', '√13', '5'], correctIndex: 1),
  Question(id: 366, examType: 'AYT', subject: 'Fizik', questionText: 'Joule Thomson etkisi hangi olayla ilgilidir?', options: ['Manyetizma', 'Gazın genişleyerek soğuması', 'Elektrik iletimi', 'Nükleer fisyon'], correctIndex: 1),
  Question(id: 367, examType: 'AYT', subject: 'Kimya', questionText: 'Hangisi bir asit-baz indikatörüdür?', options: ['Klorür iyonu', 'Turnusol', 'Sodyum hidroksit', 'Etanol'], correctIndex: 1),
  Question(id: 368, examType: 'AYT', subject: 'Biyoloji', questionText: 'Hormon nedir?', options: ['Sindirim enzimi', 'Kimyasal haberci molekül', 'Yapısal protein', 'Enerji deposu'], correctIndex: 1),
  Question(id: 369, examType: 'AYT', subject: 'Edebiyat', questionText: 'Türk halk hikayelerinde "mani" ne kadar satırlık şiirdir?', options: ['2', '4', '6', '8'], correctIndex: 1),
  Question(id: 370, examType: 'AYT', subject: 'Tarih', questionText: 'Cumhuriyetin ilanından önce TBMM\'nin yönetim biçimi nasıldı?', options: ['Padişahlık', 'Saltanat', 'Meclis Hükümeti', 'Diktatörlük'], correctIndex: 2),
  Question(id: 371, examType: 'AYT', subject: 'Matematik', questionText: 'log₂ (x-2) = 3 ise x kaçtır?', options: ['8', '10', '12', '14'], correctIndex: 1),
  Question(id: 372, examType: 'AYT', subject: 'Matematik', questionText: 'f(x) = x² + 2x + 1 ise f\'(x) nedir?', options: ['2x + 2', 'x + 1', '2x', '2'], correctIndex: 0),
  Question(id: 373, examType: 'AYT', subject: 'Matematik', questionText: '∫ (2x) dx integralinin sonucu nedir?', options: ['x² + C', '2x² + C', 'x + C', '2 + C'], correctIndex: 0),
  Question(id: 374, examType: 'AYT', subject: 'Matematik', questionText: 'lim (x->2) (x² - 4) / (x - 2) limitinin değeri kaçtır?', options: ['0', '2', '4', 'Belirsiz'], correctIndex: 2),
  Question(id: 375, examType: 'AYT', subject: 'Matematik', questionText: 'Bir aritmetik dizide a₁ = 5 ve r = 3 ise a₁₀ kaçtır?', options: ['30', '32', '35', '42'], correctIndex: 1),
  Question(id: 376, examType: 'AYT', subject: 'Matematik', questionText: 'sin(x) = 1/2 denkleminin [0, π] aralığındaki çözüm kümesi nedir?', options: ['{π/6}', '{π/6, 5π/6}', '{π/3}', '{π/4}'], correctIndex: 1),
  Question(id: 377, examType: 'AYT', subject: 'Matematik', questionText: 'z = 3 + 4i karmaşık sayısının mutlak değeri (modülü) kaçtır?', options: ['5', '7', '12', '25'], correctIndex: 0),
  Question(id: 378, examType: 'AYT', subject: 'Matematik', questionText: 'P(x) = x³ - 2x + 1 polinomunun x-1 ile bölümünden kalan kaçtır?', options: ['-1', '0', '1', '2'], correctIndex: 1),
  Question(id: 379, examType: 'AYT', subject: 'Fizik', questionText: 'Doppler olayı aşağıdakilerden hangisiyle ilgilidir?', options: ['Işığın kırılması', 'Dalga boyu ve frekans değişimi', 'Işığın soğurulması', 'Fotoelektrik olay'], correctIndex: 1),
  Question(id: 380, examType: 'AYT', subject: 'Fizik', questionText: 'Açısal momentumun birimi nedir?', options: ['kg.m²/s', 'kg.m/s', 'Joule.s', 'Watt.s'], correctIndex: 0),
  Question(id: 381, examType: 'AYT', subject: 'Fizik', questionText: 'Basit harmonik harekette maksimum ivme nerededir?', options: ['Denge noktasında', 'Uç noktalarda', 'Hızın en büyük olduğu yerde', 'Her yerde aynıdır'], correctIndex: 1),
  Question(id: 382, examType: 'AYT', subject: 'Fizik', questionText: 'Hangi parçacık bir leptondur?', options: ['Proton', 'Nötron', 'Elektron', 'Mezon'], correctIndex: 2),
  Question(id: 383, examType: 'AYT', subject: 'Fizik', questionText: 'Lenz yasası neyle ilgilidir?', options: ['Elektriksel kuvvet', 'İndüksiyon akımının yönü', 'Direnç', 'Sığa'], correctIndex: 1),
  Question(id: 384, examType: 'AYT', subject: 'Fizik', questionText: 'Elektromanyetik dalgalardan hangisinin enerjisi en yüksektir?', options: ['Radyo dalgaları', 'Kızılötesi', 'Görünür ışık', 'Gama ışınları'], correctIndex: 3),
  Question(id: 385, examType: 'AYT', subject: 'Fizik', questionText: 'Sağ el kuralı manyetizmada neyi bulmak için kullanılır?', options: ['Kuvvetin yönünü', 'Direnci', 'Potansiyeli', 'Akım şiddetini'], correctIndex: 0),
  Question(id: 386, examType: 'AYT', subject: 'Kimya', questionText: 'Organik kimyada temel element hangisidir?', options: ['Oksijen', 'Azot', 'Karbon', 'Hidrojen'], correctIndex: 2),
  Question(id: 387, examType: 'AYT', subject: 'Kimya', questionText: 'Alkanların genel formülü nedir?', options: ['CnH2n', 'CnH2n+2', 'CnH2n-2', 'CnHn'], correctIndex: 1),
  Question(id: 388, examType: 'AYT', subject: 'Kimya', questionText: 'Modern atom teorisine göre elektronların bulunduğu bölgelere ne denir?', options: ['Yörünge', 'Orbital', 'Katman', 'Bulut'], correctIndex: 1),
  Question(id: 389, examType: 'AYT', subject: 'Kimya', questionText: 'Sulu çözeltilerde H+ iyonu veren maddelere ne denir?', options: ['Asit', 'Baz', 'Tuz', 'Oksit'], correctIndex: 0),
  Question(id: 390, examType: 'AYT', subject: 'Kimya', questionText: 'Entalpi değişimi (ΔH) negatif olan tepkimelere ne denir?', options: ['Endotermik', 'Ekzotermik', 'Nötrleşme', 'Yanma'], correctIndex: 1),
  Question(id: 391, examType: 'AYT', subject: 'Kimya', questionText: 'Gazların basıncı ile hacmi arasındaki ilişkiyi açıklayan yasa hangisidir?', options: ['Charles Yasası', 'Boyle-Mariotte Yasası', 'Gay-Lussac Yasası', 'Avogadro Yasası'], correctIndex: 1),
  Question(id: 392, examType: 'AYT', subject: 'Kimya', questionText: 'Aktifleşme enerjisi nedir?', options: ['Tepkimenin hızıdır.', 'Tepkime için gereken minimum enerjidir.', 'Ürünlerin enerjisidir.', 'Katalizörün enerjisidir.'], correctIndex: 1),
  Question(id: 393, examType: 'AYT', subject: 'Biyoloji', questionText: 'Protein sentezinin şifresini veren yapı hangisidir?', options: ['mRNA', 'tRNA', 'rRNA', 'DNA'], correctIndex: 3),
  Question(id: 394, examType: 'AYT', subject: 'Biyoloji', questionText: 'İnsan vücudunda kan şekerini düşüren hormon hangisidir?', options: ['Glukagon', 'İnsülin', 'Adrenalin', 'Tiroksin'], correctIndex: 1),
  Question(id: 395, examType: 'AYT', subject: 'Biyoloji', questionText: 'Sinir sisteminin temel yapı birimi nedir?', options: ['Nefron', 'Nöron', 'Alveol', 'Osteosit'], correctIndex: 1),
  Question(id: 396, examType: 'AYT', subject: 'Biyoloji', questionText: 'Fotosentezin ışıktan bağımsız evresi nerede gerçekleşir?', options: ['Grana', 'Stroma', 'Sitoplazma', 'Mitokondri'], correctIndex: 1),
  Question(id: 397, examType: 'AYT', subject: 'Biyoloji', questionText: 'Hücre solunumunda ATP üretilen organel hangisidir?', options: ['Kloroplast', 'Ribozom', 'Mitokondri', 'Golgi'], correctIndex: 2),
  Question(id: 398, examType: 'AYT', subject: 'Biyoloji', questionText: 'Bağışıklık sisteminde görev alan kan hücreleri hangisidir?', options: ['Alyuvar', 'Akyuvar', 'Kan pulcukları', 'Plazma hücreleri'], correctIndex: 1),
  Question(id: 399, examType: 'AYT', subject: 'Biyoloji', questionText: 'Böbreklerin yapı ve işlev birimi nedir?', options: ['Nefron', 'Nöron', 'Alveol', 'Dalak'], correctIndex: 0),
  Question(id: 400, examType: 'AYT', subject: 'Edebiyat', questionText: 'Divan edebiyatının ilk şairi kim kabul edilir?', options: ['Baki', 'Fuzuli', 'Hoca Dehhani', 'Nedim'], correctIndex: 2),
  Question(id: 401, examType: 'AYT', subject: 'Edebiyat', questionText: '"Vatan Yahut Silistre" oyununun yazarı kimdir?', options: ['Ziya Paşa', 'Namık Kemal', 'İbrahim Şinasi', 'Ahmet Mithat Efendi'], correctIndex: 1),
  Question(id: 402, examType: 'AYT', subject: 'Edebiyat', questionText: 'Servet-i Fünun döneminin en önemli romanı hangisidir?', options: ['Eylül', 'Aşk-ı Memnu', 'Araba Sevdası', 'Mai ve Siyah'], correctIndex: 1),
  Question(id: 403, examType: 'AYT', subject: 'Edebiyat', questionText: 'Garip akımının (I. Yeni) kurucuları kimlerdir?', options: ['Orhan Veli, Melih Cevdet, Oktay Rifat', 'Ece Ayhan, Cemal Süreya, İlhan Berk', 'Necip Fazıl, Sezai Karakoç', 'Attila İlhan, Ahmet Arif'], correctIndex: 0),
  Question(id: 404, examType: 'AYT', subject: 'Edebiyat', questionText: 'Cumhuriyet dönemi Türk şiirinde "Mavi Gözlü Dev" olarak bilinen şair kimdir?', options: ['Nazım Hikmet', 'Necip Fazıl', 'Fazıl Hüsnü Dağlarca', 'Atilla İlhan'], correctIndex: 0),
  Question(id: 405, examType: 'AYT', subject: 'Edebiyat', questionText: '"Çalıkuşu" romanının yazarı kimdir?', options: ['Halide Edip Adıvar', 'Reşat Nuri Güntekin', 'Yakup Kadri Karaosmanoğlu', 'Refik Halit Karay'], correctIndex: 1),
  Question(id: 406, examType: 'AYT', subject: 'Edebiyat', questionText: 'Hangi edebi türde gerçek olmayan olaylar anlatılır?', options: ['Anı', 'Gezi Yazısı', 'Masal', 'Biyografi'], correctIndex: 2),
  Question(id: 407, examType: 'AYT', subject: 'Tarih', questionText: 'Fransız İhtilali hangi yıl gerçekleşmiştir?', options: ['1453', '1789', '1881', '1914'], correctIndex: 1),
  Question(id: 408, examType: 'AYT', subject: 'Tarih', questionText: 'I. Dünya Savaşı\'nı bitiren antlaşma hangisidir?', options: ['Mondros', 'Sevr', 'Versay', 'Lozan'], correctIndex: 2),
  Question(id: 409, examType: 'AYT', subject: 'Tarih', questionText: 'İslamiyet öncesi Türklerde ölen kişi için yapılan cenaze törenine ne denir?', options: ['Yuğ', 'Kurgan', 'Balbal', 'Şaman'], correctIndex: 0),
  Question(id: 410, examType: 'AYT', subject: 'Tarih', questionText: 'Osmanlı Devleti\'nde "Kanun-i Esasi" hangi padişah döneminde ilan edilmiştir?', options: ['II. Abdülhamit', 'I. Abdülhamit', 'Abdülmecit', 'Abdülaziz'], correctIndex: 0),
  Question(id: 411, examType: 'AYT', subject: 'Tarih', questionText: 'Kurtuluş Savaşı\'nda Doğu Cephesi komutanı kimdir?', options: ['İsmet İnönü', 'Kazım Karabekir', 'Refet Bele', 'Ali Fuat Cebesoy'], correctIndex: 1),
  Question(id: 412, examType: 'AYT', subject: 'Tarih', questionText: 'Hangi olayla Türkiye Cumhuriyeti bir devlet olarak resmen tanınmıştır?', options: ['Mudanya Ateşkesi', 'Lozan Barış Antlaşması', 'Ankara Antlaşması', 'Montrö Sözleşmesi'], correctIndex: 1),
  Question(id: 413, examType: 'AYT', subject: 'Tarih', questionText: 'Osmanlı Devleti\'nin son padişahı kimdir?', options: ['Vahdettin', 'V. Mehmet Reşat', 'II. Abdülhamit', 'Abdülaziz'], correctIndex: 0),
  Question(id: 414, examType: 'AYT', subject: 'Coğrafya', questionText: 'Dünya\'nın kendi ekseni etrafında dönmesiyle ne oluşur?', options: ['Mevsimler', 'Gece ve gündüz birbirini takip eder', 'Yıl kavramı', 'Ay tutulması'], correctIndex: 1),
  Question(id: 415, examType: 'AYT', subject: 'Coğrafya', questionText: 'Türkiye\'de fındık üretiminde birinci olan bölge hangisidir?', options: ['Ege', 'Marmara', 'Karadeniz', 'Akdeniz'], correctIndex: 2),
  Question(id: 416, examType: 'AYT', subject: 'Coğrafya', questionText: 'Hangi iklim tipinde bitki örtüsü maki\'dir?', options: ['Karadeniz İklimi', 'Karasal İklim', 'Akdeniz İklimi', 'Sert Karasal İklim'], correctIndex: 2),
  Question(id: 417, examType: 'AYT', subject: 'Coğrafya', questionText: 'Ekvatoral bölgede yağış rejimi nasıldır?', options: ['Düzenli', 'Düzensiz', 'Sadece kışın yağar', 'Sadece yazın yağar'], correctIndex: 0),
  Question(id: 418, examType: 'AYT', subject: 'Coğrafya', questionText: 'Türkiye\'nin en büyük yüzölçümüne sahip gölü hangisidir?', options: ['Tuz Gölü', 'Beyşehir Gölü', 'Van Gölü', 'Eğirdir Gölü'], correctIndex: 2),
  Question(id: 419, examType: 'AYT', subject: 'Coğrafya', questionText: 'Ozon tabakası hangi atmosfer katmanında bulunur?', options: ['Troposfer', 'Stratosfer', 'Mezosfer', 'Termosfer'], correctIndex: 1),
  Question(id: 420, examType: 'AYT', subject: 'Coğrafya', questionText: 'Nüfus yoğunluğu en az olan bölgemiz hangisidir?', options: ['Doğu Anadolu', 'Güneydoğu Anadolu', 'Karadeniz', 'İç Anadolu'], correctIndex: 0),
  Question(id: 421, examType: 'AYT', subject: 'Matematik', questionText: 'f(x) = sin(x) ise f\'(x) nedir?', options: ['cos(x)', '-cos(x)', 'sin(x)', '-sin(x)'], correctIndex: 0),
  Question(id: 422, examType: 'AYT', subject: 'Matematik', questionText: 'log x + log y = ?', options: ['log(x+y)', 'log(x*y)', 'log(x/y)', 'log(x-y)'], correctIndex: 1),
  Question(id: 423, examType: 'AYT', subject: 'Matematik', questionText: 'Bir geometrik dizide a₁ = 2 ve r = 3 ise a₄ kaçtır?', options: ['18', '24', '54', '162'], correctIndex: 2),
  Question(id: 424, examType: 'AYT', subject: 'Matematik', questionText: 'tan(45°) değeri kaçtır?', options: ['0', '1/2', '1', '√3'], correctIndex: 2),
  Question(id: 425, examType: 'AYT', subject: 'Matematik', questionText: 'Karmaşık sayılarda i² kaçtır?', options: ['1', '0', '-1', 'i'], correctIndex: 2),
  Question(id: 426, examType: 'AYT', subject: 'Matematik', questionText: 'Permütasyon P(5,2) sonucu kaçtır?', options: ['10', '20', '60', '120'], correctIndex: 1),
  Question(id: 427, examType: 'AYT', subject: 'Matematik', questionText: 'Kombinasyon C(5,2) sonucu kaçtır?', options: ['10', '20', '60', '120'], correctIndex: 0),
  Question(id: 428, examType: 'AYT', subject: 'Fizik', questionText: 'Sığaçların (kondansatör) birimi nedir?', options: ['Henry', 'Farad', 'Tesla', 'Weber'], correctIndex: 1),
  Question(id: 429, examType: 'AYT', subject: 'Fizik', questionText: 'Işık hızıyla hareket eden bir gözlemci için zaman nasıl geçer?', options: ['Daha hızlı', 'Daha yavaş', 'Aynı', 'Durur'], correctIndex: 1),
  Question(id: 430, examType: 'AYT', subject: 'Fizik', questionText: 'Yüklü bir parçacık manyetik alana dik girerse ne tür bir yörünge izler?', options: ['Doğrusal', 'Parabolik', 'Çembersel', 'Eliptik'], correctIndex: 2),
  Question(id: 431, examType: 'AYT', subject: 'Fizik', questionText: 'Fotoelektrik olayda kopan elektronların enerjisi neye bağlıdır?', options: ['Işığın şiddetine', 'Işığın frekansına', 'Işığın geliş açısına', 'Metal yüzeyin alanına'], correctIndex: 1),
  Question(id: 432, examType: 'AYT', subject: 'Fizik', questionText: 'Compton saçılmasında saçılan fotonun dalga boyu nasıl değişir?', options: ['Artar', 'Azalır', 'Değişmez', 'Sıfır olur'], correctIndex: 0),
  Question(id: 433, examType: 'AYT', subject: 'Fizik', questionText: 'Heisenberg belirsizlik ilkesi neyle ilgilidir?', options: ['Enerji ve Zaman', 'Konum ve Momentum', 'Hız ve İvme', 'Kütle ve Ağırlık'], correctIndex: 1),
  Question(id: 434, examType: 'AYT', subject: 'Fizik', questionText: 'Hangi kuvvet çekirdek içindeki proton ve nötronları bir arada tutar?', options: ['Kütleçekim kuvveti', 'Elektromanyetik kuvvet', 'Güçlü nükleer kuvvet', 'Zayıf nükleer kuvvet'], correctIndex: 2),
  Question(id: 435, examType: 'AYT', subject: 'Kimya', questionText: 'Benzendeki karbon atomları arasındaki bağlar nasıldır?', options: ['Hepsi tekli', 'Hepsi ikili', 'Rezonans yapılı', 'Sadece sigma bağı'], correctIndex: 2),
  Question(id: 436, examType: 'AYT', subject: 'Kimya', questionText: 'Peryodik sistemde soldan sağa gidildikçe elektronegatiflik genellikle nasıl değişir?', options: ['Artar', 'Azalır', 'Değişmez', 'Önce artar sonra azalır'], correctIndex: 0),
  Question(id: 437, examType: 'AYT', subject: 'Kimya', questionText: 'Galvanik bir hücrede yükseltgenme nerede gerçekleşir?', options: ['Anot', 'Katot', 'Tuz köprüsü', 'Çözelti'], correctIndex: 0),
  Question(id: 438, examType: 'AYT', subject: 'Kimya', questionText: 'Hangi bağ türü diğerlerinden daha güçlüdür?', options: ['Hidrojen bağı', 'Dipol-dipol', 'London kuvvetleri', 'Kovalent bağ'], correctIndex: 3),
  Question(id: 439, examType: 'AYT', subject: 'Kimya', questionText: 'Buhar basıncı neye bağlıdır?', options: ['Sıvının miktarına', 'Dış basınca', 'Sıvının cinsine ve sıcaklığa', 'Kabın şekline'], correctIndex: 2),
  Question(id: 440, examType: 'AYT', subject: 'Kimya', questionText: 'Tersinir bir tepkime dengedeyken hangisi doğrudur?', options: ['İleri hız > Geri hız', 'İleri hız = Geri hız', 'Tepkime durmuştur', 'Sadece ürünler vardır'], correctIndex: 1),
  Question(id: 441, examType: 'AYT', subject: 'Kimya', questionText: 'Aromatik bileşiklerin en basit üyesi hangisidir?', options: ['Metan', 'Etilen', 'Benzen', 'Asetilen'], correctIndex: 2),
  Question(id: 442, examType: 'AYT', subject: 'Kimya', questionText: 'Hangi çözelti pH=7 özelliğindedir?', options: ['HCl', 'NaOH', 'NaCl', 'NH3'], correctIndex: 2),
  Question(id: 443, examType: 'AYT', subject: 'Biyoloji', questionText: 'İnsanlarda soluk alıp vermeyi hangi merkez kontrol eder?', options: ['Beyincik', 'Omurilik soğanı', 'Talamus', 'Hipotalamus'], correctIndex: 1),
  Question(id: 444, examType: 'AYT', subject: 'Biyoloji', questionText: 'Hücre döngüsünün hangi evresinde DNA eşlenmesi (replikasyon) olur?', options: ['G1 evresi', 'S evresi', 'G2 evresi', 'M evresi'], correctIndex: 1),
  Question(id: 445, examType: 'AYT', subject: 'Biyoloji', questionText: 'Mendel genetiğinde "fenotip" neyi ifade eder?', options: ['Genetik yapıyı', 'Dış görünüşü', 'Mutasyonları', 'Adaptasyonları'], correctIndex: 1),
  Question(id: 446, examType: 'AYT', subject: 'Biyoloji', questionText: 'Hangi organel sadece bitki hücrelerinde bulunur?', options: ['Mitokondri', 'Kloroplast', 'Ribozom', 'Lizozom'], correctIndex: 1),
  Question(id: 447, examType: 'AYT', subject: 'Biyoloji', questionText: 'Canlıların sınıflandırılmasında en küçük birim hangisidir?', options: ['Alem', 'Sınıf', 'Cins', 'Tür'], correctIndex: 3),
  Question(id: 448, examType: 'AYT', subject: 'Biyoloji', questionText: 'Hücre zarından madde geçişinde ATP harcanan yöntem hangisidir?', options: ['Difüzyon', 'Osmoz', 'Aktif Taşıma', 'Kolaylaştırılmış difüzyon'], correctIndex: 2),
  Question(id: 449, examType: 'AYT', subject: 'Biyoloji', questionText: 'ATP molekülünün yapısında hangi baz bulunur?', options: ['Guanin', 'Sitozin', 'Adenin', 'Timin'], correctIndex: 2),
  Question(id: 450, examType: 'AYT', subject: 'Edebiyat', questionText: 'Türk edebiyatında ilk psikolojik roman hangisidir?', options: ['Eylül', 'Mai ve Siyah', 'Zehra', 'Huzur'], correctIndex: 0),
  Question(id: 451, examType: 'AYT', subject: 'Edebiyat', questionText: '"Şair-i Azam" unvanıyla tanınan şairimiz kimdir?', options: ['Namık Kemal', 'Abdülhak Hamit Tarhan', 'Tevfik Fikret', 'Yahya Kemal'], correctIndex: 1),
  Question(id: 452, examType: 'AYT', subject: 'Edebiyat', questionText: 'Mesnevi tarzında yazılan en ünlü eser hangisidir?', options: ['Divan-ı Hikmet', 'Kutadgu Bilig', 'Mesnevi (Mevlana)', 'Risaletü\'n Nushiyye'], correctIndex: 2),
  Question(id: 453, examType: 'AYT', subject: 'Edebiyat', questionText: 'Hangi akım "akıl ve sağduyu"yu ön plana çıkarır?', options: ['Klasisizm', 'Romantizm', 'Realizm', 'Sürrealizm'], correctIndex: 0),
  Question(id: 454, examType: 'AYT', subject: 'Edebiyat', questionText: 'İstiklal Şairi olarak bilinen sanatçımız kimdir?', options: ['Ziya Gökalp', 'Mehmet Akif Ersoy', 'Yahya Kemal', 'Fazıl Hüsnü'], correctIndex: 1),
  Question(id: 455, examType: 'AYT', subject: 'Edebiyat', questionText: 'Milli Edebiyat akımını başlatan dergi hangisidir?', options: ['Servet-i Fünun', 'Genç Kalemler', 'Türk Yurdu', 'Varlık'], correctIndex: 1),
  Question(id: 456, examType: 'AYT', subject: 'Edebiyat', questionText: 'Dede Korkut Hikayeleri kaç hikayeden oluşur?', options: ['10', '12', '15', '20'], correctIndex: 1),
  Question(id: 457, examType: 'AYT', subject: 'Tarih', questionText: 'Büyük Selçuklu Devleti ile Bizans arasındaki ilk büyük savaş hangisidir?', options: ['Malazgirt', 'Pasinler', 'Miryokefalon', 'Kösedağ'], correctIndex: 1),
  Question(id: 458, examType: 'AYT', subject: 'Tarih', questionText: 'Osmanlı Devleti hangi antlaşmayla Avrupa devleti sayılmıştır?', options: ['Paris Antlaşması', 'Berlin Antlaşması', 'Londra Antlaşması', 'Kütahya Antlaşması'], correctIndex: 0),
  Question(id: 459, examType: 'AYT', subject: 'Tarih', questionText: 'Halifelik ne zaman kaldırılmıştır?', options: ['29 Ekim 1923', '3 Mart 1924', '1 Kasım 1922', '20 Nisan 1924'], correctIndex: 1),
  Question(id: 460, examType: 'AYT', subject: 'Tarih', questionText: 'I. Beş Yıllık Sanayi Planı hangi yıl uygulanmaya başlanmıştır?', options: ['1923', '1930', '1934', '1938'], correctIndex: 2),
  Question(id: 461, examType: 'AYT', subject: 'Tarih', questionText: 'Milli Mücadele\'nin haklılığını kanıtlayan ilk uluslararası belge hangisidir?', options: ['Amiral Bristol Raporu', 'General Harbourd Raporu', 'Milne Hattı', 'Mondros Raporu'], correctIndex: 0),
  Question(id: 462, examType: 'AYT', subject: 'Tarih', questionText: 'Hangi ilkemiz "akılcılık ve bilimsellik" temeline dayanır?', options: ['Cumhuriyetçilik', 'Laiklik', 'Milliyetçilik', 'Halkçılık'], correctIndex: 1),
  Question(id: 463, examType: 'AYT', subject: 'Tarih', questionText: 'İkinci Dünya Savaşı hangi yıl bitmiştir?', options: ['1939', '1942', '1945', '1950'], correctIndex: 2),
  Question(id: 464, examType: 'AYT', subject: 'Coğrafya', questionText: 'Kayaçların fiziksel olarak parçalanması en çok nerede görülür?', options: ['Karadeniz', 'Akdeniz', 'İç Anadolu', 'Ege'], correctIndex: 2),
  Question(id: 465, examType: 'AYT', subject: 'Coğrafya', questionText: 'Hangi enerji kaynağı yenilenebilir değildir?', options: ['Güneş', 'Rüzgar', 'Doğalgaz', 'Jeotermal'], correctIndex: 2),
  Question(id: 466, examType: 'AYT', subject: 'Coğrafya', questionText: 'Dünya\'nın en kalabalık ülkesi hangisidir? (Son verilere göre)', options: ['Çin', 'Hindistan', 'ABD', 'Rusya'], correctIndex: 1),
  Question(id: 467, examType: 'AYT', subject: 'Coğrafya', questionText: 'Türkiye\'nin en güney ucu neresidir?', options: ['Yayladağı (Hatay)', 'Sinop (İnceburun)', 'Iğdır (Dilucu)', 'Çanakkale (Bababurnu)'], correctIndex: 0),
  Question(id: 468, examType: 'AYT', subject: 'Coğrafya', questionText: 'Yerleşik hayatın ilk başladığı bölgelerden biri olan "Bereketli Hilal" nerededir?', options: ['Mısır', 'Mezopotamya', 'Hindistan', 'Çin'], correctIndex: 1),
  Question(id: 469, examType: 'AYT', subject: 'Coğrafya', questionText: 'Hangi akarsu Türkiye dışından doğup Türkiye\'de dökülür?', options: ['Fırat', 'Dicle', 'Asi', 'Kızılırmak'], correctIndex: 2),
  Question(id: 470, examType: 'AYT', subject: 'Coğrafya', questionText: 'Türkiye\'de rüzgar enerjisinden elektrik üretimi en çok hangi bölgededir?', options: ['Marmara', 'Ege', 'İç Anadolu', 'Güneydoğu'], correctIndex: 1),

  // ─────────────── YENİ EKLENEN 50 AYT SORUSU (ÖSYM TARZI) ───────────────
  Question(id: 471, examType: 'AYT', subject: 'Matematik', questionText: 'f(x) fonksiyonu [a, b] aralığında sürekli ve (a, b) aralığında türevlenebilir olsun. f(a) = f(b) ise, f\'(c) = 0 olacak şekilde en az bir c ∈ (a, b) vardır. Bu teorem aşağıdakilerden hangisidir?', options: ['Ortalama Değer Teoremi', 'Rolle Teoremi', 'Cauchy Teoremi', 'L\'Hopital Kuralı'], correctIndex: 1),
  Question(id: 472, examType: 'AYT', subject: 'Matematik', questionText: 'z = x + iy karmaşık sayısı için |z - 2| = |z + 2| koşulunu sağlayan noktaların geometrik yeri neresidir?', options: ['x - ekseni (Gerçel eksen)', 'y - ekseni (Sanal eksen)', 'Orijin merkezli çember', 'y = x doğrusu'], correctIndex: 1),
  Question(id: 473, examType: 'AYT', subject: 'Matematik', questionText: 'Bir otoparktaki 10 araçtan 3\'ü kırmızıdır. Rastgele seçilen 2 aracın ikisinin de kırmızı olma olasılığı kaçtır?', options: ['1/15', '1/10', '2/15', '3/10'], correctIndex: 0),
  Question(id: 474, examType: 'AYT', subject: 'Matematik', questionText: '∫(0 den π\'ye) sin²(x) dx integralinin sonucu kaçtır?', options: ['π', 'π/2', 'π/4', '1'], correctIndex: 1),
  Question(id: 475, examType: 'AYT', subject: 'Matematik', questionText: 'lim (x→0) (1 - cos(x)) / x² limitinin değeri nedir?', options: ['0', '1/2', '1', 'Belirsiz'], correctIndex: 1),
  Question(id: 476, examType: 'AYT', subject: 'Matematik', questionText: 'A matrisi 2x3, B matrisi 3x4 boyutlarında ise A x B matrisinin boyutu nedir?', options: ['2x3', '3x4', '2x4', 'Çarpılamaz'], correctIndex: 2),
  Question(id: 477, examType: 'AYT', subject: 'Matematik', questionText: 'Karekök içinde -16 sayısının karmaşık düzlemdeki karşılığı nedir?', options: ['-4', '4', '4i', '-4i'], correctIndex: 2),
  Question(id: 478, examType: 'AYT', subject: 'Matematik', questionText: 'P(x) polinomu x²+1 ile tam bölünüyorsa, P(x)\'in x²+1\'e bölümünden kalan kaçtır?', options: ['0', '1', 'x', '-1'], correctIndex: 0),
  Question(id: 479, examType: 'AYT', subject: 'Matematik', questionText: 'sin(2x) fonksiyonunun periyodu nedir?', options: ['2π', 'π', 'π/2', '4π'], correctIndex: 1),
  Question(id: 480, examType: 'AYT', subject: 'Matematik', questionText: 'f(x) = e^(2x) fonksiyonunun x=0 noktasındaki teğetinin eğimi kaçtır?', options: ['0', '1', '2', 'e'], correctIndex: 2),
  Question(id: 481, examType: 'AYT', subject: 'Fizik', questionText: 'Sürtünmesiz eğik düzlemde m kütleli cisim serbest bırakıldığında ivmesi (a) kütleye (m) bağlı mıdır?', options: ['Evet, doğru orantılıdır', 'Evet, ters orantılıdır', 'Hayır, sadece açıya ve g\'ye bağlıdır (g.sinθ)', 'Kütleye ve yüzey alanına bağlıdır'], correctIndex: 2),
  Question(id: 482, examType: 'AYT', subject: 'Fizik', questionText: 'Açısal momentumun korunduğu bir sistemde, eylemsizlik momenti (I) yarıya düşerse açısal hız (ω) ne olur?', options: ['Yarıya düşer', 'Aynı kalır', '2 katına çıkar', '4 katına çıkar'], correctIndex: 2),
  Question(id: 483, examType: 'AYT', subject: 'Fizik', questionText: 'Transformatörde sarım sayıları oranı (N1/N2) gerilimler oranı (V1/V2) ile nasıl ilişkilidir?', options: ['Doğru orantılı', 'Ters orantılı', 'Karesiyle orantılı', 'Rastgeledir'], correctIndex: 0),
  Question(id: 484, examType: 'AYT', subject: 'Fizik', questionText: 'İdeal bir gaz izotermal (sabit sıcaklıkta) genişlerse, gazın iç enerjisi nasıl değişir?', options: ['Artar', 'Azalır', 'Sıfır olur', 'Değişmez'], correctIndex: 3),
  Question(id: 485, examType: 'AYT', subject: 'Fizik', questionText: 'Işığın çift yarıkta girişim deneyinde, karanlık saçak formülü nedir?', options: ['d.sinθ = nλ', 'd.sinθ = (n - 1/2)λ', 'd.cosθ = nλ', 'd.cosθ = (n - 1/2)λ'], correctIndex: 1),
  Question(id: 486, examType: 'AYT', subject: 'Fizik', questionText: 'Manyetik akı (Φ) zamanla değiştiğinde devrede hangi fiziksel büyüklük oluşur?', options: ['Direnç', 'Öz kütle', 'İndüksiyon Elektromotor Kuvveti (EMK)', 'Sığa'], correctIndex: 2),
  Question(id: 487, examType: 'AYT', subject: 'Fizik', questionText: 'De Broglie hipotezine göre, kütlesi büyük olan cisimlerin madde dalga boyu nasıldır?', options: ['Çok büyüktür', 'Çok küçüktür (algılanamaz)', 'Sabittir', 'Gittikçe artar'], correctIndex: 1),
  Question(id: 488, examType: 'AYT', subject: 'Fizik', questionText: 'Denge konumundan x kadar çekilip bırakılan yayın yaptığı harmonik harekette geri çağırıcı kuvvet F eşittir?', options: ['-kx', 'kx', '1/2 kx²', '-1/2 kx²'], correctIndex: 0),
  Question(id: 489, examType: 'AYT', subject: 'Kimya', questionText: 'Bir atomun elektron ilgisi, dışarıdan elektron aldığında meydana gelen ne değişimidir?', options: ['Kütle değişimi', 'Hacim değişimi', 'Entalpi (enerji) değişimi', 'Proton sayısı değişimi'], correctIndex: 2),
  Question(id: 490, examType: 'AYT', subject: 'Kimya', questionText: 'Le Chatelier prensibine göre, ekzotermik bir tepkimede sistemin ısısı (sıcaklığı) artırılırsa denge ne yöne kayar?', options: ['Ürünlere', 'Girenlere', 'Değişmez', 'İleri-geri durur'], correctIndex: 1),
  Question(id: 491, examType: 'AYT', subject: 'Kimya', questionText: 'Zayıf bir asit olan CH3COOH\'un sudaki iyonlaşma yüzdesi, çözelti su eklenerek seyreltildikçe ne olur?', options: ['Azalır', 'Değişmez', 'Artar', 'Sıfırlanır'], correctIndex: 2),
  Question(id: 492, examType: 'AYT', subject: 'Kimya', questionText: 'Galvanik bir hücrede (Pil), elektron akışının yönü neresidir?', options: ['Katottan anota dış devrede', 'Anotdan katota dış devrede', 'Tuz köprüsünden anota', 'Anotdan katota iç devrede'], correctIndex: 1),
  Question(id: 493, examType: 'AYT', subject: 'Kimya', questionText: 'Alkinlerin (Asetilenler) genel formülü nedir?', options: ['CnH2n', 'CnH2n+2', 'CnH2n-2', 'CnH2n-4'], correctIndex: 2),
  Question(id: 494, examType: 'AYT', subject: 'Kimya', questionText: 'Formaldehit yükseltgenirse hangi asit oluşur?', options: ['Asetik asit', 'Propanoik asit', 'Bütirik asit', 'Formik asit (Karınca asidi)'], correctIndex: 3),
  Question(id: 495, examType: 'AYT', subject: 'Kimya', questionText: 'Esterler su ile tepkimeye girerek asit ve alkole dönüşür. Bu olayın adı nedir?', options: ['Polimerleşme', 'Sabunlaşma', 'Hidroliz', 'Sübstitüsyon'], correctIndex: 2),
  Question(id: 496, examType: 'AYT', subject: 'Kimya', questionText: 'Azot molekülü (N2) içerisindeki iki azot atomu arasındaki bağ düzeni nasıldır?', options: ['Tekli bağ', 'İkili bağ', 'Üçlü bağ', 'İyonik bağ'], correctIndex: 2),
  Question(id: 497, examType: 'AYT', subject: 'Biyoloji', questionText: 'Mitokondrinin katlanmış iç zarlarına ne ad verilir?', options: ['Stroma', 'Matriks', 'Tülakoit', 'Krista'], correctIndex: 3),
  Question(id: 498, examType: 'AYT', subject: 'Biyoloji', questionText: 'Böbrekte idrar oluşum sürecinde süzülme (filtrasyon) nerede gerçekleşir?', options: ['Proksimal tüp', 'Glomerulus', 'Henle kulpunun inen kolu', 'İdrar toplama kanalı'], correctIndex: 1),
  Question(id: 499, examType: 'AYT', subject: 'Biyoloji', questionText: 'Merkezi sinir sisteminde miyelin kılıfları oluşturan destek hücrelerine verilen ad nedir?', options: ['Nöron', 'Oligodendrosit', 'Astrosit', 'Mikroglia'], correctIndex: 1),
  Question(id: 500, examType: 'AYT', subject: 'Biyoloji', questionText: 'Maddelerin derişim gradyanına (çoktan aza) karşı hücre zarı üzerinden geçişine ne denir?', options: ['Osmoz', 'Aktif taşıma', 'Basit difüzyon', 'Fagositoz'], correctIndex: 1),
  Question(id: 501, examType: 'AYT', subject: 'Biyoloji', questionText: 'DNA molekülünün kalıp zincirinden mesajcı RNA (mRNA) sentezlenmesi olayına ne denir?', options: ['Translasyon', 'Replikasyon', 'Transkripsiyon', 'Mutasyon'], correctIndex: 2),
  Question(id: 502, examType: 'AYT', subject: 'Biyoloji', questionText: 'Hangi hormon kanda kalsiyum oranını artırıcı (kemiği yıkarak) etki yapar?', options: ['Kalsitonin', 'Parathormon', 'Kortizol', 'Tiroksin'], correctIndex: 1),
  Question(id: 503, examType: 'AYT', subject: 'Biyoloji', questionText: 'Bağışıklık kazanmada aşı olmak ne tür bağışıklıktır?', options: ['Doğal pasif', 'Yapay pasif', 'Doğal aktif', 'Yapay aktif'], correctIndex: 3),
  Question(id: 504, examType: 'AYT', subject: 'Biyoloji', questionText: 'Ekolojide, belirli bir bölgede yaşayan farklı popülasyonların oluşturduğu biyolojik topluluğa ne denir?', options: ['Biyosfer', 'Komünite', 'Ekosistem', 'Biyom'], correctIndex: 1),
  Question(id: 505, examType: 'AYT', subject: 'Edebiyat', questionText: 'Fecr-i Âti beyannamesi ile ortaya çıkan ve "Sanat şahsi ve muhteremdir" görüşünü savunan edebiyatçımız kimdir?', options: ['Tevfik Fikret', 'Ahmet Haşim', 'Mehmet Akif Ersoy', 'Ziya Paşa'], correctIndex: 1),
  Question(id: 506, examType: 'AYT', subject: 'Edebiyat', questionText: '"Huzur" ve "Saatleri Ayarlama Enstitüsü" romanlarının usta yazarı kimdir?', options: ['Ahmet Hamdi Tanpınar', 'Sait Faik Abasıyanık', 'Orhan Kemal', 'Halit Ziya Uşaklıgil'], correctIndex: 0),
  Question(id: 507, examType: 'AYT', subject: 'Edebiyat', questionText: 'Türkiye\'de "İkinci Yeni" şiir hareketinin temsilcilerinden biri değildir?', options: ['Cemal Süreya', 'Edip Cansever', 'Orhan Veli Kanık', 'Turgut Uyar'], correctIndex: 2),
  Question(id: 508, examType: 'AYT', subject: 'Edebiyat', questionText: 'Türk edebiyatında mesnevi nazım biçimiyle yazılmış ilk eser kabul edilen "Kutadgu Bilig"in anlamı nedir?', options: ['Mutluluk Veren Bilgi', 'Gerçeklerin Eşiği', 'Sırlar Kitabı', 'Hükümdar Sözleri'], correctIndex: 0),
  Question(id: 509, examType: 'AYT', subject: 'Tarih', questionText: '27 Mayıs 1960 darbesi sonrasında kabul edilen, geniş özgürlükler içeren Türkiye Anayasası hangi yıldır?', options: ['1924', '1961', '1982', '1921'], correctIndex: 1),
  Question(id: 510, examType: 'AYT', subject: 'Tarih', questionText: 'Atatürk\'ün çok partili hayata geçiş denemelerinden biri olan ve Ali Fethi Okyar tarafından kurulan partinin adı nedir?', options: ['Terakkiperver Cumhuriyet Fırkası', 'Demokrat Parti', 'Serbest Cumhuriyet Fırkası', 'İttihat ve Terakki'], correctIndex: 2),
  Question(id: 511, examType: 'AYT', subject: 'Tarih', questionText: 'Tarihte "93 Harbi" olarak bilinen 1877-1878 Osmanlı-Rus Savaşı sonrasında hangi ağır antlaşma imzalanmıştır?', options: ['Ayastefanos (Yeşilköy)', 'Berlin', 'Kırım', 'Mondros'], correctIndex: 0),
  Question(id: 512, examType: 'AYT', subject: 'Tarih', questionText: 'Mustafa Kemal Paşa\'ya "Gazilik" unvanı ve "Mareşallik" rütbesi hangi savaştan sonra verilmiştir?', options: ['Sakarya Meydan Muharebesi', 'Büyük Taarruz', 'I. İnönü Muharebesi', 'Çanakkale Savaşı'], correctIndex: 0),
  Question(id: 513, examType: 'AYT', subject: 'Coğrafya', questionText: 'Sanayi tesislerinin yer seçiminde ulaşım çok etkilidir. Buna göre, İskenderun\'da demir-çelik fabrikasının kurulmasının temel sebebi nedir?', options: ['Hammadde (Demir) yakınlığı', 'Enerji (Kömür) yakınlığı', 'Ulaşım/Liman imkanları', 'İklim şartları'], correctIndex: 2),
  Question(id: 514, examType: 'AYT', subject: 'Coğrafya', questionText: 'Akdeniz İkliminin bitki örtüsü maki iken, Türkiye\'deki Bozkır (Step) ikliminin doğal bitki örtüsü nedir?', options: ['Orman', 'Çayır', 'Bozkır (Otlar)', 'Tundra'], correctIndex: 2),
  Question(id: 515, examType: 'AYT', subject: 'Coğrafya', questionText: 'Ekvatoral yağmur ormanlarının başlıca bulunduğu kıtalar hangileridir?', options: ['Güney Amerika ve Afrika', 'Asya ve Avrupa', 'Kuzey Amerika ve Avrupa', 'Antarktika ve Avustralya'], correctIndex: 0),
  Question(id: 516, examType: 'AYT', subject: 'Coğrafya', questionText: 'Aşağıdaki tarım ürünlerinden hangisinin Türkiye\'deki üretiminin büyük bir kısmı Karadeniz Bölgesinden sağlanır?', options: ['Buğday', 'Fındık', 'Zeytin', 'Pamuk'], correctIndex: 1),
  Question(id: 517, examType: 'AYT', subject: 'Felsefe Grubu', questionText: 'Felsefede "Mutlak Ruh (Geist)" kavramı ile bilinen, tez-antitez-sentez diyalektiğini savunan filozof kimdir?', options: ['Kant', 'Hegel', 'Sartre', 'Descartes'], correctIndex: 1),
  Question(id: 518, examType: 'AYT', subject: 'Felsefe Grubu', questionText: 'Sigmund Freud\'un öncüsü olduğu, bilinçdışı süreçleri ve çocukluk yaşantılarını inceleyen psikoloji yaklaşımı hangisidir?', options: ['Davranışçılık', 'Hümanizm', 'Psikanaliz', 'Bilişsel Yaklaşım'], correctIndex: 2),
  Question(id: 519, examType: 'AYT', subject: 'Felsefe Grubu', questionText: 'Sosyolojide "Toplumsal Dayanışma" türlerini (mekanik ve organik) tanımlayan sosyolog kimdir?', options: ['Karl Marx', 'Max Weber', 'Emile Durkheim', 'Auguste Comte'], correctIndex: 2),
  Question(id: 520, examType: 'AYT', subject: 'Felsefe Grubu', questionText: 'Kişinin kendi inancını evrensel bir geçerliliğe taşımadan, her türlü tanrı veya yaratıcı inancını reddetmesine ne denir?', options: ['Deizm', 'Panteizm', 'Ateizm', 'Agnostisizm'], correctIndex: 2),

  // ─────────────── YENİ EKLENEN 50 AYT SORUSU (ÖSYM TARZI - 2. PARTİ) ───────────────
  Question(id: 521, examType: 'AYT', subject: 'Matematik', questionText: 'f(x) = x³ - 3x² + 5 fonksiyonunun yerel ekstremum (maksimum ve minimum) noktalarının apsisleri toplamı kaçtır?', options: ['-3', '0', '2', '3'], correctIndex: 2), // f'(x)=3x²-6x=0 => 3x(x-2)=0 => x=0, x=2. Toplam: 2.
  Question(id: 522, examType: 'AYT', subject: 'Matematik', questionText: '∫(2x + 1) dx belirsiz integralinin sonucu aşağıdakilerden hangisidir? (c: sabit)', options: ['x² + c', 'x² + x + c', '2x² + x + c', 'x² - x + c'], correctIndex: 1),
  Question(id: 523, examType: 'AYT', subject: 'Matematik', questionText: 'P(x) polinomu x² - 4 ile kalansız bölünüyorsa ve P(x)\'in katsayılar toplamı 10 ise, P(2) ve P(-2) değerleri sırasıyla nedir?', options: ['(0, 0)', '(2, -2)', '(10, 10)', '(4, -4)'], correctIndex: 0), // Tam bölünüyor demek kökler P(2)=0 ve P(-2)=0 demektir.
  Question(id: 524, examType: 'AYT', subject: 'Matematik', questionText: 'log₂ (x-3) + log₂ (x+3) = 4 denkleminin çözüm kümesi nedir? (Logaritma tanım aralığı x > 3)', options: ['{4}', '{5}', '{6}', '{7}'], correctIndex: 1), // log₂(x²-9) = 4 => x²-9 = 16 => x²=25 => x=5 (x=-5 tanımsız)
  Question(id: 525, examType: 'AYT', subject: 'Matematik', questionText: ' Karmaşık sayılar kümesinde i² = -1 olmak üzere, z = 3 - 4i sayısının eşleniği ve modülü (mutlak değeri) sırasıyla nedir?', options: ['3 - 4i, 5', '3 + 4i, 5', '-3 - 4i, 7', '-3 + 4i, 25'], correctIndex: 1), // eşlenik: 3+4i. modül: kök(9+16)=5.
  Question(id: 526, examType: 'AYT', subject: 'Matematik', questionText: 'lim (x->2) (x² - 4)/(x - 2) limitinin değeri kaçtır?', options: ['0', '2', '4', 'Belirsiz'], correctIndex: 2), // L'Hopital veya çarpanlara ayırma: x+2 = 4.
  Question(id: 527, examType: 'AYT', subject: 'Matematik', questionText: '1\'den 10\'a kadar olan tam sayıların toplamının (Σ n) integral kullanılarak yaklaşık alanı bulunmak istense, y = x doğrusunun [0,10] aralığındaki üçgensel alanı kaçtır?', options: ['45', '50', '55', '100'], correctIndex: 1), // int x dx = x²/2 -> 100/2 = 50. (Σn = 55 ancak sürekli integral alanı üçgen = 10*10/2=50)
  Question(id: 528, examType: 'AYT', subject: 'Matematik', questionText: 'Bir aritmetik dizide a₄ = 10 ve a₇ = 19 ise bu dizinin ortak farkı (r) kaçtır?', options: ['2', '3', '4', '5'], correctIndex: 1), // 3r = 9 => r=3.
  Question(id: 529, examType: 'AYT', subject: 'Matematik', questionText: 'cos(2x) = 1/2 denkleminin [0, π/2] aralığındaki kökü aşağıdakilerden hangisidir?', options: ['π/6', 'π/4', 'π/3', 'π'], correctIndex: 0), // cos(60) = 1/2. 2x = 60 => x = 30 = π/6.
  Question(id: 530, examType: 'AYT', subject: 'Matematik', questionText: 'Bir madeni para 5 kez ard arda havaya atılıyor. Tam olarak 3 kez tura gelme olasılığı kaçtır?', options: ['5/32', '10/32', '15/32', '20/32'], correctIndex: 1), // C(5,3) * (1/2)^3 * (1/2)^2 = 10 * 1/32 = 10/32.
  Question(id: 531, examType: 'AYT', subject: 'Fizik', questionText: 'Yatay atış hareketi yapan bir cismin yere çarpma süresi sadece hangi fiziksel niceliğe bağlıdır? (Sürtünmesiz ortam)', options: ['Cismin kütlesine', 'Atılış yüksekliğine ve yerçekimi ivmesine', 'Yatay fırlatılma hızına', 'Cismin şekline'], correctIndex: 1), // h = 1/2 g t^2
  Question(id: 532, examType: 'AYT', subject: 'Fizik', questionText: 'Manyetik alan (B) içinde, manyetik alana dik ()V) hızıyla hareket eden q yüklü parçacığa etki eden Lorentz Kuvvetinin formülü nedir?', options: ['F = m.a', 'F = q.E', 'F = q.V.B', 'F = k.q1.q2/r²'], correctIndex: 2),
  Question(id: 533, examType: 'AYT', subject: 'Fizik', questionText: 'Basit harmonik hareket yapan bir sarkaçın periyodu (T), ipin uzunluğu (L) dört katına çıkarılırsa nasıl değişir?', options: ['Değişmez', 'Yarıya düşer', '2 katına çıkar', '4 katına çıkar'], correctIndex: 2), // T = 2pi * kök(L/g). L 4 katına çıkarsa köklü T 2 katına çıkar.
  Question(id: 534, examType: 'AYT', subject: 'Fizik', questionText: 'Compton Saçılması deneyinde X-ışını fotonu elektronla çarpıştıktan sonra aşağıdakilerden hangisi kesinlikle gerçekleşir?', options: ['Fotonun hızı azalır', 'Fotonun frekansı artar', 'Fotonun dalga boyu artar', 'Foton yok olur'], correctIndex: 2), // Enerji kaybeder, dalga boyu artar.
  Question(id: 535, examType: 'AYT', subject: 'Fizik', questionText: 'Sığaçlarda (Kondansatör) depolanan enerji (E), sığacın kapasitansı (C) ve uçları arasındaki potansiyel (V) ile nasıl ilişkilidir?', options: ['E = Q.V', 'E = 1/2 C.V²', 'E = I.R', 'E = m.g.h'], correctIndex: 1),
  Question(id: 536, examType: 'AYT', subject: 'Fizik', questionText: 'Sürtünmesiz yatay bir düzlemde esnek olmayan (yapışık) çarpışma yapan iki cismin çarpışma durumunda hangi nicelik kesinlikle korunur?', options: ['Kinetik enerji', 'Momentum', 'Hız', 'Sıcaklık'], correctIndex: 1), // Esnek olmayan çarpışmalarda kinetik enerji korunmaz, momentum korunur.
  Question(id: 537, examType: 'AYT', subject: 'Kimya', questionText: 'Gazların ideal gaz denkleminde (P.V = n.R.T), sıcaklık (T) hangi birimle ifade edilmek zorundadır?', options: ['Celcius', 'Fahrenheit', 'Kelvin', 'Joule'], correctIndex: 2),
  Question(id: 538, examType: 'AYT', subject: 'Kimya', questionText: 'Bir galvanik hücrenin (pil) standart hücre potansiyeli (E°hücre) pozitif çıkıyorsa, bu tepkime hakkında ne söylenebilir?', options: ['Tepkime istemsizdir, enerji gerektirir', 'Tepkime denge halindedir', 'Tepkime istemlidir, kendiliğinden gerçekleşir', 'Hücre pil olarak kullanılamaz'], correctIndex: 2),
  Question(id: 539, examType: 'AYT', subject: 'Kimya', questionText: 'Organik kimyada Alkanların genel kapalı formülü nedir?', options: ['CnH2n', 'CnH2n-2', 'CnH2n+2', 'CnH2n+1'], correctIndex: 2),
  Question(id: 540, examType: 'AYT', subject: 'Kimya', questionText: 'Kimyasal tepkimelerde katalizörün temel işlevi aşağıdakilerden hangisidir?', options: ['Tepkime verimini artırmak', 'Tepkime ısısını (entalpiyi) değiştirmek', 'Aktivasyon enerjisini düşürerek tepkimeyi hızlandırmak', 'Ürünlerin türünü değiştirmek'], correctIndex: 2),
  Question(id: 541, examType: 'AYT', subject: 'Biyoloji', questionText: 'İnsan kalbinin dıştan içe doğru sahip olduğu üç tabaka sırasıyla hangisinde doğru verilmiştir?', options: ['Perikard, Miyokard, Endokard', 'Endokard, Miyokard, Perikard', 'Miyokard, Endokard, Plevra', 'Plevra, Alveol, Membran'], correctIndex: 0),
  Question(id: 542, examType: 'AYT', subject: 'Biyoloji', questionText: 'Protein sentezi (Translasyon) hücrenin hangi organelinde gerçekleşir?', options: ['Golgi', 'Mitokondri', 'Ribozom', 'Lizozom'], correctIndex: 2),
  Question(id: 543, examType: 'AYT', subject: 'Biyoloji', questionText: 'Merkezi sinir sisteminde impuls iletimi sırasında sinaps boşluğunda impulsun bir nörondan diğerine geçişini sağlayan kimyasal maddelere ne denir?', options: ['Nörotransmitter', 'Hormon', 'Enzim', 'Antikor'], correctIndex: 0),
  Question(id: 544, examType: 'AYT', subject: 'Biyoloji', questionText: 'Fotosentezin ışıktan bağımsız tepkimeleri (Calvin Döngüsü) kloroplastın hangi bölümünde gerçekleşir?', options: ['Tilakoit zar', 'Granum', 'Stroma', 'Matriks'], correctIndex: 2),
  Question(id: 545, examType: 'AYT', subject: 'Biyoloji', questionText: 'İnce bağırsakta sindirilmiş besinlerin villuslar aracılığıyla kan kılcallarına emilmesinde etkili olan ve yüzey alanını artıran yapılara ne denir?', options: ['Mikrovillus', 'Pilor', 'Kardiya', 'Safra kesesi'], correctIndex: 0),
  Question(id: 546, examType: 'AYT', subject: 'Edebiyat', questionText: 'Şiirde dize sonlarında farklı sözcüklerle fakat aynı ses benzerliğiyle yapılan uyağa ne ad verilir?', options: ['Redif', 'Kafiye (Uyak)', 'Aliterasyon', 'Asonans'], correctIndex: 1),
  Question(id: 547, examType: 'AYT', subject: 'Edebiyat', questionText: '"Vatan Yahut Silistre" isimli tiyatro eseri ve "İntibah" adlı ilk edebi romanın yazarı tanzimat edebiyatı sanatçımız kimdir?', options: ['Namık Kemal', 'Şinasi', 'Recaizade Mahmut Ekrem', 'Ahmet Mithat Efendi'], correctIndex: 0),
  Question(id: 548, examType: 'AYT', subject: 'Edebiyat', questionText: 'Milli Edebiyat akımının dil anlayışını (sade Türkçe) ortaya koyan "Yeni Lisan" makalesi hangi dergide yayımlanmıştır?', options: ['Servet-i Fünun', 'Genç Kalemler', 'Varlık', 'Türk Yurdu'], correctIndex: 1),
  Question(id: 549, examType: 'AYT', subject: 'Edebiyat', questionText: 'Hangi edebi akım "Gerçeği olduğu gibi betimlemek ve soyaçekim (determinizm) kanunlarını romana yansıtmak" amacını taşır?', options: ['Romantizm', 'Natüralizm', 'Sürrealizm', 'Klasisizm'], correctIndex: 1),
  Question(id: 550, examType: 'AYT', subject: 'Edebiyat', questionText: 'Divan edebiyatında "Gazel" nazım şeklinin ilk beytine ve son beytine ne ad verilir?', options: ['Mısra-ı Azade / Şah Beyit', 'Kaside / Tevhid', 'Matla / Makta', 'Aruz / Hece'], correctIndex: 2), // Matla başlangıç, Makta bitiş.
  Question(id: 551, examType: 'AYT', subject: 'Tarih', questionText: 'Osmanlı Devleti\'nde kapıkulu askerlerine padişah değişikliklerinde (cülus) verilen bahşişin adı nedir?', options: ['Ulufe', 'Cülus Bahşişi', 'Ganimet', 'Tımar'], correctIndex: 1), // Ulufe maaş, Cülus bahşiştir.
  Question(id: 552, examType: 'AYT', subject: 'Tarih', questionText: 'Mondros Ateşkes Antlaşmasının Osmanlı\'nın fiilen parçalanmasına kapı aralayan o meşhur, kritik 7. maddesinin içeriği neydi?', options: ['Osmanlı ordusu terhis edilecek', 'Vilayet-i Sitte\'de karışıklık çıkarsa işgal edilecek (Madde 24)', 'İtilaf devletleri güvenliklerini tehdit eden herhangi bir stratejik noktayı işgal hakkına sahip olacak', 'Boğazlar tüm gemilere açılacak'], correctIndex: 2),
  Question(id: 553, examType: 'AYT', subject: 'Tarih', questionText: 'TBMM tarafından Lozan Barış Konferansına temsilci olarak gönderilen, Mudanya mütarekesindeki başarısından dolayı Başmüşavir seçilen devlet adamı kimdir?', options: ['Mustafa Kemal Paşa', 'Rauf Orbay', 'İsmet İnönü', 'Kazım Karabekir'], correctIndex: 2),
  Question(id: 554, examType: 'AYT', subject: 'Tarih', questionText: 'Aşağıdakilerden hangisi Cumhuriyetin İlanı (29 Ekim 1923) sonrasında yaşanan gelişmelerden DEĞİLDİR?', options: ['Halifeliğin kaldırılması (1924)', 'Tekke ve Zaviyelerin kapatılması (1925)', 'Saltanatın kaldırılması (1922)', 'Harf İnkılabı (1928)'], correctIndex: 2), // Saltanat 1922'de kalktı, cumhuriyetten önce.
  Question(id: 555, examType: 'AYT', subject: 'Tarih', questionText: 'Fransız ihtilalinin yaydığı milliyetçilik akımından etkilenerek Osmanlı İmparatorluğuna isyan eden ve bağımsızlığını kazanan İLK azınlık hangisidir?', options: ['Sırplar', 'Araplar', 'Bulgarlar', 'Yunanlar (Rumlar)'], correctIndex: 3), // Sırplar isyan eden ilk millettir ama YUNANLAR (1829 Edirne antlaşması) bağımsız olan ilk millettir.
  Question(id: 556, examType: 'AYT', subject: 'Coğrafya', questionText: 'Bir ülkenin gelişmişlik seviyesi ölçülürken nüfus piramidinin şekli büyük önem taşır. "Arı kovanı" şeklindeki nüfus piramidine sahip bir ülke için hangisi söylenebilir?', options: ['Doğum oranı çok yüksektir', 'Ortalama yaşam süresi uzundur ve nüfus yaşlıdır (Gelişmiş)', 'Gelişmemiş bir ülkedir', 'Nüfus yoğunluğu artmaktadır'], correctIndex: 1),
  Question(id: 557, examType: 'AYT', subject: 'Coğrafya', questionText: 'Jeolojik zamanlar düşünüldüğünde, Türkiye linyit, tuz ve bor yataklarının oluşumu hangi jeolojik zamana denk gelmektedir?', options: ['I. Jeolojik Zaman (Paleozoik)', 'II. Jeolojik Zaman (Mesozoik)', 'III. Jeolojik Zaman (Tersiyer)', 'IV. Jeolojik Zaman (Kuvaterner)'], correctIndex: 2),
  Question(id: 558, examType: 'AYT', subject: 'Coğrafya', questionText: 'Dünyada ulaşımı sağlamak için denizleri birbirine bağlayan yapay kanallar mevcuttur. Akdeniz ile Kızıldeniz\'i birleştiren ve Mısır\'da bulunan kanalın adı nedir?', options: ['Panama Kanalı', 'Süveyş Kanalı', 'Kiel Kanalı', 'Korint Kanalı'], correctIndex: 1),
  Question(id: 559, examType: 'AYT', subject: 'Coğrafya', questionText: 'Çevresel (Ekolojik) krizlere yol açan küresel iklim değişikliğinin temel (en büyük) nedeni (Sera Etkisi) aşağıda atmosferdeki hangi gazın artışıyla ilişkilidir?', options: ['Oksijen', 'Azot', 'Karbondioksit (CO2)', 'Helyum'], correctIndex: 2),
  Question(id: 560, examType: 'AYT', subject: 'Coğrafya', questionText: 'Güneş ışınlarının düşme açısı değiştikçe gölge boyu değişir. Türkiye\'de yatay bir düzleme dikilen çubuğun gölgesinin tüm yıl boyunca "kuzeye" düşmesinin sebebi nedir?', options: ['Yengeç dönencesinin kuzeyinde yer alması (Orta Kuşak)', 'Asya kıtasında olması', 'Dağlık olması', 'Kışların soğuk geçmesi'], correctIndex: 0),
  Question(id: 561, examType: 'AYT', subject: 'Felsefe Grubu', questionText: 'Platon felsefesinde "Gerçek varlık, duyularla algılanan nesneler değil, salt akılla kavranan değişmez, tümel özlerdir." cümlesi ile kastedilen dünya nedir?', options: ['Duyular dünyası', 'Oluş dünyası', 'İdealar dünyası', 'Madde dünyası'], correctIndex: 2),
  Question(id: 562, examType: 'AYT', subject: 'Felsefe Grubu', questionText: 'Sosyolojide bireylere toplum kurallarını benimseterek onları topluma uyumlu hale getirme sürecine ne ad verilir?', options: ['Toplumsal tabakalaşma', 'Sosyalleşme (Toplumsallaşma)', 'Sosyal hareketlilik', 'Toplumsal sapma'], correctIndex: 1),
  Question(id: 563, examType: 'AYT', subject: 'Felsefe Grubu', questionText: 'Pavlov\'un köpekler üzerinde yaptığı deneyle psikoloji literatürüne kazandırdığı ve "zil sesine salya akıtma" olarak kodlanan öğrenme türü hangisidir?', options: ['Klasik koşullanma', 'Edimsel koşullanma', 'Bilişsel öğrenme', 'Sosyal (Gözlem yoluyla) öğrenme'], correctIndex: 0),
  Question(id: 564, examType: 'AYT', subject: 'Felsefe Grubu', questionText: 'Mantık biliminde, bir önermenin "Doğru ya da Yanlış" olabilme özelliğine ne ad verilir?', options: ['Doğruluk değeri', 'Geçerlilik', 'Tutarlılık', 'Tanım'], correctIndex: 0),
  Question(id: 565, examType: 'AYT', subject: 'Din Kültürü', questionText: 'İslam dini fıkhında, yapılmasında sevap olan, yapılmamasında ise günah olmayan (Hz. Muhammed\'in ibadet kapsamı dışındaki güzel davranışları) eylemlere ne denir?', options: ['Farz', 'Vacip', 'Sünnet', 'Mekruh'], correctIndex: 2),
  Question(id: 566, examType: 'AYT', subject: 'Matematik', questionText: 'Eğer bir f(x) fonksiyonu x=a apsisli noktasında sürekli ancak türevsiz ise bu nokta fonksiyon grafinde genellikle nasıl bir şekle karşılık gelir?', options: ['Kopma (Sıçrama)', 'Kırılma (Sivri uç)', 'Boşluk (Delik)', 'Sabit çizgi'], correctIndex: 1), // Kırılma veya Sivri noktalarda sağ ve sol türev farklıdır, türev yoktur.
  Question(id: 567, examType: 'AYT', subject: 'Matematik', questionText: 'ln(e³) + log(100) işleminin sonucu kaçtır?', options: ['2', '3', '4', '5'], correctIndex: 3), // 3 * ln(e) + 2 * log(10) = 3(1) + 2(1) = 5.
  Question(id: 568, examType: 'AYT', subject: 'Fizik', questionText: 'Fotoelektrik olayda metalden koparılan elektronların maksimum kinetik enerjisini sıfıra düşüren ve akımı kesen potansiyel farkına ne ad verilir?', options: ['Anma Gerilimi', 'Etkin Gerilim', 'Kesme Potansiyeli', 'Zıt Potansiyel'], correctIndex: 2),
  Question(id: 569, examType: 'AYT', subject: 'Kimya', questionText: 'Asitlerin kuvvetliliğine etki eden faktörlere göre molekül yapısı en elektro-negatif atoma (Örn: Flor vs Klor/İyot) bağlı olan oksi-asitlerin kuvvetliği nasıl değişir?', options: ['Artar', 'Azalır', 'Etkilenmez', 'Nötre Döner'], correctIndex: 0), // Elektronegatiflik arttıkça oksi-asidizasyon elektron çekimi artar O-H bağı zayıflar, asitlik kuvveti artar.
  Question(id: 570, examType: 'AYT', subject: 'Biyoloji', questionText: 'Böbrekte Nefron kanalcıklarında geri emilim sırasında "suyun geri emiliminde görevli olan" ince-kalın kanalcıklar ağının (U borusu şeklinde olan) adı nedir?', options: ['Glomerulus Yumağı', 'Bowman Kapsülü', 'Henle Kulpu', 'Malpighi Cisimciği'], correctIndex: 2),

  // ─────────────── YENİ EKLENEN 50 AYT SORUSU (ÖSYM TARZI - 3. PARTİ) ───────────────
  Question(id: 571, examType: 'AYT', subject: 'Matematik', questionText: 'f(x) fonksiyonun (a, b) aralığında birinci türevi f\'(x) > 0 ve ikinci türevi f\'\'(x) < 0 dır. Buna göre f(x) fonksiyonunun bu aralıktaki değişim eğilimi nasıldır?', options: ['Azalan ve İçe Bükey (Konkav)', 'Artan ve İçe Bükey (Konkav)', 'Artan ve Dışa Bükey (Konveks)', 'Azalan ve Dışa Bükey (Konveks)'], correctIndex: 1), // f'>0 Artan, f''<0 Konkav (İçe Bükey) (Ağzı aşağı).
  Question(id: 572, examType: 'AYT', subject: 'Matematik', questionText: 'Gerçel sayılarda tanımlı f(x) = x³ - 12x fonksiyonunun mutlak minimum değeri, x ∈ [-1, 5] kapalı aralığında kaçtır?', options: ['-16', '-11', '0', '65'], correctIndex: 0), // f'(x)=3x²-12=0 -> x=2, x=-2. [-1,5] de f(2)=8-24= -16. Uç noktalar: f(-1)=-1+12=11. f(5)=125-60=65. Mutlak minimum = -16.
  Question(id: 573, examType: 'AYT', subject: 'Matematik', questionText: 'Sınırları x=1 ve x=2 olan, f(x) = 1/x fonksiyonunun integrali (eğri altında kalan alan) aşağıdakilerden hangisidir?', options: ['ln(1/2)', 'ln(2)', '1', 'e²'], correctIndex: 1), // int (1/x) dx = ln|x|. ln2 - ln1 = ln2.
  Question(id: 574, examType: 'AYT', subject: 'Matematik', questionText: 'z = 1 + i karmaşık sayısının kutupsal (trigonometrik) gösterimi aşağıdakilerden hangisidir?', options: ['√2(cos45° + i.sin45°)', '2(cos30° + i.sin30°)', '√2(cos60° + i.sin60°)', 'cos45° - i.sin45°'], correctIndex: 0), // r = kök(1+1) = kök2. arg: tanA = 1/1 = 1 -> 45 derece.
  Question(id: 575, examType: 'AYT', subject: 'Matematik', questionText: 'log_x (y) = 2 ve log_y (z) = 3 olduğuna göre log_x (z) kaçtır?', options: ['1', '5', '6', '8'], correctIndex: 2), // log_x(y) * log_y(z) = 2 * 3 = 6 -> log_x(z) = 6.
  Question(id: 576, examType: 'AYT', subject: 'Matematik', questionText: 'Bir aritmetik dizide İlk n terim toplamı S_n = 2n² + 3n formülüyle veriliyor. Bu dizinin 5. terimi (a₅) kaçtır?', options: ['15', '19', '21', '65'], correctIndex: 2), // a5 = S5 - S4. S5 = 2(25)+15 = 65. S4 = 2(16)+12 = 44. 65 - 44 = 21.
  Question(id: 577, examType: 'AYT', subject: 'Matematik', questionText: '5 kız ve 4 erkek öğrenci arasından 3 kişilik bir ekip oluşturulacaktır. Ekipte en az iki kız öğrenci olma olasılığı kaçtır?', options: ['10/84', '40/84', '50/84', '60/84'], correctIndex: 2), // Toplam C(9,3) = 84. (2K,1E): C(5,2)*C(4,1) = 10*4=40. (3K): C(5,3) = 10. Toplam = 50. 50/84.
  Question(id: 578, examType: 'AYT', subject: 'Matematik', questionText: 'P(x) = x³ + ax² + bx + c polinomunun üç kökü de birbirine eşittir. P(0) = -8 olduğuna göre P(1) kaçtır?', options: ['-1', '0', '1', '8'], correctIndex: 0), // (x-x0)³. P(0) = -x0³ = -8 => x0=2. P(x) = (x-2)³. P(1) = (-1)³ = -1.
  Question(id: 579, examType: 'AYT', subject: 'Matematik', questionText: 'sin²(15°) - cos²(15°) ifadesinin değeri kaçtır?', options: ['-√3 / 2', '-1/2', '1/2', '√3 / 2'], correctIndex: 0), // = -(cos²15 - sin²15) = -cos(30) = -kök3 / 2.
  Question(id: 580, examType: 'AYT', subject: 'Matematik', questionText: 'Koordinat düzleminde, merkezi (3, -4) olan ve orijinden (0, 0) geçen çemberin denklemi aşağıdakilerden hangisidir?', options: ['(x-3)² + (y+4)² = 5', '(x-3)² + (y+4)² = 25', '(x+3)² + (y-4)² = 25', '(x-3)² + (y+4)² = 7'], correctIndex: 1), // r² = 3² + (-4)² = 25.
  Question(id: 581, examType: 'AYT', subject: 'Fizik', questionText: 'Yarıçapı R olan iletken küreyi +Q yükü ile yüklediğimizde, kürenin içindeki elektrik alan (E) ve elektriksel potansiyel (V) için ne söylenebilir?', options: ['E = 0, V = 0', 'E maksimum, V sıfırdır', 'E = 0, V her noktada yüzeydekine eşittir (sabittir)', 'E yüzeydekine eşittir, V sıfırdır'], correctIndex: 2),
  Question(id: 582, examType: 'AYT', subject: 'Fizik', questionText: 'Bir transformatörde, primer sarım (N1) sekonder sarımdan (N2) fazla ise potansiyel (V) ve akım (I) nasıl değişir? (İdeal Transformatör)', options: ['Gerilim düşürülür, akım yükseltilir', 'Gerilim yükseltilir, akım düşürülür', 'İkisi de yükseltilir', 'İkisi de değişmez'], correctIndex: 0), // Alçaltıcı transformatör: V düşer, I artar.
  Question(id: 583, examType: 'AYT', subject: 'Fizik', questionText: 'Işığın dalga doğasını kanıtlayan "Çift Yarıkta Girişim (Young Deneyi)" deneyinde, ekran yarık düzleminden uzaklaştırılırsa (L artarsa) saçak genişliği (Δx) nasıl değişir?', options: ['Azalır', 'Artar', 'Değişmez', 'Önce artar sonra azalır'], correctIndex: 1), // Δx = λ * L / d * n. L artarsa formül gereği Δx artar.
  Question(id: 584, examType: 'AYT', subject: 'Fizik', questionText: 'Bohr Atom Modeline göre hidrojen atomunda elektron n=2 den n=1 seviyesine indiğinde açısal momentumu ne kadar değişir?', options: ['h/π kadar azalır', 'h/2π kadar azalır', 'h/2π kadar artar', 'Değişmez'], correctIndex: 1), // L = n * h/2π. n 2'den 1'e inerse, 1 * h/2π kadar azalır.
  Question(id: 585, examType: 'AYT', subject: 'Fizik', questionText: 'Kütleleri eşit (m) olan iki bilyeden biri h yüksekliğinden serbest düşmeye bırakılıyor, diğeri ise eğik düzlemde h yüksekliğinden serbest bırakılarak kayıyor. Ortam sürtünmesiz ise yere ulaştıklarında hangisi daha BÜYÜK hıza sahip olur?', options: ['Serbest düşen', 'Eğik düzlemde kayan', 'İkisinin de yere çarpma hızları Eşittir', 'Eğik düzlemin açısına bağlıdır'], correctIndex: 2), // Enerji korunumu: mgh = 1/2 m V². Hız her ikisinde de aynı olur (Eşittir).
  Question(id: 586, examType: 'AYT', subject: 'Kimya', questionText: 'Modern Atom Teorisine göre n=3 baş kuantum sayısına (Halkaya) sahip bir enerji düzeyinde bulunabilecek maksimum elektron sayısı kaçtır? (Formül: 2n²)', options: ['8', '16', '18', '32'], correctIndex: 2),
  Question(id: 587, examType: 'Kimya', subject: 'AYT', questionText: 'Hess Yasasına göre bir kimyasal tepkimenin entalpi değişimi (ΔH) aşağıdakilerden hangisine bağlı DEĞİLDİR?', options: ['Tepkimeye girenlerin türüne', 'Oluşan ürünlerin fiziksel haline', 'Tepkimenin izlediği yola (mekanizmasına)', 'Sıcaklık ve basınca'], correctIndex: 2), // Hess yasası: Entalpi değişimi sadece ilk ve son hallere bağlıdır, izlenen yola bağlı değildir. (Wait examType ve subject ters yazılmış. Düzeltiyorum.
  Question(id: 588, examType: 'AYT', subject: 'Kimya', questionText: '2X(g) ⇌ Y(g) + Z(g) tepkimesi kapalı bir kapta denge halindeyken kabın Hacmi küçültülürse, denge nasıl tepki verir?', options: ['Girenlere kayar', 'Ürünlere kayar', 'Denge konumu değişmez', 'Hız sabiti (K) küçülür'], correctIndex: 2), // Gaz mol sayıları eşit (2 -> 1+1). Hacim/Basınç dengenin yönünü değiştirmez.
  Question(id: 589, examType: 'AYT', subject: 'Kimya', questionText: 'Eritilmiş asit ve bazların sulu çözeltilerinde pH değerini koruyan, zayıf asit ile onun eşlenik (konjuge) bazının tuzu veya zayıf baz ile eşlenik asidinin tuzu karışımına ne denir?', options: ['Aerosol çözeltisi', 'Doygun çözelti', 'Tampon çözelti', 'Süspansiyon'], correctIndex: 2),
  Question(id: 590, examType: 'AYT', subject: 'Kimya', questionText: 'CH3-CH2-OH (Etil alkol) organik molekülünde, hangi tür fonksiyonel grup bulunur?', options: ['Karboksil', 'Hidroksil', 'Keton', 'Eter'], correctIndex: 1), // R-OH, Hidroksil (-OH) grubudur. Alkol sınıfı.
  Question(id: 591, examType: 'AYT', subject: 'Biyoloji', questionText: 'Sinir telinde aksiyon potansiyelinin oluşması anında impuls (uyartı) geçerken iç kısmın pozitif (+), dış kısmın negatif (-) olma durumuna (polarizasyonun bozulmasına) ne denir?', options: ['Polarizasyon', 'Depolarizasyon', 'Repolarizasyon', 'Sinerjit durum'], correctIndex: 1),
  Question(id: 592, examType: 'AYT', subject: 'Biyoloji', questionText: 'Kapalı tohumlu bitkilerde embriyo kesesindeki yumurta hücresinin bir spermle döllenerek zigotu, diğer spermin polar çekirdeklerle birleşerek 3n kromozomlu endospermi (besi doku) oluşturması olayına ne denir?', options: ['Vejetatif üreme', 'Tomurcuklanma', 'Çifte döllenme', 'Partenogenez'], correctIndex: 2),
  Question(id: 593, examType: 'AYT', subject: 'Biyoloji', questionText: 'Ökaryot bir hücrede Oksijenli solunum ETS (Elektron Taşıma Sistemi) evresi tam olarak nerede gerçekleşir?', options: ['Sitoplazmada', 'Mitokondrinin dış zarında', 'Mitokondrinin matriks sıvısında', 'Mitokondrinin iç zarı olan Kristalarda'], correctIndex: 3),
  Question(id: 594, examType: 'AYT', subject: 'Biyoloji', questionText: 'Bir DNA molekülünün kopyalanmasında (Replikasyonunda) çift sarmalı bir fermuar gibi açarak hidrojen bağlarını koparan enzimin adı nedir?', options: ['DNA Ligaz', 'DNA Polimeraz', 'Helikaz', 'RNA Polimeraz'], correctIndex: 2),
  Question(id: 595, examType: 'AYT', subject: 'Biyoloji', questionText: 'Kandaki glikoz seviyesi düştüğünde pankreasın alfa hücrelerinden salgılanarak karaciğerdeki glikojeni glikoza çeviren, kan şekerini ARTTIRAN hormon hangisidir?', options: ['İnsülin', 'Glukagon', 'Adrenalin', 'Aldosteron'], correctIndex: 1),
  Question(id: 596, examType: 'AYT', subject: 'Edebiyat', questionText: 'Cumhuriyet dönemi Türk şiirinde "Öz (Saf) Şiir" anlayışını benimseyerek ideolojiyi şiirden uzak tutan ve "Kaldırımlar" şiiri ile efsaneleşen şairimiz kimdir?', options: ['Necip Fazıl Kısakürek', 'Mehmet Akif Ersoy', 'Nazım Hikmet Ran', 'Orhan Veli Kanık'], correctIndex: 0),
  Question(id: 597, examType: 'AYT', subject: 'Edebiyat', questionText: '"Su Kasidesi", Fuzuli\'nin hangi türde kaleme aldığı ve en bilinen eserlerindendir?', options: ['Tevhid (Allah\'ı anma)', 'Naat (Peygamberi övme)', 'Mersiye', 'Hicviye'], correctIndex: 1),
  Question(id: 598, examType: 'AYT', subject: 'Edebiyat', questionText: 'Bir edebi eserde gerçek ya da hayali bir varlığı başka bir kavrama benzetirken "Bir hilal uğruna ya Rab ne güneşler batıyor" mısrasındaki gibi "Sadece kendisine benzetilen" in kullanılması sanatına ne ad verilir?', options: ['Teşhis', 'Kapalı İstiare', 'Açık İstiare', 'Kinaye'], correctIndex: 2), // Güneş (asker). Asker yok, sadece Güneş var. Açık istiare.
  Question(id: 599, examType: 'AYT', subject: 'Edebiyat', questionText: 'Yusuf Has Hacib tarafından yazılan ve siyasetname tarzında bir rüya kurgusunu, dört sembolik kişi üzerinden mutluluğu anlatan eser hangisidir?', options: ['Atabetü\'l Hakayık', 'Divanu Lugati\'t Türk', 'Kutadgu Bilig', 'Divan-ı Hikmet'], correctIndex: 2),
  Question(id: 600, examType: 'AYT', subject: 'Edebiyat', questionText: 'Köy Enstitülerinden yetişerek tarım işçilerinin, göçmenlerin ve köylünün yaşamını gerçekçi bir dille "Yılanların Öcü" eserinde anlatan Fakir Baykurt hangi edebiyat akımı içindedir?', options: ['Bireyin İç Dünyasını Esas Alan', 'Toplumcu Gerçekçi', 'Geleneksel Modern', 'Milli Duyarlılığı Yansıtan'], correctIndex: 1),
  Question(id: 601, examType: 'AYT', subject: 'Tarih', questionText: 'Anadolu Selçuklu Devleti\'nin siyasi birliğini ve gücünü yitirerek Moğol (İlhanlı) egemenliğine girmesine neden olan yıkıcı savaş hangisidir?', options: ['Malazgirt Meydan Muharebesi', 'Miryokefalon Savaşı', 'Kösedağ Savaşı', 'Ankara Savaşı'], correctIndex: 2), // 1243 Kösedağ
  Question(id: 602, examType: 'AYT', subject: 'Tarih', questionText: 'Avrupa\'da "Yeniden Doğuş" anlamına gelen, edebiyat, sanat ve bilim alanında antik Yunan ve Roma eserlerinin incelendiği 15. yüzyıl hareketine ne denir?', options: ['Sanayi Devrimi', 'Reform', 'Rönesans', 'Aydınlanma Çağı'], correctIndex: 2),
  Question(id: 603, examType: 'AYT', subject: 'Tarih', questionText: 'Birinci Dünya Savaşı sırasında Osmanlı İmparatorluğu\'nun Orta Asya Türkleri ile birleşmek (Turancılık) amacıyla açtığı ancak çok büyük asker kaybıyla (Sarıkamış Faciası) sonuçlanan cephe neresidir?', options: ['Galiçya Cephesi', 'Kanal Cephesi', 'Çanakkale Cephesi', 'Kafkasya Cephesi'], correctIndex: 3),
  Question(id: 604, examType: 'AYT', subject: 'Tarih', questionText: 'Modern Türkiye Cumhuriyeti\'nin uluslararası arenada meşruiyetini kanıtlayan ve "Türk Milletinin Bağımsızlık Tapusu" kabul edilen antlaşma hangisidir?', options: ['Mudanya Mütarekesi', 'Kars Antlaşması', 'Lozan Barış Antlaşması', 'Montrö Boğazlar Sözleşmesi'], correctIndex: 2),
  Question(id: 605, examType: 'AYT', subject: 'Tarih', questionText: 'Sovyetler Birliği\'nin (SSCB) komünizmi Doğu Avrupa\'da yaymasını engellemek amacıyla ABD tarafından uygulamaya konulan ekonomik yardım paketinin adı nedir?', options: ['Truman Doktrini', 'Marshall Planı', 'Eisenhower Doktrini', 'Versay Antlaşması'], correctIndex: 1), // Marshall Planı Ekonomik yardımdır.
  Question(id: 606, examType: 'AYT', subject: 'Coğrafya', questionText: 'Bir ülkede hammaddenin dışarıya ihraç edilip (satılıp), işlenmiş mamul maddelerin dışarıdan ithal ediliyor (alınıyor) olması o ülkenin coğrafi yapısı ve ekonomisi hakkında hangi temel bilgiyi verir?', options: ['Sanayisinin dışa bağımlı, henüz gelişmemiş olduğunu', 'Kalkınmış, ileri teknoloji kullandığını', 'Topraklarının çok verimli olduğunu', 'Tarım ülkesi olmadığını'], correctIndex: 0),
  Question(id: 607, examType: 'AYT', subject: 'Coğrafya', questionText: 'Deprem risk analizlerinde, levha sınırlarının harita ile örtüştürüldüğü durumlarda, dünyadaki en aktif tektonik kuşak olan ve "Pasifik Ateş Çemberi" olarak bilinen hat üzerinde aşağıdaki ülkelerden hangisi BULUNMAZ?', options: ['Japonya', 'Filipinler', 'Şili', 'Norveç'], correctIndex: 3), // Norveç Baltık Kalkanı'ndadır, deprem riski sıfıra yakındır.
  Question(id: 608, examType: 'AYT', subject: 'Coğrafya', questionText: 'Yer altına inen mağma kütlelerinin soğuyarak "Batolit, Lakolit, Sill, Dayk" gibi formasyonlar oluşturmasına neden olan coğrafi faaliyete ne ad verilir?', options: ['Epirojenez (Kıta Oluşumu)', 'Derinlik (İç) Volkanizması', 'Orojenez (Dağ oluşumu)', 'Kimyasal Çözünme'], correctIndex: 1),
  Question(id: 609, examType: 'AYT', subject: 'Coğrafya', questionText: 'Sürdürülebilir büyüme konseptinde, bugün tüketilen fosil yakıt rezervlerinin ve ekolojik zararın yıllar içindeki izine ne ad verilir?', options: ['Karbon Ayak İzi', 'Küresel Isınma', 'Demografik Geçiş', 'Verimli Biyo-Kütle'], correctIndex: 0),
  Question(id: 610, examType: 'AYT', subject: 'Coğrafya', questionText: 'Okyanus akıntıları, kıyı iklimleri üzerinde büyük rol oynar. Batı Avrupa kıyılarında sıcaklığı yükselterek o bölgenin (Örn. İngiltere) ılıman bir iklime sahip olmasını sağlayan sıcak su akıntısı hangisidir?', options: ['Labrador', 'Peru (Humboldt)', 'Gulf Stream', 'Canary (Kanarya)'], correctIndex: 2),
  Question(id: 611, examType: 'AYT', subject: 'Felsefe Grubu', questionText: 'Immanuel Kant’ın Epistemolojisinde (Bilgi Felsefesi) duyularımızla elde ettiğimiz "a posteriori" bilgilerin zihnimizdeki doğuştan gelen (a priori) kategorilerde işlendiğini ileri sürdüğü "Kritisizm (Eleştiricilik)" akımı, hangi iki zıt akımın birleşimidir?', options: ['Rasyonalizm ve Empirisizm', 'Materyalizm ve İdealizm', 'Varoluşçuluk ve Nihilizm', 'Pozitivizm ve Entüisyonizm'], correctIndex: 0),
  Question(id: 612, examType: 'AYT', subject: 'Felsefe Grubu', questionText: 'İslam felsefesinde aklı ön plana alan, Aristoteles mantığını savunan Muallim-i Sani (İkinci Öğretmen) lakaplı filozofumuz kimdir?', options: ['İbn-i Sina', 'Farabi', 'Gazali', 'Mevlana'], correctIndex: 1), // İkinci öğretmen Farabi'dir (Muallim-i Sani). Birinci Aristo'dur.
  Question(id: 613, examType: 'AYT', subject: 'Felsefe Grubu', questionText: 'Sosyolojide bireylere dayatılan belli tutumların veya etiketlemelerin kişilerin kimliklerine yapışıp aynen o beklenen karakteri yaratmasına (Örn: tembel denen çocuğun tembel olması) psikolojide ve sosyolojide ne denir?', options: ['Öğrenilmiş çaresizlik', 'Haleli etkisi (Halo effect)', 'Kendini Gerçekleştiren Kehanet (Pygmalion Etkisi)', 'Grup baskısı'], correctIndex: 2),
  Question(id: 614, examType: 'AYT', subject: 'Felsefe Grubu', questionText: 'Klasik Mantıkta "Bütün insanlar ölümlüdür. (Öncül 1) Sokrates bir insandır. (Öncül 2) O halde Sokrates de ölümlüdür. (Sonuç)" diyen akıl yürütme tekniğinin (Genelden Özele) adı nedir?', options: ['Tümevarım (Endüksiyon)', 'Tümdengelim (Dedüksiyon)', 'Analoji (Benzeşim)', 'Paradoks'], correctIndex: 1),
  Question(id: 615, examType: 'AYT', subject: 'Din Kültürü', questionText: 'İslam tarihindeki ilk mimari eser olan ve hicretin ardından Medine\'de Mescid-i Nebevi\'nin hemen bitişiğine kurulan "Suffe" platformu ne amaçla yapılmıştır?', options: ['Ticari merkez olarak kullanılmıştır', 'Savaş hazırlığı ve silah deposu olarak yapılmıştır', 'Hastalar ve yetimlerin barınması için kervansaraydır', 'Kimsesizlerin ve fakir sahabelerin barınması, ilim-irfan (Eğitim) görmesi için yapılmıştır'], correctIndex: 3),
  Question(id: 427, examType: 'AYT', subject: 'Matematik', questionText: 'Kombinasyon C(5,2) sonucu kaçtır?', options: ['10', '20', '60', '120'], correctIndex: 0),
  Question(id: 428, examType: 'AYT', subject: 'Fizik', questionText: 'Sığaçların (kondansatör) birimi nedir?', options: ['Henry', 'Farad', 'Tesla', 'Weber'], correctIndex: 1),
  Question(id: 429, examType: 'AYT', subject: 'Fizik', questionText: 'Işık hızıyla hareket eden bir gözlemci için zaman nasıl geçer?', options: ['Daha hızlı', 'Daha yavaş', 'Aynı', 'Durur'], correctIndex: 1),
  Question(id: 430, examType: 'AYT', subject: 'Fizik', questionText: 'Yüklü bir parçacık manyetik alana dik girerse ne tür bir yörünge izler?', options: ['Doğrusal', 'Parabolik', 'Çembersel', 'Eliptik'], correctIndex: 2),
  Question(id: 431, examType: 'AYT', subject: 'Fizik', questionText: 'Fotoelektrik olayda kopan elektronların enerjisi neye bağlıdır?', options: ['Işığın şiddetine', 'Işığın frekansına', 'Işığın geliş açısına', 'Metal yüzeyin alanına'], correctIndex: 1),
  Question(id: 432, examType: 'AYT', subject: 'Fizik', questionText: 'Compton saçılmasında saçılan fotonun dalga boyu nasıl değişir?', options: ['Artar', 'Azalır', 'Değişmez', 'Sıfır olur'], correctIndex: 0),
  Question(id: 433, examType: 'AYT', subject: 'Fizik', questionText: 'Heisenberg belirsizlik ilkesi neyle ilgilidir?', options: ['Enerji ve Zaman', 'Konum ve Momentum', 'Hız ve İvme', 'Kütle ve Ağırlık'], correctIndex: 1),
  Question(id: 434, examType: 'AYT', subject: 'Fizik', questionText: 'Hangi kuvvet çekirdek içindeki proton ve nötronları bir arada tutar?', options: ['Kütleçekim kuvveti', 'Elektromanyetik kuvvet', 'Güçlü nükleer kuvvet', 'Zayıf nükleer kuvvet'], correctIndex: 2),
  Question(id: 435, examType: 'AYT', subject: 'Kimya', questionText: 'Benzendeki karbon atomları arasındaki bağlar nasıldır?', options: ['Hepsi tekli', 'Hepsi ikili', 'Rezonans yapılı', 'Sadece sigma bağı'], correctIndex: 2),
  Question(id: 436, examType: 'AYT', subject: 'Kimya', questionText: 'Peryodik sistemde soldan sağa gidildikçe elektronegatiflik genellikle nasıl değişir?', options: ['Artar', 'Azalır', 'Değişmez', 'Önce artar sonra azalır'], correctIndex: 0),
  Question(id: 437, examType: 'AYT', subject: 'Kimya', questionText: 'Galvanik bir hücrede yükseltgenme nerede gerçekleşir?', options: ['Anot', 'Katot', 'Tuz köprüsü', 'Çözelti'], correctIndex: 0),
  Question(id: 438, examType: 'AYT', subject: 'Kimya', questionText: 'Hangi bağ türü diğerlerinden daha güçlüdür?', options: ['Hidrojen bağı', 'Dipol-dipol', 'London kuvvetleri', 'Kovalent bağ'], correctIndex: 3),
  Question(id: 439, examType: 'AYT', subject: 'Kimya', questionText: 'Buhar basıncı neye bağlıdır?', options: ['Sıvının miktarına', 'Dış basınca', 'Sıvının cinsine ve sıcaklığa', 'Kabın şekline'], correctIndex: 2),
  Question(id: 440, examType: 'AYT', subject: 'Kimya', questionText: 'Tersinir bir tepkime dengedeyken hangisi doğrudur?', options: ['İleri hız > Geri hız', 'İleri hız = Geri hız', 'Tepkime durmuştur', 'Sadece ürünler vardır'], correctIndex: 1),
  Question(id: 441, examType: 'AYT', subject: 'Kimya', questionText: 'Aromatik bileşiklerin en basit üyesi hangisidir?', options: ['Metan', 'Etilen', 'Benzen', 'Asetilen'], correctIndex: 2),
  Question(id: 442, examType: 'AYT', subject: 'Kimya', questionText: 'Hangi çözelti pH=7 özelliğindedir?', options: ['HCl', 'NaOH', 'NaCl', 'NH3'], correctIndex: 2),
  Question(id: 443, examType: 'AYT', subject: 'Biyoloji', questionText: 'İnsanlarda soluk alıp vermeyi hangi merkez kontrol eder?', options: ['Beyincik', 'Omurilik soğanı', 'Talamus', 'Hipotalamus'], correctIndex: 1),
  Question(id: 444, examType: 'AYT', subject: 'Biyoloji', questionText: 'Hücre döngüsünün hangi evresinde DNA eşlenmesi (replikasyon) olur?', options: ['G1 evresi', 'S evresi', 'G2 evresi', 'M evresi'], correctIndex: 1),
  Question(id: 445, examType: 'AYT', subject: 'Biyoloji', questionText: 'Mendel genetiğinde "fenotip" neyi ifade eder?', options: ['Genetik yapıyı', 'Dış görünüşü', 'Mutasyonları', 'Adaptasyonları'], correctIndex: 1),
  Question(id: 446, examType: 'AYT', subject: 'Biyoloji', questionText: 'Hangi organel sadece bitki hücrelerinde bulunur?', options: ['Mitokondri', 'Kloroplast', 'Ribozom', 'Lizozom'], correctIndex: 1),
  Question(id: 447, examType: 'AYT', subject: 'Biyoloji', questionText: 'Canlıların sınıflandırılmasında en küçük birim hangisidir?', options: ['Alem', 'Sınıf', 'Cins', 'Tür'], correctIndex: 3),
  Question(id: 448, examType: 'AYT', subject: 'Biyoloji', questionText: 'Hücre zarından madde geçişinde ATP harcanan yöntem hangisidir?', options: ['Difüzyon', 'Osmoz', 'Aktif Taşıma', 'Kolaylaştırılmış difüzyon'], correctIndex: 2),
  Question(id: 449, examType: 'AYT', subject: 'Biyoloji', questionText: 'ATP molekülünün yapısında hangi baz bulunur?', options: ['Guanin', 'Sitozin', 'Adenin', 'Timin'], correctIndex: 2),
  Question(id: 450, examType: 'AYT', subject: 'Edebiyat', questionText: 'Türk edebiyatında ilk psikolojik roman hangisidir?', options: ['Eylül', 'Mai ve Siyah', 'Zehra', 'Huzur'], correctIndex: 0),
  Question(id: 451, examType: 'AYT', subject: 'Edebiyat', questionText: '"Şair-i Azam" unvanıyla tanınan şairimiz kimdir?', options: ['Namık Kemal', 'Abdülhak Hamit Tarhan', 'Tevfik Fikret', 'Yahya Kemal'], correctIndex: 1),
  Question(id: 452, examType: 'AYT', subject: 'Edebiyat', questionText: 'Mesnevi tarzında yazılan en ünlü eser hangisidir?', options: ['Divan-ı Hikmet', 'Kutadgu Bilig', 'Mesnevi (Mevlana)', 'Risaletü\'n Nushiyye'], correctIndex: 2),
  Question(id: 453, examType: 'AYT', subject: 'Edebiyat', questionText: 'Hangi akım "akıl ve sağduyu"yu ön plana çıkarır?', options: ['Klasisizm', 'Romantizm', 'Realizm', 'Sürrealizm'], correctIndex: 0),
  Question(id: 454, examType: 'AYT', subject: 'Edebiyat', questionText: 'İstiklal Şairi olarak bilinen sanatçımız kimdir?', options: ['Ziya Gökalp', 'Mehmet Akif Ersoy', 'Yahya Kemal', 'Fazıl Hüsnü'], correctIndex: 1),
  Question(id: 455, examType: 'AYT', subject: 'Edebiyat', questionText: 'Milli Edebiyat akımını başlatan dergi hangisidir?', options: ['Servet-i Fünun', 'Genç Kalemler', 'Türk Yurdu', 'Varlık'], correctIndex: 1),
  Question(id: 456, examType: 'AYT', subject: 'Edebiyat', questionText: 'Dede Korkut Hikayeleri kaç hikayeden oluşur?', options: ['10', '12', '15', '20'], correctIndex: 1),
  Question(id: 457, examType: 'AYT', subject: 'Tarih', questionText: 'Büyük Selçuklu Devleti ile Bizans arasındaki ilk büyük savaş hangisidir?', options: ['Malazgirt', 'Pasinler', 'Miryokefalon', 'Kösedağ'], correctIndex: 1),
  Question(id: 458, examType: 'AYT', subject: 'Tarih', questionText: 'Osmanlı Devleti hangi antlaşmayla Avrupa devleti sayılmıştır?', options: ['Paris Antlaşması', 'Berlin Antlaşması', 'Londra Antlaşması', 'Kütahya Antlaşması'], correctIndex: 0),
  Question(id: 459, examType: 'AYT', subject: 'Tarih', questionText: 'Halifelik ne zaman kaldırılmıştır?', options: ['29 Ekim 1923', '3 Mart 1924', '1 Kasım 1922', '20 Nisan 1924'], correctIndex: 1),
  Question(id: 460, examType: 'AYT', subject: 'Tarih', questionText: 'I. Beş Yıllık Sanayi Planı hangi yıl uygulanmaya başlanmıştır?', options: ['1923', '1930', '1934', '1938'], correctIndex: 2),
  Question(id: 461, examType: 'AYT', subject: 'Tarih', questionText: 'Milli Mücadele\'nin haklılığını kanıtlayan ilk uluslararası belge hangisidir?', options: ['Amiral Bristol Raporu', 'General Harbourd Raporu', 'Milne Hattı', 'Mondros Raporu'], correctIndex: 0),
  Question(id: 462, examType: 'AYT', subject: 'Tarih', questionText: 'Hangi ilkemiz "akılcılık ve bilimsellik" temeline dayanır?', options: ['Cumhuriyetçilik', 'Laiklik', 'Milliyetçilik', 'Halkçılık'], correctIndex: 1),
  Question(id: 463, examType: 'AYT', subject: 'Tarih', questionText: 'İkinci Dünya Savaşı hangi yıl bitmiştir?', options: ['1939', '1942', '1945', '1950'], correctIndex: 2),
  Question(id: 464, examType: 'AYT', subject: 'Coğrafya', questionText: 'Kayaçların fiziksel olarak parçalanması en çok nerede görülür?', options: ['Karadeniz', 'Akdeniz', 'İç Anadolu', 'Ege'], correctIndex: 2),
  Question(id: 465, examType: 'AYT', subject: 'Coğrafya', questionText: 'Hangi enerji kaynağı yenilenebilir değildir?', options: ['Güneş', 'Rüzgar', 'Doğalgaz', 'Jeotermal'], correctIndex: 2),
  Question(id: 466, examType: 'AYT', subject: 'Coğrafya', questionText: 'Dünya\'nın en kalabalık ülkesi hangisidir? (Son verilere göre)', options: ['Çin', 'Hindistan', 'ABD', 'Rusya'], correctIndex: 1),
  Question(id: 467, examType: 'AYT', subject: 'Coğrafya', questionText: 'Türkiye\'nin en güney ucu neresidir?', options: ['Yayladağı (Hatay)', 'Sinop (İnceburun)', 'Iğdır (Dilucu)', 'Çanakkale (Bababurnu)'], correctIndex: 0),
  Question(id: 468, examType: 'AYT', subject: 'Coğrafya', questionText: 'Yerleşik hayatın ilk başladığı bölgelerden biri olan "Bereketli Hilal" nerededir?', options: ['Mısır', 'Mezopotamya', 'Hindistan', 'Çin'], correctIndex: 1),
  Question(id: 469, examType: 'AYT', subject: 'Coğrafya', questionText: 'Hangi akarsu Türkiye dışından doğup Türkiye\'de dökülür?', options: ['Fırat', 'Dicle', 'Asi', 'Kızılırmak'], correctIndex: 2),
  Question(id: 470, examType: 'AYT', subject: 'Coğrafya', questionText: 'Türkiye\'de rüzgar enerjisinden elektrik üretimi en çok hangi bölgededir?', options: ['Marmara', 'Ege', 'İç Anadolu', 'Güneydoğu'], correctIndex: 1),

  // ─────────────── YENİ EKLENEN 50 AYT SORUSU (ÖSYM TARZI) ───────────────
  Question(id: 471, examType: 'AYT', subject: 'Matematik', questionText: 'f(x) fonksiyonu [a, b] aralığında sürekli ve (a, b) aralığında türevlenebilir olsun. f(a) = f(b) ise, f\'(c) = 0 olacak şekilde en az bir c ∈ (a, b) vardır. Bu teorem aşağıdakilerden hangisidir?', options: ['Ortalama Değer Teoremi', 'Rolle Teoremi', 'Cauchy Teoremi', 'L\'Hopital Kuralı'], correctIndex: 1),
  Question(id: 472, examType: 'AYT', subject: 'Matematik', questionText: 'z = x + iy karmaşık sayısı için |z - 2| = |z + 2| koşulunu sağlayan noktaların geometrik yeri neresidir?', options: ['x - ekseni (Gerçel eksen)', 'y - ekseni (Sanal eksen)', 'Orijin merkezli çember', 'y = x doğrusu'], correctIndex: 1),
  Question(id: 473, examType: 'AYT', subject: 'Matematik', questionText: 'Bir otoparktaki 10 araçtan 3\'ü kırmızıdır. Rastgele seçilen 2 aracın ikisinin de kırmızı olma olasılığı kaçtır?', options: ['1/15', '1/10', '2/15', '3/10'], correctIndex: 0),
  Question(id: 474, examType: 'AYT', subject: 'Matematik', questionText: '∫(0 den π\'ye) sin²(x) dx integralinin sonucu kaçtır?', options: ['π', 'π/2', 'π/4', '1'], correctIndex: 1),
  Question(id: 475, examType: 'AYT', subject: 'Matematik', questionText: 'lim (x→0) (1 - cos(x)) / x² limitinin değeri nedir?', options: ['0', '1/2', '1', 'Belirsiz'], correctIndex: 1),
  Question(id: 476, examType: 'AYT', subject: 'Matematik', questionText: 'A matrisi 2x3, B matrisi 3x4 boyutlarında ise A x B matrisinin boyutu nedir?', options: ['2x3', '3x4', '2x4', 'Çarpılamaz'], correctIndex: 2),
  Question(id: 477, examType: 'AYT', subject: 'Matematik', questionText: 'Karekök içinde -16 sayısının karmaşık düzlemdeki karşılığı nedir?', options: ['-4', '4', '4i', '-4i'], correctIndex: 2),
  Question(id: 478, examType: 'AYT', subject: 'Matematik', questionText: 'P(x) polinomu x²+1 ile tam bölünüyorsa, P(x)\'in x²+1\'e bölümünden kalan kaçtır?', options: ['0', '1', 'x', '-1'], correctIndex: 0),
  Question(id: 479, examType: 'AYT', subject: 'Matematik', questionText: 'sin(2x) fonksiyonunun periyodu nedir?', options: ['2π', 'π', 'π/2', '4π'], correctIndex: 1),
  Question(id: 480, examType: 'AYT', subject: 'Matematik', questionText: 'f(x) = e^(2x) fonksiyonunun x=0 noktasındaki teğetinin eğimi kaçtır?', options: ['0', '1', '2', 'e'], correctIndex: 2),
  Question(id: 481, examType: 'AYT', subject: 'Fizik', questionText: 'Sürtünmesiz eğik düzlemde m kütleli cisim serbest bırakıldığında ivmesi (a) kütleye (m) bağlı mıdır?', options: ['Evet, doğru orantılıdır', 'Evet, ters orantılıdır', 'Hayır, sadece açıya ve g\'ye bağlıdır (g.sinθ)', 'Kütleye ve yüzey alanına bağlıdır'], correctIndex: 2),
  Question(id: 482, examType: 'AYT', subject: 'Fizik', questionText: 'Açısal momentumun korunduğu bir sistemde, eylemsizlik momenti (I) yarıya düşerse açısal hız (ω) ne olur?', options: ['Yarıya düşer', 'Aynı kalır', '2 katına çıkar', '4 katına çıkar'], correctIndex: 2),
  Question(id: 483, examType: 'AYT', subject: 'Fizik', questionText: 'Transformatörde sarım sayıları oranı (N1/N2) gerilimler oranı (V1/V2) ile nasıl ilişkilidir?', options: ['Doğru orantılı', 'Ters orantılı', 'Karesiyle orantılı', 'Rastgeledir'], correctIndex: 0),
  Question(id: 484, examType: 'AYT', subject: 'Fizik', questionText: 'İdeal bir gaz izotermal (sabit sıcaklıkta) genişlerse, gazın iç enerjisi nasıl değişir?', options: ['Artar', 'Azalır', 'Sıfır olur', 'Değişmez'], correctIndex: 3),
  Question(id: 485, examType: 'AYT', subject: 'Fizik', questionText: 'Işığın çift yarıkta girişim deneyinde, karanlık saçak formülü nedir?', options: ['d.sinθ = nλ', 'd.sinθ = (n - 1/2)λ', 'd.cosθ = nλ', 'd.cosθ = (n - 1/2)λ'], correctIndex: 1),
  Question(id: 486, examType: 'AYT', subject: 'Fizik', questionText: 'Manyetik akı (Φ) zamanla değiştiğinde devrede hangi fiziksel büyüklük oluşur?', options: ['Direnç', 'Öz kütle', 'İndüksiyon Elektromotor Kuvveti (EMK)', 'Sığa'], correctIndex: 2),
  Question(id: 487, examType: 'AYT', subject: 'Fizik', questionText: 'De Broglie hipotezine göre, kütlesi büyük olan cisimlerin madde dalga boyu nasıldır?', options: ['Çok büyüktür', 'Çok küçüktür (algılanamaz)', 'Sabittir', 'Gittikçe artar'], correctIndex: 1),
  Question(id: 488, examType: 'AYT', subject: 'Fizik', questionText: 'Denge konumundan x kadar çekilip bırakılan yayın yaptığı harmonik harekette geri çağırıcı kuvvet F eşittir?', options: ['-kx', 'kx', '1/2 kx²', '-1/2 kx²'], correctIndex: 0),
  Question(id: 489, examType: 'AYT', subject: 'Kimya', questionText: 'Bir atomun elektron ilgisi, dışarıdan elektron aldığında meydana gelen ne değişimidir?', options: ['Kütle değişimi', 'Hacim değişimi', 'Entalpi (enerji) değişimi', 'Proton sayısı değişimi'], correctIndex: 2),
  Question(id: 490, examType: 'AYT', subject: 'Kimya', questionText: 'Le Chatelier prensibine göre, ekzotermik bir tepkimede sistemin ısısı (sıcaklığı) artırılırsa denge ne yöne kayar?', options: ['Ürünlere', 'Girenlere', 'Değişmez', 'İleri-geri durur'], correctIndex: 1),
  Question(id: 491, examType: 'AYT', subject: 'Kimya', questionText: 'Zayıf bir asit olan CH3COOH\'un sudaki iyonlaşma yüzdesi, çözelti su eklenerek seyreltildikçe ne olur?', options: ['Azalır', 'Değişmez', 'Artar', 'Sıfırlanır'], correctIndex: 2),
  Question(id: 492, examType: 'AYT', subject: 'Kimya', questionText: 'Galvanik bir hücrede (Pil), elektron akışının yönü neresidir?', options: ['Katottan anota dış devrede', 'Anotdan katota dış devrede', 'Tuz köprüsü', 'Anotdan katota iç devrede'], correctIndex: 1),
  Question(id: 493, examType: 'AYT', subject: 'Kimya', questionText: 'Alkinlerin (Asetilenler) genel formülü nedir?', options: ['CnH2n', 'CnH2n+2', 'CnH2n-2', 'CnH2n-4'], correctIndex: 2),
  Question(id: 494, examType: 'AYT', subject: 'Kimya', questionText: 'Formaldehit yükseltgenirse hangi asit oluşur?', options: ['Asetik asit', 'Propanoik asit', 'Bütirik asit', 'Formik asit (Karınca asidi)'], correctIndex: 3),
  Question(id: 495, examType: 'AYT', subject: 'Kimya', questionText: 'Esterler su ile tepkimeye girerek asit ve alkole dönüşür. Bu olayın adı nedir?', options: ['Polimerleşme', 'Sabunlaşma', 'Hidroliz', 'Sübstitüsyon'], correctIndex: 2),
  Question(id: 496, examType: 'AYT', subject: 'Kimya', questionText: 'Azot molekülü (N2) içerisindeki iki azot atomu arasındaki bağ düzeni nasıldır?', options: ['Tekli bağ', 'İkili bağ', 'Üçlü bağ', 'İyonik bağ'], correctIndex: 2),
  Question(id: 497, examType: 'AYT', subject: 'Biyoloji', questionText: 'Mitokondrinin katlanmış iç zarlarına ne ad verilir?', options: ['Stroma', 'Matriks', 'Tülakoit', 'Krista'], correctIndex: 3),
  Question(id: 498, examType: 'AYT', subject: 'Biyoloji', questionText: 'Böbrekte idrar oluşum sürecinde süzülme (filtrasyon) nerede gerçekleşir?', options: ['Proksimal tüp', 'Glomerulus', 'Henle kulpunun inen kolu', 'İdrar toplama kanalı'], correctIndex: 1),
  Question(id: 499, examType: 'AYT', subject: 'Biyoloji', questionText: 'Merkezi sinir sisteminde miyelin kılıfları oluşturan destek hücrelerine verilen ad nedir?', options: ['Nöron', 'Oligodendrosit', 'Astrosit', 'Mikroglia'], correctIndex: 1),
  Question(id: 500, examType: 'AYT', subject: 'Biyoloji', questionText: 'Maddelerin derişim gradyanına (çoktan aza) karşı hücre zarı üzerinden geçişine ne denir?', options: ['Osmoz', 'Aktif taşıma', 'Basit difüzyon', 'Fagositoz'], correctIndex: 1),
  Question(id: 501, examType: 'AYT', subject: 'Biyoloji', questionText: 'DNA molekülünün kalıp zincirinden mesajcı RNA (mRNA) sentezlenmesi olayına ne denir?', options: ['Translasyon', 'Replikasyon', 'Transkripsiyon', 'Mutasyon'], correctIndex: 2),
  Question(id: 502, examType: 'AYT', subject: 'Biyoloji', questionText: 'Hangi hormon kanda kalsiyum oranını artırıcı (kemiği yıkarak) etki yapar?', options: ['Kalsitonin', 'Parathormon', 'Kortizol', 'Tiroksin'], correctIndex: 1),
  Question(id: 503, examType: 'AYT', subject: 'Biyoloji', questionText: 'Bağışıklık kazanmada aşı olmak ne tür bağışıklıktır?', options: ['Doğal pasif', 'Yapay pasif', 'Doğal aktif', 'Yapay aktif'], correctIndex: 3),
  Question(id: 504, examType: 'AYT', subject: 'Biyoloji', questionText: 'Ekolojide, belirli bir bölgede yaşayan farklı popülasyonların oluşturduğu biyolojik topluluğa ne denir?', options: ['Biyosfer', 'Komünite', 'Ekosistem', 'Biyom'], correctIndex: 1),
  Question(id: 505, examType: 'AYT', subject: 'Edebiyat', questionText: 'Fecr-i Âti beyannamesi ile ortaya çıkan ve "Sanat şahsi ve muhteremdir" görüşünü savunan edebiyatçımız kimdir?', options: ['Tevfik Fikret', 'Ahmet Haşim', 'Mehmet Akif Ersoy', 'Ziya Paşa'], correctIndex: 1),
  Question(id: 506, examType: 'AYT', subject: 'Edebiyat', questionText: '"Huzur" ve "Saatleri Ayarlama Enstitüsü" romanlarının usta yazarı kimdir?', options: ['Ahmet Hamdi Tanpınar', 'Sait Faik Abasıyanık', 'Orhan Kemal', 'Halit Ziya Uşaklıgil'], correctIndex: 0),
  Question(id: 507, examType: 'AYT', subject: 'Edebiyat', questionText: 'Türkiye\'de "İkinci Yeni" şiir hareketinin temsilcilerinden biri değildir?', options: ['Cemal Süreya', 'Edip Cansever', 'Orhan Veli Kanık', 'Turgut Uyar'], correctIndex: 2),
  Question(id: 508, examType: 'AYT', subject: 'Edebiyat', questionText: 'Türk edebiyatında mesnevi nazım biçimiyle yazılmış ilk eser kabul edilen "Kutadgu Bilig"in anlamı nedir?', options: ['Mutluluk Veren Bilgi', 'Gerçeklerin Eşiği', 'Sırlar Kitabı', 'Hükümdar Sözleri'], correctIndex: 0),
  Question(id: 509, examType: 'AYT', subject: 'Tarih', questionText: '27 Mayıs 1960 darbesi sonrasında kabul edilen, geniş özgürlükler içeren Türkiye Anayasası hangi yıldır?', options: ['1924', '1961', '1982', '1921'], correctIndex: 1),
  Question(id: 510, examType: 'AYT', subject: 'Tarih', questionText: 'Atatürk\'ün çok partili hayata geçiş denemelerinden biri olan ve Ali Fethi Okyar tarafından kurulan partinin adı nedir?', options: ['Terakkiperver Cumhuriyet Fırkası', 'Demokrat Parti', 'Serbest Cumhuriyet Fırkası', 'İttihat ve Terakki'], correctIndex: 2),
  Question(id: 511, examType: 'AYT', subject: 'Tarih', questionText: 'Tarihte "93 Harbi" olarak bilinen 1877-1878 Osmanlı-Rus Savaşı sonrasında hangi ağır antlaşma imzalanmıştır?', options: ['Ayastefanos (Yeşilköy)', 'Berlin', 'Kırım', 'Mondros'], correctIndex: 0),
  Question(id: 512, examType: 'AYT', subject: 'Tarih', questionText: 'Mustafa Kemal Paşa\'ya "Gazilik" unvanı ve "Mareşallik" rütbesi hangi savaştan sonra verilmiştir?', options: ['Sakarya Meydan Muharebesi', 'Büyük Taarruz', 'I. İnönü Muharebesi', 'Çanakkale Savaşı'], correctIndex: 0),
  Question(id: 513, examType: 'AYT', subject: 'Coğrafya', questionText: 'Sanayi tesislerinin yer seçiminde ulaşım çok etkilidir. Buna göre, İskenderun\'da demir-çelik fabrikasının kurulmasının temel sebebi nedir?', options: ['Hammadde (Demir) yakınlığı', 'Enerji (Kömür) yakınlığı', 'Ulaşım/Liman imkanları', 'İklim şartları'], correctIndex: 2),
  Question(id: 514, examType: 'AYT', subject: 'Coğrafya', questionText: 'Akdeniz İkliminin bitki örtüsü maki iken, Türkiye\'deki Bozkır (Step) ikliminin doğal bitki örtüsü nedir?', options: ['Orman', 'Çayır', 'Bozkır (Otlar)', 'Tundra'], correctIndex: 2),
  Question(id: 515, examType: 'AYT', subject: 'Coğrafya', questionText: 'Ekvatoral yağmur ormanlarının başlıca bulunduğu kıtalar hangileridir?', options: ['Güney Amerika ve Afrika', 'Asya ve Avrupa', 'Kuzey Amerika ve Avrupa', 'Antarktika ve Avustralya'], correctIndex: 0),
  Question(id: 516, examType: 'AYT', subject: 'Coğrafya', questionText: 'Aşağıdaki tarım ürünlerinden hangisinin Türkiye\'deki üretiminin büyük bir kısmı Karadeniz Bölgesinden sağlanır?', options: ['Buğday', 'Fındık', 'Zeytin', 'Pamuk'], correctIndex: 1),
  Question(id: 517, examType: 'AYT', subject: 'Felsefe Grubu', questionText: 'Felsefede "Mutlak Ruh (Geist)" kavramı ile bilinen, tez-antitez-sentez diyalektiğini savunan filozof kimdir?', options: ['Kant', 'Hegel', 'Sartre', 'Descartes'], correctIndex: 1),
  Question(id: 518, examType: 'AYT', subject: 'Felsefe Grubu', questionText: 'Sigmund Freud\'un öncüsü olduğu, bilinçdışı süreçleri ve çocukluk yaşantılarını inceleyen psikoloji yaklaşımı hangisidir?', options: ['Davranışçılık', 'Hümanizm', 'Psikanaliz', 'Bilişsel Yaklaşım'], correctIndex: 2),
  Question(id: 519, examType: 'AYT', subject: 'Felsefe Grubu', questionText: 'Sosyolojide "Toplumsal Dayanışma" türlerini (mekanik ve organik) tanımlayan sosyolog kimdir?', options: ['Karl Marx', 'Max Weber', 'Emile Durkheim', 'Auguste Comte'], correctIndex: 2),
  Question(id: 520, examType: 'AYT', subject: 'Felsefe Grubu', questionText: 'Kişinin kendi inancını evrensel bir geçerliliğe taşımadan, her türlü tanrı veya yaratıcı inancını reddetmesine ne denir?', options: ['Deizm', 'Panteizm', 'Ateizm', 'Agnostisizm'], correctIndex: 2),

  // ─────────────── YENİ EKLENEN 50 AYT SORUSU (ÖSYM TARZI - 2. PARTİ) ───────────────
  Question(id: 521, examType: 'AYT', subject: 'Matematik', questionText: 'f(x) = x³ - 3x² + 5 fonksiyonunun yerel ekstremum (maksimum ve minimum) noktalarının apsisleri toplamı kaçtır?', options: ['-3', '0', '2', '3'], correctIndex: 2),
  Question(id: 522, examType: 'AYT', subject: 'Matematik', questionText: '∫(2x + 1) dx belirsiz integralinin sonucu aşağıdakilerden hangisidir? (c: sabit)', options: ['x² + c', 'x² + x + c', '2x² + x + c', 'x² - x + c'], correctIndex: 1),
  Question(id: 523, examType: 'AYT', subject: 'Matematik', questionText: 'P(x) polinomu x² - 4 ile kalansız bölünüyorsa ve P(x)\'in katsayılar toplamı 10 ise, P(2) ve P(-2) değerleri sırasıyla nedir?', options: ['(0, 0)', '(2, -2)', '(10, 10)', '(4, -4)'], correctIndex: 0),
  Question(id: 524, examType: 'AYT', subject: 'Matematik', questionText: 'log₂ (x-3) + log₂ (x+3) = 4 denkleminin çözüm kümesi nedir? (Logaritma tanım aralığı x > 3)', options: ['{4}', '{5}', '{6}', '{7}'], correctIndex: 1),
  Question(id: 525, examType: 'AYT', subject: 'Matematik', questionText: ' Karmaşık sayılar kümesinde i² = -1 olmak üzere, z = 3 - 4i sayısının eşleniği ve modülü (mutlak değeri) sırasıyla nedir?', options: ['3 - 4i, 5', '3 + 4i, 5', '-3 - 4i, 7', '-3 + 4i, 25'], correctIndex: 1),
  Question(id: 526, examType: 'AYT', subject: 'Matematik', questionText: 'lim (x->2) (x² - 4)/(x - 2) limitinin değeri kaçtır?', options: ['0', '2', '4', 'Belirsiz'], correctIndex: 2),
  Question(id: 527, examType: 'AYT', subject: 'Matematik', questionText: '1\'den 10\'a kadar olan tam sayıların toplamının (Σ n) integral kullanılarak yaklaşık alanı bulunmak istense, y = x doğrusunun [0,10] aralığındaki üçgensel alanı kaçtır?', options: ['45', '50', '55', '100'], correctIndex: 1),
  Question(id: 528, examType: 'AYT', subject: 'Matematik', questionText: 'Bir aritmetik dizide a₄ = 10 ve a₇ = 19 ise bu dizinin ortak farkı (r) kaçtır?', options: ['2', '3', '4', '5'], correctIndex: 1),
  Question(id: 529, examType: 'AYT', subject: 'Matematik', questionText: 'cos(2x) = 1/2 denkleminin [0, π/2] aralığındaki kökü aşağıdakilerden hangisidir?', options: ['π/6', 'π/4', 'π/3', 'π'], correctIndex: 0),
  Question(id: 530, examType: 'AYT', subject: 'Matematik', questionText: 'Bir madeni para 5 kez ard arda havaya atılıyor. Tam olarak 3 kez tura gelme olasılığı kaçtır?', options: ['5/32', '10/32', '15/32', '20/32'], correctIndex: 1),
  Question(id: 531, examType: 'AYT', subject: 'Fizik', questionText: 'Yatay atış hareketi yapan bir cismin yere çarpma süresi sadece hangi fiziksel niceliğe bağlıdır? (Sürtünmesiz ortam)', options: ['Cismin kütlesine', 'Atılış yüksekliğine ve yerçekimi ivmesine', 'Yatay fırlatılma hızına', 'Cismin şekline'], correctIndex: 1),
  Question(id: 532, examType: 'AYT', subject: 'Fizik', questionText: 'Manyetik alan (B) içinde, manyetik alana dik ()V) hızıyla hareket eden q yüklü parçacığa etki eden Lorentz Kuvvetinin formülü nedir?', options: ['F = m.a', 'F = q.E', 'F = q.V.B', 'F = k.q1.q2/r²'], correctIndex: 2),
  Question(id: 533, examType: 'AYT', subject: 'Fizik', questionText: 'Basit harmonik hareket yapan bir sarkaçın periyodu (T), ipin uzunluğu (L) dört katına çıkarılırsa nasıl değişir?', options: ['Değişmez', 'Yarıya düşer', '2 katına çıkar', '4 katına çıkar'], correctIndex: 2),
  Question(id: 534, examType: 'AYT', subject: 'Fizik', questionText: 'Compton Saçılması deneyinde X-ışını fotonu elektronla çarpıştıktan sonra aşağıdakilerden hangisi kesinlikle gerçekleşir?', options: ['Fotonun hızı azalır', 'Fotonun frekansı artar', 'Fotonun dalga boyu artar', 'Foton yok olur'], correctIndex: 2),
  Question(id: 535, examType: 'AYT', subject: 'Fizik', questionText: 'Sığaçlarda (Kondansatör) depolanan enerji (E), sığacın kapasitansı (C) ve uçları arasındaki potansiyel (V) ile nasıl ilişkilidir?', options: ['E = Q.V', 'E = 1/2 C.V²', 'E = I.R', 'E = m.g.h'], correctIndex: 1),
  Question(id: 536, examType: 'AYT', subject: 'Fizik', questionText: 'Sürtünmesiz yatay bir düzlemde esnek olmayan (yapışık) çarpışma yapan iki cismin çarpışma durumunda hangi nicelik kesinlikle korunur?', options: ['Kinetik enerji', 'Momentum', 'Hız', 'Sıcaklık'], correctIndex: 1),
  Question(id: 537, examType: 'AYT', subject: 'Kimya', questionText: 'Gazların ideal gaz denkleminde (P.V = n.R.T), sıcaklık (T) hangi birimle ifade edilmek zorundadır?', options: ['Celcius', 'Fahrenheit', 'Kelvin', 'Joule'], correctIndex: 2),
  Question(id: 538, examType: 'AYT', subject: 'Kimya', questionText: 'Bir galvanik hücrenin (pil) standart hücre potansiyeli (E°hücre) pozitif çıkıyorsa, bu tepkime hakkında ne söylenebilir?', options: ['Tepkime istemsizdir, enerji gerektirir', 'Tepkime denge halindedir', 'Tepkime istemlidir, kendiliğinden gerçekleşir', 'Hücre pil olarak kullanılamaz'], correctIndex: 2),
  Question(id: 539, examType: 'AYT', subject: 'Kimya', questionText: 'Organik kimyada Alkanların genel kapalı formülü nedir?', options: ['CnH2n', 'CnH2n-2', 'CnH2n+2', 'CnH2n+1'], correctIndex: 2),
  Question(id: 540, examType: 'AYT', subject: 'Kimya', questionText: 'Kimyasal tepkimelerde katalizörün temel işlevi aşağıdakilerden hangisidir?', options: ['Tepkime verimini artırmak', 'Tepkime ısısını (entalpiyi) değiştirmek', 'Aktivasyon enerjisini düşürerek tepkimeyi hızlandırmak', 'Ürünlerin türünü değiştirmek'], correctIndex: 2),
  Question(id: 541, examType: 'AYT', subject: 'Biyoloji', questionText: 'İnsan kalbinin dıştan içe doğru sahip olduğu üç tabaka sırasıyla hangisinde doğru verilmiştir?', options: ['Perikard, Miyokard, Endokard', 'Endokard, Miyokard, Perikard', 'Miyokard, Endokard, Plevra', 'Plevra, Alveol, Membran'], correctIndex: 0),
  Question(id: 542, examType: 'AYT', subject: 'Biyoloji', questionText: 'Protein sentezi (Translasyon) hücrenin hangi organelinde gerçekleşir?', options: ['Golgi', 'Mitokondri', 'Ribozom', 'Lizozom'], correctIndex: 2),
  Question(id: 543, examType: 'AYT', subject: 'Biyoloji', questionText: 'Merkezi sinir sisteminde impuls iletimi sırasında sinaps boşluğunda impulsun bir nörondan diğerine geçişini sağlayan kimyasal maddelere ne denir?', options: ['Nörotransmitter', 'Hormon', 'Enzim', 'Antikor'], correctIndex: 0),
  Question(id: 544, examType: 'AYT', subject: 'Biyoloji', questionText: 'Fotosentezin ışıktan bağımsız tepkimeleri (Calvin Döngüsü) kloroplastın hangi bölümünde gerçekleşir?', options: ['Tilakoit zar', 'Granum', 'Stroma', 'Matriks'], correctIndex: 2),
  Question(id: 545, examType: 'AYT', subject: 'Biyoloji', questionText: 'İnce bağırsakta sindirilmiş besinlerin villuslar aracılığıyla kan kılcallarına emilmesinde etkili olan ve yüzey alanını artıran yapılara ne denir?', options: ['Mikrovillus', 'Pilor', 'Kardiya', 'Safra kesesi'], correctIndex: 0),
  Question(id: 546, examType: 'AYT', subject: 'Edebiyat', questionText: 'Şiirde dize sonlarında farklı sözcüklerle fakat aynı ses benzerliğiyle yapılan uyağa ne ad verilir?', options: ['Redif', 'Kafiye (Uyak)', 'Aliterasyon', 'Asonans'], correctIndex: 1),
  Question(id: 547, examType: 'AYT', subject: 'Edebiyat', questionText: '"Vatan Yahut Silistre" isimli tiyatro eseri ve "İntibah" adlı ilk edebi romanın yazarı tanzimat edebiyatı sanatçımız kimdir?', options: ['Namık Kemal', 'Şinasi', 'Recaizade Mahmut Ekrem', 'Ahmet Mithat Efendi'], correctIndex: 0),
  Question(id: 548, examType: 'AYT', subject: 'Edebiyat', questionText: 'Milli Edebiyat akımının dil anlayışını (sade Türkçe) ortaya koyan "Yeni Lisan" makalesi hangi dergide yayımlanmıştır?', options: ['Servet-i Fünun', 'Genç Kalemler', 'Varlık', 'Türk Yurdu'], correctIndex: 1),
  Question(id: 549, examType: 'AYT', subject: 'Edebiyat', questionText: 'Hangi edebi akım "Gerçeği olduğu gibi betimlemek ve soyaçekim (determinizm) kanunlarını romana yansıtmak" amacını taşır?', options: ['Romantizm', 'Natüralizm', 'Sürrealizm', 'Klasisizm'], correctIndex: 1),
  Question(id: 550, examType: 'AYT', subject: 'Edebiyat', questionText: 'Divan edebiyatında "Gazel" nazım şeklinin ilk beytine ve son beytine ne ad verilir?', options: ['Mısra-ı Azade / Şah Beyit', 'Kaside / Tevhid', 'Matla / Makta', 'Aruz / Hece'], correctIndex: 2),
  Question(id: 551, examType: 'AYT', subject: 'Tarih', questionText: 'Osmanlı Devleti\'nde kapıkulu askerlerine padişah değişikliklerinde (cülus) verilen bahşişin adı nedir?', options: ['Ulufe', 'Cülus Bahşişi', 'Ganimet', 'Tımar'], correctIndex: 1),
  Question(id: 552, examType: 'AYT', subject: 'Tarih', questionText: 'Mondros Ateşkes Antlaşmasının Osmanlı\'nın fiilen parçalanmasına kapı aralayan o meşhur, kritik 7. maddesinin içeriği neydi?', options: ['Osmanlı ordusu terhis edilecek', 'Vilayet-i Sitte\'de karışıklık çıkarsa işgal edilecek (Madde 24)', 'İtilaf devletleri güvenliklerini tehdit eden herhangi bir stratejik noktayı işgal hakkına sahip olacak', 'Boğazlar tüm gemilere açılacak'], correctIndex: 2),
  Question(id: 553, examType: 'AYT', subject: 'Tarih', questionText: 'TBMM tarafından Lozan Barış Konferansına temsilci olarak gönderilen, Mudanya mütarekesindeki başarısından dolayı Başmüşavir seçilen devlet adamı kimdir?', options: ['Mustafa Kemal Paşa', 'Rauf Orbay', 'İsmet İnönü', 'Kazım Karabekir'], correctIndex: 2),
  Question(id: 554, examType: 'AYT', subject: 'Tarih', questionText: 'Aşağıdakilerden hangisi Cumhuriyetin İlanı (29 Ekim 1923) sonrasında yaşanan gelişmelerden DEĞİLDİR?', options: ['Halifeliğin kaldırılması (1924)', 'Tekke ve Zaviyelerin kapatılması (1925)', 'Saltanatın kaldırılması (1922)', 'Harf İnkılabı (1928)'], correctIndex: 2),
  Question(id: 555, examType: 'AYT', subject: 'Tarih', questionText: 'Fransız ihtilalinin yaydığı milliyetçilik akımından etkilenerek Osmanlı İmparatorluğuna isyan eden ve bağımsızlığını kazanan İLK azınlık hangisidir?', options: ['Sırplar', 'Araplar', 'Bulgarlar', 'Yunanlar (Rumlar)'], correctIndex: 3),
  Question(id: 556, examType: 'AYT', subject: 'Coğrafya', questionText: 'Bir ülkenin gelişmişlik seviyesi ölçülürken nüfus piramidinin şekli büyük önem taşır. "Arı kovanı" şeklindeki nüfus piramidine sahip bir ülke için hangisi söylenebilir?', options: ['Doğum oranı çok yüksektir', 'Ortalama yaşam süresi uzundur ve nüfus yaşlıdır (Gelişmiş)', 'Gelişmemiş bir ülkedir', 'Nüfus yoğunluğu artmaktadır'], correctIndex: 1),
  Question(id: 557, examType: 'AYT', subject: 'Coğrafya', questionText: 'Jeolojik zamanlar düşünüldüğünde, Türkiye linyit, tuz ve bor yataklarının oluşumu hangi jeolojik zamana denk gelmektedir?', options: ['I. Jeolojik Zaman (Paleozoik)', 'II. Jeolojik Zaman (Mesozoik)', 'III. Jeolojik Zaman (Tersiyer)', 'IV. Jeolojik Zaman (Kuvaterner)'], correctIndex: 2),
  Question(id: 558, examType: 'AYT', subject: 'Coğrafya', questionText: 'Dünyada ulaşımı sağlamak için denizleri birbirine bağlayan yapay kanallar mevcuttur. Akdeniz ile Kızıldeniz\'i birleştiren ve Mısır\'da bulunan kanalın adı nedir?', options: ['Panama Kanalı', 'Süveyş Kanalı', 'Kiel Kanalı', 'Korint Kanalı'], correctIndex: 1),
  Question(id: 559, examType: 'AYT', subject: 'Coğrafya', questionText: 'Çevresel (Ekolojik) krizlere yol açan küresel iklim değişikliğinin temel (en büyük) nedeni (Sera Etkisi) aşağıda atmosferdeki hangi gazın artışıyla ilişkilidir?', options: ['Oksijen', 'Azot', 'Karbondioksit (CO2)', 'Helyum'], correctIndex: 2),
  Question(id: 560, examType: 'AYT', subject: 'Coğrafya', questionText: 'Güneş ışınlarının düşme açısı değiştikçe gölge boyu değişir. Türkiye\'de yatay bir düzleme dikilen çubuğun gölgesinin tüm yıl boyunca "kuzeye" düşmesinin sebebi nedir?', options: ['Yengeç dönencesinin kuzeyinde yer alması (Orta Kuşak)', 'Asya kıtasında olması', 'Dağlık olması', 'Kışların soğuk geçmesi'], correctIndex: 0),
  Question(id: 561, examType: 'AYT', subject: 'Felsefe Grubu', questionText: 'Platon felsefesinde "Gerçek varlık, duyularla algılanan nesneler değil, salt akılla kavranan değişmez, tümel özlerdir." cümlesi ile kastedilen dünya nedir?', options: ['Duyular dünyası', 'Oluş dünyası', 'İdealar dünyası', 'Madde dünyası'], correctIndex: 2),
  Question(id: 562, examType: 'AYT', subject: 'Felsefe Grubu', questionText: 'Sosyolojide bireylere toplum kurallarını benimseterek onları topluma uyumlu hale getirme sürecine ne ad verilir?', options: ['Toplumsal tabakalaşma', 'Sosyalleşme (Toplumsallaşma)', 'Sosyal hareketlilik', 'Toplumsal sapma'], correctIndex: 1),
  Question(id: 563, examType: 'AYT', subject: 'Felsefe Grubu', questionText: 'Pavlov\'un köpekler üzerinde yaptığı deneyle psikoloji literatürüne kazandırdığı ve "zil sesine salya akıtma" olarak kodlanan öğrenme türü hangisidir?', options: ['Klasik koşullanma', 'Edimsel koşullanma', 'Bilişsel öğrenme', 'Sosyal (Gözlem yoluyla) öğrenme'], correctIndex: 0),
  Question(id: 564, examType: 'AYT', subject: 'Felsefe Grubu', questionText: 'Mantık biliminde, bir önermenin "Doğru ya da Yanlış" olabilme özelliğine ne ad verilir?', options: ['Doğruluk değeri', 'Geçerlilik', 'Tutarlılık', 'Tanım'], correctIndex: 0),
  Question(id: 565, examType: 'AYT', subject: 'Din Kültürü', questionText: 'İslam dini fıkhında, yapılmasında sevap olan, yapılmamasında ise günah olmayan (Hz. Muhammed\'in ibadet kapsamı dışındaki güzel davranışları) eylemlere ne denir?', options: ['Farz', 'Vacip', 'Sünnet', 'Mekruh'], correctIndex: 2),
  Question(id: 566, examType: 'AYT', subject: 'Matematik', questionText: 'Eğer bir f(x) fonksiyonu x=a apsisli noktasında sürekli ancak türevsiz ise bu nokta fonksiyon grafinde genellikle nasıl bir şekle karşılık gelir?', options: ['Kopma (Sıçrama)', 'Kırılma (Sivri uç)', 'Boşluk (Delik)', 'Sabit çizgi'], correctIndex: 1),
  Question(id: 567, examType: 'AYT', subject: 'Matematik', questionText: 'ln(e³) + log(100) işleminin sonucu kaçtır?', options: ['2', '3', '4', '5'], correctIndex: 3),
  Question(id: 568, examType: 'AYT', subject: 'Fizik', questionText: 'Fotoelektrik olayda metalden koparılan elektronların maksimum kinetik enerjisini sıfıra düşüren ve akımı kesen potansiyel farkına ne ad verilir?', options: ['Anma Gerilimi', 'Etkin Gerilim', 'Kesme Potansiyeli', 'Zıt Potansiyel'], correctIndex: 2),
  Question(id: 569, examType: 'AYT', subject: 'Kimya', questionText: 'Asitlerin kuvvetliliğine etki eden faktörlere göre molekül yapısı en elektro-negatif atoma (Örn: Flor vs Klor/İyot) bağlı olan oksi-asitlerin kuvvetliği nasıl değişir?', options: ['Artar', 'Azalır', 'Etkilenmez', 'Nötre Döner'], correctIndex: 0),
  Question(id: 570, examType: 'AYT', subject: 'Biyoloji', questionText: 'Böbrekte Nefron kanalcıklarında geri emilim sırasında "suyun geri emiliminde görevli olan" ince-kalın kanalcıklar ağının (U borusu şeklinde olan) adı nedir?', options: ['Glomerulus Yumağı', 'Bowman Kapsülü', 'Henle Kulpu', 'Malpighi Cisimciği'], correctIndex: 2),

  // ─────────────── YENİ EKLENEN 50 AYT SORUSU (ÖSYM TARZI - 3. PARTİ) ───────────────
  Question(id: 571, examType: 'AYT', subject: 'Matematik', questionText: 'f(x) fonksiyonun (a, b) aralığında birinci türevi f\'(x) > 0 ve ikinci türevi f\'\'(x) < 0 dır. Buna göre f(x) fonksiyonunun bu aralıktaki değişim eğilimi nasıldır?', options: ['Azalan ve İçe Bükey (Konkav)', 'Artan ve İçe Bükey (Konkav)', 'Artan ve Dışa Bükey (Konveks)', 'Azalan ve Dışa Bükey (Konveks)'], correctIndex: 1),
  Question(id: 572, examType: 'AYT', subject: 'Matematik', questionText: 'Gerçel sayılarda tanımlı f(x) = x³ - 12x fonksiyonunun mutlak minimum değeri, x ∈ [-1, 5] kapalı aralığında kaçtır?', options: ['-16', '-11', '0', '65'], correctIndex: 0),
  Question(id: 573, examType: 'AYT', subject: 'Matematik', questionText: 'Sınırları x=1 ve x=2 olan, f(x) = 1/x fonksiyonunun integrali (eğri altında kalan alan) aşağıdakilerden hangisidir?', options: ['ln(1/2)', 'ln(2)', '1', 'e²'], correctIndex: 1),
  Question(id: 574, examType: 'AYT', subject: 'Matematik', questionText: 'z = 1 + i karmaşık sayısının kutupsal (trigonometrik) gösterimi aşağıdakilerden hangisidir?', options: ['√2(cos45° + i.sin45°)', '2(cos30° + i.sin30°)', '√2(cos60° + i.sin60°)', 'cos45° - i.sin45°'], correctIndex: 0),
  Question(id: 575, examType: 'AYT', subject: 'Matematik', questionText: 'log_x (y) = 2 ve log_y (z) = 3 olduğuna göre log_x (z) kaçtır?', options: ['1', '5', '6', '8'], correctIndex: 2),
  Question(id: 576, examType: 'AYT', subject: 'Matematik', questionText: 'Bir aritmetik dizide İlk n terim toplamı S_n = 2n² + 3n formülüyle veriliyor. Bu dizinin 5. terimi (a₅) kaçtır?', options: ['15', '19', '21', '65'], correctIndex: 2),
  Question(id: 577, examType: 'AYT', subject: 'Matematik', questionText: '5 kız ve 4 erkek öğrenci arasından 3 kişilik bir ekip oluşturulacaktır. Ekipte en az iki kız öğrenci olma olasılığı kaçtır?', options: ['10/84', '40/84', '50/84', '60/84'], correctIndex: 2),
  Question(id: 578, examType: 'AYT', subject: 'Matematik', questionText: 'P(x) = x³ + ax² + bx + c polinomunun üç kökü de birbirine eşittir. P(0) = -8 olduğuna göre P(1) kaçtır?', options: ['-1', '0', '1', '8'], correctIndex: 0),
  Question(id: 579, examType: 'AYT', subject: 'Matematik', questionText: 'sin²(15°) - cos²(15°) ifadesinin değeri kaçtır?', options: ['-√3 / 2', '-1/2', '1/2', '√3 / 2'], correctIndex: 0),
  Question(id: 580, examType: 'AYT', subject: 'Matematik', questionText: 'Koordinat düzleminde, merkezi (3, -4) olan ve orijinden (0, 0) geçen çemberin denklemi aşağıdakilerden hangisidir?', options: ['(x-3)² + (y+4)² = 5', '(x-3)² + (y+4)² = 25', '(x+3)² + (y-4)² = 25', '(x-3)² + (y+4)² = 7'], correctIndex: 1),
  Question(id: 581, examType: 'AYT', subject: 'Fizik', questionText: 'Yarıçapı R olan iletken küreyi +Q yükü ile yüklediğimizde, kürenin içindeki elektrik alan (E) ve elektriksel potansiyel (V) için ne söylenebilir?', options: ['E = 0, V = 0', 'E maksimum, V sıfırdır', 'E = 0, V her noktada yüzeydekine eşittir (sabittir)', 'E yüzeydekine eşittir, V sıfırdır'], correctIndex: 2),
  Question(id: 582, examType: 'AYT', subject: 'Fizik', questionText: 'Bir transformatörde, primer sarım (N1) sekonder sarımdan (N2) fazla ise potansiyel (V) ve akım (I) nasıl değişir? (İdeal Transformatör)', options: ['Gerilim düşürülür, akım yükseltilir', 'Gerilim yükseltilir, akım düşürülür', 'İkisi de yükseltilir', 'İkisi de değişmez'], correctIndex: 0),
  Question(id: 583, examType: 'AYT', subject: 'Fizik', questionText: 'Işığın dalga doğasını kanıtlayan "Çift Yarıkta Girişim (Young Deneyi)" deneyinde, ekran yarık düzleminden uzaklaştırılırsa (L artarsa) saçak genişliği (Δx) nasıl değişir?', options: ['Azalır', 'Artar', 'Değişmez', 'Önce artar sonra azalır'], correctIndex: 1),
  Question(id: 584, examType: 'AYT', subject: 'Fizik', questionText: 'Bohr Atom Modeline göre hidrojen atomunda elektron n=2 den n=1 seviyesine indiğinde açısal momentumu ne kadar değişir?', options: ['h/π kadar azalır', 'h/2π kadar azalır', 'h/2π kadar artar', 'Değişmez'], correctIndex: 1),
  Question(id: 585, examType: 'AYT', subject: 'Fizik', questionText: 'Kütleleri eşit (m) olan iki bilyeden biri h yüksekliğinden serbest düşmeye bırakılıyor, diğeri ise eğik düzlemde h yüksekliğinden serbest bırakılarak kayıyor. Ortam sürtünmesiz ise yere ulaştıklarında hangisi daha BÜYÜK hıza sahip olur?', options: ['Serbest düşen', 'Eğik düzlemde kayan', 'İkisinin de yere çarpma hızları Eşittir', 'Eğik düzlemin açısına bağlıdır'], correctIndex: 2),
  Question(id: 586, examType: 'AYT', subject: 'Kimya', questionText: 'Modern Atom Teorisine göre n=3 baş kuantum sayısına (Halkaya) sahip bir enerji düzeyinde bulunabilecek maksimum elektron sayısı kaçtır? (Formül: 2n²)', options: ['8', '16', '18', '32'], correctIndex: 2),
  Question(id: 587, examType: 'AYT', subject: 'Kimya', questionText: 'Hess Yasasına göre bir kimyasal tepkimenin entalpi değişimi (ΔH) aşağıdakilerden hangisine bağlı DEĞİLDİR?', options: ['Tepkimeye girenlerin türüne', 'Oluşan ürünlerin fiziksel haline', 'Tepkimenin izlediği yola (mekanizmasına)', 'Sıcaklık ve basınca'], correctIndex: 2),
  Question(id: 588, examType: 'AYT', subject: 'Kimya', questionText: '2X(g) ⇌ Y(g) + Z(g) tepkimesi kapalı bir kapta denge halindeyken kabın Hacmi küçültülürse, denge nasıl tepki verir?', options: ['Girenlere kayar', 'Ürünlere kayar', 'Denge konumu değişmez', 'Hız sabiti (K) küçülür'], correctIndex: 2),
  Question(id: 589, examType: 'AYT', subject: 'Kimya', questionText: 'Eritilmiş asit ve bazların sulu çözeltilerinde pH değerini koruyan, zayıf asit ile onun eşlenik (konjuge) bazının tuzu veya zayıf baz ile eşlenik asidinin tuzu karışımına ne denir?', options: ['Aerosol çözeltisi', 'Doygun çözelti', 'Tampon çözelti', 'Süspansiyon'], correctIndex: 2),
  Question(id: 590, examType: 'AYT', subject: 'Kimya', questionText: 'CH3-CH2-OH (Etil alkol) organik molekülünde, hangi tür fonksiyonel grup bulunur?', options: ['Karboksil', 'Hidroksil', 'Keton', 'Eter'], correctIndex: 1),
  Question(id: 591, examType: 'AYT', subject: 'Biyoloji', questionText: 'Sinir telinde aksiyon potansiyelinin oluşması anında impuls (uyartı) geçerken iç kısmın pozitif (+), dış kısmın negatif (-) olma durumuna (polarizasyonun bozulmasına) ne denir?', options: ['Polarizasyon', 'Depolarizasyon', 'Repolarizasyon', 'Sinerjit durum'], correctIndex: 1),
  Question(id: 592, examType: 'AYT', subject: 'Biyoloji', questionText: 'Kapalı tohumlu bitkilerde embriyo kesesindeki yumurta hücresinin bir spermle döllenerek zigotu, diğer spermin polar çekirdeklerle birleşerek 3n kromozomlu endospermi (besi doku) oluşturması olayına ne denir?', options: ['Vejetatif üreme', 'Tomurcuklanma', 'Çifte döllenme', 'Partenogenez'], correctIndex: 2),
  Question(id: 593, examType: 'AYT', subject: 'Biyoloji', questionText: 'Ökaryot bir hücrede Oksijenli solunum ETS (Elektron Taşıma Sistemi) evresi tam olarak nerede gerçekleşir?', options: ['Sitoplazmada', 'Mitokondrinin dış zarında', 'Mitokondrinin matriks sıvısında', 'Mitokondrinin iç zarı olan Kristalarda'], correctIndex: 3),
  Question(id: 594, examType: 'AYT', subject: 'Biyoloji', questionText: 'Bir DNA molekülünün kopyalanmasında (Replikasyonunda) çift sarmalı bir fermuar gibi açarak hidrojen bağlarını koparan enzimin adı nedir?', options: ['DNA Ligaz', 'DNA Polimeraz', 'Helikaz', 'RNA Polimeraz'], correctIndex: 2),
  Question(id: 595, examType: 'AYT', subject: 'Biyoloji', questionText: 'Kandaki glikoz seviyesi düştüğünde pankreasın alfa hücrelerinden salgılanarak karaciğerdeki glikojeni glikoza çeviren, kan şekerini ARTTIRAN hormon hangisidir?', options: ['İnsülin', 'Glukagon', 'Adrenalin', 'Aldosteron'], correctIndex: 1),
  Question(id: 596, examType: 'AYT', subject: 'Edebiyat', questionText: 'Cumhuriyet dönemi Türk şiirinde "Öz (Saf) Şiir" anlayışını benimseyerek ideolojiyi şiirden uzak tutan ve "Kaldırımlar" şiiri ile efsaneleşen şairimiz kimdir?', options: ['Necip Fazıl Kısakürek', 'Mehmet Akif Ersoy', 'Nazım Hikmet Ran', 'Orhan Veli Kanık'], correctIndex: 0),
  Question(id: 597, examType: 'AYT', subject: 'Edebiyat', questionText: '"Su Kasidesi", Fuzuli\'nin hangi türde kaleme aldığı ve en bilinen eserlerindendir?', options: ['Tevhid (Allah\'ı anma)', 'Naat (Peygamberi övme)', 'Mersiye', 'Hicviye'], correctIndex: 1),
  Question(id: 598, examType: 'AYT', subject: 'Edebiyat', questionText: 'Bir edebi eserde gerçek ya da hayali bir varlığı başka bir kavrama benzetirken "Bir hilal uğruna ya Rab ne güneşler batıyor" mısrasındaki gibi "Sadece kendisine benzetilen" in kullanılması sanatına ne ad verilir?', options: ['Teşhis', 'Kapalı İstiare', 'Açık İstiare', 'Kinaye'], correctIndex: 2),
  Question(id: 599, examType: 'AYT', subject: 'Edebiyat', questionText: 'Yusuf Has Hacib tarafından yazılan ve siyasetname tarzında bir rüya kurgusunu, dört sembolik kişi üzerinden mutluluğu anlatan eser hangisidir?', options: ['Atabetü\'l Hakayık', 'Divanu Lugati\'t Türk', 'Kutadgu Bilig', 'Divan-ı Hikmet'], correctIndex: 2),
  Question(id: 600, examType: 'AYT', subject: 'Edebiyat', questionText: 'Köy Enstitülerinden yetişerek tarım işçilerinin, göçmenlerin ve köylünün yaşamını gerçekçi bir dille "Yılanların Öcü" eserinde anlatan Fakir Baykurt hangi edebiyat akımı içindedir?', options: ['Bireyin İç Dünyasını Esas Alan', 'Toplumcu Gerçekçi', 'Geleneksel Modern', 'Milli Duyarlılığı Yansıtan'], correctIndex: 1),
  Question(id: 601, examType: 'AYT', subject: 'Tarih', questionText: 'Anadolu Selçuklu Devleti\'nin siyasi birliğini ve gücünü yitirerek Moğol (İlhanlı) egemenliğine girmesine neden olan yıkıcı savaş hangisidir?', options: ['Malazgirt Meydan Muharebesi', 'Miryokefalon Savaşı', 'Kösedağ Savaşı', 'Ankara Savaşı'], correctIndex: 2),
  Question(id: 602, examType: 'AYT', subject: 'Tarih', questionText: 'Avrupa\'da "Yeniden Doğuş" anlamına gelen, edebiyat, sanat ve bilim alanında antik Yunan ve Roma eserlerinin incelendiği 15. yüzyıl hareketine ne denir?', options: ['Sanayi Devrimi', 'Reform', 'Rönesans', 'Aydınlanma Çağı'], correctIndex: 2),
  Question(id: 603, examType: 'AYT', subject: 'Tarih', questionText: 'Birinci Dünya Savaşı sırasında Osmanlı İmparatorluğu\'nun Orta Asya Türkleri ile birleşmek (Turancılık) amacıyla açtığı ancak çok büyük asker kaybıyla (Sarıkamış Faciası) sonuçlanan cephe neresidir?', options: ['Galiçya Cephesi', 'Kanal Cephesi', 'Çanakkale Cephesi', 'Kafkasya Cephesi'], correctIndex: 3),
  Question(id: 604, examType: 'AYT', subject: 'Tarih', questionText: 'Modern Türkiye Cumhuriyeti\'nin uluslararası arenada meşruiyetini kanıtlayan ve "Türk Milletinin Bağımsızlık Tapusu" kabul edilen antlaşma hangisidir?', options: ['Mudanya Mütarekesi', 'Kars Antlaşması', 'Lozan Barış Antlaşması', 'Montrö Boğazlar Sözleşmesi'], correctIndex: 2),
  Question(id: 605, examType: 'AYT', subject: 'Tarih', questionText: 'Sovyetler Birliği\'nin (SSCB) komünizmi Doğu Avrupa\'da yaymasını engellemek amacıyla ABD tarafından uygulamaya konulan ekonomik yardım paketinin adı nedir?', options: ['Truman Doktrini', 'Marshall Planı', 'Eisenhower Doktrini', 'Versay Antlaşması'], correctIndex: 1),
  Question(id: 606, examType: 'AYT', subject: 'Coğrafya', questionText: 'Bir ülkede hammaddenin dışarıya ihraç edilip (satılıp), işlenmiş mamul maddelerin dışarıdan ithal ediliyor (alınıyor) olması o ülkenin coğrafi yapısı ve ekonomisi hakkında hangi temel bilgiyi verir?', options: ['Sanayisinin dışa bağımlı, henüz gelişmemiş olduğunu', 'Kalkınmış, ileri teknoloji kullandığını', 'Topraklarının çok verimli olduğunu', 'Tarım ülkesi olmadığını'], correctIndex: 0),
  Question(id: 607, examType: 'AYT', subject: 'Coğrafya', questionText: 'Deprem risk analizlerinde, levha sınırlarının harita ile örtüştürüldüğü durumlarda, dünyadaki en aktif tektonik kuşak olan ve "Pasifik Ateş Çemberi" olarak bilinen hat üzerinde aşağıdaki ülkelerden hangisi BULUNMAZ?', options: ['Japonya', 'Filipinler', 'Şili', 'Norveç'], correctIndex: 3),
  Question(id: 608, examType: 'AYT', subject: 'Coğrafya', questionText: 'Yer altına inen mağma kütlelerinin soğuyarak "Batolit, Lakolit, Sill, Dayk" gibi formasyonlar oluşturmasına neden olan coğrafi faaliyete ne ad verilir?', options: ['Epirojenez (Kıta Oluşumu)', 'Derinlik (İç) Volkanizması', 'Orojenez (Dağ oluşumu)', 'Kimyasal Çözünme'], correctIndex: 1),
  Question(id: 609, examType: 'AYT', subject: 'Coğrafya', questionText: 'Sürdürülebilir büyüme konseptinde, bugün tüketilen fosil yakıt rezervlerinin ve ekolojik zararın yıllar içindeki izine ne ad verilir?', options: ['Karbon Ayak İzi', 'Küresel Isınma', 'Demografik Geçiş', 'Verimli Biyo-Kütle'], correctIndex: 0),
  Question(id: 610, examType: 'AYT', subject: 'Coğrafya', questionText: 'Okyanus akıntıları, kıyı iklimleri üzerinde büyük rol oynar. Batı Avrupa kıyılarında sıcaklığı yükselterek o bölgenin (Örn. İngiltere) ılıman bir iklime sahip olmasını sağlayan sıcak su akıntısı hangisidir?', options: ['Labrador', 'Peru (Humboldt)', 'Gulf Stream', 'Canary (Kanarya)'], correctIndex: 2),
  Question(id: 611, examType: 'AYT', subject: 'Felsefe Grubu', questionText: 'Immanuel Kant’ın Epistemolojisinde (Bilgi Felsefesi) duyularımızla elde ettiğimiz "a posteriori" bilgilerin zihnimizdeki doğuştan gelen (a priori) kategorilerde işlendiğini ileri sürdüğü "Kritisizm (Eleştiricilik)" akımı, hangi iki zıt akımın birleşimidir?', options: ['Rasyonalizm ve Empirisizm', 'Materyalizm ve İdealizm', 'Varoluşçuluk ve Nihilizm', 'Pozitivizm ve Entüisyonizm'], correctIndex: 0),
  Question(id: 612, examType: 'AYT', subject: 'Felsefe Grubu', questionText: 'İslam felsefesinde aklı ön plana alan, Aristoteles mantığını savunan Muallim-i Sani (İkinci Öğretmen) lakaplı filozofumuz kimdir?', options: ['İbn-i Sina', 'Farabi', 'Gazali', 'Mevlana'], correctIndex: 1),
  Question(id: 613, examType: 'AYT', subject: 'Felsefe Grubu', questionText: 'Sosyolojide bireylere dayatılan belli tutumların veya etiketlemelerin kişilerin kimliklerine yapışıp aynen o beklenen karakteri yaratmasına (Örn: tembel denen çocuğun tembel olması) psikolojide ve sosyolojide ne denir?', options: ['Öğrenilmiş çaresizlik', 'Haleli etkisi (Halo effect)', 'Kendini Gerçekleştiren Kehanet (Pygmalion Etkisi)', 'Grup baskısı'], correctIndex: 2),
  Question(id: 614, examType: 'AYT', subject: 'Felsefe Grubu', questionText: 'Klasik Mantıkta "Bütün insanlar ölümlüdür. (Öncül 1) Sokrates bir insandır. (Öncül 2) O halde Sokrates de ölümlüdür. (Sonuç)" diyen akıl yürütme tekniğinin (Genelden Özele) adı nedir?', options: ['Tümevarım (Endüksiyon)', 'Tümdengelim (Dedüksiyon)', 'Analoji (Benzeşim)', 'Paradoks'], correctIndex: 1),
  Question(id: 615, examType: 'AYT', subject: 'Din Kültürü', questionText: 'İslam tarihindeki ilk mimari eser olan ve hicretin ardından Medine\'de Mescid-i Nebevi\'nin hemen bitişiğine kurulan "Suffe" platformu ne amaçla yapılmıştır?', options: ['Ticari merkez olarak kullanılmıştır', 'Savaş hazırlığı ve silah deposu olarak yapılmıştır', 'Hastalar ve yetimlerin barınması için kervansaraydır', 'Kimsesizlerin ve fakir sahabelerin barınması, ilim-irfan (Eğitim) görmesi için yapılmıştır'], correctIndex: 3),
  Question(id: 616, examType: 'AYT', subject: 'Din Kültürü', questionText: 'Hz. Muhammed\'e indirilen ilk ayet "Yaratan Rabb\'inin adıyla oku!" Alak Suresinin ilk 5 ayetidir. Bu olayın gerçekleştiği geceye Kur\'an\'da hangi isim verilir?', options: ['Kadir Gecesi', 'Berat Kandili', 'Miraç Gecesi', 'Mevlid Kandili'], correctIndex: 0),
  Question(id: 617, examType: 'AYT', subject: 'Matematik', questionText: 'Kesişen iki fonksiyon grafiği arasında kalan kapalı bölgenin alanı bulunurken hangi yöntem kullanılır?', options: ['Sadece limitleri toplayıp çıkartmak', 'Olasılık dağılımlarını hesaplamak', 'Üstteki fonksiyon denkleminden alttaki fonksiyon denklemini çıkararak integral almak', 'Trigonometrik özdeşliklere bölmek'], correctIndex: 2),
  Question(id: 618, examType: 'AYT', subject: 'Fizik', questionText: 'Evrendeki kararlılığı (Büyük Patlama sonrası) koruyan kütle-Çekim yasasını uzay-zaman eğriliğinin bir sonucu olarak izah eden "Genel Görelilik (İzafiyet) Teorisi"ni kim, hangi yüzyılda ortaya atmıştır?', options: ['Isaac Newton (17. YY)', 'Albert Einstein (20. YY)', 'Nikola Tesla (19. YY)', 'Galileo Galilei (16. YY)'], correctIndex: 1),
  Question(id: 619, examType: 'AYT', subject: 'Kimya', questionText: 'Metaller asitlerle tepkimeye girerek H₂ gazı çıkartırlar (Aktif metaller). Ancak Cu (Bakır), Ag (Gümüş), Hg (Cıva) gibi yarı soy metaller hidroklorik asit (HCl) ile tepkime vermezler, sadece hangi asitlerle tepkime verebilirler?', options: ['Sadece zayıf asitlerle', 'Oksijen içeren kuvvetli asitlerle (HNO3, H2SO4)', 'NaOH gibi kuvvetli bazlarla', 'Sadece organik asitlerle'], correctIndex: 1),
  Question(id: 620, examType: 'AYT', subject: 'Biyoloji', questionText: 'Popülasyon genetiğinde "Hardy-Weinberg Kuralı"na göre ideal (evrimin sıfır olduğu) bir popülasyonda nesiller boyunca allel frekanslarının (p + q = 1) sabit kalması için hangisi OLMAMALIDIR?', options: ['Popülasyonun çok büyük (sonsuza yakın) karakterde olması', 'Rastgele eşleşme (çiftleşme)', 'Herhangi bir doğal seçilimin yaşanması veya mutasyon', 'İzolasyonun korunması (dışarıdan göç olmaması)'], correctIndex: 2),
  ...aytNewQuestions1,
  ...aytNewQuestions2,
  ...aytNewQuestions3,
  ...aytNewQuestions4,
];
