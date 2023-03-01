<?php

namespace App\Entity;

use App\Repository\AisShipTypeRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: AisShipTypeRepository::class)]
class AisShipType
{
    #[Assert\Unique(fields:['aisShipType'])]
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column]
    #[Assert\Range(
            min: 1,
            max: 9,
            notInRangeMessage: 'Le type AIS doit être compris entre {{ min }} et {{ max }}',
    )]
    private ?int $aisShipType = null;

    #[ORM\Column(length: 60)]
    private ?string $libelle = null;

    #[ORM\OneToMany(mappedBy: 'AisShipType', targetEntity: Navire::class)]
    private Collection $navires;

    #[ORM\ManyToMany(targetEntity: Port::class, mappedBy: 'types')]
    private Collection $portsCompatibles;

    public function __construct()
    {
        $this->navires = new ArrayCollection();
        $this->portsCompatibles = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getAisShipType(): ?int
    {
        return $this->aisShipType;
    }

    public function setAisShipType(int $aisShipType): self
    {
        $this->aisShipType = $aisShipType;

        return $this;
    }

    public function getLibelle(): ?string
    {
        return $this->libelle;
    }

    public function setLibelle(string $libelle): self
    {
        $this->libelle = $libelle;

        return $this;
    }

    /**
     * @return Collection<int, Navire>
     */
    public function getNavires(): Collection
    {
        return $this->navires;
    }

    public function addNavire(Navire $navire): self
    {
        if (!$this->navires->contains($navire)) {
            $this->navires->add($navire);
            $navire->setAisShipType($this);
        }

        return $this;
    }

    public function removeNavire(Navire $navire): self
    {
        if ($this->navires->removeElement($navire)) {
            // set the owning side to null (unless already changed)
            if ($navire->getAisShipType() === $this) {
                $navire->setAisShipType(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, Port>
     */
    public function getPorts(): Collection
    {
        return $this->portsCompatibles;
    }

    public function addPort(Port $port): self
    {
        if (!$this->portsCompatibles->contains($port)) {
            $this->portsCompatibles->add($port);
            $port->addType($this);
        }

        return $this;
    }

    public function removePort(Port $port): self
    {
        if ($this->portsCompatibles->removeElement($port)) {
            $port->removeType($this);
        }

        return $this;
    }
}
