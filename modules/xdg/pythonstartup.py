import atexit
import os
import readline

MAX_HISTORY_LENGTH = 2000
histfile = os.path.join(os.environ["XDG_CACHE_HOME"], "python_history")

try:
    readline.read_history_file(histfile)
    h_len = readline.get_current_history_length()
except FileNotFoundError:
    open(histfile, "wb").close()
    h_len = 0


def save(prev_h_len, histfile):
    new_h_len = readline.get_current_history_length()
    readline.set_history_length(MAX_HISTORY_LENGTH)
    readline.append_history_file(new_h_len - prev_h_len, histfile)


atexit.register(save, h_len, histfile)
