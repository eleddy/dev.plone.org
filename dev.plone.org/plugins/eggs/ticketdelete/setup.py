#!/usr/bin/env python
# -*- coding: iso-8859-1 -*-

from setuptools import setup

setup(
    name = 'TracTicketDelete',
    version = '2.0.1',
    packages = ['ticketdelete'],
    package_data = { 'ticketdelete': ['templates/*.html', 'htdocs/*.js', 'htdocs/*.css' ] },

    author = "Noah Kantrowitz",
    author_email = "noah@coderanger.net",
    description = "Remove tickets and ticket changes from Trac.",
    long_description = "Provides a web interface to removing whole tickets and ticket changes in Trac.",
    license = "BSD",
    keywords = "trac plugin ticket delete",
    url = "http://trac-hacks.org/wiki/TicketDeletePlugin",
    classifiers = [
        'Framework :: Trac',
    ],
    
    entry_points = {
        'trac.plugins': [
            'ticketdelete.web_ui = ticketdelete.web_ui'
        ]
    }
)
