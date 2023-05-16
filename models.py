from datetime import date
from pony.orm import *


db = Database()


class Module(db.Entity):
    id = PrimaryKey(int, auto=True)
    last_run = Optional(date)
    total_cases = Optional(int)
    name = Optional(str)
    total_checklists = Optional(int)
    checklists = Set('Checklist')
    test_runs = Set('TestRun')


class Checklist(db.Entity):
    id = PrimaryKey(int, auto=True)
    module = Required(Module)
    cases = Set('Case')


class Case(db.Entity):
    id = PrimaryKey(int, auto=True)
    checklists = Set(Checklist)
    run_cases = Set('RunCase')
    priority = Optional(str)


class TestRun(db.Entity):
    id = PrimaryKey(int, auto=True)
    module = Required(Module)
    run_cases = Set('RunCase')


class RunCase(db.Entity):
    id = PrimaryKey(int, auto=True)
    case = Required(Case)
    status = Required(str)
    comment = Optional(str)
    test_run = Required(TestRun)



db.generate_mapping()