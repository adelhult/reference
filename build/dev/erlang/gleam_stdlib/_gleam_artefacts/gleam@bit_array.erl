-module(gleam@bit_array).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch]).

-export([from_string/1, byte_size/1, slice/3, is_utf8/1, to_string/1, concat/1, append/2, base64_encode/2, base64_decode/1, base64_url_encode/2, base64_url_decode/1, base16_encode/1, base16_decode/1, inspect/1]).

-file("/home/eli/dev/reference/build/packages/gleam_stdlib/src/gleam/bit_array.gleam", 11).
-spec from_string(binary()) -> bitstring().
from_string(X) ->
    gleam_stdlib:identity(X).

-file("/home/eli/dev/reference/build/packages/gleam_stdlib/src/gleam/bit_array.gleam", 17).
-spec byte_size(bitstring()) -> integer().
byte_size(X) ->
    erlang:byte_size(X).

-file("/home/eli/dev/reference/build/packages/gleam_stdlib/src/gleam/bit_array.gleam", 42).
-spec slice(bitstring(), integer(), integer()) -> {ok, bitstring()} |
    {error, nil}.
slice(String, Position, Length) ->
    gleam_stdlib:bit_array_slice(String, Position, Length).

-file("/home/eli/dev/reference/build/packages/gleam_stdlib/src/gleam/bit_array.gleam", 55).
-spec do_is_utf8(bitstring()) -> boolean().
do_is_utf8(Bits) ->
    case Bits of
        <<>> ->
            true;

        <<_/utf8, Rest/binary>> ->
            do_is_utf8(Rest);

        _ ->
            false
    end.

-file("/home/eli/dev/reference/build/packages/gleam_stdlib/src/gleam/bit_array.gleam", 50).
-spec is_utf8(bitstring()) -> boolean().
is_utf8(Bits) ->
    do_is_utf8(Bits).

-file("/home/eli/dev/reference/build/packages/gleam_stdlib/src/gleam/bit_array.gleam", 83).
-spec do_to_string(bitstring()) -> {ok, binary()} | {error, nil}.
do_to_string(Bits) ->
    case is_utf8(Bits) of
        true ->
            {ok, gleam_stdlib:identity(Bits)};

        false ->
            {error, nil}
    end.

-file("/home/eli/dev/reference/build/packages/gleam_stdlib/src/gleam/bit_array.gleam", 75).
-spec to_string(bitstring()) -> {ok, binary()} | {error, nil}.
to_string(Bits) ->
    do_to_string(Bits).

-file("/home/eli/dev/reference/build/packages/gleam_stdlib/src/gleam/bit_array.gleam", 101).
-spec concat(list(bitstring())) -> bitstring().
concat(Bit_arrays) ->
    gleam_stdlib:bit_array_concat(Bit_arrays).

-file("/home/eli/dev/reference/build/packages/gleam_stdlib/src/gleam/bit_array.gleam", 28).
-spec append(bitstring(), bitstring()) -> bitstring().
append(First, Second) ->
    gleam_stdlib:bit_array_concat([First, Second]).

-file("/home/eli/dev/reference/build/packages/gleam_stdlib/src/gleam/bit_array.gleam", 107).
-spec base64_encode(bitstring(), boolean()) -> binary().
base64_encode(Input, Padding) ->
    gleam_stdlib:bit_array_base64_encode(Input, Padding).

-file("/home/eli/dev/reference/build/packages/gleam_stdlib/src/gleam/bit_array.gleam", 111).
-spec base64_decode(binary()) -> {ok, bitstring()} | {error, nil}.
base64_decode(Encoded) ->
    Padded = case erlang:byte_size(gleam_stdlib:identity(Encoded)) rem 4 of
        0 ->
            Encoded;

        N ->
            gleam@string:append(
                Encoded,
                gleam@string:repeat(<<"="/utf8>>, 4 - N)
            )
    end,
    gleam_stdlib:base_decode64(Padded).

-file("/home/eli/dev/reference/build/packages/gleam_stdlib/src/gleam/bit_array.gleam", 125).
-spec base64_url_encode(bitstring(), boolean()) -> binary().
base64_url_encode(Input, Padding) ->
    _pipe = gleam_stdlib:bit_array_base64_encode(Input, Padding),
    _pipe@1 = gleam@string:replace(_pipe, <<"+"/utf8>>, <<"-"/utf8>>),
    gleam@string:replace(_pipe@1, <<"/"/utf8>>, <<"_"/utf8>>).

-file("/home/eli/dev/reference/build/packages/gleam_stdlib/src/gleam/bit_array.gleam", 133).
-spec base64_url_decode(binary()) -> {ok, bitstring()} | {error, nil}.
base64_url_decode(Encoded) ->
    _pipe = Encoded,
    _pipe@1 = gleam@string:replace(_pipe, <<"-"/utf8>>, <<"+"/utf8>>),
    _pipe@2 = gleam@string:replace(_pipe@1, <<"_"/utf8>>, <<"/"/utf8>>),
    base64_decode(_pipe@2).

-file("/home/eli/dev/reference/build/packages/gleam_stdlib/src/gleam/bit_array.gleam", 142).
-spec base16_encode(bitstring()) -> binary().
base16_encode(Input) ->
    binary:encode_hex(Input).

-file("/home/eli/dev/reference/build/packages/gleam_stdlib/src/gleam/bit_array.gleam", 146).
-spec base16_decode(binary()) -> {ok, bitstring()} | {error, nil}.
base16_decode(Input) ->
    gleam_stdlib:base16_decode(Input).

-file("/home/eli/dev/reference/build/packages/gleam_stdlib/src/gleam/bit_array.gleam", 170).
-spec do_inspect(bitstring(), binary()) -> binary().
do_inspect(Input, Accumulator) ->
    case Input of
        <<>> ->
            Accumulator;

        <<X:1>> ->
            <<<<Accumulator/binary, (gleam@int:to_string(X))/binary>>/binary,
                ":size(1)"/utf8>>;

        <<X@1:2>> ->
            <<<<Accumulator/binary, (gleam@int:to_string(X@1))/binary>>/binary,
                ":size(2)"/utf8>>;

        <<X@2:3>> ->
            <<<<Accumulator/binary, (gleam@int:to_string(X@2))/binary>>/binary,
                ":size(3)"/utf8>>;

        <<X@3:4>> ->
            <<<<Accumulator/binary, (gleam@int:to_string(X@3))/binary>>/binary,
                ":size(4)"/utf8>>;

        <<X@4:5>> ->
            <<<<Accumulator/binary, (gleam@int:to_string(X@4))/binary>>/binary,
                ":size(5)"/utf8>>;

        <<X@5:6>> ->
            <<<<Accumulator/binary, (gleam@int:to_string(X@5))/binary>>/binary,
                ":size(6)"/utf8>>;

        <<X@6:7>> ->
            <<<<Accumulator/binary, (gleam@int:to_string(X@6))/binary>>/binary,
                ":size(7)"/utf8>>;

        <<X@7, Rest/bitstring>> ->
            Suffix = case Rest of
                <<>> ->
                    <<""/utf8>>;

                _ ->
                    <<", "/utf8>>
            end,
            Accumulator@1 = <<<<Accumulator/binary,
                    (gleam@int:to_string(X@7))/binary>>/binary,
                Suffix/binary>>,
            do_inspect(Rest, Accumulator@1);

        _ ->
            Accumulator
    end.

-file("/home/eli/dev/reference/build/packages/gleam_stdlib/src/gleam/bit_array.gleam", 165).
-spec inspect(bitstring()) -> binary().
inspect(Input) ->
    <<(do_inspect(Input, <<"<<"/utf8>>))/binary, ">>"/utf8>>.
