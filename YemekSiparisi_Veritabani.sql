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
