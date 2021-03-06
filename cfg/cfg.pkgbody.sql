create or replace package body cfg is
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

-------------------------------------------------------------------------------
function getCfg
  ( iName         in varchar2 )
  return anydata
is
  vRslt  anydata;
begin

  select z.value
    into vRslt
    from dual
    left join "cfg" z
      on z.name = lower(trim(iName));

  return vRslt;

end getCfg;
-------------------------------------------------------------------------------
function getCfgString
  ( iName         in varchar2 )
  return varchar2
is
  vRslt  utl.text;
begin

  select cfg.getCfg(iName).accessVarchar2()
    into vRslt
    from dual;

  return vRslt;

end getCfgString;
-------------------------------------------------------------------------------
function getCfgNumber
  ( iName         in varchar2 )
  return number
is
  vRslt  number;
begin

  select cfg.getCfg(iName).accessNumber()
    into vRslt
    from dual;

  return vRslt;

end getCfgNumber;
-------------------------------------------------------------------------------
function getCfgTimestamp
  ( iName         in varchar2 )
  return timestamp
is
  vRslt  timestamp;
begin

  select cfg.getCfg(iName).accessTimestamp()
    into vRslt
    from dual;

  return vRslt;

end getCfgTimestamp;
-------------------------------------------------------------------------------
function getCfgRaw
  ( iName         in varchar2 )
  return raw
is
  vRslt  raw(2000);
begin

  select cfg.getCfg(iName).accessRaw()
    into vRslt
    from dual;

  return vRslt;

end getCfgRaw;
-------------------------------------------------------------------------------
end cfg;
/
show errors package body cfg
