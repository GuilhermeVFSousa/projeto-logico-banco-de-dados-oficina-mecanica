
# Projeto Lógico de Banco de Dados

Projeto realizado durante o Bootcamp Database Experience da Digital Innovation One (DIO).

## Objetivos


- Criar o esquema lógico para o contexto de uma oficina;
- Recuperações simples com SELECT Statement;
- Filtros com WHERE Statement;
- Criar expressões para gerar atributos derivados;
- Definir ordenações dos dados com ORDER BY;
- Condições de filtros aos grupos – HAVING Statement;
- Criar junções entre tabelas para fornecer uma perspectiva mais complexa dos dados;


### Consultas elaboradas

#### CONSULTA VEÍCULO E NOME DO CLIENTE

```sql
SELECT Nome, Modelo, Marca, Placa
	FROM Cliente, Veiculo
    WHERE idCliente = Cliente_idCliente;
```

#### CONSULTA DE FUNCIONÁRIOS MECÂNICOS POR EQUIPE
```sql
SELECT A.Nome, B.Codigo_Funcionario, D.EquipeNome, D.Especialidade
	FROM Funcionarios as A
	INNER JOIN Mecanicos as B ON A.idFuncionarios = Funcionarios_idFuncionarios
	INNER JOIN Equipe_Mecanicos as C ON B.idMecanicos = C.Mecanicos_idMecanicos
	INNER JOIN Equipe as D ON C.Equipe_idEquipe = D.idEquipe
	ORDER BY D.EquipeNome DESC;
```

#### CONSULTA QUAL O CLIENTE REALIZOU O PEDIDO
```sql
SELECT Nome, CPF, Telefone, Modelo, idPedido
	FROM Cliente, Veiculo, Pedido
    WHERE idVeiculo = Veiculo_idVeiculo AND idCliente = Cliente_idCliente
    ORDER BY Nome;
```

#### CONSULTA DA ORDEM DE SERVICO, O PEDIDO NO QUAL ORIGINOU, O CLIENTE E O VEÍCULO
```sql
SELECT A.Numero_OS, A.DataEmissao, A.Status_os, B.idPedido, C.Modelo, C.Marca, D.Nome, D.Telefone
	FROM OrdemDeServico AS A
	INNER JOIN Pedido AS B ON A.Pedido_idPedido = B.idPedido
	INNER JOIN Veiculo AS C ON B.Veiculo_idVeiculo = C.idVeiculo
	INNER JOIN Cliente AS D ON C.Cliente_idCliente = D.idCliente;
```

#### CONSULTA DAS PEÇAS E VALORES POR PEDIDO
```sql
SELECT A.idPedido, C.NomePeca, C.ValorPeca, B.Quantidade
	FROM Pedido AS A
    INNER JOIN Pedido_Pecas AS B ON A.idPedido = B.Pedido_idPedido
    INNER JOIN Pecas AS C ON B.Pecas_idPecas = C.idPecas;
```
#### CONSULTA DOS SERVICOS E VALORES POR PEDIDO
```sql
SELECT A.idPedido, D.ServicoNome, D.ValorMaoDeObra
	FROM Pedido AS A
    INNER JOIN Servico as D ON A.Servico_idServico = D.idServico;
```

#### VALOR TOTAL DO PEDIDO SOMANDO TODAS AS PEÇAS DO PEDIDO E MÃO DE OBRA,APRESENTANDO NOME DO CLIENTE, MODELO E MARCA DO VEÍCULO, NUMERO DA ORDEM DE SERVIÇO, DATA DE EMISSÃO DA O.S. E STATUS DA O.S.
```sql
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
    ```

```sql

```

#### VALOR TOTAL DO PEDIDO SOMANDO TODAS AS PEÇAS DO PEDIDO E MÃO DE OBRA, APRESENTANDO NOME DO CLIENTE, MODELO E MARCA DO VEÍCULO, NUMERO DA ORDEM DE SERVIÇO, DATA DE EMISSÃO DA O.S. E STATUS DA O.S.
##### PEDIDOS CONCLUÍDOS COM VALOR MAIOR QUE R$1000,00

```sql
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
```