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
import subprocess
from peewee import *
from models import *

sys.path.append(os.path.abspath(os.getcwd() + '/../engine'))

from pw_utils import *

class pw_db_setup:
    def __init__(self):
        self.utils = pw_utils()
        self.config = self.utils.loadConfig()

        self.schema  = self.config['pw_schema']
        self.PW_DB   = self.config['pw_db_name']
        self.PW_HOST = self.config['pw_host']
        self.PW_USER = self.config['pw_user']
        self.PW_PWD  = self.config['pw_pwd']

        self.db = MySQLDatabase(self.PW_DB, user = self.PW_USER, passwd = self.PW_PWD)

        self.setupDatabase()

    """
    Called by the setup script to perform all initial db related tasks 
    params: None
    return: None
    """
    def setupDatabase(self):
        self._createDatabase()
        #self._initialData()

    """
    Create the database and inject the schema 
    params: None
    return: None
    """
    def _createDatabase(self):
        # WARNING: this can't be undone yet

        # Drop if exists, and (re)create the database
        tmp = os.getcwd() + '/create_db.sql'
        f = open(tmp, 'w')
        f.write('DROP DATABASE IF EXISTS `' + self.PW_DB + '`; ')
        f.write('CREATE DATABASE `' + self.PW_DB + '`')
        f.close()
        tmp_abs_path = f.name

        print('Creating database ...')


        if (self.PW_PWD):
            cmd = ['/usr/bin/mysql', '-u', self.PW_USER, '-p ', self.PW_PWD, '<', tmp_abs_path]
        else:
            cmd = ['/usr/bin/mysql', '-u', self.PW_USER, '< ', tmp_abs_path]

        try:
            p = subprocess.call(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        except Exception as e:
            print(e)
            raise

        print('done')

        print('Injecting base schema ...')
        # Inject the schema
        if (self.PW_PWD):
            cmd  = ['/usr/bin/mysql', '-u', self.PW_USER, '-p', self.PW_PWD, self.PW_DB]
            cmd += ['<', self.schema]
        else:
            cmd = ['/usr/bin/mysql', '-u', self.PW_USER, self.PW_DB, '< ', self.schema]

        try:
            p = subprocess.call(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        except Exception as e:
            print(e)
            raise

        print('done')

    """
    (If they do not exist) Create initial entries
    params: None
    return: None
    """
    #def _initialData()
    #    try:
    #        self.db.connect()
    #    except Exception as e:
    #        print(e)
    #        raise


    # Tables to fill: Metric,

if __name__ == "__main__":
    init = pw_db_setup()
