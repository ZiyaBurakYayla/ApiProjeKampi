# 🍽️ ApiProjeKampı — Yummy Restoran Yönetim Sistemi

**Yummy**, bir restoranın hem **tanıtım web sitesini** hem de **yönetim panelini** (admin) içeren, yapay zeka destekli bir restoran yönetim sistemidir. Proje; ürün/kategori, rezervasyon, grup rezervasyonu, etkinlik, şef, galeri, müşteri yorumu, iletişim ve mesaj kutusu gibi tüm restoran operasyonlarını tek çatı altında toplar.

Projenin öne çıkan tarafı, klasik CRUD işlemlerinin ötesinde **operasyonel süreçlere gömülü yapay zeka kullanımıdır**: müşteri mesajlarına otomatik yanıt üretme, gelen mesajları toksiklik açısından denetleme, malzemeye göre yemek tarifi önerme ve gerçek zamanlı akan (streaming) bir yapay zeka sohbet asistanı.

---

## 🧱 Mimari

Çözüm iki ana projeden oluşur:

| Proje | Rol |
|-------|-----|
| **ApiProjeKampi.WebApi** | RESTful API katmanı. EF Core (Code-First) ile SQL Server üzerinde tüm veriyi yönetir; AutoMapper ile DTO eşlemesi, FluentValidation ile doğrulama yapar. Swagger ile dokümante edilir. |
| **ApiProjeKampi.WebUI** | ASP.NET Core MVC sunum katmanı. İki yüzü vardır: ziyaretçilere açık **Yummy tanıtım sitesi** ve yöneticilere özel **admin paneli**. Veriyi doğrudan değil, `IHttpClientFactory` üzerinden WebApi'yi tüketerek alır. |

WebUI; ana sayfadaki her bölümü (hero, hakkımızda, menü, şefler, etkinlikler, galeri, yorumlar, iletişim, footer) ayrı **ViewComponent**'ler aracılığıyla API'den besler. Tüm yapay zeka yetenekleri WebUI tarafında konumlanır.

---

## 🛠️ Teknolojiler

- **.NET 8 / ASP.NET Core** — Web API + MVC
- **Entity Framework Core** (Code-First, Migrations) + **SQL Server**
- **AutoMapper** — Entity ↔ DTO eşlemesi
- **FluentValidation** — iş kuralı doğrulamaları
- **SignalR** — gerçek zamanlı, akan (token-by-token) AI sohbeti
- **OpenAI API** (GPT-3.5-turbo) — üretken yapay zeka
- **Hugging Face Inference API** — çeviri ve toksiklik sınıflandırma modelleri
- **Swagger / OpenAPI** — API dokümantasyonu
- **Bootstrap tabanlı temalar** — modern tanıtım sitesi ve modern admin paneli

---

## 🤖 Yapay Zeka Entegrasyonları

Projenin kalbi burasıdır. Yapay zeka, "gösteri amaçlı" bir eklenti değil; **müşteri iletişimi, içerik üretimi ve içerik denetimi** gibi gerçek iş akışlarına gömülmüştür. Birden fazla sağlayıcı (OpenAI, Hugging Face) ve birden fazla model, farklı amaçlarla birlikte kullanılır.

### 1) 🧑‍🍳 Malzemeye Göre AI Yemek Tarifi Önerisi
**Model:** OpenAI `gpt-3.5-turbo` · **Konum:** `AIController.CreateRecipeWithOpenAI`

Yönetici, elindeki malzemeleri serbest metin olarak girer; sistem bunu bir **sistem rolü** (restoran için tarif öneren bir asistan) eşliğinde OpenAI sohbet tamamlama uç noktasına gönderir ve dönen tarifi panelde gösterir. `temperature = 0.5` ile tutarlı ama yaratıcı öneriler hedeflenir. Menü geliştirme ve "elimizdeki malzemeyle ne yapabiliriz?" senaryoları için kullanılır.

### 2) ✉️ Müşteri Mesajlarına Otomatik AI Yanıtı
**Model:** OpenAI `gpt-3.5-turbo` · **Konum:** `MessageController.AsnwerMessageWithOpenAI`

Gelen kutusundaki bir müşteri mesajı "Mesajı Aç" ile açıldığında, mesaj içeriği API'den çekilip OpenAI'a iletilir. Sistem promptu, modeli **"restoran adına gelen mesajlara olabildiğince olumlu, samimi ve mantıklı yanıtlar üreten bir asistan"** olarak konumlandırır. Üretilen taslak yanıt yöneticiye sunulur; böylece müşteri iletişimi hızlanır ve tonu standartlaşır.

### 3) 💬 Gerçek Zamanlı (Streaming) AI Sohbet Asistanı
**Teknoloji:** SignalR + OpenAI streaming · **Konum:** `Models/ChatHub.cs`, `ChatController.SendChatWithAI`

`/chathub` uç noktasına bağlı bir **SignalR Hub** üzerinden çalışan, cevabı **kelime kelime akıtan** (token-by-token) bir sohbet asistanıdır:

- Her bağlantı (`ConnectionId`) için ayrı bir **konuşma geçmişi** tutulur; böylece asistan bağlamı korur.
- OpenAI'a `stream = true` ile istek atılır; gelen `data:` parçaları (chunk) anlık olarak ayrıştırılıp `ReceiveToken` olayıyla istemciye gönderilir.
- Yanıt tamamlanınca tam metin geçmişe eklenir ve `CompleteMessage` ile bildirilir; bağlantı koptuğunda geçmiş temizlenir.

Bu yapı, sayfayı yenilemeden, "yazıyor..." hissi veren akıcı bir sohbet deneyimi sağlar.

### 4) 🛡️ Toksik Mesaj Denetimi (Çok Adımlı AI Pipeline)
**Modeller:** Hugging Face `Helsinki-NLP/opus-mt-tr-en` + `unitary/toxic-bert` · **Konum:** `MessageController.SendMessage`

Bu, projenin en dikkat çekici yapay zeka akışıdır. Ziyaretçi siteden bir mesaj gönderdiğinde, mesaj kaydedilmeden önce **otomatik içerik denetiminden** geçer:

1. **Çeviri:** Mesaj Türkçe yazıldığı için önce `Helsinki-NLP/opus-mt-tr-en` modeliyle **TR → EN** çevrilir (toksiklik modeli İngilizce çalıştığından).
2. **Toksiklik sınıflandırma:** İngilizce metin `unitary/toxic-bert` modeline gönderilir; model her etiket için bir skor döndürür.
3. **Karar:** Herhangi bir etiketin skoru **0.5'in üzerindeyse** mesajın durumu `"Toksik Mesaj"` olarak işaretlenir; aksi halde `"Mesaj Alındı"` olur. Hata durumunda güvenli bir varsayılana düşülür.

Böylece zararlı/uygunsuz mesajlar, insan müdahalesi olmadan otomatik olarak etiketlenir ve önceliklendirilir.

### 5) 🧠 Dashboard AI Paneli (Claude AI)
**Konum:** `_DashboardClaudeAIComponentPartial`

Yönetim panelinin gösterge tablosunda, yapay zeka asistanına ayrılmış bir **Claude AI** bileşeni yer alır; yöneticinin panelden ayrılmadan yapay zekayla etkileşime geçebileceği bir alan olarak tasarlanmıştır.

### Özet — Kullanılan Modeller ve Amaçları

| Amaç | Sağlayıcı / Model | Tür |
|------|-------------------|-----|
| Yemek tarifi önerisi | OpenAI · gpt-3.5-turbo | Üretken metin |
| Mesaja otomatik yanıt | OpenAI · gpt-3.5-turbo | Üretken metin |
| Dinamik Dashboard Chart | OpenAI · gpt-4.o-mini | Üretken metin |
| Akan sohbet asistanı | OpenAI · gpt-3.5-turbo (stream) | Üretken metin (SignalR) |
| Dil çevirisi (TR→EN) | Hugging Face · Helsinki-NLP/opus-mt-tr-en | Çeviri |
| Toksiklik denetimi | Hugging Face · unitary/toxic-bert | Sınıflandırma |

> API anahtarları yapılandırmadan (`OpenAI:ApiKey`, `HuggingFace:ApiKey`) okunur ve istek başlıklarına eklenir.

---

## ✨ Özellikler

**Tanıtım sitesi (Yummy):** Dinamik hero/öne çıkan alan, hakkımızda + tanıtım videosu, kategoriye göre sayfalanan menü, şef kadrosu (sayfalama ile), etkinlik kayıtları, görsel galeri (swiper), müşteri yorumları, dinamik iletişim bilgileri ve haritalı iletişim, online rezervasyon ve mesaj formu.

**Yönetim paneli (Admin):** Tüm varlıklar için liste + ekle/güncelle/sil işlemleri, rezervasyon durum yönetimi (Onayla / Beklet / İptal), grup rezervasyonları yönetimi (detay popup + tam liste), gelen mesaj kutusu, galeri yönetimi ve istatistik/grafik içeren dashboard. Panel, tutarlı ve modern bir kart/tablo tasarım diline sahiptir.

---

## 🗂️ Veri Modeli (Entity'ler)

`Category` · `Product` · `Chef` · `Feature` · `Image` · `Message` · `Reservation` · `GroupReservation` · `Service` · `Testimonial` · `YummyEvent` · `Notification` · `About` · `Contact` · `EmployeeTask` · `EmployeeTaskChef`

Her varlık; ilgili **Entity → DTO** dönüşümleriyle (AutoMapper) ve `api/[controller]` desenindeki RESTful uç noktalarıyla yönetilir.

-----

![](https://raw.githubusercontent.com/ZiyaBurakYayla/ApiProjeKampi/refs/heads/Default/ApiProjeKampi.WebUI/Images/Ekran%20g%C3%B6r%C3%BCnt%C3%BCs%C3%BC%202026-06-18%20150406.png)
![](https://raw.githubusercontent.com/ZiyaBurakYayla/ApiProjeKampi/refs/heads/Default/ApiProjeKampi.WebUI/Images/Ekran%20g%C3%B6r%C3%BCnt%C3%BCs%C3%BC%202026-06-18%20150423.png)
![](https://raw.githubusercontent.com/ZiyaBurakYayla/ApiProjeKampi/refs/heads/Default/ApiProjeKampi.WebUI/Images/Ekran%20g%C3%B6r%C3%BCnt%C3%BCs%C3%BC%202026-06-18%20150438.png)
![](https://raw.githubusercontent.com/ZiyaBurakYayla/ApiProjeKampi/refs/heads/Default/ApiProjeKampi.WebUI/Images/Ekran%20g%C3%B6r%C3%BCnt%C3%BCs%C3%BC%202026-06-18%20150449.png)
![](https://raw.githubusercontent.com/ZiyaBurakYayla/ApiProjeKampi/refs/heads/Default/ApiProjeKampi.WebUI/Images/Ekran%20g%C3%B6r%C3%BCnt%C3%BCs%C3%BC%202026-06-18%20150503.png)
![](https://raw.githubusercontent.com/ZiyaBurakYayla/ApiProjeKampi/refs/heads/Default/ApiProjeKampi.WebUI/Images/Ekran%20g%C3%B6r%C3%BCnt%C3%BCs%C3%BC%202026-06-18%20150514.png)
![](https://raw.githubusercontent.com/ZiyaBurakYayla/ApiProjeKampi/refs/heads/Default/ApiProjeKampi.WebUI/Images/Ekran%20g%C3%B6r%C3%BCnt%C3%BCs%C3%BC%202026-06-18%20150624.png)
![](https://raw.githubusercontent.com/ZiyaBurakYayla/ApiProjeKampi/refs/heads/Default/ApiProjeKampi.WebUI/Images/Ekran%20g%C3%B6r%C3%BCnt%C3%BCs%C3%BC%202026-06-18%20150632.png)
![](https://raw.githubusercontent.com/ZiyaBurakYayla/ApiProjeKampi/refs/heads/Default/ApiProjeKampi.WebUI/Images/Ekran%20g%C3%B6r%C3%BCnt%C3%BCs%C3%BC%202026-06-18%20150920.png)
![](https://raw.githubusercontent.com/ZiyaBurakYayla/ApiProjeKampi/refs/heads/Default/ApiProjeKampi.WebUI/Images/Ekran%20g%C3%B6r%C3%BCnt%C3%BCs%C3%BC%202026-06-18%20151229.png)
![](https://raw.githubusercontent.com/ZiyaBurakYayla/ApiProjeKampi/refs/heads/Default/ApiProjeKampi.WebUI/Images/Ekran%20g%C3%B6r%C3%BCnt%C3%BCs%C3%BC%202026-06-18%20150818.png)
![](https://raw.githubusercontent.com/ZiyaBurakYayla/ApiProjeKampi/refs/heads/Default/ApiProjeKampi.WebUI/Images/Ekran%20g%C3%B6r%C3%BCnt%C3%BCs%C3%BC%202026-06-18%20150826.png)
![](https://raw.githubusercontent.com/ZiyaBurakYayla/ApiProjeKampi/refs/heads/Default/ApiProjeKampi.WebUI/Images/Ekran%20g%C3%B6r%C3%BCnt%C3%BCs%C3%BC%202026-06-18%20150640.png)
![](https://raw.githubusercontent.com/ZiyaBurakYayla/ApiProjeKampi/refs/heads/Default/ApiProjeKampi.WebUI/Images/Ekran%20g%C3%B6r%C3%BCnt%C3%BCs%C3%BC%202026-06-18%20150714.png)
![](https://raw.githubusercontent.com/ZiyaBurakYayla/ApiProjeKampi/refs/heads/Default/ApiProjeKampi.WebUI/Images/Ekran%20g%C3%B6r%C3%BCnt%C3%BCs%C3%BC%202026-06-18%20150847.png)
![](https://raw.githubusercontent.com/ZiyaBurakYayla/ApiProjeKampi/refs/heads/Default/ApiProjeKampi.WebUI/Images/Ekran%20g%C3%B6r%C3%BCnt%C3%BCs%C3%BC%202026-06-18%20151207.png)
![](https://raw.githubusercontent.com/ZiyaBurakYayla/ApiProjeKampi/refs/heads/Default/ApiProjeKampi.WebUI/Images/Ekran%20g%C3%B6r%C3%BCnt%C3%BCs%C3%BC%202026-06-18%20150714.png)
