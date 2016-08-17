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
import os
import peewee
from peewee import *
from models import *

sys.path.append(os.path.abspath(os.getcwd() + '/../engine'))

from pw_utils import *

# build a class:
# register_app(self, app_infos)
# update_app(self, app_infos)

class pw_db:
    def __init__(self):
        self.utils = pw_utils()
        self.config = self.utils.loadConfig()

        # hardcoded database name
        self.PW_DB   = 'warehouse' 
        self.PW_HOST = self.config['pw_host']
        self.PW_USER = self.config['pw_user']
        self.PW_PWD  = self.config['pw_pwd']

        self.db = MySQLDatabase(self.PW_DB, user = self.PW_USER, passwd = self.PW_PWD)

    """
    Register a new application entry in the database
    params: app_info, a dict containing app information (id, name, etc)
    return: None
    """
    def registerApp(self, app_info):
        try:
            self.db.connect()
        except Exception as e:
            print(e)
            raise

        application = Application.create(
            app_id     = app_info['app_id'],
            app_name   = app_info['app_name'],
            app_submit = app_info['app_submit'],
            app_master = app_info['app_master'],
        )

        # Also create containers entry for driver
        driver = Container.create(
            app_id          = app_info['app_id'],
            container_host  = app_info['app_driver'],
            #TODO: find default #cores and source for mem
            #container_cores = app_info['app_driver_cores'] if app_info['app_driver_cores'] else 1,
            #container_mem   = ''
        )

        # update Application with driver's container ID
        print(driver.get(driver.app_id == app_info['app_id']))
#        driver_id = driver.get(driver.app_id == app_info['app_id'])
#        application.app_driver = driver_id
#        application.save()

        self.db.close()
