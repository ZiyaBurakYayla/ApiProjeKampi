SET NOCOUNT ON;
SET XACT_ABORT ON;
BEGIN TRANSACTION;

/* ============ Services  (column fix: Title -> Tite) ============ */
INSERT INTO Services (Tite, Description, IconUrl) VALUES
(N'Lezzetin kalbinde buluşuyoruz', N'Tüm yemeklerimiz usta şeflerin elinden doğal ve katkısız ürünlerle hazırlanır.', N'aa'),
(N'Tazeliğe verdiğimiz önem', N'Her gün taze temin edilen malzemelerle, sağlığınız ve damak zevkiniz ön plandadır.', N'aa'),
(N'Sıcak servis, samimi ortam', N'Konforlu ortamımızda yemeklerinizi keyifle yiyin, kendinizi evinizde hissedin.', N'aa'),
(N'Uygun fiyat, yüksek kalite', N'Yummy, her bütçeye uygun fiyatlarla lezzetli yemekleri sizlere sunar.', N'aa'),
(N'Güler yüzlü hizmet anlayışı', N'Misafirlerimizi her zaman memnun edecek şekilde hizmet sunmak önceliğimizdir.', N'aa');

/* ============ Categories  (capture new IDs so Products map correctly) ============ */
DECLARE @catMap TABLE (CategoryName nvarchar(200), CategoryId int);

INSERT INTO Categories (CategoryName)
OUTPUT INSERTED.CategoryName, INSERTED.CategoryId INTO @catMap (CategoryName, CategoryId)
VALUES
(N'Tatlılar'),
(N'Yemekler'),
(N'Salatalar'),
(N'Çorbalar'),
(N'İçecekler'),
(N'Vejetaryen'),
(N'Kahvaltılıklar'),
(N'Izgaralar'),
(N'Deniz Ürünleri'),
(N'Atıştırmalıklar'),
(N'Makarnalar'),
(N'Pizzalar');

/* ============ Products  (column fix: ProductDescription -> Description; CategoryId mapped by name) ============ */
INSERT INTO Products (ProductName, Description, Price, ImageUrl, CategoryId)
SELECT v.ProductName, v.Description, v.Price, v.ImageUrl, m.CategoryId
FROM (VALUES
 (N'Profiterol', N'Çikolata sosuyla kaplanmış nefis profiterol tatlısı', 120, N'aa', N'Tatlılar'),
 (N'Cheesecake', N'Orman meyveli taze cheesecake', 140, N'aa', N'Tatlılar'),
 (N'Izgara Tavuk', N'Özel baharatlarla marine edilmiş ızgara tavuk', 220, N'aa', N'Yemekler'),
 (N'Et Sote', N'Taze sebzelerle birlikte sotelenmiş dana eti', 280, N'aa', N'Yemekler'),
 (N'Sezar Salata', N'Tavuklu, parmesanlı klasik sezar salata', 160, N'aa', N'Salatalar'),
 (N'Akdeniz Salata', N'Zeytinyağlı ve taptaze sebzelerden oluşan hafif salata', 150, N'aa', N'Salatalar'),
 (N'Mercimek Çorbası', N'Klasik Anadolu usulü mercimek çorbası', 90, N'aa', N'Çorbalar'),
 (N'Domates Çorbası', N'Kaşar peynirli domates çorbası', 95, N'aa', N'Çorbalar'),
 (N'Ev Yapımı Limonata', N'Taze limonlardan hazırlanmış ferahlatıcı limonata', 70, N'aa', N'İçecekler'),
 (N'Türk Kahvesi', N'Közde pişmiş geleneksel Türk kahvesi', 60, N'aa', N'İçecekler'),
 (N'Falafel Tabağı', N'Nohut köftesi, humus ve salata ile servis edilir', 200, N'aa', N'Vejetaryen'),
 (N'Vejetaryen Güveç', N'Taze sebzelerle fırında pişmiş güveç', 210, N'aa', N'Vejetaryen'),
 (N'Serpme Kahvaltı', N'Peynir, zeytin, reçel ve sıcaklarla dolu geleneksel kahvaltı', 280, N'aa', N'Kahvaltılıklar'),
 (N'Menemen', N'Domates, biber ve yumurta ile hazırlanan geleneksel tat', 120, N'aa', N'Kahvaltılıklar'),
 (N'Izgara Köfte', N'Dana kıymasından hazırlanan ızgara köfte', 230, N'aa', N'Izgaralar'),
 (N'Kuzu Pirzola', N'Izgara kuzu pirzola, yanında garnitür', 350, N'aa', N'Izgaralar'),
 (N'Izgara Somon', N'Limon soslu ızgara somon', 340, N'aa', N'Deniz Ürünleri'),
 (N'Karides Güveç', N'Özel soslu tereyağında pişmiş karides güveç', 360, N'aa', N'Deniz Ürünleri'),
 (N'Patates Kızartması', N'Kızarmış patates, yanında sos', 90, N'aa', N'Atıştırmalıklar'),
 (N'Soğan Halkası', N'Kızartılmış çıtır soğan halkaları', 100, N'aa', N'Atıştırmalıklar'),
 (N'Spagetti Bolonez', N'Kıymalı bolonez soslu spagetti', 200, N'aa', N'Makarnalar'),
 (N'Fettucini Alfredo', N'Kremalı mantarlı fettucini alfredo', 220, N'aa', N'Makarnalar'),
 (N'Margherita Pizza', N'Mozzarella, domates sos ve fesleğenli klasik pizza', 250, N'aa', N'Pizzalar'),
 (N'Karışık Pizza', N'Sucuk, salam, mantar ve biberle hazırlanmış pizza', 280, N'aa', N'Pizzalar')
) v(ProductName, Description, Price, ImageUrl, CatName)
INNER JOIN @catMap m ON m.CategoryName = v.CatName;

/* ============ Testimonials ============ */
INSERT INTO Testimonials (NameSurname, Title, Comment, ImageUrl) VALUES
(N'Ayşe Demir', N'Gıda Mühendisi', N'Yemeklerin tazeliği ve lezzeti harikaydı. Uzun zamandır bu kadar keyifli bir akşam geçirmemiştim.', N'aa'),
(N'Mehmet Yıldız', N'Avukat', N'Samimi atmosferi ve güler yüzlü hizmetiyle gerçekten fark yaratan bir mekan.', N'aa'),
(N'Elif Korkmaz', N'Öğretmen', N'Çocuklarla birlikte geldik, hem onlar hem biz çok memnun kaldık. Menüde herkes için seçenek var.', N'aa'),
(N'Can Özkan', N'Mühendis', N'Izgaralar tam kıvamında pişmişti, fiyat–performans dengesi çok başarılı.', N'aa'),
(N'Zeynep Acar', N'Doktor', N'Tatlıları mutlaka denemelisiniz, özellikle cheesecake favorim oldu!', N'aa');

/* ============ YummyEvents  (added required EventDate -- placeholder dates, edit as needed) ============ */
INSERT INTO YummyEvents (Title, Description, EventDate, ImageUrl, Status, Price) VALUES
(N'Şefin Özel Gecesi', N'Usta şefimizin hazırladığı 5 farklı özel menü tadımı ile unutulmaz bir akşam yaşayın.', N'2026-07-15', N'aa', 1, 750),
(N'Canlı Müzik Akşamı', N'Hafta sonuna özel canlı müzik eşliğinde yemek keyfi.', N'2026-07-19', N'aa', 1, 300),
(N'Şarap & Peynir Tadımı', N'En seçkin şaraplar ve özel peynir çeşitleri ile keyifli bir deneyim.', N'2026-07-26', N'aa', 1, 500),
(N'Sevgililer Günü Menüsü', N'Romantik bir atmosferde çiftlere özel menü ve sürprizler.', N'2027-02-14', N'aa', 1, 950),
(N'Kahvaltı Brunch Etkinliği', N'Pazar gününe özel açık büfe serpme kahvaltı ve brunch etkinliği.', N'2026-07-12', N'aa', 1, 350),
(N'Doğum Günü Organizasyonu', N'Sevdikleriniz için özel süslemeler, doğum günü pastası ve kutlama menüsü.', N'2026-08-01', N'aa', 1, 1200),
(N'İş Yemeği & Toplantı', N'Kurumsal iş yemekleri ve toplantılar için özel hazırlanmış menüler ve VIP salon.', N'2026-08-05', N'aa', 1, 1500),
(N'Ramazan İftarı', N'Ramazan ayına özel iftar menüsü ve sınırsız çay ikramı.', N'2027-03-01', N'aa', 1, 400),
(N'Yılbaşı Özel Programı', N'Canlı müzik, özel yılbaşı menüsü ve sürprizlerle dolu eğlenceli bir gece.', N'2026-12-31', N'aa', 1, 2000),
(N'Dünya Mutfağı Haftası', N'Farklı ülkelerin en özel lezzetleriyle dolu bir hafta sizi bekliyor.', N'2026-09-10', N'aa', 1, 800);

/* ============ Chefs ============ */
INSERT INTO Chefs (NameSurname, Title, Description, ImageUrl) VALUES
(N'Ahmet Kaya', N'Baş Şef', N'20 yıllık mutfak deneyimiyle Türk ve dünya mutfaklarını ustalıkla harmanlayan baş şefimiz.', N'aa'),
(N'Elif Demir', N'Pastane Şefi', N'Tatlı ve pastalarda uzman, özellikle cheesecake ve çikolatalı tatlılarıyla tanınır.', N'aa'),
(N'Mehmet Yıldız', N'Izgara Ustası', N'Et ve ızgara yemeklerinde uzman, lezzet sırlarını yılların deneyimiyle sunuyor.', N'aa'),
(N'Selin Arslan', N'Vejetaryen & Vegan Şef', N'Sebze ve bitki bazlı yemeklerde yaratıcı tarifleriyle öne çıkıyor.', N'aa'),
(N'Canan Yüce', N'Deniz Ürünleri Şefi', N'Balık ve deniz ürünlerinde uzman, Akdeniz mutfağını sofralara taşıyor.', N'aa');

/* ============ Reservations  (column fix: PhoneNumber -> PhoneNo, CountofPeople -> CountOfPeople) ============ */
INSERT INTO Reservations (NameSurname, Email, PhoneNo, ReservationDate, ReservationTime, CountOfPeople, Message, ReservationStatus) VALUES
(N'Ahmet Demir', N'ahmetdemir@example.com', N'05001112233', '2025-09-25', N'19:30', 2, N'Eşimle akşam yemeği için rezervasyon yapmak istiyorum.', N'Onay Bekliyor'),
(N'Elif Yılmaz', N'elifyilmaz@example.com', N'05002223344', '2025-09-26', N'20:00', 4, N'Doğum günü kutlaması için masa ayırabilir misiniz?', N'Onaylandı'),
(N'Mehmet Kaya', N'mehmetkaya@example.com', N'05003334455', '2025-09-27', N'18:00', 3, N'Pencere kenarında masa rica ediyorum.', N'İptal Edildi'),
(N'Zeynep Arslan', N'zeyneparslan@example.com', N'05004445566', '2025-09-28', N'21:00', 5, N'İş yemeği için sessiz bir alan ayırabilir misiniz?', N'Tamamlandı'),
(N'Can Özkan', N'canozkan@example.com', N'05005556677', '2025-09-29', N'19:00', 2, N'Romantik bir akşam için küçük bir masa istiyoruz.', N'Gelmedi'),
(N'Deniz Çelik', N'denizcelik@example.com', N'05006667788', '2025-09-30', N'20:30', 6, N'Arkadaş grubumuz için geniş masa rica ederiz.', N'Onay Bekliyor'),
(N'Hülya Şahin', N'hulyasahin@example.com', N'05007778899', '2025-10-01', N'19:00', 2, N'Anneme doğum günü sürprizi yapacağız.', N'Onaylandı'),
(N'Burak Yıldırım', N'burakyildirim@example.com', N'05008889900', '2025-10-02', N'20:00', 8, N'Şirket yemeği için rezervasyon yaptırmak istiyorum.', N'Tamamlandı'),
(N'Selin Acar', N'selinacar@example.com', N'05009990011', '2025-10-03', N'18:30', 3, N'Glutensiz menü seçeneğiniz var mı?', N'Onay Bekliyor'),
(N'Murat Koç', N'muratkoc@example.com', N'05001112244', '2025-10-04', N'21:00', 2, N'Deniz ürünleri menüsü için rezervasyon yaptırmak istiyoruz.', N'Onaylandı'),
(N'Cansu Polat', N'cansupolat@example.com', N'05002223355', '2025-10-05', N'19:30', 5, N'Arkadaşlarla mezuniyet kutlaması yapacağız.', N'Onay Bekliyor'),
(N'Kerem Aslan', N'keremaslan@example.com', N'05003334466', '2025-10-06', N'20:00', 4, N'Sessiz ve sakin bir masa istiyoruz.', N'İptal Edildi'),
(N'Melis Kurt', N'meliskurt@example.com', N'05004445577', '2025-10-07', N'19:00', 3, N'Tatlı menünüzü özellikle denemek istiyoruz.', N'Onaylandı'),
(N'Okan Erdem', N'okanerdem@example.com', N'05005556688', '2025-10-08', N'20:30', 7, N'Kalabalık arkadaş grubumuz için geniş masa lütfen.', N'Tamamlandı'),
(N'İrem Aksoy', N'iremaksoy@example.com', N'05006667799', '2025-10-09', N'18:00', 2, N'Romantik akşam için mum ışığı olsun lütfen.', N'Onay Bekliyor'),
(N'Tolga Uçar', N'tolgaucar@example.com', N'05007778800', '2025-10-10', N'19:30', 4, N'Şarap tadımı için geldik, rezervasyon yapıyoruz.', N'Onaylandı'),
(N'Derya Efe', N'deryaefe@example.com', N'05008889911', '2025-10-11', N'20:00', 6, N'Aile yemeği için geniş masa rica ederiz.', N'Gelmedi'),
(N'Emre Sezgin', N'emresezgin@example.com', N'05009990022', '2025-10-12', N'21:00', 2, N'Eşimle evlilik yıldönümümüz için rezervasyon.', N'Onaylandı'),
(N'Gizem Yalçın', N'gizemyalcin@example.com', N'05001113344', '2025-10-13', N'19:00', 3, N'Menüde vegan seçenekler var mı?', N'Onay Bekliyor'),
(N'Serkan Güneş', N'serkangunes@example.com', N'05002224455', '2025-10-14', N'20:30', 5, N'Doğum günü kutlaması için pasta istiyoruz.', N'Tamamlandı'),
(N'Ayşe Karaca', N'aysekaraca@example.com', N'05003335566', '2025-10-15', N'19:00', 2, N'Arkadaşımın doğum günü için küçük masa rica ediyorum.', N'Onay Bekliyor'),
(N'Mert Özdemir', N'mertozdemir@example.com', N'05004446677', '2025-10-16', N'20:00', 6, N'Kalabalık grup olarak geleceğiz, uygun masa ayırır mısınız?', N'Onaylandı'),
(N'Seda Çetin', N'sedacetin@example.com', N'05005557788', '2025-10-17', N'18:30', 3, N'Vegan menü seçenekleri için bilgi almak istiyorum.', N'Tamamlandı'),
(N'Ali Turan', N'alaturan@example.com', N'05006668899', '2025-10-18', N'19:30', 5, N'İş toplantısı için sessiz bir masa ayırabilir misiniz?', N'İptal Edildi'),
(N'Nazan Yıldız', N'nazanyildiz@example.com', N'05007779900', '2025-10-19', N'21:00', 2, N'Romantik bir akşam yemeği için rezervasyon.', N'Onay Bekliyor'),
(N'Furkan Kılıç', N'furkankilic@example.com', N'05008880011', '2025-10-20', N'20:00', 8, N'Şirket çalışanları ile yemek organizasyonu yapıyoruz.', N'Onaylandı'),
(N'Buse Akın', N'buseakin@example.com', N'05009991122', '2025-10-21', N'19:00', 4, N'Pencere kenarı masa mümkünse ayırın lütfen.', N'Tamamlandı'),
(N'Hakan Duman', N'hakanduman@example.com', N'05001114455', '2025-10-22', N'20:30', 3, N'Yemek sonrası tatlı için öneriniz var mı?', N'Onay Bekliyor'),
(N'Yasemin Er', N'yaseminer@example.com', N'05002225566', '2025-10-23', N'18:00', 2, N'Kız kardeşimle kahvaltı için rezervasyon.', N'Onaylandı'),
(N'Barış Kurt', N'bariskurt@example.com', N'05003336677', '2025-10-24', N'19:30', 6, N'Üniversite arkadaşlarımızla buluşma yapacağız.', N'Tamamlandı'),
(N'Ece Koç', N'ecekoc@example.com', N'05004447788', '2025-10-25', N'20:00', 2, N'Sevgilimle yıldönümümüz için rezervasyon.', N'Onay Bekliyor'),
(N'Tolga Tekin', N'tolgatekin@example.com', N'05005558899', '2025-10-26', N'19:00', 5, N'Çocuk menüsü var mı?', N'İptal Edildi'),
(N'Hande Yalçın', N'handeyalcin@example.com', N'05006669900', '2025-10-27', N'21:00', 4, N'Tatlı menünüz çok ilgimizi çekti, rezervasyon yaptırıyoruz.', N'Onay Bekliyor'),
(N'Umut Sezer', N'umutsezer@example.com', N'05007770011', '2025-10-28', N'20:00', 3, N'Ailemle birlikte geleceğiz, rahat bir masa rica ediyoruz.', N'Onaylandı'),
(N'Cemre Ay', N'cemreay@example.com', N'05008881122', '2025-10-29', N'19:30', 7, N'Arkadaş grubumuzla kutlama yapacağız.', N'Tamamlandı'),
(N'Kaan Kaplan', N'kaankaplan@example.com', N'05009992233', '2025-10-30', N'18:00', 2, N'Sessiz köşe masa istiyoruz.', N'Onay Bekliyor'),
(N'Zehra Işık', N'zehraisik@example.com', N'05001115544', '2025-10-31', N'19:00', 5, N'Sürpriz doğum günü için masa ayarlayabilir misiniz?', N'Onaylandı'),
(N'Ömer Çolak', N'omercolak@example.com', N'05002226655', '2025-11-01', N'20:30', 2, N'Romantik bir akşam yemeği için rezervasyon.', N'Tamamlandı'),
(N'Gülşah Aydın', N'gulsahaydin@example.com', N'05003337766', '2025-11-02', N'21:00', 6, N'Arkadaşlarla kahkaha dolu bir akşam için rezervasyon.', N'Gelmedi'),
(N'Levent Kara', N'leventkara@example.com', N'05004448877', '2025-11-03', N'19:30', 4, N'Ailemle birlikte doğum günü kutlaması yapacağız.', N'Onay Bekliyor'),
(N'Nilay Güneş', N'nilaygunes@example.com', N'05005559911', '2025-11-04', N'20:00', 2, N'Arkadaşım ile uzun zamandır görüşmedik, sakin masa rica ediyoruz.', N'Onaylandı'),
(N'Taylan Yavuz', N'taylanyavuz@example.com', N'05006660022', '2025-11-05', N'19:30', 5, N'Şirket ekibiyle yemek organizasyonu yapıyoruz.', N'Tamamlandı'),
(N'Aslı Koçak', N'aslikocak@example.com', N'05007771133', '2025-11-06', N'18:30', 3, N'Vegan menü seçenekleri için rezervasyon.', N'Onay Bekliyor'),
(N'Kemal Ekinci', N'kemalekinci@example.com', N'05008882244', '2025-11-07', N'20:00', 6, N'Aile toplantısı için geniş masa rica ediyoruz.', N'İptal Edildi'),
(N'Sibel Arı', N'sibelari@example.com', N'05009993355', '2025-11-08', N'21:00', 2, N'Romantik akşam yemeği planlıyoruz.', N'Onay Bekliyor'),
(N'Gökhan Can', N'gokhancan@example.com', N'05001116677', '2025-11-09', N'19:00', 4, N'Arkadaşlarla doğum günü kutlaması yapacağız.', N'Onaylandı'),
(N'Meltem Usta', N'meltemusta@example.com', N'05002227788', '2025-11-10', N'20:30', 2, N'Evlilik yıldönümümüz için rezervasyon.', N'Tamamlandı'),
(N'Orhan Tetik', N'orhantetik@example.com', N'05003338899', '2025-11-11', N'19:30', 7, N'Şirket toplantısı sonrası akşam yemeği.', N'Onay Bekliyor'),
(N'Pelin Bayrak', N'pelinbayrak@example.com', N'05004440011', '2025-11-12', N'18:00', 3, N'Tatlı menüsünü denemek için geleceğiz.', N'Onaylandı'),
(N'Cihan Bozkurt', N'cihanbozkurt@example.com', N'05005551122', '2025-11-13', N'20:00', 2, N'Sevgilimle birlikte özel masa ayırır mısınız?', N'Tamamlandı'),
(N'Zeliha Polat', N'zelihapolat@example.com', N'05006662233', '2025-11-14', N'19:00', 4, N'Kızlarla buluşma için rezervasyon.', N'Onay Bekliyor'),
(N'Taner Özkan', N'tanerozkan@example.com', N'05007773344', '2025-11-15', N'20:30', 5, N'Kalabalık aile yemeği planlıyoruz.', N'Onaylandı'),
(N'Gamze Akyüz', N'gamzeakyuz@example.com', N'05008884455', '2025-11-16', N'21:00', 6, N'Arkadaş grubumuzla eğlenceli akşam planlıyoruz.', N'Gelmedi'),
(N'Halil Sarı', N'halilsari@example.com', N'05009995566', '2025-11-17', N'19:30', 2, N'Sessiz köşe masa rica ediyoruz.', N'Onay Bekliyor'),
(N'Ceyda Acar', N'ceydaacar@example.com', N'05001117788', '2025-11-18', N'20:00', 8, N'Şirket departman yemeği için masa ayırır mısınız?', N'Onaylandı'),
(N'Arda İnce', N'ardaince@example.com', N'05002228899', '2025-11-19', N'18:30', 3, N'Tatlılardan özellikle cheesecake denemek istiyoruz.', N'Tamamlandı'),
(N'Songül Kaya', N'songulkaya@example.com', N'05003339900', '2025-11-20', N'19:00', 4, N'Ailecek akşam yemeği için rezervasyon.', N'Onay Bekliyor'),
(N'Ferhat Demirtaş', N'ferhatdemirtas@example.com', N'05004441122', '2025-11-21', N'20:30', 2, N'Eşimle özel akşam yemeği için masa istiyoruz.', N'Onaylandı'),
(N'Müge Şen', N'mugesen@example.com', N'05005552233', '2025-11-22', N'21:00', 5, N'Kız arkadaş grubumuzla kutlama yapacağız.', N'İptal Edildi'),
(N'Alper Güven', N'alperguven@example.com', N'05006663344', '2025-11-23', N'19:30', 2, N'Romantik bir akşam planlıyoruz.', N'Onay Bekliyor'),
(N'Sevgi Doğan', N'sevgidogan@example.com', N'05007774455', '2025-11-24', N'20:00', 3, N'Kardeşimle birlikte akşam yemeği için masa rica ediyoruz.', N'Onay Bekliyor'),
(N'Tolga Alkan', N'tolgaalkan@example.com', N'05008885566', '2025-11-25', N'19:30', 5, N'Arkadaş grubumuzla kutlama yapacağız.', N'Onaylandı'),
(N'Nazlı Kurtuluş', N'nazlikurtulus@example.com', N'05009996677', '2025-11-26', N'18:30', 2, N'Romantik bir masa rica ediyoruz.', N'Tamamlandı'),
(N'Yusuf Erdem', N'yusuferdem@example.com', N'05001118899', '2025-11-27', N'20:00', 6, N'Şirket yemeği için geniş masa istiyoruz.', N'İptal Edildi'),
(N'Selma Karahan', N'selmakarahan@example.com', N'05002229900', '2025-11-28', N'21:00', 4, N'Ailecek akşam yemeği için rezervasyon.', N'Onay Bekliyor'),
(N'İsmail Tetik', N'ismailtetik@example.com', N'05003330011', '2025-11-29', N'19:00', 2, N'Sevgilimle yıldönümümüz için masa rica ediyoruz.', N'Onaylandı'),
(N'Ebru Yıldırım', N'ebruyildirim@example.com', N'05004441122', '2025-11-30', N'20:30', 3, N'Arkadaşlarımızla keyifli bir akşam için rezervasyon.', N'Tamamlandı'),
(N'Berk Demirci', N'berkdemirci@example.com', N'05005552233', '2025-12-01', N'19:30', 7, N'Mezuniyet kutlaması için masa rica ediyoruz.', N'Onay Bekliyor'),
(N'Esra Gök', N'esragok@example.com', N'05006663344', '2025-12-02', N'18:00', 2, N'Pencere kenarında masa lütfen.', N'Onaylandı'),
(N'Kadir Uzun', N'kadiruzun@example.com', N'05007774455', '2025-12-03', N'20:00', 4, N'İş toplantısı sonrası yemek için masa ayırın.', N'Tamamlandı'),
(N'Nihal Yüksel', N'nihalyuksel@example.com', N'05008885566', '2025-12-04', N'19:00', 6, N'Aile buluşması için masa ayırın.', N'Onay Bekliyor'),
(N'Emin Kaya', N'eminkaya@example.com', N'05009996677', '2025-12-05', N'20:30', 2, N'Sevgilimle özel günümüz için masa istiyoruz.', N'Onaylandı'),
(N'Yeliz Duran', N'yelizduran@example.com', N'05001119988', '2025-12-06', N'21:00', 5, N'Kız arkadaş grubumuzla eğlenceli bir akşam planlıyoruz.', N'Gelmedi'),
(N'Cengiz Çolak', N'cengizcolak@example.com', N'05002220099', '2025-12-07', N'19:30', 3, N'Sessiz köşe masa rica ediyoruz.', N'Onay Bekliyor'),
(N'Aylin Öztürk', N'aylinozturk@example.com', N'05003331100', '2025-12-08', N'20:00', 2, N'Tatlı menünüzü denemek için rezervasyon.', N'Onaylandı'),
(N'Murat Çetin', N'muratcetin@example.com', N'05004442211', '2025-12-09', N'19:00', 4, N'Ailemle birlikte doğum günü kutlaması yapacağız.', N'Tamamlandı'),
(N'Gonca Polat', N'goncapolis@example.com', N'05005553322', '2025-12-10', N'20:30', 2, N'Romantik bir akşam için rezervasyon.', N'Onay Bekliyor'),
(N'Samet Öz', N'sametoz@example.com', N'05006664433', '2025-12-11', N'21:00', 8, N'Şirket departman yemeği için masa ayırır mısınız?', N'Onaylandı'),
(N'Hazal Yıldız', N'hazalyildiz@example.com', N'05007775544', '2025-12-12', N'19:30', 2, N'Yılbaşı öncesi arkadaşlarla yemek için masa istiyoruz.', N'Tamamlandı'),
(N'Volkan Acar', N'volkanacar@example.com', N'05008886655', '2025-12-13', N'20:00', 6, N'Kalabalık aile yemeği için rezervasyon.', N'İptal Edildi');

COMMIT TRANSACTION;

SELECT 'Services' tbl, COUNT(*) cnt FROM Services
UNION ALL SELECT 'Categories', COUNT(*) FROM Categories
UNION ALL SELECT 'Products', COUNT(*) FROM Products
UNION ALL SELECT 'Testimonials', COUNT(*) FROM Testimonials
UNION ALL SELECT 'YummyEvents', COUNT(*) FROM YummyEvents
UNION ALL SELECT 'Chefs', COUNT(*) FROM Chefs
UNION ALL SELECT 'Reservations', COUNT(*) FROM Reservations;
