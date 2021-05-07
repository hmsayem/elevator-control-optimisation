(define (domain elevators-sequencedstrips)
  (:requirements :typing :action-costs :negative-preconditions :conditional-effects)
  (:types
    elevator passenger count - object
    slow-elevator fast-elevator - elevator
    teacher general - passenger
  )

  (:predicates
    (origin ?person - passenger ?floor - count)
    (dest ?person - passenger ?floor - count)
    (boarded ?person - passenger ?lift - elevator)
    (served ?person - passenger)
    (is-special ?person - passenger)
    (lift-at ?lift - elevator ?floor - count)
    (reachable-floor ?lift - elevator ?floor - count)
    (above ?floor1 - count ?floor2 - count)
    (passengers ?lift - elevator ?n - count)
    (can-hold ?lift - elevator ?n - count)
    (next ?n1 - count ?n2 - count)
    (contains-special ?lift - elevator)
    (is-restricted ?lift - elevator)

  )

  (:functions
    (total-cost) - number
    (travel-slow ?f1 - count ?f2 - count) - number
    (travel-fast ?f1 - count ?f2 - count) - number
  )

  (:action up-slow
    :parameters (?lift - slow-elevator ?f1 - count ?f2 - count)
    :precondition (and
      (lift-at ?lift ?f1)
      (above ?f1 ?f2)
      (reachable-floor ?lift ?f2))
    :effect (and
      (lift-at ?lift ?f2)
      (not (lift-at ?lift ?f1))
      (increase (total-cost) (travel-slow ?f1 ?f2)))
  )

  (:action down-slow
    :parameters (?lift - slow-elevator ?f1 - count ?f2 - count)
    :precondition (and
      (lift-at ?lift ?f1)
      (above ?f2 ?f1)
      (reachable-floor ?lift ?f2))
    :effect (and
      (lift-at ?lift ?f2)
      (not (lift-at ?lift ?f1))
      (increase (total-cost) (travel-slow ?f2 ?f1)))
  )

  (:action up-fast
    :parameters (?lift - fast-elevator ?f1 - count ?f2 - count)
    :precondition (and
      (lift-at ?lift ?f1)
      (above ?f1 ?f2)
      (reachable-floor ?lift ?f2))
    :effect (and
      (lift-at ?lift ?f2)
      (not (lift-at ?lift ?f1))
      (increase (total-cost) (travel-fast ?f1 ?f2)))
  )

  (:action down-fast
    :parameters (?lift - fast-elevator ?f1 - count ?f2 - count)
    :precondition (and
      (lift-at ?lift ?f1)
      (above ?f2 ?f1)
      (reachable-floor ?lift ?f2))
    :effect (and
      (lift-at ?lift ?f2)
      (not (lift-at ?lift ?f1))
      (increase (total-cost) (travel-fast ?f2 ?f1)))
  )

  (:action load-teacher
    :parameters (?p - teacher ?lift - fast-elevator ?f - count ?n1 - count ?n2 - count)
    :precondition (and
      (forall
        (?l - elevator)
        (not (boarded ?p ?l)))
      (not (served ?p))
      (is-restricted ?lift)
      (lift-at ?lift ?f)
      (origin ?p ?f)
      (passengers ?lift ?n1)
      (next ?n1 ?n2)
      (can-hold ?lift ?n2))
    :effect (and
      (boarded ?p ?lift)
      (not (passengers ?lift ?n1))
      (passengers ?lift ?n2))
  )

  (:action unload-teacher
    :parameters (?p - teacher ?lift - fast-elevator ?f - count ?n1 - count ?n2 - count)
    :precondition (and
      (dest ?p ?f)
      (is-restricted ?lift)
      (lift-at ?lift ?f)
      (boarded ?p ?lift)
      (passengers ?lift ?n1)
      (next ?n2 ?n1))
    :effect (and
      (served ?p)
      (not (boarded ?p ?lift))
      (not (passengers ?lift ?n1))
      (passengers ?lift ?n2))
  )

  (:action load-special
    :parameters (?p - passenger ?lift - fast-elevator ?f - count ?n1 - count ?n2 - count)
    :precondition (and
      (forall
        (?l - elevator)
        (not (boarded ?p ?l)))
      (is-special ?p)
      (not(is-restricted ?lift))
      (not (served ?p))
      (not(contains-special ?lift))
      (lift-at ?lift ?f)
      (origin ?p ?f)
      (passengers ?lift ?n1)
      (next ?n1 ?n2)
      (can-hold ?lift ?n2))
    :effect (and
      (contains-special ?lift)
      (boarded ?p ?lift)
      (not (passengers ?lift ?n1))
      (passengers ?lift ?n2))
  )

  (:action unload-special
    :parameters (?p - passenger ?lift - fast-elevator ?f - count ?n1 - count ?n2 - count)
    :precondition (and
      (is-special ?p)
      (dest ?p ?f)
      (lift-at ?lift ?f)
      (boarded ?p ?lift)
      (passengers ?lift ?n1)
      (next ?n2 ?n1))
    :effect (and
      (served ?p)
      (not (boarded ?p ?lift))
      (not (passengers ?lift ?n1))
      (passengers ?lift ?n2)
      (not(contains-special ?lift)))
  )

  (:action load-general
    :parameters (?p - passenger ?lift - elevator ?f - count ?n1 - count ?n2 - count)
    :precondition (and
      (forall
        (?l - elevator)
        (not (boarded ?p ?l)))
      (not(is-restricted ?lift))
      (not(is-special ?p))
      (not (served ?p))
      (not(contains-special ?lift))
      (lift-at ?lift ?f)
      (origin ?p ?f)
      (passengers ?lift ?n1)
      (next ?n1 ?n2)
      (can-hold ?lift ?n2))
    :effect (and
      (boarded ?p ?lift)
      (not (passengers ?lift ?n1))
      (passengers ?lift ?n2))
  )

  (:action unload-general
    :parameters (?p - general ?lift - elevator ?f - count ?n1 - count ?n2 - count)
    :precondition (and
      (not(is-restricted ?lift))
      (not(is-special ?p))
      (not(contains-special ?lift))
      (dest ?p ?f)
      (lift-at ?lift ?f)
      (boarded ?p ?lift)
      (passengers ?lift ?n1)
      (next ?n2 ?n1))
    :effect (and
      (served ?p)
      (not (boarded ?p ?lift))
      (not (passengers ?lift ?n1))
      (passengers ?lift ?n2))
  )
)