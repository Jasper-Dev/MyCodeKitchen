import time
from datetime import datetime
import tkinter as tk
from tkinter import scrolledtext
import threading
import queue
from pynput import keyboard

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

def on_key_event(e):
    global key_down_times

    if isinstance(e, keyboard.Key):
        e = e.name

    if isinstance(e, keyboard.KeyCode):
        key_name = e.char if e.char else e.name
    else:
        key_name = e

    if key_name in special_chars:
        key_name = special_chars[key_name]

    scan_code = e.vk if isinstance(e, keyboard.KeyCode) else None
    ascii_repr = scan_code if scan_code and 0 <= scan_code <= 127 else "N/A"

    if key_name not in key_down_times:
        key_down_times[key_name] = time.time()
    else:
        duration = (time.time() - key_down_times[key_name]) * 1000
        line = "| {} | {:03X} | {} | {} | {:.0f} |".format(key_name, scan_code, ascii_repr, key_name, duration)

        with open(output_file, "a") as f:
            f.write(line + "\n")

        key_events_queue.put(line)
        key_down_times.pop(key_name, None)




def update_text_box():
    while True:
        line = key_events_queue.get()
        text_box.configure(state='normal')
        text_box.insert(tk.END, line + "\n")
        text_box.see(tk.END)
        text_box.configure(state='disabled')

output_file = "keystrokes_{}.txt".format(datetime.now().strftime("%Y%m%d%H%M%S"))

header = "| Key | SC Code | ASCII | Description | Duration (ms) |\n| --- | ------- | ----- | ----------- | ------------- |\n"

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

def copy_to_clipboard():
    try:
        selected_text = text_box.get(tk.SEL_FIRST, tk.SEL_LAST)
        root.clipboard_clear()
        root.clipboard_append(selected_text)
    except tk.TclError:
        pass

def show_context_menu(event):
    context_menu.tk_popup(event.x_root, event.y_root)

context_menu = tk.Menu(root, tearoff=0)
context_menu.add_command(label="Copy", command=copy_to_clipboard)

text_box.bind("<Button-3>", show_context_menu)

def for_canonical(f):
    return lambda k: f(listener.canonical(k))

with keyboard.Listener(on_press=for_canonical(on_key_event), on_release=for_canonical(on_key_event), suppress=True) as listener:
    update_text_box_thread = threading.Thread(target=update_text_box, daemon=True)
    update_text_box_thread.start()

    root.mainloop()
    listener.join()
