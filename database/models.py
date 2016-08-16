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

from peewee import *

database = MySQLDatabase('warehouse3', **{'user': 'root'})

class UnknownField(object):
    def __init__(self, *_, **__): pass

class BaseModel(Model):
    class Meta:
        database = database

# Possible reference cycle: Application
class Container(BaseModel):
    app = ForeignKeyField(db_column='app_id', null=True, rel_model=Application, to_field='id')
    container_cores = IntegerField(null=True)
    container_env = TextField(null=True)
    container_host = CharField(null=True)
    container = IntegerField(db_column='container_id', null=True)
    container_mem = IntegerField(null=True)
    container_type = CharField(null=True)
    container_yarn = IntegerField(db_column='container_yarn_id', null=True)

    class Meta:
        db_table = 'Container'

class Application(BaseModel):
    app_dag = TextField(null=True)
    app_driver = ForeignKeyField(db_column='app_driver', null=True, rel_model=Container, to_field='id')
    app_env = TextField(null=True)
    app = IntegerField(db_column='app_id', null=True)
    app_master = ForeignKeyField(db_column='app_master', null=True, rel_model=Container, related_name='Container_app_master_set', to_field='id')
    app_name = CharField(null=True)
    app_submit = TextField(null=True)

    class Meta:
        db_table = 'Application'

class Event(BaseModel):
    event_details = TextField(null=True)
    event = IntegerField(db_column='event_id', null=True)
    event_time = DateTimeField()
    event_trace = TextField(null=True)
    event_type = CharField(null=True)

    class Meta:
        db_table = 'Event'

class AppEvent(BaseModel):
    app = ForeignKeyField(db_column='app_id', null=True, rel_model=Application, to_field='id')
    event = ForeignKeyField(db_column='event_id', null=True, rel_model=Event, to_field='id')

    class Meta:
        db_table = 'App_event'

class Metric(BaseModel):
    metric = CharField(db_column='metric_id', null=True)
    metric_name = CharField(null=True)
    metric_source = CharField(null=True)
    metric_type = CharField(null=True)
    metric_unit = CharField(null=True)
    metric_value = CharField(null=True)

    class Meta:
        db_table = 'Metric'

class AppMetric(BaseModel):
    app = ForeignKeyField(db_column='app_id', null=True, rel_model=Application, to_field='id')
    metric = ForeignKeyField(db_column='metric_id', null=True, rel_model=Metric, to_field='id')

    class Meta:
        db_table = 'App_metric'

class ContainerEvent(BaseModel):
    cont = ForeignKeyField(db_column='cont_id', null=True, rel_model=Container, to_field='id')
    event = ForeignKeyField(db_column='event_id', null=True, rel_model=Event, to_field='id')

    class Meta:
        db_table = 'Container_event'

class ContainerMetric(BaseModel):
    cont = ForeignKeyField(db_column='cont_id', null=True, rel_model=Container, to_field='id')
    metric = ForeignKeyField(db_column='metric_id', null=True, rel_model=Metric, to_field='id')

    class Meta:
        db_table = 'Container_metric'

class Job(BaseModel):
    app = ForeignKeyField(db_column='app_id', null=True, rel_model=Application, to_field='id')
    job_dag = TextField(null=True)
    job_env = TextField(null=True)
    job = IntegerField(db_column='job_id', null=True)
    job_name = CharField(null=True)

    class Meta:
        db_table = 'Job'

class JobEvent(BaseModel):
    event = ForeignKeyField(db_column='event_id', null=True, rel_model=Event, to_field='id')
    job = ForeignKeyField(db_column='job_id', null=True, rel_model=Job, to_field='id')

    class Meta:
        db_table = 'Job_event'

class JobMetric(BaseModel):
    job = ForeignKeyField(db_column='job_id', null=True, rel_model=Job, to_field='id')
    metric = ForeignKeyField(db_column='metric_id', null=True, rel_model=Metric, to_field='id')

    class Meta:
        db_table = 'Job_metric'

class Pnode(BaseModel):
    pnode_hw = TextField(db_column='pnode_HW', null=True)
    pnode_mac = CharField(db_column='pnode_MAC', null=True)
    pnode_hostname = CharField(null=True)
    pnode = IntegerField(db_column='pnode_id', null=True)
    pnode_ip = CharField(null=True)
    pnode_type = CharField(null=True)

    class Meta:
        db_table = 'Pnode'

class PnodeEvent(BaseModel):
    event = ForeignKeyField(db_column='event_id', null=True, rel_model=Event, to_field='id')
    pnode = ForeignKeyField(db_column='pnode_id', null=True, rel_model=Pnode, to_field='id')

    class Meta:
        db_table = 'Pnode_event'

class PnodeMetric(BaseModel):
    metric = ForeignKeyField(db_column='metric_id', null=True, rel_model=Metric, to_field='id')
    pnode = ForeignKeyField(db_column='pnode_id', null=True, rel_model=Pnode, to_field='id')

    class Meta:
        db_table = 'Pnode_metric'

class Stage(BaseModel):
    app = ForeignKeyField(db_column='app_id', null=True, rel_model=Application, to_field='id')
    job = ForeignKeyField(db_column='job_id', null=True, rel_model=Job, to_field='id')
    stage_dag = TextField(null=True)
    stage_env = TextField(null=True)
    stage = IntegerField(db_column='stage_id', null=True)
    stage_name = CharField(null=True)

    class Meta:
        db_table = 'Stage'

class StageEvent(BaseModel):
    event = ForeignKeyField(db_column='event_id', null=True, rel_model=Event, to_field='id')
    stage = ForeignKeyField(db_column='stage_id', null=True, rel_model=Stage, to_field='id')

    class Meta:
        db_table = 'Stage_event'

class StageMetric(BaseModel):
    metric = ForeignKeyField(db_column='metric_id', null=True, rel_model=Metric, to_field='id')
    stage = ForeignKeyField(db_column='stage_id', null=True, rel_model=Stage, to_field='id')

    class Meta:
        db_table = 'Stage_metric'

class Task(BaseModel):
    app = ForeignKeyField(db_column='app_id', null=True, rel_model=Application, to_field='id')
    container = ForeignKeyField(db_column='container_id', null=True, rel_model=Container, to_field='id')
    job = ForeignKeyField(db_column='job_id', null=True, rel_model=Job, to_field='id')
    stage = ForeignKeyField(db_column='stage_id', null=True, rel_model=Stage, to_field='id')
    task_attempt = IntegerField(null=True)
    task_env = TextField(null=True)
    task_name = CharField(null=True)

    class Meta:
        db_table = 'Task'

class TaskEvent(BaseModel):
    event = ForeignKeyField(db_column='event_id', null=True, rel_model=Event, to_field='id')
    task = ForeignKeyField(db_column='task_id', null=True, rel_model=Task, to_field='id')

    class Meta:
        db_table = 'Task_event'

class TaskMetric(BaseModel):
    metric = ForeignKeyField(db_column='metric_id', null=True, rel_model=Metric, to_field='id')
    task = ForeignKeyField(db_column='task_id', null=True, rel_model=Task, to_field='id')

    class Meta:
        db_table = 'Task_metric'

