#!/bin/bash

echo "Copying files..."

cp ./Scripts/custom_commands.sh ~
cd

echo "Writing to bashrc..."
echo "source custom_commands.sh" >> .bashrc

echo "Finished with exit code 0"