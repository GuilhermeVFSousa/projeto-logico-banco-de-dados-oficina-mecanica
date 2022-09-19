-- PERSISTINDO DADOS
USE Oficina_Mecanica;

INSERT INTO Cliente (Nome, CPF, Telefone, Endereco) VALUES
('Emily Marli Porto', '68745189501', '16 99999-8888', 'Rua Bambuzinho, 848, Manaus - AM'),
('Cauê Iago Santos', '73813898784', '16 99999-8888', 'Rua Bambuzinho, 2348, Araraquara - SP'),
('Raul Marcelo Geraldo Rezende', '21726514005', '16 99999-8888', 'Rua Bambuzinho, 28, Campinas - SP'),
('Sarah Vanessa Nogueira', '23551656452', '16 99999-8888', 'Rua Bambuzinho, 243, Uberlândia - MG'),
('Renato Leonardo Bryan Silva', '37101432174', '16 99999-8888', 'Rua Bambuzinho, 1232, Minas Gerais - MG'),
('Lara Alícia Agatha Nogueira', '77026004891', '16 99999-8888', 'Rua Bambuzinho, 345, Rio de Janeiro - RJ'),
('Lucas Roberto Silveira', '32854099400', '16 99999-8888', 'Rua Bambuzinho, 823, São Carlos - SP');

INSERT INTO Veiculo (Modelo, Marca, Placa, Cliente_idCliente) VALUES
('Passat', 'VW', 'ABC1234', 1),
('Corsa', 'Chevrolet', 'ABC2345', 2),
('306', 'Peugeot', 'ABC3456', 3),
('Uno', 'Fiat', 'ABC5678', 4),
('Sandero', 'Renault', 'ABC6789', 5),
('A3', 'Audi', 'ABC7890', 6),
('Grand Vitara', 'Suzuki', 'ABC8912', 7);

INSERT INTO Funcionarios (Nome, Endereco, Telefone) VALUES
('Thiago Leite', 'Rua do Chapeu, 222, São Carlos - SP', '16 3333-3321'),
('Benedito Silva', 'Rua do Chapelão, 2132, São Carlos - SP', '16 3333-3321'),
('Cassia de Fátima', 'Rua da Boina, 659, São Carlos - SP', '16 3333-3321'),
('Yuri Alberto', 'Rua do Boné, 123, São Carlos - SP', '16 3333-3321');

INSERT INTO Mecanicos (Codigo_Funcionario, Funcionarios_idFuncionarios) VALUES
(100001, 1),
(100002, 2),
(100003, 3),
(100004, 4);

INSERT INTO Equipe (EquipeNome, Especialidade) VALUES
('Equipe Azul', 'Revisão'),
('Equipe Vermelha', 'Elétrica');

INSERT INTO Equipe_Mecanicos (Equipe_idEquipe, Mecanicos_idMecanicos) VALUES
(1, 1),
(1, 2),
(2, 3),
(2, 4);

INSERT INTO Pecas (idPecas, NomePeca, ValorPeca) VALUES
(1, 'Correia Dentada', 300.00), -- 1
(2, 'Óleo Semi-Sintético - 5L', 200.00), -- 2
(3, 'Filtro de Ar', 80.00), -- 3
(4, 'Disco de Freio', 250.00), -- 4
(5, 'Pastilhas de Freio', 100.00), -- 5
(6, 'Fluído de Freio - 500ml', 100.00),  -- 6
(7, 'Fluído Arrefecimento - 5L', 100.00),  -- 7
(8, 'Lampada LED Farol - 1 Un', 100.00), -- 8
(9, 'Lampada Seta Ambar - 1 Un', 50.00); -- 9

SELECT * FROM PECAS;

DELETE FROM PECAS;

INSERT INTO Servico (ServicoNome, ValorMaoDeObra) VALUES
('Revisão', 250.00),
('Reparo Elétrico', 100.00);

INSERT INTO Pedido (Veiculo_idVeiculo, Equipe_idEquipe, Servico_idServico) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 1, 1),
(4, 1, 1),
(5, 2, 2);

SELECT * FROM PEDIDO;

INSERT INTO Pedido_Pecas (Pedido_idPedido, Pecas_idPecas, Quantidade) VALUES
(1, 1, 1),
(1, 2, 1),
(1, 3, 1),
(1, 4, 2),
(1, 5, 2),
(1, 6, 1),
(1, 7, 1),
(2, 8, 2),
(3, 4, 2),
(3, 5, 2),
(4, 1, 1),
(4, 2, 1),
(5, 9, 4);

INSERT INTO OrdemDeServico (Numero_OS, DataEmissao, Status_OS, DataConclusao, Pedido_idPedido) VALUES
('000001', curdate(), 'Concluído', '2022-09-20', 1),
('000002', curdate(), 'Em Andamento', '2022-09-22', 2),
('000003', curdate(), 'Em Andamento', '2022-09-21', 3),
('000004', curdate(), 'Cancelado', NULL, 4),
('000005', curdate(), 'Concluído', '2022-09-19', 5);

SELECT * FROM OrdemDeServico;

-- CONSULTA VEÍCULO E NOME DO CLIENTE
SELECT Nome, Modelo, Marca, Placa
	FROM Cliente, Veiculo
    WHERE idCliente = Cliente_idCliente;
    
-- CONSULTA DE FUNCIONÁRIOS MECÂNICOS POR EQUIPE
SELECT A.Nome, B.Codigo_Funcionario, D.EquipeNome, D.Especialidade
FROM Funcionarios as A
INNER JOIN Mecanicos as B ON A.idFuncionarios = Funcionarios_idFuncionarios
INNER JOIN Equipe_Mecanicos as C ON B.idMecanicos = C.Mecanicos_idMecanicos
INNER JOIN Equipe as D ON C.Equipe_idEquipe = D.idEquipe
ORDER BY D.EquipeNome DESC;

-- CONSULTA QUAL O CLIENTE REALIZOU O PEDIDO
SELECT Nome, CPF, Telefone, Modelo, idPedido
	FROM Cliente, Veiculo, Pedido
    WHERE idVeiculo = Veiculo_idVeiculo AND idCliente = Cliente_idCliente
    ORDER BY Nome;

-- CONSULTA DA ORDEM DE SERVICO, O PEDIDO NO QUAL ORIGINOU, O CLIENTE E O VEÍCULO
SELECT A.Numero_OS, A.DataEmissao, A.Status_os, B.idPedido, C.Modelo, C.Marca, D.Nome, D.Telefone
	FROM OrdemDeServico AS A
	INNER JOIN Pedido AS B ON A.Pedido_idPedido = B.idPedido
	INNER JOIN Veiculo AS C ON B.Veiculo_idVeiculo = C.idVeiculo
	INNER JOIN Cliente AS D ON C.Cliente_idCliente = D.idCliente;
    
-- CONSULTA DAS PEÇAS E VALORES POR PEDIDO
SELECT A.idPedido, C.NomePeca, C.ValorPeca, B.Quantidade
	FROM Pedido AS A
    INNER JOIN Pedido_Pecas AS B ON A.idPedido = B.Pedido_idPedido
    INNER JOIN Pecas AS C ON B.Pecas_idPecas = C.idPecas;
    
-- CONSULTA DOS SERVICOS E VALORES POR PEDIDO
SELECT A.idPedido, D.ServicoNome, D.ValorMaoDeObra
	FROM Pedido AS A
    INNER JOIN Servico as D ON A.Servico_idServico = D.idServico;
    
-- CONSULTA PEDIDOS REALIZADOS COM DUAS OU MAIS PEÇAS
SELECT COUNT(*) AS QtdPecas, idPedido
	FROM (SELECT A.idPedido, C.NomePeca, C.ValorPeca, B.Quantidade
	FROM Pedido AS A
    INNER JOIN Pedido_Pecas AS B ON A.idPedido = B.Pedido_idPedido
    INNER JOIN Pecas AS C ON B.Pecas_idPecas = C.idPecas) AS AA
    GROUP BY idPedido
    HAVING QtdPecas >= 2;


-- VALOR TOTAL DO PEDIDO SOMANDO TODAS AS PEÇAS DO PEDIDO E MÃO DE OBRA
SELECT _idPedido, SomaValorTotalPecas+ValorMaoDeObra
	FROM (SELECT idPedido AS _idPedido, SUM(ValorTotalPecas) AS SomaValorTotalPecas, ServicoNome, ValorMaoDeObra
			FROM (SELECT A.idPedido, C.NomePeca, C.ValorPeca*B.Quantidade AS ValorTotalPecas, D.ServicoNome, D.ValorMaoDeObra
					FROM Pedido AS A
					INNER JOIN Pedido_Pecas AS B ON A.idPedido = B.Pedido_idPedido
					INNER JOIN Pecas AS C ON B.Pecas_idPecas = C.idPecas
					INNER JOIN Servico as D ON A.Servico_idServico = D.idServico) AS AAA GROUP BY idPedido) AS ValorTotalDoPedido;
                    

-- VALOR TOTAL DO PEDIDO SOMANDO TODAS AS PEÇAS DO PEDIDO E MÃO DE OBRA, APRESENTANDO NOME DO CLIENTE, MODELO E MARCA DO VEÍCULO, NUMERO DA ORDEM DE SERVIÇO, DATA DE EMISSÃO DA O.S. E STATUS DA O.S.
SELECT Numero_OS, _idPedido, DataEmissao, Nome, Modelo, Marca, Status_OS, SomaValorTotalPecas+ValorMaoDeObra AS ValorTotalPedido
	FROM (SELECT idPedido AS _idPedido, SUM(ValorTotalPecas) AS SomaValorTotalPecas, ServicoNome, ValorMaoDeObra, Nome, Modelo, Marca, Numero_OS, Status_OS, DataEmissao
			FROM (SELECT A.idPedido, C.NomePeca, C.ValorPeca*B.Quantidade AS ValorTotalPecas, D.ServicoNome, D.ValorMaoDeObra, G.Nome, F.Modelo, F.Marca, H.Numero_OS, H.Status_OS, H.DataEmissao
					FROM Pedido AS A
					INNER JOIN Pedido_Pecas AS B ON A.idPedido = B.Pedido_idPedido
					INNER JOIN Pecas AS C ON B.Pecas_idPecas = C.idPecas
					INNER JOIN Servico as D ON A.Servico_idServico = D.idServico
					INNER JOIN Veiculo AS F ON A.Veiculo_idVeiculo = F.idVeiculo
					INNER JOIN Cliente AS G ON F.Cliente_idCliente = G.idCliente
                    INNER JOIN OrdemDeServico AS H ON H.Pedido_idPedido = A.idPedido) AS AAA GROUP BY idPedido) AS ValorTotalDoPedido;

-- VALOR TOTAL DO PEDIDO SOMANDO TODAS AS PEÇAS DO PEDIDO E MÃO DE OBRA, APRESENTANDO NOME DO CLIENTE, MODELO E MARCA DO VEÍCULO, NUMERO DA ORDEM DE SERVIÇO, DATA DE EMISSÃO DA O.S. E STATUS DA O.S.
-- PEDIDOS CONCLUÍDOS COM VALOR MAIOR QUE R$1000,00
SELECT Numero_OS, _idPedido, DataEmissao, Nome, Modelo, Marca, Status_OS, SomaValorTotalPecas+ValorMaoDeObra AS ValorTotalPedido
	FROM (SELECT idPedido AS _idPedido, SUM(ValorTotalPecas) AS SomaValorTotalPecas, ServicoNome, ValorMaoDeObra, Nome, Modelo, Marca, Numero_OS, Status_OS, DataEmissao
			FROM (SELECT A.idPedido, C.NomePeca, C.ValorPeca*B.Quantidade AS ValorTotalPecas, D.ServicoNome, D.ValorMaoDeObra, G.Nome, F.Modelo, F.Marca, H.Numero_OS, H.Status_OS, H.DataEmissao
					FROM Pedido AS A
					INNER JOIN Pedido_Pecas AS B ON A.idPedido = B.Pedido_idPedido
					INNER JOIN Pecas AS C ON B.Pecas_idPecas = C.idPecas
					INNER JOIN Servico as D ON A.Servico_idServico = D.idServico
					INNER JOIN Veiculo AS F ON A.Veiculo_idVeiculo = F.idVeiculo
					INNER JOIN Cliente AS G ON F.Cliente_idCliente = G.idCliente
                    INNER JOIN OrdemDeServico AS H ON H.Pedido_idPedido = A.idPedido) AS AAA GROUP BY idPedido) AS ValorTotalDoPedido
                    HAVING ValorTotalPedido > 1000 AND Status_OS = 'Concluído';
            

	





