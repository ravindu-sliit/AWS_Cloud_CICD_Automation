# =============================================================================
# DOCKERFILE - Educational Assessment API
# =============================================================================
# This file contains instructions to build a Docker image for our API.
# Each instruction creates a "layer" in the image.
# =============================================================================

# -----------------------------------------------------------------------------
# BASE IMAGE
# -----------------------------------------------------------------------------
# FROM specifies the starting point - an existing image to build upon.
# 
# python:3.13-slim means:
#   - python    : Official Python image from Docker Hub
#   - 3.13      : Python version
#   - slim      : Minimal Debian-based image (smaller than default)
#
# Other options:
#   - python:3.13        : Full image with more tools (~900MB)
#   - python:3.13-slim   : Smaller, just essentials (~150MB)
#   - python:3.13-alpine : Even smaller but can have compatibility issues
# -----------------------------------------------------------------------------
FROM python:3.13-slim

# -----------------------------------------------------------------------------
# WORKING DIRECTORY
# -----------------------------------------------------------------------------
# WORKDIR sets the directory for all following commands.
# If it doesn't exist, Docker creates it.
# Think of it as "cd /app" that persists for all subsequent commands.
# -----------------------------------------------------------------------------
WORKDIR /app

# -----------------------------------------------------------------------------
# COPY REQUIREMENTS (Dependency Layer)
# -----------------------------------------------------------------------------
# We copy requirements.txt FIRST, separately from the rest of the code.
# 
# Why? Docker caching.
# 
# Docker caches each layer. If a layer hasn't changed, Docker reuses it.
# Dependencies change less often than code. By copying requirements.txt
# first, we only reinstall packages when dependencies actually change.
#
# COPY <source on your PC> <destination in container>
# The "." means "current directory" (which is /app due to WORKDIR)
# -----------------------------------------------------------------------------
COPY requirements.txt .

# -----------------------------------------------------------------------------
# INSTALL DEPENDENCIES
# -----------------------------------------------------------------------------
# RUN executes a command during the BUILD process.
# 
# pip install -r requirements.txt : Install packages listed in file
# --no-cache-dir                  : Don't store pip's cache (smaller image)
#
# This layer is cached. Rebuilding after code changes won't reinstall packages.
# -----------------------------------------------------------------------------
RUN pip install --no-cache-dir -r requirements.txt

# -----------------------------------------------------------------------------
# COPY APPLICATION CODE
# -----------------------------------------------------------------------------
# Now we copy the actual application code.
# 
# COPY app/ ./app/
#   - app/    : Source folder on your PC
#   - ./app/  : Destination inside container (/app/app/)
#
# This layer changes every time you modify code, but the pip install
# layer above stays cached.
# -----------------------------------------------------------------------------
COPY app/ ./app/

# -----------------------------------------------------------------------------
# EXPOSE PORT
# -----------------------------------------------------------------------------
# EXPOSE documents which port the application uses.
# 
# Important: This does NOT actually publish the port!
# It's documentation for users and tools.
# You still need -p flag when running: docker run -p 8000:8000
# -----------------------------------------------------------------------------
EXPOSE 8000

# -----------------------------------------------------------------------------
# STARTUP COMMAND
# -----------------------------------------------------------------------------
# CMD specifies the default command when a container starts.
# 
# We use the "exec form" (JSON array) instead of "shell form" (string).
# Exec form:  CMD ["uvicorn", "app.main:app", ...]
# Shell form: CMD uvicorn app.main:app ...
#
# Exec form is preferred because:
#   - Signals (like Ctrl+C) go directly to the process
#   - No shell overhead
#   - More predictable behavior
#
# Note: No --reload flag! That's for development only.
# In production/containers, we want stability, not auto-reloading.
#
# --host 0.0.0.0 : Listen on all network interfaces (required in Docker)
#                  127.0.0.1 would only allow connections from inside container
# -----------------------------------------------------------------------------
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
