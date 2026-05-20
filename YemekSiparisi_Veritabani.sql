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
