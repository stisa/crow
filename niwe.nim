import ./niwe/events
import ./niwe/windows

while not window.ctx.shouldClose:
  pollEvents() # avoid window close
