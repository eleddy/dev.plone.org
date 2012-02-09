from setuptools import find_packages, setup

setup(
    name='TracCiaNotification',
    version='1.0',
    author='Erik Rose',
    author_email='ErikRose@psu.edu',
    url='http://trac-hacks.org/wiki/CiaNotificationPlugin',
    classifiers = [
        'Framework :: Trac',
        'Development Status :: 5 - Production/Stable',
        'Environment :: Web Environment',
        'Natural Language :: English',
        'Operating System :: OS Independent',
        'Programming Language :: Python',
    ],
    description='Notify the CIA IRC bot of new tickets.',
    license='GPL',
    keywords='trac plugin irc cia',
    packages=find_packages(exclude=['*.tests*']),
    install_requires=['Trac>=0.11'],
    entry_points = {'trac.plugins': ['cianotification = cianotification']}
)
