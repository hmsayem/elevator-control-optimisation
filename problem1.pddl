(define (problem elevators-sequencedstrips-task1)
    (:domain elevators-sequencedstrips)

    (:objects
        n0 n1 n2 n3 n4 n5 - count
        p0 p1 p2 p3 - general
        t0 t1 - teacher
        faculty all - fast-elevator
        even odd - slow-elevator
    )

    (:init

        (is-special p1)
        (is-restricted faculty)

        (next n0 n1)
        (next n1 n2)
        (next n2 n3)
        (next n3 n4)
        (next n4 n5)

        (above n0 n1)
        (above n0 n2)
        (above n0 n3)
        (above n0 n4)
        (above n0 n5)
        (above n1 n2)
        (above n1 n3)
        (above n1 n4)
        (above n1 n5)
        (above n2 n3)
        (above n2 n4)
        (above n2 n5)
        (above n3 n4)
        (above n3 n5)
        (above n4 n5)

        (lift-at faculty n0)
        (passengers faculty n0)
        (can-hold faculty n1)
        (can-hold faculty n2)
        (can-hold faculty n3)
        (can-hold faculty n4)
        (can-hold faculty n5)
        (reachable-floor faculty n0)
        (reachable-floor faculty n1)
        (reachable-floor faculty n2)
        (reachable-floor faculty n3)
        (reachable-floor faculty n4)
        (reachable-floor faculty n5)

        (lift-at all n0)
        (passengers all n0)
        (can-hold all n1)
        (can-hold all n2)
        (can-hold all n3)
        (can-hold all n4)
        (can-hold all n5)
        (reachable-floor all n0)
        (reachable-floor all n1)
        (reachable-floor all n2)
        (reachable-floor all n3)
        (reachable-floor all n4)
        (reachable-floor all n5)

        (lift-at even n0)
        (passengers even n0)
        (can-hold even n1)
        (can-hold even n2)
        (can-hold even n3)
        (can-hold even n4)
        (can-hold even n5)
        (reachable-floor even n0)
        (reachable-floor even n2)
        (reachable-floor even n4)

        (lift-at odd n0)
        (passengers odd n0)
        (can-hold odd n1)
        (can-hold odd n2)
        (can-hold odd n3)
        (can-hold odd n4)
        (can-hold odd n5)
        (reachable-floor odd n0)
        (reachable-floor odd n1)
        (reachable-floor odd n3)
        (reachable-floor odd n5)

        (origin p0 n5)
        (origin p1 n3)
        (origin p2 n4)
        (origin p3 n2)
        (origin t0 n3)
        (origin t1 n1)

        (dest p0 n1)
        (dest p1 n0)
        (dest p2 n5)
        (dest p3 n4)
        (dest t0 n0)
        (dest t1 n5)

        (= (travel-slow n0 n1) 6)
        (= (travel-slow n0 n2) 7)
        (= (travel-slow n0 n3) 8)
        (= (travel-slow n0 n4) 9)
        (= (travel-slow n0 n5) 10)

        (= (travel-slow n1 n2) 6)
        (= (travel-slow n1 n3) 7)
        (= (travel-slow n1 n4) 8)
        (= (travel-slow n1 n5) 9)

        (= (travel-slow n2 n3) 6)
        (= (travel-slow n2 n4) 7)
        (= (travel-slow n2 n5) 8)

        (= (travel-slow n3 n4) 6)
        (= (travel-slow n3 n5) 7)

        (= (travel-slow n4 n5) 6)

        (= (travel-fast n0 n1) 6)
        (= (travel-fast n0 n2) 7)
        (= (travel-fast n0 n3) 10)
        (= (travel-fast n0 n4) 13)
        (= (travel-fast n0 n5) 16)

        (= (travel-fast n1 n2) 6)
        (= (travel-fast n1 n3) 7)
        (= (travel-fast n1 n4) 10)
        (= (travel-fast n1 n5) 13)

        (= (travel-fast n2 n3) 6)
        (= (travel-fast n2 n4) 7)
        (= (travel-fast n2 n5) 10)

        (= (travel-fast n3 n4) 6)
        (= (travel-fast n3 n5) 7)

        (= (travel-fast n4 n5) 6)

        (= (total-cost) 0)
    )

    (:goal
        (and
            (served p0)
            (served p1)
            (served p2)
            (served p3)
            (served t0)
            (served t1)
        )
    )

    (:metric minimize(total-cost)
    )

)