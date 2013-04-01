#!/usr/bin/python

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

import re
import sys

fin = file(sys.argv[1])
fout = file(sys.argv[2], "w")
fout.write("#include <ioCC2530.h>\n")
fout.write("typedef signed   long int32_t;\n")
fout.write("typedef unsigned long uint32_t;\n")

lines = fin.readlines()
for line in lines:
    m_lineno = re.match(r'^#\s*(line)?\s*\d+.*$', line)
    m_null = re.match(r'^\s*$', line)
    m_silly = re.match(r'^.*__nesc_sillytask_.*$', line)

    line = re.sub(r"/\*([^\*]|(\*)*[^\*/])*(\*)*\*/", '', line)
    line = re.sub(r'\b__extension__\b', '', line)
    line = re.sub(r'\b__inline\b', 'inline', line)

    m_attrs = re.findall(r'(__attribute(__)?\(\((\w*)\)\))', line)

    for m_attr in m_attrs:
        matched_attr = m_attr[0]
        attr = m_attr[2]
        if attr == 'interrupt':
            line = line.replace(matched_attr, '__interrupt')
        elif attr == 'delete_this_line':
            line = ""
        elif re.match(r'\w+_VECTOR', attr):
            line = line.replace(matched_attr, '_Pragma("vector=%s") ' % attr)
        else:
            line = line.replace(matched_attr, '');

    if not m_lineno and not m_null and not m_silly:
        fout.write(line)

