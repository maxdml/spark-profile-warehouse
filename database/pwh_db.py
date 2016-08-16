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

import peewee
from peewee import *

sys.path.append(os.path.abspath(os.getcwd() + '/../engine'))

from pw_utils import *

# TODO load config
#PWH_HOST     = config['pwh_host']
#PWH_USER     = config['pwh_user']
#PWH_PWD      = config['pwh_pwd']
