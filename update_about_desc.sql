SET NOCOUNT ON;
SET XACT_ABORT ON;

UPDATE Abouts
SET Description = N'Restoranımız, yılların verdiği deneyim ve tutkuyla misafirlerimize sadece yemek değil, aynı zamanda unutulmaz bir deneyim sunmak için kurulmuştur. Sadece lezzet değil, aynı zamanda güven ve şeffaflık da bizim için çok önemli. Hijyen, kalite standartları ve müşteri memnuniyeti, tüm çalışmalarımızın merkezinde yer alır. Restoranımızda geçirdiğiniz her anın, özel bir anı olarak kalmasını istiyoruz. Sevdiklerinizle paylaşacağınız keyifli dakikalar, bizim için en değerli başarıdır. Misafirlerimiz için hazırladığımız menüde, damak zevkine hitap eden farklı tatları bir arada bulacaksınız. Geleneksel mutfağın izlerini taşıyan yemeklerimizin yanında, yenilikçi tariflerimizle de sizi farklı bir yolculuğa çıkarıyoruz. Her lokmada, mutfağımızın emeğini, şeflerimizin ustalığını ve kaliteye verdiğimiz önemi hissedeceksiniz.'
WHERE AboutId = 5;

SELECT AboutId, LEN(Description) AS KarakterSayisi FROM Abouts WHERE AboutId = 5;
