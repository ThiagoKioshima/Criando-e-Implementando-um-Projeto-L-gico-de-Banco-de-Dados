-- =================================================================================
-- PARTE 1: CRIAÇÃO DO ESQUEMA (DDL)
-- =================================================================================
-- Criação do banco de dados para cenario de E-commerce
-- drop database ecommerce;

create database if not exists ecommerce1;
use ecommerce1;

-- 1. Tabela Cliente
create table client(
		idClient int auto_increment primary key,
        Fname varchar(10),
        Minit char(3),
        Lname varchar(20),
        CPF char(11), -- Não mais NOT NULL aqui, pois a constraint de exclusividade será adicionada
		CNPJ char(14),
        Address varchar(60),
		-- Constraint de exclusividade para CPF e CNPJ (OR EXCLUSIVO)
		constraint chk_cnpj_cpf_exclusive_client check(
        (CNPJ is not null and CPF is null) or
        (CNPJ is null and CPF is not null)
		),
        constraint unique_cpf_client unique (CPF),
		constraint unique_cnpj_client unique (CNPJ)
);

-- 2. Tabela Produto
create table product(
		idProduct int auto_increment primary key,
        Pname varchar(40) not null, 
        classification_kids bool default false,
        category enum('Eletronico', 'Vestimenta', 'Brinquedos', 'Alimentos', 'Móveis') not null,
        avaliação float default 0,
        size varchar(10)
);

-- 3. Tabela Pedido
create table orders(
		idOrder int auto_increment primary key,
        idOrderClient int,
        OrdersStatus enum('Cancelado', 'Confirmado', 'Em Processamento') default 'Em processamento',
        OrdersDescription varchar(255),
        sendValue float default 10,
		-- A forma de pagamento será tratada na tabela de pagamento
		constraint fk_orders_client foreign key (idOrderClient) references client(idClient)
);

-- 4. Tabela Pagamento (Permite mais de uma forma de pagamento por cliente)
create table payments(
	idPayment int auto_increment primary key,
	idPayClient int not null,
	typePayment enum('Cartão', 'Boleto', 'Pix', 'Dois Cartões') not null,
	limitAvailable float,
	constraint fk_payments_client foreign key (idPayClient) references client(idClient)
);

-- 5. Tabela Entrega (Permite status e código de rastreio)
create table delivery(
    idDelivery int auto_increment primary key,
    idDelOrder int not null,
    deliveryStatus enum('Enviado', 'Em Trânsito', 'Entregue', 'Atrasado') default 'Enviado',
    trackingCode varchar(50) unique not null,
    estimateDate DATE,
    constraint fk_delivery_order foreign key (idDelOrder) references orders(idOrder)
);
 
-- 6. Tabela Estoque
create table productStorage(
		idproductStorage int auto_increment primary key,
        storageLocation varchar(255),
        quantity int default 0
        
);

-- 7. Tabela Fornecedor
create table supplier(
		idsupplier int auto_increment primary key,
        SocialName varchar(255) not null,
        CNPJ char(14) not null unique,
        contact char(11) not null
);

-- 8. Tabela Vendedor (Já com a regra PJ/PF OR Exclusivo)
create table seller(
		idSeller int auto_increment primary key,
		SocialName varchar(255) not null, 
		AbstName varchar(255),
		CNPJ char(14) unique,
		CPF char(11) unique,
		Location varchar(255),
		contact char(11) not null,
		-- Restrição de exclusividade (PJ ou PF, mas não ambos)
		constraint chk_cnpj_cpf_exclusive_seller check(
        (CNPJ is not null and CPF is null) or
        (CNPJ is null and CPF is not null)
		)
);

-- 9. Tabela de Relacionamento N:M Produto-Vendedor
create table productSeller(
		idPseller int,
		idPproduct int,
		prodQuantity int default 1,
		primary key (idPseller, idPproduct),
		constraint fk_product_seller foreign key (idPseller) references seller(idSeller),
		constraint fk_product_product foreign key (idPproduct) references product(idProduct)        
);

-- 10. Tabela de Relacionamento N:M Produto-Pedido (Itens do Pedido)
create table productOrder(
		idPOproduct int,
		idPOorder int,
		PoQuantity int default 1,
		poStatus enum('Disponivel', 'Sem Estoque') default 'Disponivel',
		primary key (idPOproduct, idPOorder),
		constraint fk_productOrder_product foreign key(idPOproduct) references product(idProduct),
		constraint fk_productOrder_order foreign key (idPOorder) references orders(idOrder)
);

-- 11. Tabela de Relacionamento N:M Produto-Estoque
create table storagelocation(
		idLproduct int,
		idLstorage int,
		location varchar(255) not null,
		primary key (idLproduct, idLstorage),
		constraint fk_storage_location_product foreign key (idLproduct) references product(idProduct),
		constraint fk_storage_location_storage foreign key (idLstorage) references productStorage(idProductStorage)
);    

-- 12. Tabela de Relacionamento N:M Produto-Fornecedor
create table ProductSupplier(
		idPsSupplier int,
		idPsProduct int not null,
		Quantity int not null,
		primary key (idPsSupplier, idPsProduct),
		constraint fk_product_supplier_supplier foreign key (idPsSupplier) references supplier(idSupplier),
		constraint fk_product_supplier_product foreign key (idPsProduct) references product(idProduct)
);

show tables;

                     

