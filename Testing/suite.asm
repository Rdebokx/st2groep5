
    ;   TEST ADDRESSING MODES

    processor   6502

    org    1

    inc
    inc    $1
    inc    1,x
    inc    1000
    inc    1000,x


    lsr
    lsr    1
    lsr    1,x
    lsr    1000
    lsr    1000,x
    stp


