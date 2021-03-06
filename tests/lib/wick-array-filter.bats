#!../bats/bats

setup() {
    load ../wick-test-base
    . "$WICK_DIR/lib/wick-indirect"
    . "$WICK_DIR/lib/wick-indirect-array"
    . "$WICK_DIR/lib/wick-array-filter"
    . "$WICK_DIR/lib/wick-strict-run"
}

removeLeadingA() {
    [[ "${1:0:1}" != "a" ]]
}

@test "lib/wick-array-filter: none match" {
    local X

    X=(b1 b2 b3 " " b4)
    wickArrayFilter X removeLeadingA "${X[@]}"
    [[ "${#X[@]}" == 5 ]]
    [[ "${X[@]}" == "b1 b2 b3   b4" ]]
}

@test "lib/wick-array-filter: removing some" {
    local X

    X=(a1 b1 a2 b2 a3)
    wickArrayFilter X removeLeadingA "${X[@]}"
    [[ "${#X[@]}" == 2 ]]
    [[ "${X[@]}" == "b1 b2" ]]
}

@test "lib/wick-array-filter: removing all elements" {
    local X

    X=(a1 a2 a3)
    wickArrayFilter X removeLeadingA "${X[@]}"
    [[ "${#X[@]}" == 0 ]]
    [[ "${X[@]}" == "" ]]
}
