SET NOCOUNT ON;
SET XACT_ABORT ON;
BEGIN TRANSACTION;

/* Mevcut anlamsız kaydı sil, tutarlı tek bir iletişim kaydı gir.
   View her kayıt için bir iletişim bölümü bastığından TEK kayıt tutuyoruz.
   MapLocation = iframe src (geçerli Google Maps embed URL'si).
   OpenHours = Html.Raw ile basıldığı için <br> kullanılabilir. */
DELETE FROM Contacts;

INSERT INTO Contacts (Address, Email, PhoneNo, OpenHours, MapLocation) VALUES
(N'Bağdat Caddesi No:123, Kadıköy / İstanbul',
 N'info@yummyrestoran.com',
 N'+90 212 444 96 69',
 N'Pazartesi - Cuma: 10:00 - 23:00<br>Cumartesi - Pazar: 09:00 - 00:00',
 N'https://www.google.com/maps?q=Kadikoy+Istanbul&output=embed');

COMMIT TRANSACTION;

SELECT ContactId, Address, Email, PhoneNo, OpenHours, MapLocation FROM Contacts;
