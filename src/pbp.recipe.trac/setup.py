# -*- coding: utf-8 -*-
"""
This module contains the tool of pbp.recipe.trac
"""
import os
from setuptools import setup, find_packages

def read(*rnames):
    return open(os.path.join(os.path.dirname(__file__), *rnames)).read()

version = '0.4.4.dev'

long_description = (
    read('README.txt')
    + '\n' +
    'Detailed Documentation\n'
    '**********************\n'
    + '\n' +
    read('pbp', 'recipe', 'trac', 'README.txt')
    + '\n' +
    'Contributors\n'
    '************\n'
    + '\n' +
    read('CONTRIBUTORS.txt')
    + '\n' +
    'Change history\n'
    '**************\n'
    + '\n' +
    read('CHANGES.txt')
    + '\n' +
    'Download\n'
    '********\n'
    )
entry_point = 'pbp.recipe.trac:Recipe'
entry_points = {"zc.buildout": ["default = %s" % entry_point]}

tests_require=['zope.testing', 'zc.buildout']

setup(name='pbp.recipe.trac',
      version=version,
      description="ZC Buildout recipe to install and configure a Trac server.",
      long_description=long_description,
      # Get more strings from http://www.python.org/pypi?%3Aaction=list_classifiers
      classifiers=[
        'Framework :: Buildout',
        'Framework :: Buildout :: Recipe',
        'Framework :: Trac',
        'Intended Audience :: Developers',
        'Topic :: Software Development :: Build Tools',
        'Topic :: Software Development :: Libraries :: Python Modules',
        'License :: OSI Approved :: GNU General Public License (GPL)',
        ],
      keywords='trac pbp buildout recipe',
      author='Tarek Ziade',
      author_email='tarek@ziade.org',
      url='http://pypi.python.org/pypi/pbp.recipe.trac',
      license='GPL',
      packages=find_packages(exclude=['ez_setup']),
      namespace_packages=['pbp', 'pbp.recipe'],
      include_package_data=True,
      zip_safe=False,
      install_requires=['setuptools',
                        'zc.buildout',
                        'zc.recipe.egg',
                        'Trac < 0.13.dev',
                        # Trac extra requirements
                        'pysqlite >= 2.5.5',
                        'docutils >= 0.3.9',
                        'Pygments >= 0.6',
                        'pytz',
                        'Babel >= 0.9.5',
                        # add ons for plone - no idea why they have to be 
                        # here instead of in the buildout
                        #'TracStats',
                        #'TracSpamFilter',
                        #'BatchModify',
                        #'TracSubversionLocation', 
                        #'WorkflowEditorPlugin',
                        ],
      tests_require=tests_require,
      extras_require=dict(tests=tests_require),
      test_suite = 'pbp.recipe.trac.tests.test_docs.test_suite',
      entry_points=entry_points,
      dependency_links=["http://trac-hacks.org/export/11267/batchmodifyplugin/0.12/tags/BatchModify-0.8.0_trac0.12-py2.6.egg#egg=BatchModify",]
      )

