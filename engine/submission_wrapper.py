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

#TODO: setup a configuration file (SPARK_HOME, etc)

import sys
import subprocess
from pw_utils import *

# This script job is not to check spark submit parameters
if len(sys.argv) < 2:
    sample  = '--class org.apache.spark.examples.SparkPi --master local[8]'
    sample += 'examples/src/main/python/pi.py 10'
    print('Usage: python submission_wrapper.py ' + sample)
    exit(1)

utils  = pw_utils()
params = utils.flattenList(sys.argv[1:])

# Run spark-submit in the background
subprocess.call(['/home/max/codeZ/SPARK/spark-1.6.2-bin-hadoop2.6', str(params)])
