CREATE DATABASE Academia_Atos_ExercicioDinossauros;

USE Academia_Atos_ExercicioDinossauros;

CREATE TABLE Era (
    id INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    ano_inicio INT NOT NULL,
    ano_fim INT NOT NULL
);

CREATE TABLE Grupo (
    id INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    tipo_alimentacao VARCHAR(100) NOT NULL
);

CREATE TABLE Dinossauro (
    id INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    grupo INT NOT NULL,
    toneladas DECIMAL(10, 2) NOT NULL,
    ano_descoberta INT NOT NULL,
    descobridor VARCHAR(100) NOT NULL,
    era_existencia INT NOT NULL,
    pais_descoberta VARCHAR(100) NOT NULL,
    FOREIGN KEY (grupo) REFERENCES Grupo(id),
    FOREIGN KEY (era_existencia) REFERENCES Era(id)
);

INSERT INTO Era (id, nome, ano_inicio, ano_fim) VALUES
    (1, 'Triássico', 251, 200),
    (2, 'Jurássico', 200, 145),
    (3, 'Cretáceo', 145, 65);

INSERT INTO Grupo (id, nome, tipo_alimentacao) VALUES
    (1, 'Anquilossauros', 'Herbívora'),
    (2, 'Ceratopsídeos', 'Herbívora'),
    (3, 'Estegossauros', 'Herbívora'),
    (4, 'Terápodes', 'Carnívora');

INSERT INTO Dinossauro (id, nome, grupo, toneladas, ano_descoberta, descobridor, era_existencia, pais_descoberta) VALUES
    (1, 'Saichania', 1, 4, 1977, 'Maryanska', 3, 'Mongólia'),
    (2, 'Tricerátops', 2, 6, 1887, 'John Bell Hatcher', 3, 'Canadá'),
    (3, 'Kentrossauro', 3, 2, 1909, 'Cientistas Alemães', 2, 'Tanzânia'),
    (4, 'Pinacossauro', 1, 6, 1999, 'Museu Americano de História Natural', 1, 'China'),
    (5, 'Alossauro', 4, 3, 1877, 'Othniel Charles Marsh', 2, 'América do Norte');



DROP TRIGGER IF EXISTS valida_anos_existencia;

GO

IF EXISTS (SELECT * FROM sys.triggers WHERE name = 'valida_anos_existencia')
    DROP TRIGGER valida_anos_existencia;
GO

CREATE TRIGGER valida_anos_existencia
ON Dinossauro
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @era_inicio INT, @era_fim INT;

    SELECT @era_inicio = ano_inicio, @era_fim = ano_fim
    FROM Era
    WHERE nome = (SELECT era_existencia FROM inserted);

    IF (SELECT ano_descoberta FROM inserted) < @era_inicio OR (SELECT ano_descoberta FROM inserted) > @era_fim
    BEGIN
        RAISERROR ('O ano de descoberta está fora do intervalo da era.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END;
END;
GO
