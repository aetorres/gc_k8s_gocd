#!/usr/bin/env python
from gomatic import *

configurator = GoCdConfigurator(HostRestClient("35.226.11.209:8153", ssl=False))
pipeline = configurator\
	.ensure_pipeline_group("defaultGroup")\
	.ensure_replacement_of_pipeline("test_pipeline")\
	.set_template_name("base_template")\
	.set_lock_behavior("unlockWhenFinished")\
	.set_git_url("https://github.com/aetorres/c_test.git")
template = configurator.ensure_replacement_of_template("base_template")
stage = template.ensure_stage("defaultStage2")
job = stage.ensure_job("defaultJob")
job.add_task(ExecTask(['/bin/bash', '-c', 'gcc -Wall test.c -o test']))

configurator.save_updated_config()
