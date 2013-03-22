#!/usr/bin/perl

# 
# Copyright (c) 2013 Northwestern Polytechnical University, China
# All rights reserved.
# 
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 
# - Redistributions of source code must retain the above copyright
#   notice, this list of conditions and the following disclaimer.
# 
# - Redistributions in binary form must reproduce the above copyright
#   notice, this list of conditions and the following disclaimer in the
#   documentation and/or other materials provided with the
#   distribution.
# 
# - Neither the name of the copyright holders nor the names of
#   its contributors may be used to endorse or promote products derived
#   from this software without specific prior written permission.
# 
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
# FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL
# THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
# INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
# STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
# OF THE POSSIBILITY OF SUCH DAMAGE.
# 
# 

# Author: Qiu Ying <qiuying@mail.nwpu.edu.cn>
# 

$TOSDIR = $ENV{"TOSDIR"} if defined($ENV{"TOSDIR"});
$platform_dir = "$TOSDIR/platforms/cc2530";
$platform_def = "$platform_dir/.platform";
$target="cc2530";

do $platform_def;

push @includes, "%T/interfaces";
push @includes, "%T/types";
push @includes, "%T/system";

foreach $idir (@includes) {
    $idir = &idir_subst($idir);
    push @new_args, "-I$idir";
}

unshift @new_args, "-DPLATFORM_\U$target";
push @new_args, @opts;

print join(' ', @new_args);

sub idir_subst {
    local ($idir) = @_;
    local $idx = 0;

    while (($idx = index $idir, "%", $idx) >= 0) {
	$char = substr $idir, $idx + 1, 1;
	$rep = 0;
	$rep = "%" if $char eq "%";
	$rep = $TOSDIR if $char eq "T";
	$rep = $target if $char eq "p";
	$rep = $platform_dir if $char eq "P";
	&fail("unknown include-path substitution %" . $char) if !$rep;
	substr($idir, $idx, 2) = $rep;
	$idx += length $rep;
    }
    return $idir;
}
