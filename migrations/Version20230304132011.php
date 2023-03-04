<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20230304132011 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE TABLE aisshiptype (id INT AUTO_INCREMENT NOT NULL, ais_ship_type INT NOT NULL, libelle VARCHAR(60) NOT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE escale (id INT AUTO_INCREMENT NOT NULL, idnavire INT NOT NULL, idport INT NOT NULL, dateHeureArrivee DATETIME NOT NULL, dateHeureDepart DATETIME DEFAULT NULL, INDEX IDX_C39FEDD36A50BD94 (idnavire), INDEX IDX_C39FEDD3905EAC6C (idport), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE message (id INT AUTO_INCREMENT NOT NULL, nom VARCHAR(100) NOT NULL, prenom VARCHAR(100) NOT NULL, mail VARCHAR(255) NOT NULL, message LONGTEXT NOT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE navire (id INT AUTO_INCREMENT NOT NULL, idaisshiptype INT NOT NULL, idpays INT NOT NULL, idport INT DEFAULT NULL, imo VARCHAR(7) NOT NULL, nom VARCHAR(255) NOT NULL, mmsi VARCHAR(9) NOT NULL, indicatifappel VARCHAR(10) NOT NULL, eta DATETIME DEFAULT NULL, longueur INT NOT NULL, largeur INT NOT NULL, tirantdeau DOUBLE PRECISION NOT NULL, INDEX IDX_EED103839F5FA88 (idaisshiptype), INDEX IDX_EED1038E750CD0E (idpays), INDEX IDX_EED1038905EAC6C (idport), INDEX ind_IMO (imo), INDEX ind_MMSI (mmsi), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE pays (id INT AUTO_INCREMENT NOT NULL, nom VARCHAR(70) NOT NULL, indicatif VARCHAR(3) NOT NULL, INDEX ind_indicatif (indicatif), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE port (id INT AUTO_INCREMENT NOT NULL, idpays INT NOT NULL, nom VARCHAR(70) NOT NULL, indicatif VARCHAR(5) NOT NULL, INDEX IDX_43915DCCE750CD0E (idpays), INDEX ind_INDICATIF (indicatif), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE porttypecompatible (idport INT NOT NULL, idaisshiptype INT NOT NULL, INDEX IDX_2C02FFDB905EAC6C (idport), INDEX IDX_2C02FFDB39F5FA88 (idaisshiptype), PRIMARY KEY(idport, idaisshiptype)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('ALTER TABLE escale ADD CONSTRAINT FK_C39FEDD36A50BD94 FOREIGN KEY (idnavire) REFERENCES navire (id)');
        $this->addSql('ALTER TABLE escale ADD CONSTRAINT FK_C39FEDD3905EAC6C FOREIGN KEY (idport) REFERENCES port (id)');
        $this->addSql('ALTER TABLE navire ADD CONSTRAINT FK_EED103839F5FA88 FOREIGN KEY (idaisshiptype) REFERENCES aisshiptype (id)');
        $this->addSql('ALTER TABLE navire ADD CONSTRAINT FK_EED1038E750CD0E FOREIGN KEY (idpays) REFERENCES pays (id)');
        $this->addSql('ALTER TABLE navire ADD CONSTRAINT FK_EED1038905EAC6C FOREIGN KEY (idport) REFERENCES port (id)');
        $this->addSql('ALTER TABLE port ADD CONSTRAINT FK_43915DCCE750CD0E FOREIGN KEY (idpays) REFERENCES pays (id)');
        $this->addSql('ALTER TABLE porttypecompatible ADD CONSTRAINT FK_2C02FFDB905EAC6C FOREIGN KEY (idport) REFERENCES port (id)');
        $this->addSql('ALTER TABLE porttypecompatible ADD CONSTRAINT FK_2C02FFDB39F5FA88 FOREIGN KEY (idaisshiptype) REFERENCES aisshiptype (id)');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE escale DROP FOREIGN KEY FK_C39FEDD36A50BD94');
        $this->addSql('ALTER TABLE escale DROP FOREIGN KEY FK_C39FEDD3905EAC6C');
        $this->addSql('ALTER TABLE navire DROP FOREIGN KEY FK_EED103839F5FA88');
        $this->addSql('ALTER TABLE navire DROP FOREIGN KEY FK_EED1038E750CD0E');
        $this->addSql('ALTER TABLE navire DROP FOREIGN KEY FK_EED1038905EAC6C');
        $this->addSql('ALTER TABLE port DROP FOREIGN KEY FK_43915DCCE750CD0E');
        $this->addSql('ALTER TABLE porttypecompatible DROP FOREIGN KEY FK_2C02FFDB905EAC6C');
        $this->addSql('ALTER TABLE porttypecompatible DROP FOREIGN KEY FK_2C02FFDB39F5FA88');
        $this->addSql('DROP TABLE aisshiptype');
        $this->addSql('DROP TABLE escale');
        $this->addSql('DROP TABLE message');
        $this->addSql('DROP TABLE navire');
        $this->addSql('DROP TABLE pays');
        $this->addSql('DROP TABLE port');
        $this->addSql('DROP TABLE porttypecompatible');
    }
}
