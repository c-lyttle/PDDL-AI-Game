;The following problem displays personnel movement around the map
(define (problem problem1)
    (:domain planetDomain)
    
    (:objects
        ;Each personnel member
        commander1 engineer1 engineer2 scienceOfficer1 scienceOfficer2 security1
        ;Each location as an object
        l11 l12 l13 l14 l21 l22 l23 l24 l31 l32 l33 l34 l41 l42 l43 l44
        ;The terraformer
        terraformer1
        ;The planetary shield
        planetaryShield1
    )

    (:init
        ;Each personnel member
        (personnel commander1)
        (personnel engineer1)
        (personnel engineer2)
        (personnel scienceOfficer1)
        (personnel scienceOfficer2)
        (personnel security1)
        
        ;Their roles
        (isCommander commander1)
        (isEngineer engineer1)
        (isEngineer engineer2)
        (isScienceOfficer scienceOfficer1)
        (isScienceOfficer scienceOfficer2)
        (isSecurity security1)
        
        ;Terraformer
        (terraformer terraformer1)
        
        ;PlanetaryShield
        (PlanetaryShield planetaryShield1)
        
        ;Each grid location
        (location l11)
        (location l12)
        (location l13)
        (location l14)
        (location l21)
        (location l22)
        (location l23)
        (location l24)
        (location l31)
        (location l32)
        (location l33)
        (location l34)
        (location l41)
        (location l42)
        (location l43)
        (location l44)
        
        ;Each locations terrain
        (isMountainous l11)
        (isMountainous l12)
        (isFlat l13)
        (isHilly l14)
        (isFlat l21)
        (isFlat l22)
        (isHilly l23)
        (isHilly l24)
        (isMountainous l31)
        (isFlat l32)
        (isFlat l33)
        (isHilly l34)
        (isHilly l41)
        (isHilly l42)
        (isFlat l43)
        (isMountainous l44)
        
        ;Base location
        (isBase l33)
        
        ;Pirate occupied locations
        (isPirateOccupied l13)
        (isPirateOccupied l43)
        
        ;Start point for personnel
        (at commander1 l33)
        (at engineer1 l33)
        (at engineer2 l33)
        (at scienceOfficer1 l33)
        (at scienceOfficer2 l33)
        (at security1 l33)
        
        ;Definition of item distrubution
        (has2ShieldEmitters engineer1)
        (has2ShieldEmitters engineer2)
        (atBase terraformer1)
        
        ;Each regions adjacent regions
        ;Row 1
        (adjacent l11 l12)
        (adjacent l11 l21)
        
        (adjacent l12 l11)
        (adjacent l12 l13)
        (adjacent l12 l22)
        
        (adjacent l13 l12)
        (adjacent l13 l14)
        (adjacent l13 l23)
        
        (adjacent l14 l13)
        (adjacent l14 l24)
        
        ;Row 2
        (adjacent l21 l11)
        (adjacent l21 l22)
        (adjacent l21 l31)
        
        (adjacent l22 l21)
        (adjacent l22 l12)
        (adjacent l22 l23)
        (adjacent l22 l32)
        
        (adjacent l23 l22)
        (adjacent l23 l13)
        (adjacent l23 l24)
        (adjacent l23 l33)
        
        (adjacent l24 l23)
        (adjacent l24 l14)
        (adjacent l24 l34)
        
        ;Row 3
        (adjacent l31 l21)
        (adjacent l31 l32)
        (adjacent l31 l41)
        
        (adjacent l32 l31)
        (adjacent l32 l22)
        (adjacent l32 l33)
        (adjacent l32 l42)
        
        (adjacent l33 l32)
        (adjacent l33 l23)
        (adjacent l33 l34)
        (adjacent l33 l43)
        
        (adjacent l34 l24)
        (adjacent l34 l33)
        (adjacent l34 l44)
        
        ;Row 4
        (adjacent l41 l42)
        (adjacent l41 l31)
        
        (adjacent l42 l41)
        (adjacent l42 l43)
        (adjacent l42 l32)
        
        (adjacent l43 l42)
        (adjacent l43 l44)
        (adjacent l43 l33)
        
        (adjacent l44 l43)
        (adjacent l44 l34)
        
        ;Which locations are themselves (used to stop 1 shield form turning on planetary shield)
        ;Row 1
        (same l11,l11)
        (same l12,l12)
        (same l13,l13)
        (same l14,l14)
        ;Row2
        (same l21,l21)
        (same l22,l22)
        (same l23,l23)
        (same l24,l24)
        ;Row3
        (same l31,l31)
        (same l32,l32)
        (same l33,l33)
        (same l34,l34)
        ;Row3
        (same l41,l41)
        (same l42,l42)
        (same l43,l43)
        (same l44,l44)
        
    )
    
    (:goal
        (and
            (at commander1 l41)
        )
    )
)