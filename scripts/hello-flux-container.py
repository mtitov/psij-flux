#!/usr/bin/env python3

import os
import psij
import time

from datetime import timedelta
from pathlib import Path


def main():

    # settings
    pwd = Path('/tmp/.psij')
    log = Path(pwd, 'flux.launcher.log')
    os.makedirs(pwd, exist_ok=True)

    # create config and job executor
    config = psij.JobExecutorConfig(launcher_log_file=log, work_directory=pwd)
    jex = psij.JobExecutor.get_instance('flux', config=config)

    # make job
    job = psij.Job()

    # job spec
    spec = psij.JobSpec()
    spec.executable = 'hostname'
    spec.arguments = []

    spec.stdout_path = os.path.abspath(os.path.dirname(__file__)) + \
        '/psij.' + time.strftime('%Y-%m-%d-%H-%M-%S') + '.stdout'

    job.spec = spec
    # submit job
    jex.submit(job)

    # wait for job to be done
    job.wait(timedelta(seconds=3))

    with open(spec.stdout_path, encoding='utf-8') as f:
        print('\n> Job output, while executing "%s":\n%s' %
              (spec.executable, ''.join(f.readlines())))


if __name__ == '__main__':
    main()
