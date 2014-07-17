create or replace package utl authid definer is
/*  Copyright (c) 2014, Ruby Willow, Inc.
    All rights reserved.

    Redistribution and use in source and binary forms, with or without modification,
    are permitted provided that the following conditions are met:

    Redistributions of source code must retain the above copyright notice,
    this list of conditions and the following disclaimer.

    Redistributions in binary form must reproduce the above copyright notice, this list of
    conditions and the following disclaimer in the documentation
    and/or other materials provided with the distribution.

    Neither the name of Ruby Willow, Inc. nor the names of its contributors may be used to
    endorse or promote products derived from this software without specific prior written permission.

    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR
    IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY
    AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER
    OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
    CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
    SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
    THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
    OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
    EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

-- a convenient type for use in any PL/SQL package.
subtype text is varchar2(32760);

-- associative arrays (also known as "Index By" [ib] tables)
-- These essentially mirror the SQL array/table types that
-- are defined in this schema.
type stribstr is table of text index by text;
type stribint is table of text index by binary_integer;

type numibstr is table of number index by text;
type numibint is table of number index by binary_integer;

type tsibstr is table of timestamp index by text;
type tsibint is table of timestamp index by binary_integer;

type tstzibstr is table of timestamp with time zone index by text;
type tstzibint is table of timestamp with time zone index by binary_integer;

-- if a non-null string is passed to this procedure, an exception is thrown
procedure checkError
  ( iError  in  varchar2 );

/*  FUNCTION SPLIT_STRING_...

    Return a table of strings based on the delimiter.
    This is implemented in Java using the String.split() method, so
    the delimiter is a Regular Expression.

    By default, the array and the strings in the array are trimmed.
    If you want to leave things untrimmed, then pass NULL or anything
    other than "*" (star/asterisk/splat) for RETURN_TRIM

    As you can see, there is a version for strtable and strarray
*/
function split_string_strtable
  ( string_to_split    in   varchar2,
    delimiter          in   varchar2,
    return_trim        in   varchar2 default '*' )
  return strtable deterministic;

function split_string_strarray
  ( string_to_split    in   varchar2,
    delimiter          in   varchar2,
    return_trim        in   varchar2 default '*' )
  return strarray deterministic;

/*  FUNCTION RANDOM_GUID

    Return a pseudo-random GUID. Implemented in Java using the UUID.randomUUID() method.
    The Java implementation returns a string with dashes. This function strips the
    dashes and returns raw bytes.
*/
function random_guid
  return raw;

end utl;
/
show errors package utl

grant execute on utl to public
/

create or replace public synonym utl for utl
/