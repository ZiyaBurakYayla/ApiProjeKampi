SET NOCOUNT ON;
SET XACT_ABORT ON;
BEGIN TRANSACTION;

/* ===== CHEFS (eksik 'aa' olanlar) — kare 600x600 portre (tema chefs-1.jpg ile aynı) ===== */
;WITH chefImg(ChefId, Url) AS (
  SELECT * FROM (VALUES
    (6,  N'https://images.pexels.com/photos/6050329/pexels-photo-6050329.jpeg?auto=compress&cs=tinysrgb&fit=crop&w=600&h=600'),   -- Ahmet Kaya  (kıdemli baş şef)
    (7,  N'https://images.pexels.com/photos/3983667/pexels-photo-3983667.jpeg?auto=compress&cs=tinysrgb&fit=crop&w=600&h=600'),   -- Elif Demir  (pasta süsleyen pastane şefi)
    (8,  N'https://images.pexels.com/photos/8629122/pexels-photo-8629122.jpeg?auto=compress&cs=tinysrgb&fit=crop&w=600&h=600'),   -- Mehmet Yıldız (ızgara ustası)
    (9,  N'https://images.pexels.com/photos/10432622/pexels-photo-10432622.jpeg?auto=compress&cs=tinysrgb&fit=crop&w=600&h=600'), -- Selin Arslan (vejetaryen şef)
    (10, N'https://images.pexels.com/photos/6036009/pexels-photo-6036009.jpeg?auto=compress&cs=tinysrgb&fit=crop&w=600&h=600')    -- Canan Yüce  (deniz ürünleri şefi)
  ) v(ChefId, Url)
)
UPDATE c SET c.ImageUrl = ci.Url
FROM Chefs c INNER JOIN chefImg ci ON ci.ChefId = c.ChefId;

/* ===== YUMMYEVENTS (eksik 'aa' olanlar) — yatay 1024x683 (tema events-1.jpg ile aynı) ===== */
;WITH evImg(YummyEventId, Url) AS (
  SELECT * FROM (VALUES
    (7,  N'https://images.pexels.com/photos/34106025/pexels-photo-34106025.jpeg?auto=compress&cs=tinysrgb&fit=crop&w=1024&h=683'), -- Şefin Özel Gecesi (fine dining tadım)
    (8,  N'https://images.pexels.com/photos/2724670/pexels-photo-2724670.jpeg?auto=compress&cs=tinysrgb&fit=crop&w=1024&h=683'),    -- Canlı Müzik Akşamı
    (9,  N'https://images.pexels.com/photos/8473176/pexels-photo-8473176.jpeg?auto=compress&cs=tinysrgb&fit=crop&w=1024&h=683'),    -- Şarap & Peynir Tadımı
    (10, N'https://images.pexels.com/photos/19763210/pexels-photo-19763210.jpeg?auto=compress&cs=tinysrgb&fit=crop&w=1024&h=683'),  -- Sevgililer Günü Menüsü
    (11, N'https://images.pexels.com/photos/253580/pexels-photo-253580.jpeg?auto=compress&cs=tinysrgb&fit=crop&w=1024&h=683'),      -- Kahvaltı Brunch Etkinliği
    (12, N'https://images.pexels.com/photos/5610322/pexels-photo-5610322.jpeg?auto=compress&cs=tinysrgb&fit=crop&w=1024&h=683'),    -- Doğum Günü Organizasyonu
    (13, N'https://images.pexels.com/photos/4339864/pexels-photo-4339864.jpeg?auto=compress&cs=tinysrgb&fit=crop&w=1024&h=683'),    -- İş Yemeği & Toplantı
    (14, N'https://images.pexels.com/photos/36089024/pexels-photo-36089024.jpeg?auto=compress&cs=tinysrgb&fit=crop&w=1024&h=683'),  -- Ramazan İftarı
    (15, N'https://images.pexels.com/photos/3171815/pexels-photo-3171815.jpeg?auto=compress&cs=tinysrgb&fit=crop&w=1024&h=683'),    -- Yılbaşı Özel Programı
    (16, N'https://images.pexels.com/photos/15029824/pexels-photo-15029824.jpeg?auto=compress&cs=tinysrgb&fit=crop&w=1024&h=683')   -- Dünya Mutfağı Haftası
  ) v(YummyEventId, Url)
)
UPDATE e SET e.ImageUrl = ei.Url
FROM YummyEvents e INNER JOIN evImg ei ON ei.YummyEventId = e.YummyEventId;

COMMIT TRANSACTION;

SELECT 'CHEF' AS Tip, ChefId AS Id, NameSurname AS Ad, ImageUrl FROM Chefs WHERE ChefId BETWEEN 6 AND 10
UNION ALL
SELECT 'EVENT', YummyEventId, Title, ImageUrl FROM YummyEvents WHERE YummyEventId BETWEEN 7 AND 16
ORDER BY Tip, Id;
