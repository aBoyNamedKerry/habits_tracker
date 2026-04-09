# file to attempt to create a LICENSE using the `lice` package
# if this has not been possible then the user is informed via a non-fatal message
#!/bin/sh

license="$1"  
license=${license,,} # make lowercase
copywrite_text="$2"
license_path="$4"

lice "$license" -o "$copywrite_text" > "$license_path"/LICENSE
if [ $? -ne 0 ]; then
    echo -e "\`lice\` failed to generate a license. No license has been created."
else
    echo -e "\nLICENSE created"
fi