SET NOCOUNT ON;
SET XACT_ABORT ON;
BEGIN TRANSACTION;

INSERT INTO GroupReservations
(ResponsibleCustomerName, GroupTitle, ReservationDate, LastProcessDate, Priority, Details, ReservationStatus, PersonCount, Email)
VALUES
(N'Ahmet Yılmaz', N'Yılmaz Holding Yıl Sonu Yemeği', '2026-12-20 20:00', '2026-06-12 10:00', N'Yüksek', N'Kurumsal yıl sonu kutlaması, VIP salon ve özel menü talebi.', N'Onaylandı', 45, N'ahmet.yilmaz@yilmazholding.com'),
(N'Elif Demir', N'Demir Ailesi Nişan Yemeği', '2026-08-15 19:30', '2026-06-14 11:20', N'Orta', N'Nişan organizasyonu, pasta ve masa süslemesi dahil.', N'Onay Bekliyor', 30, N'elifdemir@gmail.com'),
(N'Mehmet Kaya', N'Kaya İnşaat Toplantı Yemeği', '2026-07-10 13:00', '2026-06-15 09:45', N'Yüksek', N'İş toplantısı sonrası öğle yemeği, projeksiyon ihtiyacı var.', N'Onaylandı', 18, N'mkaya@kayainsaat.com'),
(N'Zeynep Arslan', N'Mezuniyet Kutlaması', '2026-06-28 18:00', '2026-06-10 16:00', N'Düşük', N'Üniversite mezuniyet yemeği, öğrenci grubu.', N'Tamamlandı', 25, N'zeynep.arslan@hotmail.com'),
(N'Can Öztürk', N'Bekarlığa Veda Partisi', '2026-07-05 21:00', '2026-06-16 12:30', N'Orta', N'Erkek arkadaş grubu, canlı müzik talebi.', N'Onay Bekliyor', 12, N'canozturk@gmail.com'),
(N'Selin Acar', N'Acar Ailesi Doğum Günü', '2026-07-22 19:00', '2026-06-17 14:10', N'Düşük', N'Sürpriz doğum günü, pasta ve balon süslemesi.', N'Onaylandı', 16, N'selin.acar@gmail.com'),
(N'Burak Şahin', N'TechSoft Yazılım Ekip Yemeği', '2026-07-18 20:00', '2026-06-13 15:25', N'Orta', N'Departman ekip yemeği, açık büfe tercih ediliyor.', N'Onay Bekliyor', 35, N'burak.sahin@techsoft.com'),
(N'Derya Çelik', N'Çelik & Yıldız Düğün After', '2026-09-12 22:00', '2026-06-11 10:40', N'Yüksek', N'Düğün sonrası kutlama, DJ ve ikram düzeni.', N'Onaylandı', 60, N'derya.celik@gmail.com'),
(N'Okan Erdem', N'Erdem Hukuk Bürosu Tanışma Yemeği', '2026-07-09 19:30', '2026-06-09 09:00', N'Orta', N'Yeni ekip tanışma yemeği, sessiz salon talebi.', N'İptal Edildi', 14, N'okan.erdem@erdemhukuk.com'),
(N'İrem Aksoy', N'Aksoy Ailesi Sünnet Düğünü', '2026-08-02 13:00', '2026-06-15 17:30', N'Yüksek', N'Sünnet organizasyonu, çocuk menüsü ve animasyon.', N'Onay Bekliyor', 50, N'irem.aksoy@gmail.com'),
(N'Tolga Uçar', N'Uçar Otomotiv Bayi Toplantısı', '2026-07-25 12:00', '2026-06-16 11:15', N'Yüksek', N'Bayi toplantısı ardından kurumsal öğle yemeği.', N'Onaylandı', 40, N'tolga.ucar@ucarotomotiv.com'),
(N'Gizem Yalçın', N'Kına Gecesi Organizasyonu', '2026-08-20 20:00', '2026-06-14 18:00', N'Orta', N'Kına gecesi, geleneksel düzen ve özel dekor.', N'Onay Bekliyor', 38, N'gizem.yalcin@gmail.com'),
(N'Serkan Güneş', N'Güneş Spor Kulübü Şampiyonluk Yemeği', '2026-06-30 19:00', '2026-06-08 13:45', N'Düşük', N'Takım şampiyonluk kutlaması, kalabalık masa düzeni.', N'Tamamlandı', 28, N'serkan.gunes@gunesspor.com'),
(N'Aslı Koçak', N'Koçak Ailesi Yıl Dönümü', '2026-07-14 20:30', '2026-06-17 10:05', N'Düşük', N'Evlilik yıl dönümü, romantik masa ve çiçek.', N'Onaylandı', 10, N'asli.kocak@gmail.com'),
(N'Kemal Ekinci', N'Ekinci Lojistik Yıl Sonu', '2026-12-27 20:00', '2026-06-12 16:20', N'Yüksek', N'Yıl sonu personel yemeği, plaket töreni dahil.', N'Onay Bekliyor', 55, N'kemal.ekinci@ekincilojistik.com'),
(N'Sibel Arı', N'Arı Dernek Dayanışma Yemeği', '2026-07-08 18:30', '2026-06-10 14:50', N'Orta', N'Dernek üyeleri dayanışma yemeği.', N'Onaylandı', 32, N'sibel.ari@dernek.org'),
(N'Gökhan Can', N'Can Ailesi Bayram Yemeği', '2026-07-12 13:00', '2026-06-15 09:30', N'Düşük', N'Geniş aile bayram buluşması.', N'Onay Bekliyor', 22, N'gokhan.can@gmail.com'),
(N'Meltem Usta', N'Usta Mimarlık Proje Kutlaması', '2026-07-19 19:30', '2026-06-16 15:00', N'Orta', N'Proje teslim kutlaması, kurumsal menü.', N'Onaylandı', 20, N'meltem.usta@ustamimarlik.com'),
(N'Orhan Tetik', N'Tetik Ailesi Nişan', '2026-09-05 19:00', '2026-06-13 11:40', N'Yüksek', N'Nişan töreni, sahne ve fotoğrafçı düzeni.', N'Onay Bekliyor', 48, N'orhan.tetik@gmail.com'),
(N'Pelin Bayrak', N'Bayrak Kız İstemesi Yemeği', '2026-07-16 18:00', '2026-06-17 12:15', N'Orta', N'Kız isteme yemeği, sade ve şık düzen.', N'Onaylandı', 15, N'pelin.bayrak@gmail.com'),
(N'Cihan Bozkurt', N'Bozkurt İnşaat Açılış Daveti', '2026-07-28 20:00', '2026-06-14 10:25', N'Yüksek', N'Şube açılış daveti, kokteyl ve ikram.', N'Onay Bekliyor', 42, N'cihan.bozkurt@bozkurtinsaat.com'),
(N'Zeliha Polat', N'Polat Kızlar Buluşması', '2026-07-11 17:30', '2026-06-09 16:45', N'Düşük', N'Arkadaş grubu buluşması, tatlı ağırlıklı menü.', N'Tamamlandı', 9, N'zeliha.polat@gmail.com'),
(N'Taner Özkan', N'Özkan Ailesi Geniş Aile Yemeği', '2026-08-09 13:30', '2026-06-16 09:55', N'Orta', N'Geniş aile buluşması, çocuklu masa düzeni.', N'Onay Bekliyor', 34, N'taner.ozkan@gmail.com'),
(N'Gamze Akyüz', N'Akyüz & Demir Söz Töreni', '2026-09-18 19:00', '2026-06-12 14:00', N'Yüksek', N'Söz töreni organizasyonu, özel pasta.', N'Onaylandı', 26, N'gamze.akyuz@gmail.com'),
(N'Halil Sarı', N'Sarı Tekstil Departman Yemeği', '2026-07-23 19:30', '2026-06-15 13:20', N'Orta', N'Departman motivasyon yemeği.', N'İptal Edildi', 24, N'halil.sari@saritekstil.com'),
(N'Ceyda Acar', N'Acar Reklam Ajansı Lansman', '2026-08-06 20:00', '2026-06-17 11:00', N'Yüksek', N'Ürün lansman daveti, basın ve davetli ağırlama.', N'Onay Bekliyor', 65, N'ceyda.acar@acarreklam.com'),
(N'Arda İnce', N'İnce Ailesi Doğum Günü', '2026-07-13 18:30', '2026-06-10 10:10', N'Düşük', N'Çocuk doğum günü, animasyon ve çocuk menüsü.', N'Onaylandı', 20, N'arda.ince@gmail.com'),
(N'Songül Kaya', N'Kaya Okulu Öğretmenler Yemeği', '2026-06-27 19:00', '2026-06-08 15:30', N'Orta', N'Dönem sonu öğretmenler yemeği.', N'Tamamlandı', 30, N'songul.kaya@kayaokul.k12.tr'),
(N'Ferhat Demirtaş', N'Demirtaş Ailesi Asker Uğurlaması', '2026-07-06 13:00', '2026-06-14 12:40', N'Düşük', N'Asker uğurlama yemeği, geniş masa.', N'Onay Bekliyor', 28, N'ferhat.demirtas@gmail.com'),
(N'Müge Şen', N'Şen Kozmetik Bayi Buluşması', '2026-07-30 19:30', '2026-06-16 14:15', N'Yüksek', N'Bayi tanıtım ve ödül töreni.', N'Onaylandı', 36, N'muge.sen@senkozmetik.com'),
(N'Alper Güven', N'Güven Ailesi Akika Yemeği', '2026-07-17 13:30', '2026-06-13 09:20', N'Düşük', N'Akika organizasyonu, geleneksel ikram.', N'Onay Bekliyor', 18, N'alper.guven@gmail.com'),
(N'Nilay Güneş', N'Güneş & Kara Düğün Provası', '2026-09-01 20:00', '2026-06-15 16:35', N'Orta', N'Düğün provası yemeği, yakın aile.', N'Onaylandı', 14, N'nilay.gunes@gmail.com'),
(N'Taylan Yavuz', N'Yavuz Yazılım Sprint Kutlaması', '2026-07-20 20:30', '2026-06-17 13:50', N'Düşük', N'Proje sprint kutlaması, ekip yemeği.', N'Onay Bekliyor', 16, N'taylan.yavuz@yavuzyazilim.com'),
(N'Yusuf Erdem', N'Erdem Holding Yönetim Yemeği', '2026-08-11 20:00', '2026-06-12 11:05', N'Yüksek', N'Üst yönetim akşam yemeği, VIP salon.', N'Onaylandı', 12, N'yusuf.erdem@erdemholding.com'),
(N'Selma Karahan', N'Karahan Ailesi Aile Toplantısı', '2026-07-15 18:00', '2026-06-16 10:50', N'Orta', N'Aile büyükleri onuruna yemek.', N'Onay Bekliyor', 27, NULL),
(N'İsmail Tetik', N'Tetik Lokal Esnaf Yemeği', '2026-06-29 19:00', '2026-06-09 14:25', N'Düşük', N'Esnaf dayanışma yemeği.', N'Tamamlandı', 33, N'ismail.tetik@gmail.com'),
(N'Ebru Yıldırım', N'Yıldırım Ailesi Sünnet', '2026-08-23 13:00', '2026-06-14 17:10', N'Yüksek', N'Sünnet düğünü, çocuk eğlence alanı talebi.', N'Onay Bekliyor', 52, NULL);

COMMIT TRANSACTION;

SELECT COUNT(*) AS ToplamKayit FROM GroupReservations;
SELECT TOP 5 GroupReservationId, ResponsibleCustomerName, GroupTitle, ReservationStatus, PersonCount FROM GroupReservations ORDER BY GroupReservationId;
