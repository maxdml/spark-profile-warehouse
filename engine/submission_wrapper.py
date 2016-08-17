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
import json
import requests
import subprocess
from pw_utils import *

sys.path.append(os.path.abspath(os.getcwd() + '/../database'))
from pw_db import *

# This script job is not to check spark submit parameters
if len(sys.argv) < 2:
    sample  = '--class org.apache.spark.examples.SparkPi --master local[8]'
    sample += 'examples/src/main/python/pi.py 10'
    print('Usage: python submission_wrapper.py ' + sample)
    exit(1)

utils  = pw_utils()
pw_db = pw_db()

# Load configuration
config    = utils.loadConfig()

SPARK_HOME   = config['spark_home']
SPARK_SUBMIT = SPARK_HOME + '/bin/spark-submit'
SPARK_MASTER = config['spark_master']
SPARK_API    = SPARK_MASTER + '/api/v1/'
APP_STDOUT   = config['app_stdout']

params = utils.flattenList(sys.argv[1:])
cmd = [SPARK_SUBMIT] + params

# Run spark-submit in the background
# TODO: later on we might want to allow remote runs by using the API
app_output = open(APP_STDOUT, 'w+')
print('Submitting Spark application...')
p = subprocess.Popen(cmd, stdout=app_output, stderr=subprocess.STDOUT)
app_output.close()

# Query the API to retrieve new application's details
print('Retrieving application details...')
applications = requests.get(SPARK_API + 'applications')

#
# TODO: We actually use a very naive way of retrieving an application (pick the last one which
#       name match the submitted class name).

#
# TODO: implement https://issues.apache.org/jira/browse/SPARK-16122 to get environment through API

new_app = {}
new_app['app_submit'] = ' '.join(params)
new_app['app_id']     = applications.json()[0]['id']
new_app['app_name']   = applications.json()[0]['name']
new_app['app_master'] = SPARK_MASTER

new_app_executors = requests.get(SPARK_API + 'applications/' + new_app['app_id'] + '/executors')

#
# TODO: we assume that the driver is the first entry in the list
new_app['app_driver'] = new_app_executors.json()[0]['hostPort']
# TODO find out which field is the allocated memory per core
# TODO find out which field is the allocated #cores for the driver

# Create application entry in the database
print('Registering new application in the Profile Warehouse...')
pw_db.registerApp(new_app)

#
# TODO: once the application is completed, build the DAG. How to know about completion?
