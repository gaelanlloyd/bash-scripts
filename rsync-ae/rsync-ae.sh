#!/bin/bash
# ------------------------------------------------------------------
# Purpose: Runs rsync on a given target and excludes any folder that
#          contains a file called .exclude
#
# Copyright (C) 2014 Gaelan Lloyd
#
# rsync-ae is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
# ------------------------------------------------------------------

# Definitions

# Presence of this file in a folder will exclude the folder from the rsync operation
excludeFlag=".exclude"
excludeList="excludelist.tmp"
workingPath=$1

# Debug
echo "Working path was defined as ["$workingPath"]"

echo "Looking for ["$excludeFlag"]"

# Create the list of folders to exclude
find $workingPath -name "$excludeFlag" -exec dirname {} \; > $excludeList
