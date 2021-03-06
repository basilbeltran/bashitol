#!/usr/bin/env python
#==============================================================================
# Copyright 2012 Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# Licensed under the Amazon Software License (the "License"). You may not use
# this file except in compliance with the License. A copy of the License is
# located at
#
#       http://aws.amazon.com/asl/
#
# or in the "license" file accompanying this file. This file is distributed on
# an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, express or
# implied. See the License for the specific language governing permissions
# and limitations under the License.
#==============================================================================


import argparse as _argparse
from contextlib import closing as _closing
import logging as _logging
from StringIO import StringIO as _StringIO

from lib.utility import misc 
from scli.resources import CommandType
from scli.resources import CLISwitch
from scli.resources import CLISwitchMsg
from scli.resources import EBSCliAttr
from scli.constants import ServiceDefault
from scli.constants import ServiceRegionId
from scli.constants import ParameterName
from scli.constants import ParameterSource
from scli.parameter import Parameter
from scli.exception import ArgumentError


log = _logging.getLogger('cli')


def _word_join(word_list, separator = u''):
    x =  separator.join(map(unicode, word_list))
    return x


def command(string):
    command = unicode(string) 
    for item in CommandType:
        if item.lower() == command.lower().strip():
            return item
    raise AttributeError(unicode.format(EBSCliAttr.InvalidCommand, command))


def _init_parser(parser):
    
    commands = u', '.join(map(unicode.lower, CommandType))
    parser.add_argument(CLISwitch[ParameterName.Command], 
                        type = command,
                        metavar = u'COMMAND', help = commands)
    
    # AWS credential
    parser.add_argument(u'-I', u'--' + CLISwitch[ParameterName.AwsAccessKeyId], 
                        dest = ParameterName.AwsAccessKeyId,
                        metavar = u'ACCESS_KEY_ID',
                        help = CLISwitchMsg[ParameterName.AwsAccessKeyId])
    
    parser.add_argument(u'-S', '--' + CLISwitch[ParameterName.AwsSecretAccessKey], 
                        dest = ParameterName.AwsSecretAccessKey,
                        metavar = u'SECRET_ACCESS_KEY',
                        help = CLISwitchMsg[ParameterName.AwsSecretAccessKey])
    
    parser.add_argument(u'--' + CLISwitch[ParameterName.AwsCredentialFile],
                        dest = ParameterName.AwsCredentialFile,
                        metavar = u'FILE_PATH_NAME',
                        help = CLISwitchMsg[ParameterName.AwsCredentialFile]) 
    
    
    # Application/environment 
    parser.add_argument(u'-s', u'--' + CLISwitch[ParameterName.SolutionStack], 
                        dest = ParameterName.SolutionStack, nargs = '+',
                        metavar = u'',
                        help = CLISwitchMsg[ParameterName.SolutionStack]) 
    
    parser.add_argument(u'-a', u'--' + CLISwitch[ParameterName.ApplicationName], 
                        dest = ParameterName.ApplicationName,
                        metavar = u'APPLICATION_NAME',
                        help = CLISwitchMsg[ParameterName.ApplicationName]) 
    
    parser.add_argument(u'-l', u'--' + CLISwitch[ParameterName.ApplicationVersionName], 
                        dest = ParameterName.ApplicationVersionName,
                        metavar = u'VERSION_LABEL',
                        help = CLISwitchMsg[ParameterName.ApplicationVersionName]) 
    
    parser.add_argument(u'-e', u'--' + CLISwitch[ParameterName.EnvironmentName], 
                        dest = ParameterName.EnvironmentName,
                        metavar = u'ENVIRONMENT_NAME',
                        help = CLISwitchMsg[ParameterName.EnvironmentName]) 
    
    
    # Output
    parser.add_argument(u'--' + CLISwitch[ParameterName.Verbose],
                        action = 'store_const', const = ServiceDefault.ENABLED,
                        dest = ParameterName.Verbose,
                        metavar = u'',
                        help = CLISwitchMsg[ParameterName.Verbose])    

    parser.add_argument(u'-f', u'--' + CLISwitch[ParameterName.Force],
                        action = 'store_const', const = ServiceDefault.ENABLED,
                        dest = ParameterName.Force,
                        metavar = u'',
                        help = CLISwitchMsg[ParameterName.Force])    
        
    # Service
    parser.add_argument(u'--' + CLISwitch[ParameterName.WaitForFinishTimeout], type = int,
                        dest = ParameterName.WaitForFinishTimeout, 
                        metavar = u'TIMEOUT_IN_SEC',
                        help = unicode.format(CLISwitchMsg[ParameterName.WaitForFinishTimeout], 
                                              ServiceDefault.WAIT_TIMEOUT_IN_SEC))
    
    parser.add_argument(u'--' + CLISwitch[ParameterName.Region],
                        dest = ParameterName.Region, 
                        metavar = u'REGION',
                        help = CLISwitchMsg[ParameterName.Region])
        

    parser.add_argument(u'--' + CLISwitch[ParameterName.ServiceEndpoint],
                        dest = ParameterName.ServiceEndpoint, 
                        metavar = u'ENDPOINT',
                        help = CLISwitchMsg[ParameterName.ServiceEndpoint])

    
    # SCli Helper switch
    parser.add_argument(u'--version', action=u'version', version=EBSCliAttr.Version)    



def parse(parameter_pool, line = None):
    ''' Parse command arguments'''
    parser = ArgumentParser(description = EBSCliAttr.Name, 
                            usage = EBSCliAttr.Usage)
    _init_parser(parser)

    if line is not None:
        args = vars(parser.parse_args(line.split()))
    else:
        args = vars(parser.parse_args())
   
    # Post prcessing
    if args[ParameterName.SolutionStack] is not None:
        solution_stack = _word_join(args[ParameterName.SolutionStack], u' ')
        args[ParameterName.SolutionStack] = solution_stack

    if args[ParameterName.Region] is not None:
        region_id = args[ParameterName.Region]
        region = ServiceRegionId.keys()[ServiceRegionId.values().index(region_id)]
        args[ParameterName.Region] = region


    # Store command line arguments into parameter pool     
    for arg, value in args.iteritems():
        if value is not None:
            arg = misc.to_unicode(arg)
            value = misc.to_unicode(value)
            if arg == CLISwitch[ParameterName.Command]:
                parameter_pool.put(Parameter(ParameterName.Command, 
                                             value, 
                                             ParameterSource.CliArgument))
            else:
                parameter_pool.put(Parameter(arg, 
                                             value, 
                                             ParameterSource.CliArgument))
    
    log.info(u'Finished parsing command line arguments')
    if log.isEnabledFor(_logging.DEBUG): 
        log.debug(u'Received arguments: {0}'.\
                  format(misc.collection_to_string(parameter_pool.parameter_names)))
 
    return args


class ArgumentParser(_argparse.ArgumentParser):
    '''Subclass of argparse.ArgumentParser to override behavior of error()'''
    def error(self, error_message):
        with _closing(_StringIO()) as usage:
            self.print_usage(usage)
            message = EBSCliAttr.ErrorMsg.format(error_message, usage.getvalue(), self.prog)
        raise ArgumentError(message)
    
    
