import os

import ranger.api


OLD_HOOK_INIT = ranger.api.hook_init


def hook_init(fm):
    OLD_HOOK_INIT(fm)

    bookmarks = {
        'c': '~/.dotfiles',
        'D': '~/Documents',
        'd': '~/Downloads',
        'm': '~/Music',
        'i': '~/Pictures',
        'p': '~/Projects',
        'P': '~/Public',
        'v': '~/Videos'
    }

    for key, path in bookmarks.items():
        fm.set_bookmark(key, os.path.expanduser(path))


ranger.api.hook_init = hook_init
