#/usr/bin/python

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>

# Copyright (C) <2016>  <Henri Maxime Demoulin>

import sys

class pw_utils:
    
    def __repr__(self):
        tools  = 'Available tools: \n'
        tools += 'flattenList(listObject)'

        return tools

    """
    def __init__(self):
    """

    """
    Flatten a (possibly nested) list
    :param listObject the list to be flattened
    :return flat list
    """
    def flattenList(self, listObject):
        if not isinstance(listObject, list):
            return listObject
        else:
            if len(listObject) > 0:
                if isinstance(listObject[0], list):
                    return self.flattenList(listObject[0]) + self.flattenList(listObject[1:])
                else:
                    return [listObject[0]] + self.flattenList(listObject[1:])
            else:
                return []
