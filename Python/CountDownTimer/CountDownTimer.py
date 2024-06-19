import tkinter as tk
from tkinter import Toplevel, Scale, HORIZONTAL
import threading
import time

class FloatingTimer:
    def __init__(self, root):
        self.root = root
        self.root.overrideredirect(True)  # Verwijder de vensterrand en titelbalk
        self.root.attributes("-alpha", 0.6)  # Maak het venster enigszins transparant
        self.root.attributes("-topmost", True)  # Houd het venster bovenaan

        # Maak het mogelijk om het venster te verplaatsen
        self.root.bind("<Button-1>", self.start_move)
        self.root.bind("<ButtonRelease-1>", self.stop_move)
        self.root.bind("<B1-Motion>", self.do_move)

        # Timer label
        self.timer_label = tk.Label(self.root, text="00:00:00", font=("Helvetica", 32), bg="black", fg="white")
        self.timer_label.pack(padx=20, pady=20)

        # Start de timer
        self.seconds = 0
        self.running = False
        self.update_clock()

    def start_move(self, event):
        self.x = event.x
        self.y = event.y

    def stop_move(self, event):
        self.x = None
        self.y = None

    def do_move(self, event):
        deltax = event.x - self.x
        deltay = event.y - self.y
        x = self.root.winfo_x() + deltax
        y = self.root.winfo_y() + deltay
        self.root.geometry(f"+{x}+{y}")

    def update_clock(self):
        if self.running:
            self.seconds -= 1
            if self.seconds <= 0:
                self.running = False
        mins, secs = divmod(self.seconds, 60)
        hours, mins = divmod(mins, 60)
        self.timer_label.config(text=f"{hours:02d}:{mins:02d}:{secs:02d}")
        self.root.after(1000, self.update_clock)

    def start_timer(self, seconds):
        self.seconds = seconds
        self.running = True

def start_countdown():
    # Start de timer met een duur van 5 minuten (300 seconden)
    # ft.start_timer(300)
    ft.start_timer(60 * 60)

if __name__ == "__main__":
    root = tk.Tk()
    ft = FloatingTimer(root)
    threading.Thread(target=start_countdown).start()
    root.mainloop()
