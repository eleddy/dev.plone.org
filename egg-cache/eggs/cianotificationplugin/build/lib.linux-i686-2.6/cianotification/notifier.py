"""Display Subversion URLs in the Browse Source section."""

import re
import xmlrpclib

from trac.core import *
from trac.ticket.api import ITicketChangeListener
from trac.config import Option

# Ripped off from http://www.wiggy.net/files/trac-cia.diff
class MessageSender(object):
    def __init__(self, project, server="http://cia.navi.cx", module="Issue tracker"):
        self.project = project
        self.module = module
        self.server = xmlrpclib.ServerProxy(server)

    def message(self, ticket, author, message):
        ticket = " #%s" % ticket
        generator = "<generator><name>CIA Trac plugin</name><version>0.2</version></generator>"
        source = "<source><project>%s</project><module>%s</module></source>" % \
                    (self.project, self.module)
        body = "<body><commit><revision>%s</revision><author>%s</author><log>%s</log></commit></body>" % \
                    (ticket, author, message)

        return "<message>"+generator+source+body+"</message>"

    def __call__(self, ticket, author, message):
        body = self.message(ticket, author, message)
        self.server.hub.deliver(body)

class CiaNotifier(Component):
    implements(ITicketChangeListener)

    cia_project = Option('notification', 'cia_project', doc="The CIA project name?")
    cia_server = Option('notification', 'cia_server')
    
    ### ITicketChangeListener methods
    
    def ticket_created(self, ticket):
        if self.cia_project is not None and self.cia_server is not None:
            c = MessageSender(project=self.cia_project, server=self.cia_server)
            c(ticket.id, ticket['reporter'], "[%s] %s" % (ticket['component'], ticket['summary']))

    def ticket_changed(self, ticket, comment, author, old_values):
        pass
    
    def ticket_deleted(self, ticket):
        pass
