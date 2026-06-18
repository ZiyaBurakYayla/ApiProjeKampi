SET NOCOUNT ON;
SET XACT_ABORT ON;
BEGIN TRANSACTION;

/* STANDART: tüm galeri görselleri 800x600 (4:3) — tema galeri görselleriyle (gallery-*.jpg) aynı.
   Her URL'in mevcut sorgu (?...) kısmı atılıp standart kırpma parametreleri eklenir. */
UPDATE Images
SET ImageUrl = LEFT(ImageUrl, CHARINDEX('?', ImageUrl + '?') - 1) + N'?q=80&w=800&h=600&fit=crop';

COMMIT TRANSACTION;

SELECT ImageId, Title, ImageUrl FROM Images ORDER BY ImageId;
