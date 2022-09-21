import os

CUR_DIR = os.path.abspath(os.path.dirname(__file__))

CONNECTION = dict(host='https://clickhouse.lab.karpov.courses',
                database='simulator_20220820',
                user='student', 
                password='dpo_python_2020')