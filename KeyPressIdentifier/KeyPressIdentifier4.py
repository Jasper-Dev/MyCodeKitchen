import time
from datetime import datetime
import tkinter as tk
from tkinter import scrolledtext
import threading
import queue
from pynput import keyboard as pynput_keyboard

key_down_times = {}
key_events_queue = queue.Queue()

special_chars = {
    '`': 'backtick',
    '~': 'tilde',
    '@': 'at',
    '#': 'hash',
    '$': 'dollar',
    '%': 'percent',
    '^': 'caret',
    '&': 'ampersand',
    '*': 'asterisk',
    '(': 'left parenthesis',
    ')': 'right parenthesis',
    '-': 'minus',
    '_': 'underscore',
    '=': 'equals',
    '+': 'plus',
    '[': 'left square bracket',
    '{': 'left curly brace',
    ']': 'right square bracket',
    '}': 'right curly brace',
    '\\': 'backslash',
    '|': 'pipe',
    ';': 'semicolon',
    ':': 'colon',
    "'": 'single quote',
    '"': 'double quote',
    ',': 'comma',
    '<': 'less than',
    '.': 'period',
    '>': 'greater than',
    '/': 'forward slash',
    '?': 'question mark'
}

def on_key_event(e, event_type):
    if event_type == pynput_keyboard.KEY_DOWN:
        key_down_times[e.scan_code] = e.time
    elif event_type == pynput_keyboard.KEY_UP:
        duration = (e.time - key_down_times.get(e.scan_code, e.time)) * 1000  # Duration in milliseconds
        key_name = e.name
        if e.name in special_chars:
            key_name = special_chars[e.name]
        elif len(e.name) > 1 and e.name[-1] in special_chars:
            key_name = special_chars[e.name[-1]]

        line = "| {} | {:03X} | {} | {:.0f} |".format(key_name, e.scan_code, key_name, duration)

        with open(output_file, "a") as f:
            f.write(line + "\n")

        key_events_queue.put(line)

def update_text_box():
    while True:
        line = key_events_queue.get()
        text_box.configure(state='normal')
        text_box.insert(tk.END, line + "\n")
        text_box.see(tk.END)
        text_box.configure(state='disabled')

output_file = "keystrokes_{}.txt".format(datetime.now().strftime("%Y%m%d%H%M%S"))

header = "| Key | SC Code | Description | Duration (ms) |\n| --- | ------- | ----------- | ------------- |\n"

with open(output_file, "a") as f:
    f.write(header)

root = tk.Tk()
root.title("Key Press Logger")

frame = tk.Frame(root)
frame.pack(padx=10, pady=10)

text_box = scrolledtext.ScrolledText(frame, wrap=tk.WORD, width=60, height=15)
text_box.pack()
text_box.insert(tk.END, header)
text_box.configure(state='disabled')

# Start the pynput keyboard listener
def on_press(key):
    try:
        on_key_event(key, pynput_keyboard.KEY_DOWN)
    except AttributeError:
        pass

def on_release(key):
    try:
        on_key_event(key, pynput_keyboard.KEY_UP)
    except AttributeError:
        pass
    
def pynput_listener_thread():
    with pynput_keyboard.Listener(on_press=on_press, on_release=on_release) as pynput_listener:
        pynput_listener.join()

pynput_listener_thread = threading.Thread(target=pynput_listener_thread, daemon=True)
pynput_listener_thread.start()

update_text_box_thread = threading.Thread(target=update_text_box, daemon=True)
update_text_box_thread.start()

root.mainloop()
