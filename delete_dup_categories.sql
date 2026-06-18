SET NOCOUNT ON;
SET XACT_ABORT ON;
BEGIN TRANSACTION;

/* Mükerrer kategori isimlerinden, BOŞ (ürünü olmayan) olanı sil;
   AMA yalnızca aynı isimde ÜRÜNÜ OLAN bir kategori varsa (ürünlü olanı koru).
   Mükerrer olmayan boş kategorilere dokunma. */
DELETE c
OUTPUT N'SILINDI' AS Islem, DELETED.CategoryId, DELETED.CategoryName
FROM Categories c
WHERE NOT EXISTS (SELECT 1 FROM Products p WHERE p.CategoryId = c.CategoryId)          -- bu kategori boş
  AND EXISTS (SELECT 1 FROM Categories c2
              WHERE c2.CategoryName = c.CategoryName
                AND c2.CategoryId <> c.CategoryId
                AND EXISTS (SELECT 1 FROM Products p2 WHERE p2.CategoryId = c2.CategoryId)); -- aynı isimde ürünlü ikiz var

COMMIT TRANSACTION;

SELECT c.CategoryId, c.CategoryName, COUNT(p.ProductId) AS UrunSayisi
FROM Categories c LEFT JOIN Products p ON p.CategoryId = c.CategoryId
GROUP BY c.CategoryId, c.CategoryName
ORDER BY c.CategoryName, c.CategoryId;
