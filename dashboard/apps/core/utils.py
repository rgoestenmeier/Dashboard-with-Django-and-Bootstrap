import random
import string

from dashboard.settings import APP_FLDR


import logging
logger = logging.getLogger('main')
logger.level = logging.DEBUG

DEFAULT_CHAR_STRING = string.ascii_lowercase + string.digits


def generate_random_string(chars=DEFAULT_CHAR_STRING, size=6):
    return ''.join(random.choice(chars) for _ in range(size))


def log(module, func, line='', file=''):
    prefix = file.replace(APP_FLDR + '/apps/', '')
    logger.debug('DBG: %-32s | %-24s | %-32s | %s' %
                 (prefix, module, func, line))
