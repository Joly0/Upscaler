echo >/dev/null # >nul & GOTO WINDOWS & rem ^
#
# BSD 3-Clause License
#
# Copyright (c) 2023, Joly0
# Copyright (c) 2023, (Holloway) Chew, Kean Ho
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# 1. Redistributions of source code must retain the above copyright notice, this
#    list of conditions and the following disclaimer.
#
# 2. Redistributions in binary form must reproduce the above copyright notice,
#    this list of conditions and the following disclaimer in the documentation
#    and/or other materials provided with the distribution.
#
# 3. Neither the name of the copyright holder nor the names of its
#    contributors may be used to endorse or promote products derived from
#    this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
################################################################################
# Unix Main Codes                                                              #
################################################################################
repo="$(command -v $0)"
repo="${repo%%start.cmd}"
"${repo}/init/unix.sh" "$@"
################################################################################
# Unix Main Codes                                                              #
################################################################################
exit $?




:WINDOWS
::##############################################################################
:: Windows Main Codes                                                          #
::##############################################################################
@echo off
setlocal EnableDelayedExpansion
IF "%*"=="" ( goto :empty )
set location=%~dp0init\windows.ps1
set location="%location%"
set _parameters=%*

:replace_tabs
:: Replace all tabs with single spaces
set "_parameters=%_parameters:	= %"
if "%_parameters%" neq "%_parameters:	= %" goto replace_tabs

:clean_spaces_before_double_dash
:: Replace any number of spaces before double dashes with a single space
set "_parameters=%_parameters:   --= --%"
set "_parameters=%_parameters:  --= --%"
set "_parameters=%_parameters: --= --%"
:: Repeat if needed
if "%_parameters%" neq "%_parameters:  --= --%" goto clean_spaces_before_double_dash

set _parameters=!_parameters:--input=--path!
set _parameters=!_parameters:--=-!
set _parameters=!_parameters:"=\"!
call Pwsh.exe -NoProfile -executionpolicy bypass -Command "& '%location%' %_parameters%"
EXIT /B

:empty
set location=%~dp0init\windows.ps1
set location="%location%"
call Pwsh.exe -NoProfile -executionpolicy bypass -Command "& '%location%'"
::##############################################################################
:: Windows Main Codes                                                          #
::##############################################################################
