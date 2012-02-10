Introduction
============
This is a buildout for testing updates to configuration and templates 
for dev,plone.org, which is trac.

Setting Up
----------
Clone the package from github run buildout to get a local copy that won't
have data but will have the default config::

  > git clone ...
  > cd dev.plone.org
  > python bootstrap.py
  > ./bin/buildout

If this is the first time running the project, you may want to just make everything 
easy without needing ldap and debug like::

  > ./bin/trac-admin dev.plone.org permission add anonymous TRAC_ADMIN

You can add or remove later after you have everything working from the admin console. 

You can start the local project by running::

  > ./bin/tracd dev.plone.org -p 7070

# --basic-auth="*,etc/dev.htpassword,dev.plone.org"

There is a user set up there for debugging with the magical credentials of admin/admin.
