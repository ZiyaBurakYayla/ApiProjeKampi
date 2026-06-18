SET NOCOUNT ON;
SET XACT_ABORT ON;
BEGIN TRANSACTION;

/* Feature (konsepte uygun restoran görseli + tanıtım videosu) */
UPDATE Features
SET ImageUrl = N'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?auto=format&fit=crop&w=1200&q=80',
    VideoUrl = N'https://www.youtube.com/watch?v=3fp9cnOmBdk'
WHERE FeatureId = 5;

/* About (restoran ambiyans görseli + video kapağı + tanıtım videosu) */
UPDATE Abouts
SET ImageUrl            = N'https://images.unsplash.com/photo-1414235077428-338989a2e8c0?auto=format&fit=crop&w=1200&q=80',
    VideoCoverImageUrl  = N'https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=1200&q=80',
    VideoUrl            = N'https://www.youtube.com/watch?v=MgXXclCbqqs'
WHERE AboutId = 5;

COMMIT TRANSACTION;

SELECT 'Feature' AS Kayit, ImageUrl, VideoUrl, NULL AS VideoCoverImageUrl FROM Features WHERE FeatureId = 5
UNION ALL
SELECT 'About', ImageUrl, VideoUrl, VideoCoverImageUrl FROM Abouts WHERE AboutId = 5;
