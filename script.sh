#!/bin/bash

# Get the changed files using git diff
changedFilesOutput=$(git diff --name-only HEAD^ HEAD)
changedFiles=($changedFilesOutput)

# Check for changes in frontend or backend
backendChanged=false
frontendChanged=false

for file in "${changedFiles[@]}"; do
  if [[ "$file" == *"src/Backend"* ]]; then
    backendChanged=true
  fi

  if [[ "$file" == *"src/Frontend"* ]]; then
    frontendChanged=true        
  fi
done

# Set environment variables based on changes
if [ "$backendChanged" == true ]; then
  export SERVICE_PATH="src/Backend"
  export SERVICE="soc-ui"
  export BUILD_OPTIONS="-f Dockerfile .."
fi

if [ "$frontendChanged" == true ]; then
  export SERVICE_PATH="src/Frontend"
  export SERVICE="socurely-ui"
  export BUILD_OPTIONS="-f Dockerfile ../"
fi