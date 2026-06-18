SET NOCOUNT ON;
SET XACT_ABORT ON;

UPDATE Features
SET Title       = N'Sağlıklı ve Lezzetli Tatların',
    SubTitle    = N'Keyfini Çıkarın',
    Description  = N'Usta şeflerimizden özenle hazırlanan özel tarifler.',
    ImageUrl    = N'/yummy-red-1.0.0/assets/img/hero-img.png'
    -- VideoUrl korunuyor (değiştirilmedi)
WHERE FeatureId = 5;

SELECT FeatureId, Title, SubTitle, Description, ImageUrl, VideoUrl FROM Features WHERE FeatureId = 5;
