-- Banco de dados ecommerce by sergio palmiere
drop database ecommerce;
show databases;
create database ecommerce;
use ecommerce;

-- criar tabela cliente

create table cliente(
idCliente int auto_increment primary key,
Fnome varchar(10),
Snome varchar(15),
Sobrenome varchar(15),
CPF char(11) not null,
Endereco varchar(45),
constraint unique_cpf_cliente unique (CPF)
);

alter table cliente auto_increment=1;

-- criar tabela produto
create table produto(
idProduto int auto_increment primary key,
Pnome varchar(20),
classification_kids bool,
category enum('Eletrônicos', 'Vestuario', 'Brinquedos', 'Alimentos', 'Jardim', 'Casa', 'Limpeza', 'Informática', 'Móveis', 'Livros') not null,
Avaliacao float default 0,
Dimensao varchar(10)
);

alter table produto auto_increment=1;

-- criar tabela pagamento
create table pagamento(
idCliente int,
idPagamento int,
TipoPagamento enum('Boleto', 'Cartao', 'Dois Cartoes'),
LimiteValor float,
primary key(idCliente, idPagamento)
);


-- criar tabela pedido
create table pedido(
idPedido int auto_increment primary key,
idPedidoCliente int,
StatusPedido enum('Cancelado', 'Confirmado', 'Em processamento') default 'Em processamento',
DescricaoPedido varchar(255),
FretePedido float default 10,
PagamentoDinheiro bool default false,
constraint fk_pedido_cliente foreign key (idPedidoCliente) references Cliente(idCliente)
	on update cascade
    on delete set null
);

alter table pedido auto_increment=1;

-- criar tabela estoque
create table estoque(
idEstoque int auto_increment primary key,
Local_Estoque varchar(45),
Quantidade int
);

alter table estoque auto_increment=1;

-- criar tabela fornecedor
create table fornecedor(
idFornecedor int auto_increment primary key,
Razao_Social	varchar(45),
Nome_Fantasia	varchar(45),
CNPJ	char(15) not null,
Contato char(11) not null, 
Email varchar(45),
Estado char(2) not null default 'SP',
Endereco varchar(255),
constraint unique_fornecedor unique (CNPJ)
);

alter table fornecedor auto_increment=1;


-- criar tabela vendedor
create table vendedor(
idVendedor int auto_increment primary key,
Razao_Social	varchar(45) not null,
Nome_Fantasia	varchar(45),
CNPJ	char(15),
CPF		char(11),
Contato char(11) not null, 
Email varchar(45),
Estado char(2) not null default 'SP',
Endereco varchar(255),
constraint unique_CNPJ_vendedor unique (CNPJ),
constraint unique_CPF_vendedor unique (CPF)
);

alter table vendedor auto_increment=1;


-- criar tabela produtos-vendedor
create table produtovendedor(
id_Vendedor int,	
id_Produto  int,
quantidade_produto int default 1,
primary key (id_Vendedor, id_Produto),
constraint fk_produto_vendedor foreign key (id_Vendedor) references vendedor(idVendedor),
constraint fk_produto_produto foreign key (id_Produto) references produto(idProduto)
);


-- criar tabela produtos-fornecedor
create table produtofornecedor(
id_Fornecedor int,	
id_Produto  int,
quantidade int not null,
primary key (id_Fornecedor, id_Produto),
constraint fk_produtofornecedor_fornecedor foreign key (id_Fornecedor) references fornecedor(idFornecedor),
constraint fk_produtofornecedor_produto foreign key (id_Produto) references produto(idProduto)
);

-- criar tabela produto-pedido
create table produtopedido(
id_Produto int,	
id_Pedido  int,
ppQuantidade_produto int default 1,
ppStatus enum('Disponivel', 'Sem Estoque') default 'Disponivel',
primary key (id_Produto, id_Pedido),
constraint fk_produtopedido_produto foreign key (id_Produto) references produto(idProduto),
constraint fk_produtopedido_pedido foreign key (id_Pedido) references pedido(idPedido)
);

-- criar tabela estoque-local
create table estoquelocal(
id_Produto int,
id_Estoque int,
Localizacao varchar(255) not null,
primary key (id_Produto, id_Estoque),
constraint fk_estoquelocal_produto foreign key (id_Produto) references produto(idProduto),
constraint fk_estoquelocal_local foreign key (id_Estoque) references estoque(idEstoque)
);

show tables;
desc estoquelocal;
show databases;
use information_schema;
desc TABLE_CONSTRAINTS;
select * from referential_constraints where constraint_schema = 'ecommerce';


-- Populando o database
-- by sergio palmiere
use ecommerce;

insert into cliente (Fnome, Snome, Sobrenome, CPF, Endereco)
values ('Sandie', 'Bonnick', 'Jehu', 86684582326, '7 Parkside Point'),
		('Meghann', 'Tille', 'Jerrie', 7914179476, '214 Tennessee Lane'),
		('Garrick', 'Waycott', 'Waite', 14998354471, '21610 Dakota Place'),
		('Emmy', 'Flawn', 'Jerrie', 45486596698, '50 Walton Alley'),
		('Norris', 'Wooton', 'Bren', 90754221903, '4 Corscot Alley'),
		('Kellen', 'Cavee', 'Lucian', 2477333103, '9169 Lukken Parkway'),
		('Meier', 'Marrison', 'Garreth', 67782589368, '4684 Stang Point'),
		('Gerri', 'Arbuckel', 'Reuven', 69126457533, '22 Shasta Lane'),
		('Welbie', 'Larrie', 'Pen', 7034376829, '54 Talmadge Place'),
		('Wang', 'Buddell', 'Wayland', 39094711159, '24 Monica Avenue');
        
        
insert into vendedor (Razao_Social, Nome_fantasia, CNPJ, CPF, Contato, Email, Estado, Endereco) 
values ('Buzzshare', 'Stool Softener', null, 19809492863, 'Dale', 'dmerriott0@ox.ac.uk', 'AM', '30191 Melvin Avenue'),
		('Teklist', 'LBEL EFFET PARFAIT Spots', null, 42722958603, 'Davie', 'dfirmage1@google.it', 'RJ', '67499 Summerview Trail'),
		('Yozio', 'Christian Dior Prestige Brightening', null, 82358699391, 'Sinclair', 'shitzke2@narod.ru', 'SP', '95690 Crest Line Point'),
		('Zoomlounge', 'SOMA Diat', null, 14603533627, 'Jake', 'jpilgram3@rediff.com', 'GO', '2452 Claremont Junction'),
		('Bubblebox', 'Isosorbide Dinitrate', null, 57096971679, 'Doug', 'dcherryholme4@cnet.com', 'RS', '8 Ilene Avenue');
        
        
insert into produto (Pnome, classification_kids, category, Avaliacao, Dimensao) 
values ('Smartfone XS', 0, 'Eletrônicos', 4, '15x20x3'),
		('Oculos VR', 0, 'Informática', 3.5, '10x10x5'),
		('Camisa azul', 1, 'Vestuario', 2.9, '35x35x40');

insert into fornecedor (Razao_Social, Nome_fantasia, CNPJ, Contato, Email, Estado, Endereco) 
values ('Meevee', 'METHADONE HYDROCHLORIDE', 2048700444, 'Deanna', 'drisen0@nytimes.com', 'SP', '0759 Almo Circle'),
		('Avamba', 'Clotrimazole Antifungal', 78071983532, 'Neddie', 'nharnett1@senate.gov', 'SP', '827 Anniversary Drive'),
		('Abata', 'Pseudoephedrine hydrochloride', 25703731466, 'Bancroft', 'bdeeks2@theguardian.com', 'RJ', '2 Twin Pines Lane'),
		('Thoughtsphere', 'Bodycology', 59582629472, 'Durante', 'dpoynzer3@admin.ch', 'MS', '3319 Esch Court'),
		('Linklinks', 'SURGICEPT', 20606048634, 'Griffith', 'gives4@sitemeter.com', 'MA', '1518 Novick Parkway'),
		('Skalith', 'CVS Medicated Chest Rub Roll-On', 62925205182, 'Mae', 'mauckland5@rakuten.co.jp', 'PA', '32979 Autumn Leaf Drive');
        
        
insert into pedido (idPedidoCliente, StatusPedido, DescricaoPedido, FretePedido, PagamentoDinheiro) 
values	 (1, default, 'compra via aplicativo', null, 1),
		(2, default, 'compra via aplicativo', 50, 0),
        (3, default, 'confirmado', 45, 1),
        (4, default, 'cconfirmado', 150, 0),
        (5, default, 'compra via aplicativo', 80, 0);

insert into produtopedido (id_Produto, id_Pedido, ppQuantidade_Produto, ppStatus) 
values	 (1,1,2,null),
		(2,1,1,null),
        (3,1,1,null);
        
       
insert into estoque (idEstoque,Local_Estoque, Quantidade)   
values (1,1,200),
		(2,1,100),
        (3,2,100);
        
insert into estoquelocal (id_produto, id_Estoque, Localizacao)
  values (1, 1, 'Sao Paulo'),
		 (2,1, 'Sao Paulo'),
         (3, 1, 'Rio de Janeiro');
         
 insert into produtofornecedor (id_Fornecedor, id_Produto, quantidade)
  values (1, 1, 30),
		 (2,2, 5),
         (6,3, 40);        

 insert into produtovendedor (id_Vendedor, id_Produto, quantidade_produto)
  values (5, 1, 30),
		 (1,2, 5),
         (5,3, 40);    
         
 insert into pagamento (idCliente, idPagamento, TipoPagamento, LimiteValor)
  values (1, 1,'Boleto', 30.5),
		 (7,2, 'Cartao', 50.8),
         (10,3, 'Dois Cartoes', 80);   
         
 -- Consultas ao banco de dados ecommerce
 -- by sergio palmiere
 
 select * from cliente;
select * from vendedor;
select * from produto;
select * from fornecedor;
select * from pedido;
select * from estoque;
select * from produtofornecedor;
select * from produtopedido;
select * from estoquelocal;
select * from pagamento;
select * from produtovendedor;
select count(*) from cliente;
select * from cliente c, pedido p where c.idCliente = idPedidoCliente;
select Fnome, Snome, Sobrenome, StatusPedido from cliente c, pedido p where c.idCliente = idPedidoCliente;
select concat(Fnome, ' ', Snome, ' ', Sobrenome) as 'comprador', StatusPedido from cliente c, pedido p where c.idCliente = idPedidoCliente;
select * from cliente c, pedido p 
where c.idCliente = idPedidoCliente
group by idPedido;
select * from cliente left outer join pedido on idCliente = idPedidoCliente;
select * from cliente left outer join pedido on idCliente = idPedidoCliente
inner join produto;
select * from cliente left outer join pedido on idCliente = idPedidoCliente
inner join produto on idPedido = idProduto; 
-- Recuperar pedido de produto associado
select * from cliente left outer join pedido on idCliente = idPedidoCliente
inner join produto on idPedido = idProduto
group by idCliente; 
-- Recuperar quantos pedidos foram realizados pelos clientes?
select c.idCliente, Pnome, count(*) as 'Numero_Pedidos' from cliente c left outer 
join pedido p on idCliente = idPedidoCliente
inner join produto on idPedido = idProduto
group by idCliente; 