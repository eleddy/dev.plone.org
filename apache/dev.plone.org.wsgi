import sys
sys.stdout = sys.stderr

import os
os.environ['TRAC_ENV'] = '/var/lib/trac/dev.plone.org'
os.environ['PYTHON_EGG_CACHE'] = '/var/lib/trac/egg-cache'

import trac.web.main

application = trac.web.main.dispatch_request
