printf "Path to the data directory: "
printf "\nExample: /home/user/data\n"
read path
#prompt to set the path to the data directory
#read path stores the path given by the user in the variable "path"


if [ ! -d "$path" ]; then
	echo -e "\033[0;31mThis directory does not exist. Create it first.\033[0m"
	exit 1
fi
echo -e "\033[0;32mThe path has been set to $path\033[0m"
echo "Run "make" again to start the services"

echo "$path" > srcs/requirements/tools/path.txt
#stores the path in path.txt

cp srcs/requirements/tools/template.yml srcs/docker-compose.yml
#Replace the file docker-compose.yml with the template.yml file which contains the placeholders for the path to the data directory

cat srcs/docker-compose.yml | sed "s+pathtodata+$path+g" > srcs/docker-compose.yml.tmp
#Replace the placeholder "pathtodata" with the path given by the user in the file docker-compose.yml
#The result is stored in a temporary file docker-compose.yml.tmp
mv srcs/docker-compose.yml.tmp srcs/docker-compose.yml
#Replace the original file docker-compose.yml with the temporary file docker-compose.yml.tmp
