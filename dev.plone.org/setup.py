#!/usr/bin/env python

from setuptools import setup, find_packages

setup(  
        name='AdvancedTicketWorkflowPlugin',
        version='0.11',
        author = 'Eli Carter',
        author_email = 'elicarter@retracile.net',
        license='BSD',
        description = 'Advanced workflow operations Trac plugin',
        long_description = 'Provides more advanced workflow operations for Trac 0.12',
        url = 'http://trac-hacks.org/wiki/AdvancedTicketWorkflowPlugin',

        packages = find_packages(),
        package_data = {},
        entry_points = {'trac.plugins':['advancedworkflow.controller = advancedworkflow.controller']},
        install_requires = [],
        #zip_safe = False,
)
