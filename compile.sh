"Copying files..."

cp .my_custom_commands.sh ~
cd

"Writing to bashrc..."
echo "source .my_custom_commands.sh" >> .bashrc

echo "Completed"