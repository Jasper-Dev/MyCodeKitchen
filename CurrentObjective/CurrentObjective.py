# # Import the Pygame library
# import pygame

# # Initialize the Pygame library
# pygame.init()

# # Set the screen size and background color
# SCREEN_WIDTH = 640
# SCREEN_HEIGHT = 480
# SCREEN_COLOR = (255, 255, 255)
# screen = pygame.display.set_mode((SCREEN_WIDTH, SCREEN_HEIGHT))
# screen.fill(SCREEN_COLOR)

# # Set the font and text color
# FONT_NAME = "Arial"
# FONT_SIZE = 24
# FONT_COLOR = (0, 0, 0)
# font = pygame.font.SysFont(FONT_NAME, FONT_SIZE)

# #Set the OSD text and position
# OSD_TEXT = "Hello World!"
# OSD_POS_X = SCREEN_WIDTH / 2
# OSD_POS_Y = SCREEN_HEIGHT / 2

# #Create a surface with the OSD text
# osd_text_surface = font.render(OSD_TEXT, True, FONT_COLOR)

# #Get the dimensions of the OSD text surface
# osd_text_width, osd_text_height = osd_text_surface.get_size()

# #Calculate the OSD text position
# osd_text_pos_x = OSD_POS_X - osd_text_width / 2
# osd_text_pos_y = OSD_POS_Y - osd_text_height / 2

# #Blit the OSD text surface onto the screen
# screen.blit(osd_text_surface, (osd_text_pos_x, osd_text_pos_y))

# #Set the OSD window to always be on top
# pygame.window.set_always_on_top(True)

# #Update the screen
# pygame.display.update()

# #Wait for the user to close the window
# while True:
#     for event in pygame.event.get():
#         if event.type == pygame.QUIT:
#             pygame.quit()
#             exit()

import tkinter as tk
# from tkinter import ttk

# import sys

# # Get the Python version
# version = sys.version_info

# # Print the Tkinter version
# print("Tkinter version:", version.major, ".", version.minor)

# Get the Tcl/Tk version that Tkinter is built on
version = tk.version

# Print the Tkinter version
print("Tkinter version:", version)


# # Create the main window
# root = tk.Tk()

# # Set the window to always stay on top
# root.wm_attributes("-topmost", True)


# # Create the tray icon
# tray = ttk.Tray(root, image="icon.png")

# # Show the tray icon
# tray.update()


# # Create the OSD window
# osd = tk.Toplevel(root)

# # Remove the window title and border
# osd.overrideredirect(True)

# # Set the OSD window position and size
# osd.geometry("200x100+300+300")

# # Add some content to the OSD window
# label = tk.Label(osd, text="This is an OSD")
# label.pack()

# # Start the event loop
# root.mainloop()