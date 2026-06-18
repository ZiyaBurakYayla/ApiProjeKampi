SET NOCOUNT ON;
SET XACT_ABORT ON;
BEGIN TRANSACTION;

/* STANDART: tüm ürün görselleri kare (1:1), ortadan kırpılmış, 600x600.
   Pexels  -> ?auto=compress&cs=tinysrgb&fit=crop&w=600&h=600
   TheMealDB köfte zaten 700x700 kare olduğu için olduğu gibi bırakıldı. */
;WITH img(ProductId, Url) AS (
  SELECT * FROM (VALUES
    (5,  N'https://images.pexels.com/photos/28561583/pexels-photo-28561583.jpeg?auto=compress&cs=tinysrgb&fit=crop&w=600&h=600'),  -- Profiterol
    (6,  N'https://images.pexels.com/photos/4722018/pexels-photo-4722018.jpeg?auto=compress&cs=tinysrgb&fit=crop&w=600&h=600'),    -- Cheesecake
    (7,  N'https://images.pexels.com/photos/1247677/pexels-photo-1247677.jpeg?auto=compress&cs=tinysrgb&fit=crop&w=600&h=600'),    -- Izgara Tavuk
    (8,  N'https://images.pexels.com/photos/1327393/pexels-photo-1327393.jpeg?auto=compress&cs=tinysrgb&fit=crop&w=600&h=600'),    -- Et Sote
    (9,  N'https://images.pexels.com/photos/8251537/pexels-photo-8251537.jpeg?auto=compress&cs=tinysrgb&fit=crop&w=600&h=600'),    -- Sezar Salata
    (10, N'https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&fit=crop&w=600&h=600'),    -- Akdeniz Salata
    (11, N'https://images.pexels.com/photos/6120506/pexels-photo-6120506.jpeg?auto=compress&cs=tinysrgb&fit=crop&w=600&h=600'),    -- Mercimek Çorbası
    (12, N'https://images.pexels.com/photos/17302314/pexels-photo-17302314.jpeg?auto=compress&cs=tinysrgb&fit=crop&w=600&h=600'),  -- Domates Çorbası
    (13, N'https://images.pexels.com/photos/6541793/pexels-photo-6541793.jpeg?auto=compress&cs=tinysrgb&fit=crop&w=600&h=600'),    -- Ev Yapımı Limonata
    (14, N'https://images.pexels.com/photos/28468270/pexels-photo-28468270.jpeg?auto=compress&cs=tinysrgb&fit=crop&w=600&h=600'),  -- Türk Kahvesi
    (15, N'https://images.pexels.com/photos/6275158/pexels-photo-6275158.jpeg?auto=compress&cs=tinysrgb&fit=crop&w=600&h=600'),    -- Falafel Tabağı
    (16, N'https://images.pexels.com/photos/2181151/pexels-photo-2181151.jpeg?auto=compress&cs=tinysrgb&fit=crop&w=600&h=600'),    -- Vejetaryen Güveç
    (17, N'https://images.pexels.com/photos/18543435/pexels-photo-18543435.jpeg?auto=compress&cs=tinysrgb&fit=crop&w=600&h=600'),  -- Serpme Kahvaltı
    (18, N'https://images.pexels.com/photos/9928336/pexels-photo-9928336.jpeg?auto=compress&cs=tinysrgb&fit=crop&w=600&h=600'),    -- Menemen
    (19, N'https://www.themealdb.com/images/media/meals/lgmnff1763789847.jpg'),                                                    -- Izgara Köfte (700x700 kare)
    (20, N'https://images.pexels.com/photos/13304044/pexels-photo-13304044.jpeg?auto=compress&cs=tinysrgb&fit=crop&w=600&h=600'),  -- Kuzu Pirzola
    (21, N'https://images.pexels.com/photos/5463886/pexels-photo-5463886.jpeg?auto=compress&cs=tinysrgb&fit=crop&w=600&h=600'),    -- Izgara Somon
    (22, N'https://images.pexels.com/photos/921367/pexels-photo-921367.jpeg?auto=compress&cs=tinysrgb&fit=crop&w=600&h=600'),      -- Karides Güveç
    (23, N'https://images.pexels.com/photos/1583891/pexels-photo-1583891.jpeg?auto=compress&cs=tinysrgb&fit=crop&w=600&h=600'),    -- Patates Kızartması
    (24, N'https://images.pexels.com/photos/1109195/pexels-photo-1109195.jpeg?auto=compress&cs=tinysrgb&fit=crop&w=600&h=600'),    -- Soğan Halkası
    (25, N'https://images.pexels.com/photos/6287525/pexels-photo-6287525.jpeg?auto=compress&cs=tinysrgb&fit=crop&w=600&h=600'),    -- Spagetti Bolonez
    (26, N'https://images.pexels.com/photos/11220208/pexels-photo-11220208.jpeg?auto=compress&cs=tinysrgb&fit=crop&w=600&h=600'),  -- Fettucini Alfredo
    (27, N'https://images.pexels.com/photos/14590497/pexels-photo-14590497.jpeg?auto=compress&cs=tinysrgb&fit=crop&w=600&h=600'),  -- Margherita Pizza
    (28, N'https://images.pexels.com/photos/27582711/pexels-photo-27582711.jpeg?auto=compress&cs=tinysrgb&fit=crop&w=600&h=600')   -- Karışık Pizza
  ) v(ProductId, Url)
)
UPDATE p SET p.ImageUrl = i.Url
FROM Products p
INNER JOIN img i ON i.ProductId = p.ProductId;

COMMIT TRANSACTION;

SELECT ProductId, ProductName, ImageUrl FROM Products WHERE ProductId BETWEEN 5 AND 28 ORDER BY ProductId;
