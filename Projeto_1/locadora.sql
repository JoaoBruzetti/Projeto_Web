-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 01-Fev-2021 às 05:06
-- Versão do servidor: 10.4.17-MariaDB
-- versão do PHP: 7.4.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `locadora`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `aluga`
--

CREATE TABLE `aluga` (
  `id_aluga` int(11) NOT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `id_filme` int(11) DEFAULT NULL,
  `qtd_dias` int(11) DEFAULT NULL,
  `preco_total` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `aluga`
--

INSERT INTO `aluga` (`id_aluga`, `id_usuario`, `id_filme`, `qtd_dias`, `preco_total`) VALUES
(3, 3, 1, 2, 50),
(4, 3, 2, 2, 30),
(5, 3, 2, 0, 0),
(6, 3, 1, 2, 40),
(7, 3, 2, 3, 60),
(8, 3, 3, 3, 15),
(9, 3, 5, 5, 15),
(10, 12, 1, 2, 40);

-- --------------------------------------------------------

--
-- Estrutura da tabela `filme`
--

CREATE TABLE `filme` (
  `id_filme` int(11) NOT NULL,
  `nome` varchar(20) DEFAULT NULL,
  `sinopse` varchar(200) DEFAULT NULL,
  `faixa_etaria` varchar(5) DEFAULT NULL,
  `preco` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `filme`
--

INSERT INTO `filme` (`id_filme`, `nome`, `sinopse`, `faixa_etaria`, `preco`) VALUES
(1, 'VINGADORES', 'Homem de   ferro morre', '10', 20),
(2, 'Batman', 'batman e coringa', '18', 20),
(3, 'JOKER', 'CORINGA MATA  GERAL', '16', 5),
(5, 'Crespusculo', 'Duas pessoa', 'L', 40),
(6, 'Amanhecer', 'É crespuscolo ainda', '12', 30),
(7, 'Homem de Ferro', 'homem rico que vira super heroi', '12', 20);

-- --------------------------------------------------------

--
-- Estrutura da tabela `nivel_usuario`
--

CREATE TABLE `nivel_usuario` (
  `Nivel` int(11) NOT NULL,
  `descrição` char(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `nivel_usuario`
--

INSERT INTO `nivel_usuario` (`Nivel`, `descrição`) VALUES
(1, 'Admin'),
(2, 'cliente');

-- --------------------------------------------------------

--
-- Estrutura da tabela `usuario`
--

CREATE TABLE `usuario` (
  `ID_usuario` int(11) NOT NULL,
  `Nivel_usuario` int(11) DEFAULT NULL,
  `nome` varchar(50) DEFAULT NULL,
  `senha` varchar(64) DEFAULT NULL,
  `tel` varchar(15) DEFAULT NULL,
  `cpf` varchar(14) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `usuario`
--

INSERT INTO `usuario` (`ID_usuario`, `Nivel_usuario`, `nome`, `senha`, `tel`, `cpf`, `email`) VALUES
(2, 1, 'Joao', '1234', '958664544', '52204661865', 'joaovictor.bruzetti@gmail.com'),
(3, 2, 'Rayana', 'amor', '23645855', '45789657785', 'rayanagrier@gmail.com.br'),
(12, 2, 'João', '1234', '5488115848', '522461864', 'joao.bruzetti@gmail.com');

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `aluga`
--
ALTER TABLE `aluga`
  ADD PRIMARY KEY (`id_aluga`),
  ADD KEY `fk_usuario` (`id_usuario`),
  ADD KEY `fk_filme` (`id_filme`);

--
-- Índices para tabela `filme`
--
ALTER TABLE `filme`
  ADD PRIMARY KEY (`id_filme`);

--
-- Índices para tabela `nivel_usuario`
--
ALTER TABLE `nivel_usuario`
  ADD PRIMARY KEY (`Nivel`);

--
-- Índices para tabela `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`ID_usuario`),
  ADD KEY `fk_nivel` (`Nivel_usuario`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `aluga`
--
ALTER TABLE `aluga`
  MODIFY `id_aluga` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de tabela `filme`
--
ALTER TABLE `filme`
  MODIFY `id_filme` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de tabela `usuario`
--
ALTER TABLE `usuario`
  MODIFY `ID_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `aluga`
--
ALTER TABLE `aluga`
  ADD CONSTRAINT `fk_filme` FOREIGN KEY (`id_filme`) REFERENCES `filme` (`id_filme`),
  ADD CONSTRAINT `fk_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`ID_usuario`);

--
-- Limitadores para a tabela `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `fk_nivel` FOREIGN KEY (`Nivel_usuario`) REFERENCES `nivel_usuario` (`Nivel`),
  ADD CONSTRAINT `fk_nivel_usuario` FOREIGN KEY (`Nivel_usuario`) REFERENCES `nivel_usuario` (`Nivel`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
