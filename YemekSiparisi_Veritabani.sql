-- 1. MUSTERILER TABLOSU
CREATE TABLE Musteriler (
    MusteriID INT IDENTITY(1,1) PRIMARY KEY,
    Ad NVARCHAR(50) NOT NULL,
    Soyad NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    Telefon NVARCHAR(15) UNIQUE NOT NULL,
    IsIhtiyacSahibi BIT DEFAULT 0,
    IsActive BIT DEFAULT 1
);

-- 2. RESTORANLAR TABLOSU
CREATE TABLE Restoranlar (
    RestoranID INT IDENTITY(1,1) PRIMARY KEY,
    Ad NVARCHAR(100) NOT NULL,
    Adres NVARCHAR(255),
    Puan TINYINT CHECK (Puan BETWEEN 1 AND 5),
    IsActive BIT DEFAULT 1
);

-- 3. KURYELER TABLOSU
CREATE TABLE Kuryeler (
    KuryeID INT IDENTITY(1,1) PRIMARY KEY,
    Ad NVARCHAR(50) NOT NULL,
    Soyad NVARCHAR(50) NOT NULL,
    Telefon NVARCHAR(15) UNIQUE NOT NULL,
    Plaka NVARCHAR(20) UNIQUE,
    IsActive BIT DEFAULT 1
);

-- 4. MENULER TABLOSU
CREATE TABLE Menuler (
    UrunID INT IDENTITY(1,1) PRIMARY KEY,
    RestoranID INT FOREIGN KEY REFERENCES Restoranlar(RestoranID),
    UrunAdi NVARCHAR(100) NOT NULL,
    Fiyat DECIMAL(10, 2) CHECK (Fiyat > 0),
    IsActive BIT DEFAULT 1
);

-- 5. SIPARISLER TABLOSU
CREATE TABLE Siparisler (
    SiparisID INT IDENTITY(1,1) PRIMARY KEY,
    MusteriID INT FOREIGN KEY REFERENCES Musteriler(MusteriID),
    RestoranID INT FOREIGN KEY REFERENCES Restoranlar(RestoranID),
    KuryeID INT NULL FOREIGN KEY REFERENCES Kuryeler(KuryeID),
    ToplamTutar DECIMAL(10, 2) CHECK (ToplamTutar > 0),
    SiparisTarihi DATETIME DEFAULT GETDATE(),
    Durum NVARCHAR(50) DEFAULT 'Hazırlanıyor'
);

-- 6. SIPARIS DETAYLARI TABLOSU
CREATE TABLE SiparisDetaylari (
    DetayID INT IDENTITY(1,1) PRIMARY KEY,
    SiparisID INT FOREIGN KEY REFERENCES Siparisler(SiparisID),
    UrunID INT FOREIGN KEY REFERENCES Menuler(UrunID),
    Adet INT CHECK (Adet > 0),
    BirimFiyat DECIMAL(10, 2) CHECK (BirimFiyat > 0)
);


-- 7. ASKIDA YEMEK HAVUZU TABLOSU
CREATE TABLE AskidaYemekHavuzu (
    HavuzID INT IDENTITY(1,1) PRIMARY KEY,
    BagisciMusteriID INT NULL FOREIGN KEY REFERENCES Musteriler(MusteriID),
    BagisTuru NVARCHAR(20) CHECK (BagisTuru IN ('Bakiye', 'Yemek')),
    ToplamTutar DECIMAL(10, 2) CHECK (ToplamTutar > 0),
    KalanBakiye DECIMAL(10, 2) CHECK (KalanBakiye >= 0),
    BagisTarihi DATETIME DEFAULT GETDATE()
);

-- 8. ASKIDA YEMEK KULLANIMLARI TABLOSU
CREATE TABLE AskidaYemekKullanimlari (
    KullanimID INT IDENTITY(1,1) PRIMARY KEY,
    IhtiyacSahibiMusteriID INT FOREIGN KEY REFERENCES Musteriler(MusteriID),
    HavuzID INT FOREIGN KEY REFERENCES AskidaYemekHavuzu(HavuzID),
    KullanilanTutar DECIMAL(10, 2) CHECK (KullanilanTutar > 0),
    KullanimTarihi DATETIME DEFAULT GETDATE()
);

-- Musteriler Tablosuna 20 Adet Veri
INSERT INTO Musteriler (Ad, Soyad, Email, Telefon, IsIhtiyacSahibi)
VALUES 
('Ahmet', 'Yılmaz', 'ahmet.yilmaz@email.com', '05320000001', 0), ('Ayşe', 'Kaya', 'ayse.kaya@email.com', '05320000002', 1),
('Mehmet', 'Demir', 'mehmet.demir@email.com', '05320000003', 0), ('Fatma', 'Çelik', 'fatma.celik@email.com', '05320000004', 1),
('Mustafa', 'Şahin', 'mustafa.sahin@email.com', '05320000005', 0), ('Emine', 'Öztürk', 'emine.ozturk@email.com', '05320000006', 1),
('Ali', 'Yıldız', 'ali.yildiz@email.com', '05320000007', 0), ('Hatice', 'Doğan', 'hatice.dogan@email.com', '05320000008', 0),
('Hasan', 'Aydın', 'hasan.aydin@email.com', '05320000009', 1), ('Zeynep', 'Erdoğan', 'zeynep.erdogan@email.com', '05320000010', 0),
('İbrahim', 'Arslan', 'ibrahim.arslan@email.com', '05320000011', 0), ('Elif', 'Yavuz', 'elif.yavuz@email.com', '05320000012', 1),
('Hüseyin', 'Kılıç', 'huseyin.kilic@email.com', '05320000013', 0), ('Merve', 'Koç', 'merve.koc@email.com', '05320000014', 1),
('İsmail', 'Gök', 'ismail.gok@email.com', '05320000015', 0), ('Esra', 'Turan', 'esra.turan@email.com', '05320000016', 0),
('Osman', 'Güneş', 'osman.gunes@email.com', '05320000017', 1), ('Büşra', 'Yetiş', 'busra.yetis@email.com', '05320000018', 0),
('Murat', 'Çetin', 'murat.cetin@email.com', '05320000019', 1), ('Deniz', 'Bozkurt', 'deniz.bozkurt@email.com', '05320000020', 0);

-- Restoranlar Tablosuna 5 Adet Veri
INSERT INTO Restoranlar (Ad, Adres, Puan)
VALUES 
('Lezzet Sofrası Ev Yemekleri', 'Kadıköy, İstanbul', 4), ('Tarihi Merkez Kebapçısı', 'Fatih, İstanbul', 5),
('Burger Durağı', 'Beşiktaş, İstanbul', 4), ('Ege Balık Evi', 'Üsküdar, İstanbul', 5),
('Tatlı Rüyalar Pastanesi', 'Şişli, İstanbul', 5);

-- Kuryeler Tablosuna 5 Adet Veri
INSERT INTO Kuryeler (Ad, Soyad, Telefon, Plaka)
VALUES 
('Cem', 'Yılmaz', '05550000001', '34 ABC 001'), ('Burak', 'Kaya', '05550000002', '34 ABC 002'),
('Kaan', 'Demir', '05550000003', '34 ABC 003'), ('Tolga', 'Şahin', '05550000004', '34 ABC 004'),
('Oğuz', 'Çelik', '05550000005', '34 ABC 005');

-- Menuler Tablosuna 50 Adet Veri
INSERT INTO Menuler (RestoranID, UrunAdi, Fiyat)
VALUES 
(1, 'Mercimek Çorbası', 45.00), (1, 'Ezogelin Çorbası', 45.00), (1, 'Kuru Fasulye', 90.00), (1, 'Nohut Yemeği', 85.00), (1, 'Tereyağlı Pilav', 50.00),
(1, 'Bulgur Pilavı', 45.00), (1, 'İzmir Köfte', 140.00), (1, 'Fırın Makarna', 80.00), (1, 'Cacık', 35.00), (1, 'Sütlaç', 60.00),
(2, 'Adana Kebap', 220.00), (2, 'Urfa Kebap', 220.00), (2, 'Beyti Sarma', 260.00), (2, 'Ali Nazik', 240.00), (2, 'Kuşbaşı Pide', 180.00),
(2, 'Lahmacun', 60.00), (2, 'İçli Köfte', 50.00), (2, 'Gavurdağı Salatası', 90.00), (2, 'Künefe', 120.00), (2, 'Ayran', 30.00),
(3, 'Klasik Burger', 160.00), (3, 'Cheeseburger', 180.00), (3, 'Mushroom Burger', 190.00), (3, 'Barbekü Burger', 185.00), (3, 'Tavuk Burger', 140.00),
(3, 'Patates Kızartması', 60.00), (3, 'Soğan Halkası', 50.00), (3, 'Nugget', 70.00), (3, 'Kutu Kola', 35.00), (3, 'Sufle', 90.00),
(4, 'Çipura Izgara', 250.00), (4, 'Levrek Izgara', 260.00), (4, 'Hamsi Tava', 180.00), (4, 'İstavrit Tava', 170.00), (4, 'Kalamar Tava', 210.00),
(4, 'Karides Güveç', 240.00), (4, 'Midye Dolma', 70.00), (4, 'Roka Salatası', 80.00), (4, 'Şalgam Suyu', 30.00), (4, 'Fırın Helva', 85.00),
(5, 'Profiterol', 110.00), (5, 'Trileçe', 95.00), (5, 'Tiramisu', 120.00), (5, 'San Sebastian Cheesecake', 140.00), (5, 'Orman Meyveli Pasta', 130.00),
(5, 'Mozaik Pasta', 70.00), (5, 'Makaron', 150.00), (5, 'Filtre Kahve', 60.00), (5, 'Türk Kahvesi', 50.00), (5, 'Çay', 20.00);

-- AskidaYemekHavuzu ve Kullanım Tablolarına Veri Eklenmesi
INSERT INTO AskidaYemekHavuzu (BagisciMusteriID, BagisTuru, ToplamTutar, KalanBakiye)
VALUES 
(1, 'Bakiye', 500.00, 500.00), (NULL, 'Yemek', 180.00, 180.00), (3, 'Yemek', 220.00, 220.00),
(NULL, 'Bakiye', 1000.00, 1000.00), (5, 'Yemek', 480.00, 480.00), (7, 'Bakiye', 250.00, 250.00),
(NULL, 'Yemek', 360.00, 360.00), (10, 'Yemek', 550.00, 550.00), (11, 'Bakiye', 750.00, 750.00),

    -- Siparisler ve SiparisDetaylari Tablolarına 100 Adet Sipariş Eklenmesi
DECLARE @Sayac INT = 1;
DECLARE @RandomMusteriID INT, @RandomRestoranID INT, @RandomKuryeID INT;
DECLARE @RandomUrunID1 INT, @RandomUrunID2 INT;
DECLARE @BirimFiyat1 DECIMAL(10,2), @BirimFiyat2 DECIMAL(10,2);
DECLARE @Adet1 INT, @Adet2 INT;
DECLARE @SiparisTutari DECIMAL(10,2);
DECLARE @EklenenSiparisID INT;

WHILE @Sayac <= 100
BEGIN
    SET @RandomMusteriID = (ABS(CHECKSUM(NEWID())) % 20) + 1;
    SET @RandomRestoranID = (ABS(CHECKSUM(NEWID())) % 5) + 1;
    SET @RandomKuryeID = (ABS(CHECKSUM(NEWID())) % 5) + 1;
    
    SET @RandomUrunID1 = ((@RandomRestoranID - 1) * 10) + (ABS(CHECKSUM(NEWID())) % 10) + 1;
    SET @RandomUrunID2 = ((@RandomRestoranID - 1) * 10) + (ABS(CHECKSUM(NEWID())) % 10) + 1;
    
    SET @Adet1 = (ABS(CHECKSUM(NEWID())) % 3) + 1;
    SET @Adet2 = (ABS(CHECKSUM(NEWID())) % 3) + 1;

    SELECT @BirimFiyat1 = Fiyat FROM Menuler WHERE UrunID = @RandomUrunID1;
    SELECT @BirimFiyat2 = Fiyat FROM Menuler WHERE UrunID = @RandomUrunID2;
    
    IF @RandomUrunID1 = @RandomUrunID2
    BEGIN
        SET @SiparisTutari = (@BirimFiyat1 * @Adet1);
    END
    ELSE
    BEGIN
        SET @SiparisTutari = (@BirimFiyat1 * @Adet1) + (@BirimFiyat2 * @Adet2);
    END

    INSERT INTO Siparisler (MusteriID, RestoranID, KuryeID, ToplamTutar, Durum, SiparisTarihi)
    VALUES (@RandomMusteriID, @RandomRestoranID, @RandomKuryeID, @SiparisTutari, 'Teslim Edildi', DATEADD(day, -(@Sayac % 30), GETDATE()));
    
    SET @EklenenSiparisID = SCOPE_IDENTITY();
    
    INSERT INTO SiparisDetaylari (SiparisID, UrunID, Adet, BirimFiyat)
    VALUES (@EklenenSiparisID, @RandomUrunID1, @Adet1, @BirimFiyat1);

    IF @RandomUrunID1 <> @RandomUrunID2
    BEGIN
        INSERT INTO SiparisDetaylari (SiparisID, UrunID, Adet, BirimFiyat)
        VALUES (@EklenenSiparisID, @RandomUrunID2, @Adet2, @BirimFiyat2);
    END

    SET @Sayac = @Sayac + 1;
END;
GO
(NULL, 'Yemek', 600.00, 600.00);

INSERT INTO AskidaYemekKullanimlari (IhtiyacSahibiMusteriID, HavuzID, KullanilanTutar)
VALUES 
(2, 1, 150.00), (4, 2, 45.00), (6, 4, 300.00), (9, 5, 160.00), (12, 1, 200.00);

-- GÖRÜNÜMLER (VIEWS)
CREATE VIEW vw_AktifRestoranMenuleri AS
SELECT r.Ad AS RestoranAdi, m.UrunAdi, m.Fiyat
FROM Restoranlar r
INNER JOIN Menuler m ON r.RestoranID = m.RestoranID
WHERE r.IsActive = 1 AND m.IsActive = 1;
GO

CREATE VIEW vw_AskidaYemekHavuzDurumu AS
SELECT HavuzID, BagisTuru, ToplamTutar, KalanBakiye, BagisTarihi
FROM AskidaYemekHavuzu
WHERE KalanBakiye > 0;
GO

-- İNDEKSLER (INDEXES)
CREATE NONCLUSTERED INDEX IX_Siparisler_MusteriID ON Siparisler(MusteriID);
GO
CREATE NONCLUSTERED INDEX IX_Menuler_RestoranID ON Menuler(RestoranID);
GO
