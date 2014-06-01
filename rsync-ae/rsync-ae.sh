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

inputPath=$1
outputPath=$2

# Presence of this file in a folder will exclude the folder from the rsync operation
excludeFlag=".exclude"

# Options to pass along to rsync
# For non-destructive operation, remove --delete
rsyncOptions="-axvh --progress --delete"

# The location of the temporary exclusion file
# Ensure the user running this script has write permission to that folder
excludeList="/tmp/excludelist.tmp"

# ------------------------------------------------------------------

# Check that parameters were passed
if [ -z "$inputPath" ] || [ -z "$outputPath" ]
then
	echo "ERROR : rsync-ae requires two parameters (input path, output path)"
	exit 1
fi

# Create the list of folders to exclude
echo "Building exclusion list"
inputPathLen=${#inputPath}
find $inputPath -name "$excludeFlag" -exec dirname {} \; | cut -c $inputPathLen- > $excludeList

# Process the rsync command
echo "Beginning rsync operation"
rsync $rsyncOptions --exclude-from=$excludeList $inputPath $outputPath

# Delete the temporary file
rm $excludeList
