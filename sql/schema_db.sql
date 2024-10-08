-- --------------------------------------------------------
-- Servidor:                     127.0.0.1
-- Versão do servidor:           5.5.62 - MySQL Community Server (GPL)
-- OS do Servidor:               Win64
-- HeidiSQL Versão:              12.7.0.6850
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Copiando estrutura do banco de dados para matheus
CREATE DATABASE IF NOT EXISTS `matheus` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `matheus`;

-- Copiando estrutura para tabela matheus.clientes
CREATE TABLE IF NOT EXISTS `clientes` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `nome` char(50) DEFAULT NULL,
  `cpf` char(50) DEFAULT NULL,
  `rg` char(50) DEFAULT NULL,
  `cep` char(50) DEFAULT NULL,
  `endereco` char(50) DEFAULT NULL,
  `telefone` char(50) DEFAULT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela matheus.fornecedores
CREATE TABLE IF NOT EXISTS `fornecedores` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `nome` char(50) DEFAULT NULL,
  `fantasia` char(50) DEFAULT NULL,
  `cnpj` char(50) DEFAULT NULL,
  `cep` char(50) DEFAULT NULL,
  `endereco` char(50) DEFAULT NULL,
  `telefone` char(50) DEFAULT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela matheus.pedidosi
CREATE TABLE IF NOT EXISTS `pedidosi` (
  `id_item` int(11) NOT NULL AUTO_INCREMENT,
  `id_pedido` int(11) DEFAULT NULL,
  `cod_produto` int(11) DEFAULT NULL,
  `quantidade` int(11) DEFAULT NULL,
  `valor_unit` int(11) DEFAULT NULL,
  `valor_total` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_item`),
  KEY `n_pedido` (`id_pedido`),
  KEY `cod_produto` (`cod_produto`),
  CONSTRAINT `id_pedido` FOREIGN KEY (`id_pedido`) REFERENCES `pedidosm` (`id_pedido`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela matheus.pedidosm
CREATE TABLE IF NOT EXISTS `pedidosm` (
  `id_pedido` int(11) NOT NULL AUTO_INCREMENT,
  `data_pedido` date DEFAULT NULL,
  `hora_pedido` time DEFAULT NULL,
  `cod_cliente` int(11) DEFAULT NULL,
  `subtotal_pedido` decimal(20,6) DEFAULT NULL,
  `total_desconto` decimal(20,6) DEFAULT NULL,
  `total_pedido` decimal(20,6) DEFAULT NULL,
  `status_pedido` varchar(50) DEFAULT 'Aberto',
  `pcent_desconto` int(2) DEFAULT NULL,
  PRIMARY KEY (`id_pedido`),
  KEY `Coluna 4` (`cod_cliente`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela matheus.produtos
CREATE TABLE IF NOT EXISTS `produtos` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `codigo_barras` char(13) DEFAULT NULL,
  `estoque` double(15,3) DEFAULT NULL,
  `nome` char(50) DEFAULT NULL,
  `descricao` char(50) DEFAULT NULL,
  `valor_unit` double(15,2) DEFAULT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
