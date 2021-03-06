module MyFirstTest exposing (..)

import Expect
import Fuzz exposing (..)
import Main
import Test exposing (..)


suite =
    describe "My First Tests"
        [ test "Shring text should work" testShrinkText
        , test "Shring teest2 should work" testShrinkText2
        , test "1+1 should be 2" test1Plus1
        , fuzz int "n+0 should be n" testNPlusZero
        , fuzz int "n + n should be greated then n" testNGreater
        , fuzz string "shrink random text" testRandomShrink
        , fuzz (tuple ( int, string )) "Full shrink random text" testFullRandomShrink
        ]


testShrinkText _ =
    let
        result =
            Main.shrinkText 20 "This is a test"

        ok =
            result == "This is a test"
    in
    Expect.true "shrinked" ok


testShrinkText2 _ =
    let
        result =
            Main.shrinkText 5 "This is a test"

        ok =
            result == "This  ..."
    in
    Expect.true "shrinked ok" ok


testNPlusZero n =
    let
        result =
            n + 0

        ok =
            result == n
    in
    Expect.true "n greater" ok


testNGreater n =
    let
        result =
            n + n

        ok =
            result >= n
    in
    if n < 0 then
        Expect.pass

    else
        Expect.true (String.fromInt result) ok


testRandomShrink text =
    let
        result =
            Main.shrinkText 5 text

        ok =
            String.length result <= 9
    in
    Expect.true result ok


test1Plus1 _ =
    let
        result =
            1 + 1

        ok =
            result == 2
    in
    Expect.true "1 + 1" ok


testFullRandomShrink ( max, text ) =
    let
        result =
            Main.shrinkText max text

        ok =
            String.length result <= max + 4
    in
    if max <= 0 then
        Expect.pass

    else
        Expect.true result ok
