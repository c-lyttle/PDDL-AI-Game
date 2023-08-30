(define (domain planetDomain)
    (:requirements
        :strips :conditional-effects :typing
    )

    (:predicates
        (personnel ?p)
        (location ?l)
        (terraformer ?t)
        (planetaryShield ?s)
        (at ?p ?l)
        (adjacent ?l ?l)
        (same ?l ?l)
        
        ;Location states
        (isTerraformed ?l)
        (isPirateOccupied ?l)
        (isShielded ?l)
        (isBase ?l)
        (isGuarded ?l)
        
        ;Location terrain
        (isFlat ?l)
        (isHilly ?l)
        (isMountainous ?l)
        
        ;Personnel states
        (isCaptured ?p)
        (hasTerraformer ?p)
        (has2ShieldEmitters ?p)
        (hasShieldEmitter ?p)
        
        ;Roles
        (isCommander ?p)
        (isScienceOfficer ?p)
        (isEngineer ?p)
        (isSecurity ?p)
        
        ;Terraformer states
        (isBroken ?t)
        (isDischarged ?t)
        (atBase ?t)
        
        ;Planetary shield states
        (isEstablished ?s)
        (isOn ?s)
        
    )
    
    (:action move
        :parameters
            (?p ?l1 ?l2)
        :precondition
            (and
                (personnel ?p)
                (location ?l1)
                (location ?l2)
                (at ?p ?l1)
                (adjacent ?l1 ?l2)
                (not(isCaptured ?p))
                (or
                    (isFlat ?l2)
                    (isHilly ?l2)
                )
            )
        :effect
            (and
                (not(at ?p ?l1))
                (at ?p ?l2)
                (when(isSecurity ?p)
                    (and
                        (isGuarded ?l2)
                        (not(isGuarded ?l1))
                    )
                )
                (when
                    (and
                        (isPirateOccupied ?l2)
                        (not(isSecurity ?p))
                        (not(isGuarded ?l2))
                    )
                    (isCaptured ?p)
                )
            )
    )
    
    
    (:action placeShield
        :parameters
            (?p ?l)
        :precondition
            (and
                (personnel ?p)
                (location ?l)
                (at ?p ?l)
                (isEngineer ?p)
                (not(isPirateOccupied ?l))
                (or
                    (hasShieldEmitter ?p)
                    (has2ShieldEmitterS ?p)
                )
                (not(isShielded ?l))
                (isFlat ?l)
            )
        :effect
            (and
                (when (has2ShieldEmitters ?p)
                    (and
                        (not(has2ShieldEmitters ?p))
                        (hasShieldEmitter ?p)
                        (isShielded ?l)
                    )
                )
                (when (hasShieldEmitter ?p)
                    (and
                        (not(hasShieldEmitter ?p))
                        (isShielded ?l)    
                    )
                )
            )
    )
    
    (:action negotiateRelease
        :parameters
            (?p1 ?p2 ?l)
        :precondition
            (and
                (personnel ?p1)
                (personnel ?p2)
                (location ?l)
                (at ?p1 ?l)
                (at ?p2 ?l)
                (isCaptured ?p2)
                (not(isCaptured ?p1))
                (isCommander ?p1)
                (isGuarded ?l)
            )
        :effect
            (and
                (not(isCaptured ?p2))
            )
    
    
    )
    
    (:action terraform
        :parameters
            (?p ?l ?t)
        :precondition
            (and
                (personnel ?p)
                (location ?l)
                (terraformer ?t)
                (at ?p ?l)
                (isScienceOfficer ?p)
                (hasTerraformer ?p)
                (not(isBroken ?t))
                (not(isDischarged ?t))
                (or
                    (isFlat ?l)
                    (isHilly ?l)
                )
            )
        :effect
            (and
                (when (not(isShielded ?l))
                    (and
                        (isBroken ?t)
                    )
                )
                (isDischarged ?t)
                (isTerraformed ?l)
            )
    )
    
    (:action depositTerraformer
        :parameters 
            (?p ?l ?t)
        :precondition
            (and
                (personnel ?p)
                (location ?l)
                (terraformer ?t)
                (at ?p ?l)
                (isScienceOfficer ?p)
                (hasTerraformer ?p)
                (isBase ?l)
                (not(atBase ?t))
            )
        :effect
            (and
                (not(hasTerraformer ?p))
                (atBase ?t)
            )
    )
    
    (:action retrieveTerraformer
        :parameters
            (?p ?l ?t)
        :precondition
            (and
                (personnel ?p)
                (location ?l)
                (terraformer ?t)
                (at ?p ?l)
                (isScienceOfficer ?p)
                (not(hasTerraFormer ?p))
                (isBase ?l)
                (atBase ?t)
                
            )
        :effect
            (and
                (hasTerraFormer ?p)
                (not(atBase ?t))
            )
    )
    
    (:action fixTerraformer
        :parameters
            (?p ?l ?t)
        :precondition
            (and
                (personnel ?p)
                (location ?l)
                (terraformer ?t)
                (at ?p ?l)
                (isEngineer ?p)
                (isBase ?l)
                (atBase ?t)
                (isBroken ?t)
            )
        :effect
            (and
                (not(isBroken ?t))
            )
    )
    
    (:action chargeTerraformer
        :parameters
            (?p ?l ?t)
        :precondition
            (and
                (personnel ?p)
                (location ?l)
                (terraformer ?t)
                (at ?p ?l)
                (isScienceOfficer ?p)
                (isBase ?l)
                (atBase ?t)
                (isDischarged ?t)
                (not(isBroken ?t))
            )
        :effect
            (and
                (not(isDischarged ?t))
            )
    )
    
    (:action establishPlanetaryShield
        :parameters
            (?l1 ?l2 ?l3 ?s)
        :precondition
            (and
                (location ?l1)
                (location ?l2)
                (location ?l3)
                (not(same ?l1 ?l2))
                (not(same ?l2 ?l3))
                (not(same ?l1 ?l3))
                (planetaryShield ?s)
                (not(isEstablished ?s))
                (isShielded ?l1)
                (isShielded ?l2)
                (isShielded ?l3)
            )
        :effect
            (and
                (isEstablished ?s)
            )
    )
    
    (:action turnOnPlanetaryShield
        :parameters
            (?p ?l ?s)
        :precondition
            (and
                (personnel ?p)
                (location ?l)
                (planetaryShield ?s)
                (at ?p ?l)
                (isCommander ?p)
                (isBase ?l)
                (isEstablished ?s)
            )
        :effect
            (and
                (isOn ?s)
            )
    )
    
    
 )   