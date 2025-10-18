
-- =================================================================================
-- PARTE 2: PERSISTÊNCIA DE DADOS (DML)
-- =================================================================================

-- Inserindo Clientes (PF e PJ)
-- IdClient, Fname, Minit, Lname, CPF, CNPJ, Address
insert into client(Fname, Minit, Lname, CPF, CNPJ, Address) values 
		('Maria','M','Silva', '12346789100', null, 'rua silva de prata 29, Carangola - Cidade das Flores'),
		('Matheus','O','Pimentel', '98765432100', null,'rua alemeda 289, Centro - Cidade das Flores'),
		('Tecnologia','S/A','LTDA', null, '11223344556677','avenida principal 500, São Paulo'), -- PJ
		('Julia','S','França', '78912345600', null,'rua lareijras 861, Centro - Cidade das Flores'),
		('Roberta','G','Assis', '98745631000', null,'avenidade koller 19, Centro - Cidade das Flores'),
		('Isabela','M','Cruz', '65478912300', null,'rua alemeda das flores 28, Centro - Cidade das Flores');
			
-- Inserindo Produtos
-- idProduct, Pname, classification_kids, category, avaliação, size
insert into product(Pname, Classification_kids, Category, avaliação, Size) values 
		('Fone de ouvido JBL',false,'Eletronico','4',null), -- ID 1
		('Barbie Elsa',true,'Brinquedos','3',null), -- ID 2
		('Body Carters',true,'Vestimenta','5',null), -- ID 3
		('Microfone Vedo',False,'Eletronico','4',null), -- ID 4
		('Sofá retrátil',False,'Móveis','3','3x57x80'), -- ID 5
		('Farinha de aveia',False,'Alimentos','2',null), -- ID 6
		('Fire Stick Amazon',False,'Eletronico','3',null); -- ID 7

-- Inserindo Pedidos
-- idOrderClient, OrdersStatus, OrdersDescription, sendValue
insert into orders (idOrderClient, OrdersStatus, OrdersDescription, sendValue) values
		 (1, 'Confirmado','compra via aplicativo',15.50), -- ID 1
		 (2, 'Em Processamento','compra via aplicativo',50.00), -- ID 2
		 (3,'Confirmado','Pedido da Empresa S/A',100.00), -- ID 3
		 (4, 'Em Processamento','compra via web site',150.00), -- ID 4
		 (2, 'Cancelado','Compra com falha',0.00); -- ID 5

-- Inserindo Itens do Pedido (productOrder)
-- idPOproduct, idPOorder, poQuantity
insert into productOrder(idPOproduct, idPOorder, poQuantity) values
		(1,1,2), -- 2 Fones para Pedido 1
		(2,1,1), -- 1 Barbie para Pedido 1
		(3,2,5), -- 5 Bodys para Pedido 2
		(4,3,10), -- 10 Microfones para Pedido 3 (PJ)
		(7,4,1), -- 1 Fire Stick para Pedido 4
		(6,4,3); -- 3 Farinhas para Pedido 4

-- Inserindo Pagamentos (Permite múltiplas formas para um cliente)
-- idPayClient, typePayment, limitAvailable
insert into payments (idPayClient, typePayment, limitAvailable) values
		(1, 'Cartão', 2000.00),
		(1, 'Pix', null), -- Cliente 1 tem duas formas
		(3, 'Boleto', null), -- Cliente PJ paga com boleto
		(4, 'Cartão', 500.00);

-- Inserindo Entregas (delivery)
-- idDelOrder, deliveryStatus, trackingCode, estimateDate
INSERT INTO delivery (idDelOrder, deliveryStatus, trackingCode, estimateDate) VALUES
		(1, 'Entregue', 'BR123456789RJ', '2025-10-25'),
		(2, 'Em Trânsito', 'BR987654321SP', '2025-10-28'),
		(3, 'Entregue', 'BR111222333MG', '2025-11-01');

-- Inserindo Fornecedores
-- idsupplier, SocialName, CNPJ, contact
insert into supplier (SocialName, CNPJ, contact) values 
		('Almeida e filhos', '12345678912345','21985474'), -- ID 1
		('Eletrônicos Silva', '85451964914345','21985484'), -- ID 2
		('Eletrônicos Valma', '93456789393469','21975474'); -- ID 3

-- Inserindo Vendedores (Seller)
-- SocialName, AbstName, CNPJ, CPF, location, contact
insert into seller (SocialName, AbstName, CNPJ,CPF, location, contact) values
		('Tech eletronics', null, '12345678945632', null, 'Rio de Janeiro', '219946287'), -- ID 1 (PJ)
		('José da Silva',null,null,'12345678910','Rio de Janeiro', '219567895'), -- ID 2 (PF)
		('Kids World',null,'45678912365448',null,'São Paulo', '1198657484'), -- ID 3 (PJ)
		('Almeida e filhos VENDAS', null, '12345678912345', null, 'Rio de Janeiro', '21985474'); -- ID 4 (PJ - Mesmo CNPJ do Fornecedor 1)

-- Inserindo Produtos por Vendedor
-- idPseller, idPproduct, prodQuantity
insert into productSeller (idPseller, idPproduct, prodQuantity) values
		(1,1,100), -- Tech Eletronics vende Fone
		(2,6,80), -- José vende Farinha
		(3,2,20), -- Kids World vende Barbie
		(4,4,50); -- Almeida Vendas vende Microfone

-- Inserindo Produtos por Fornecedor
-- idPsSupplier, idPsProduct, Quantity
insert into ProductSupplier (idPsSupplier, idPsProduct, Quantity) values
		(1,1,500), -- Almeida (Forn) fornece Fone
		(1,5,10), -- Almeida (Forn) fornece Sofá
		(2,4,100), -- Silva (Forn) fornece Microfone
		(3,7,200); -- Valma (Forn) fornece Fire Stick

-- Inserindo Estoques (Storage)
-- storageLocation, Quantity
insert into productStorage (StorageLocation,Quantity) values  
		('Rio de Janeiro',1000), -- ID 1
		('Rio de Janeiro',500), -- ID 2
		('São Paulo',10), -- ID 3
		('São Paulo',100), -- ID 4
		('Brasília',60); -- ID 5

-- Inserindo Localização de Estoque
-- idLproduct, idLstorage, location
insert into storagelocation (idLproduct, idLstorage, location) values
		(1,1,'A1-01'), -- Fone no RJ
		(5,4,'SP-Móveis'), -- Sofá em SP
		(7,5,'BSB-10'); -- Fire Stick em BSB
        
-- =================================================================================
-- PARTE 3: QUERIES COMPLEXAS (FILTROS, AGRUPAMENTOS, JUNÇÕES, ATRIBUTOS DERIVADOS)
-- =================================================================================

-- PERGUNTA: Quantos pedidos foram feitos por cada cliente? (JUNÇÃO, AGRUPAMENTO)
SELECT 
    c.idClient,
    CONCAT(c.Fname, ' ', c.Lname) AS Nome_Cliente, -- ATRIBUTO DERIVADO (CONCAT)
    COUNT(o.idOrder) AS Total_Pedidos
FROM client c
INNER JOIN orders o ON c.idClient = o.idOrderClient -- JUNÇÃO
GROUP BY c.idClient, Nome_Cliente;


-- PERGUNTA: Qual cliente fez mais pedidos, e qual o total de pedidos? (ORDER BY)
SELECT 
    c.idClient, 
    CONCAT(c.Fname, ' ', c.Lname) AS Nome_Cliente,
    COUNT(o.idOrder) AS Total_Pedidos
FROM client c
INNER JOIN orders o ON c.idClient = o.idOrderClient
GROUP BY c.idClient, Nome_Cliente
ORDER BY Total_Pedidos DESC -- DEFININDO ORDENAÇÃO DOS DADOS
LIMIT 1; -- Seleciona apenas o primeiro (maior)


-- PERGUNTA: Quais produtos custam mais de R$ 50 (Hipótese de valor) e pertencem a pedidos confirmados? (FILTRO WHERE, JUNÇÃO)
SELECT 
	p.Pname AS Nome_Produto,
	o.idOrder AS Pedido,
	o.OrdersStatus AS Status_Pedido
FROM product p
INNER JOIN productOrder po ON p.idProduct = po.idPOproduct
INNER JOIN orders o ON po.idPOorder = o.idOrder
WHERE o.OrdersStatus = 'Confirmado' -- FILTRO COM WHERE STATEMENT
AND po.PoQuantity > 1;


-- QUERY: Listar clientes PF que usam cartão como forma de pagamento. (JUNÇÃO TRIPLA, FILTRO WHERE)
SELECT 
	CONCAT(c.Fname, ' ', c.Lname) AS Nome_Cliente_PF,
    p.typePayment AS Forma_Pagamento
FROM client c
INNER JOIN payments p ON c.idClient = p.idPayClient -- JUNÇÃO 
WHERE c.CPF IS NOT NULL -- FILTRO: Garante que seja Pessoa Física
AND p.typePayment = 'Cartão';


-- QUERY: Quais categorias de produtos tiveram mais de 10 unidades em um único pedido? (HAVING STATEMENT)
SELECT 
    p.category,
    SUM(po.PoQuantity) AS Total_Unidades_Vendidas_Na_Categoria
FROM product p
INNER JOIN productOrder po ON p.idProduct = po.idPOproduct
GROUP BY p.category
HAVING SUM(po.PoQuantity) > 10 -- FILTRO AOS GRUPOS COM HAVING STATEMENT
ORDER BY Total_Unidades_Vendidas_Na_Categoria DESC;


-- PERGUNTA: Algum vendedor também é fornecedor? (JUNÇÃO, FILTRO CNPJ)
SELECT 
    s.SocialName AS Vendedor,
    sup.SocialName AS Fornecedor,
    s.CNPJ AS CNPJ_Compartilhado
FROM seller s
INNER JOIN supplier sup ON s.CNPJ = sup.CNPJ; -- JUNÇÃO PELO CAMPO COMUM (CNPJ)
-- Resultado: Almeida e filhos VENDAS (Vendedor) é Almeida e filhos (Fornecedor)

-- PERGUNTA: Relação de nomes dos fornecedores, nomes dos produtos e locais de estoque onde o produto se encontra. (JUNÇÃO QUÁDRUPLA)
SELECT
    sup.SocialName AS Nome_Fornecedor,
    p.Pname AS Nome_Produto,
    sl.location AS Local_Estoque,
    ps.Quantity AS Quantidade_Fornecida
FROM supplier sup
INNER JOIN ProductSupplier ps ON sup.idsupplier = ps.idPsSupplier -- Fornecedor <-> Fornece Produto
INNER JOIN product p ON ps.idPsProduct = p.idProduct -- Produto <-> Produto
LEFT JOIN storagelocation sl ON p.idProduct = sl.idLproduct -- Produto <-> Localização de Estoque (LEFT JOIN para incluir produtos sem localização definida)
ORDER BY Nome_Fornecedor, Nome_Produto;


-- QUERY: Mostrar pedidos com status 'Entregue' e seu código de rastreio. (JUNÇÃO, ATRIBUTO DERIVADO)
SELECT
    CONCAT(c.Fname, ' ', c.Lname) AS Cliente,
    o.idOrder AS Pedido,
    d.deliveryStatus AS Status_Entrega,
    d.trackingCode AS Codigo_Rastreio
FROM orders o
INNER JOIN client c ON o.idOrderClient = c.idClient
INNER JOIN delivery d ON o.idOrder = d.idDelOrder -- JUNÇÃO
WHERE d.deliveryStatus = 'Entregue'; -- FILTRO COM WHERE	


