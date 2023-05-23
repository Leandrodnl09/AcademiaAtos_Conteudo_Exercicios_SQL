select livro.isbn, livro.titulo, 
    LIVRO.ano_publicacao, 
    editora.nome as 'Editora', 
    CATEGORIA.tipo_categoria as 'Categoria'
from LIVRO, editora, CATEGORIA
where LIVRO.fk_editora = editora.id
    and livro.fk_categoria = CATEGORIA.id


select livro.isbn, livro.titulo, 
    LIVRO.ano_publicacao, 
    editora.nome as 'Editora', 
    CATEGORIA.tipo_categoria as 'Categoria',
    AUTOR.nome
from LIVRO, editora, CATEGORIA, LIVROAUTOR, AUTOR
where LIVRO.fk_editora = editora.id
    and livro.fk_categoria = CATEGORIA.id
    and LIVROAUTOR.fk_livro = LIVRO.isbn
    and LIVROAUTOR.fk_autor = AUTOR.id
order by AUTOR.nome

select livro.isbn, livro.titulo, 
    LIVRO.ano_publicacao, 
    editora.nome as 'Editora', 
    CATEGORIA.tipo_categoria as 'Categoria',
    AUTOR.nome
from LIVRO, editora, CATEGORIA, LIVROAUTOR, AUTOR
where LIVRO.fk_editora = editora.id
    and livro.fk_categoria = CATEGORIA.id
    and LIVROAUTOR.fk_livro = LIVRO.isbn
    and LIVROAUTOR.fk_autor = AUTOR.id
    and 
    (CATEGORIA.tipo_categoria like '%humor%'
    or CATEGORIA.tipo_categoria like '%fic%fica')
    and 
    YEAR(LIVRO.ano_publicacao) 
            between 2000 and 2010


create table java
(
	professor varchar(20) null
)

create table net
(
	professor varchar(20) null
)

create database AcademiaAtos_Join


insert into net
values ('Fabricio'),('Ricardo'),('Alexandre')

insert into java
values ('Fabricio'),('Lucas'),('Deivison')


select * from net
union 
select * from java


select * from java
inner join net
on java.professor = net.professor


select * from java
left join net
on java.professor = net.professor

select * from java
left join net
on java.professor = net.professor
where net.professor is null

select * from java
right join net
on java.professor = net.professor

select * from java
right join net
on java.professor = net.professor
where net.professor is null

select * from java
full outer join net
on java.professor = net.professor

select * from java
full outer join net
on java.professor = net.professor
where java.professor is null
	or net.professor is null



create table EDITORA
(
    id integer not null primary key identity,
    nome varchar(50) not null
)

 

create table AUTOR
(
    id integer not null primary key identity,
    nome varchar(50) not null,
    nacionalidade varchar(50)
)

 

create table CATEGORIA
(
    id integer not null primary key identity,
    tipo_categoria varchar(50) not null
)

 

create table LIVRO
(
    isbn varchar(50) primary key not null,
    titulo varchar(100) not null,
    ano_publicacao date not null,
    fk_editora integer not null,
    fk_categoria integer not null,
    FOREIGN KEY (fk_editora) REFERENCES EDITORA (id),
    FOREIGN KEY (fk_categoria) REFERENCES CATEGORIA (id)
)

 

create table LIVROAUTOR
(
    id int not null primary key identity,
    fk_livro varchar(50) not null,
    fk_autor integer not null,
    FOREIGN KEY (fk_livro) REFERENCES LIVRO (isbn),
    FOREIGN KEY (fk_autor)    REFERENCES AUTOR (id)
)


/*insert*/
insert into CATEGORIA values('Literatura Juvenil');
insert into CATEGORIA values('Ficção Científica');
insert into CATEGORIA values('Humor');
insert into CATEGORIA values('Horror Cósmico');
select * from CATEGORIA;

 

insert into AUTOR(nome) values('J.K.Rowling');
insert into AUTOR(nome) values('Clive Staples Lewis');
insert into AUTOR(nome) values('Affonso Solano');
insert into AUTOR (nome, nacionalidade) values('Marcos Piangers', 'Brasileira');
insert into AUTOR values('Marcos Piangers', 'Brasileira');
insert into AUTOR(nome) values('Ciro Botelho - Tiririca');
insert into AUTOR(nome) values('Bianca Mól');
select * from AUTOR;

 

insert into EDITORA(nome) values('Rocco');
insert into EDITORA(nome) values('Wmf Martins Fontes');
insert into EDITORA(nome) values('Casa da Palavra');
insert into EDITORA(nome) values('Belas Letras');
insert into EDITORA(nome) values('Matrix');
select *from EDITORA;

 

insert into LIVRO values('8532511015','Harry Potter e A Pedra Filosofal','2000',1,1);
insert into LIVRO values('9788578270698','As Crônicas de Nárnia','2009',1,2);
insert into LIVRO values('9788577343348','O Espadachim de Carvão','2013',3,3);
insert into LIVRO values('9788581742458','O Papai É Pop','2015',3,1);
insert into LIVRO values('9788582302026','Pior Que Tá Não Fica','2015',4,2);
insert into LIVRO values('9788577345670','Garota Desdobrável','2015',2,3);
insert into LIVRO values('8532512062','Harry Potter e o Prisioneiro de Azkaban','2000',1,1);
select *from LIVRO;

 

insert into LIVROAUTOR values('8532511015',1);
insert into LIVROAUTOR values('9788578270698',2);
insert into LIVROAUTOR values('9788577343348',3);
insert into LIVROAUTOR values('9788581742458',4);
insert into LIVROAUTOR values('9788582302026',5);
insert into LIVROAUTOR values('9788577345670',6);
insert into LIVROAUTOR values('8532512062',1);
insert into LIVROAUTOR values('8532512062',2);
select *from LIVROAUTOR;


select LIVRO.ISBN,LIVRO.TITULO,LIVRO.ANO_PUBLICACAO, CATEGORIA.TIPO_CATEGORIA as 'CATEGORIA',EDITORA.NOME as 'EDITORA' from livro
inner join categoria
on livro.fk_categoria = categoria.id
inner join editora
on livro.fk_editora = editora.id
order by titulo;


SELECT Livro.titulo, Autor.nome, Livro.ano_publicacao, Editora.nome AS editora
FROM LIVRO
JOIN LIVROAUTOR ON LIVRO.isbn = LIVROAUTOR.fk_livro
JOIN AUTOR ON LIVROAUTOR.fk_autor = AUTOR.id
JOIN EDITORA ON LIVRO.fk_editora = EDITORA.id
ORDER BY Autor.nome ASC;

SELECT Livro.titulo, Livro.ano_publicacao, Autor.nome AS autor, Editora.nome AS editora
FROM LIVRO
JOIN LIVROAUTOR ON LIVRO.isbn = LIVROAUTOR.fk_livro
JOIN AUTOR ON LIVROAUTOR.fk_autor = AUTOR.id
JOIN EDITORA ON LIVRO.fk_editora = EDITORA.id
JOIN CATEGORIA ON LIVRO.fk_categoria = CATEGORIA.id
WHERE CATEGORIA.tipo_categoria = 'Literatura Juvenil'
ORDER BY Livro.ano_publicacao ASC;

SELECT Livro.titulo, Livro.ano_publicacao, Autor.nome AS autor, Editora.nome AS editora, Categoria.tipo_categoria
FROM LIVRO
JOIN LIVROAUTOR ON LIVRO.isbn = LIVROAUTOR.fk_livro
JOIN AUTOR ON LIVROAUTOR.fk_autor = AUTOR.id
JOIN EDITORA ON LIVRO.fk_editora = EDITORA.id
JOIN CATEGORIA ON LIVRO.fk_categoria = CATEGORIA.id
WHERE (Categoria.tipo_categoria = 'Humor' OR Categoria.tipo_categoria = 'Ficção Científica') AND (Livro.ano_publicacao BETWEEN '2000-01-01' AND '2010-12-31')
ORDER BY Livro.ano_publicacao ASC;




create table log 
(
    id integer not null primary key identity,
    acao varchar(10) not null,
    descricao varchar(100),
    quando datetime not null
)

select * from java
select * from net

delete from java values ('Lucas')

create trigger primeiratrigger
on java
after delete
as
begin 
	insert into log values ('Exclusão', 'Um professor java foi excluido!', getdate())
end

create trigger segundatrigger
on java
after insert
as
begin 
	insert into log values ('Insersão', 'Um professor java foi Add!');
	print('Dados inseridos!')
end

create trigger terceiratrigger
on java
after insert
as 
begin
    declare @contagem int
    select @contagem = (select count(professor) from java)

 

    PRINT('Quantidade de professores: ' + 
            CONVERT(varchar(10), @contagem));

 

    IF @contagem < 3
        begin
            insert into log values ('Inserção', 
                    'Add prof java', GETDATE());
            print('Inserido com sucesso');
        end
    ELSE
        begin
            ROLLBACK;
            insert into log values ('Inserção', 
                    'Tentativa de inserção mal sucedida!', GETDATE());
            RAISERROR('INVALIDO', 14, 1);
            RETURN;
        end
end


drop trigger quartatrigger
create trigger quartatrigger
on java
after update
as
begin
    declare @anterior varchar(20)
    declare @novo varchar(20)

 

    select @anterior = (select deleted.professor from deleted)
    select @novo = (select inserted.professor from inserted)

 

    IF(ROWCOUNT_BIG() = 0)
        return;

 

    IF @anterior= @novo
    begin
        raiserror('SEM ALTERAÇÕES', 14, 1);
        rollback transaction;
        insert into log values ('Atualização', 
            'Tentativa de update mal sucedida!', GETDATE());
    end
    ELSE
    begin
        insert into log values ('upd', 
            'Alteração do prof, ' + @anterior + 
            ' para ' + @novo, GETDATE());
    end
end

 

select * from java

 

select * from log

 

update java set professor = 'Fabrício' 
where professor = 'Lucas'