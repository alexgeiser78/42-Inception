echo -e "\033[0;32m-------CONFIGURING ENVIRONMENT-------\033[0m"

printf "Enter the path to the directory where you want to store the data: "
printf "\nExample: /home/user/data\n"
read path
#prompt to set the path to the data directory
#read path stores the path given by the user in the variable "path"


if [ ! -d "$path" ]; then
	echo -e "\033[0;31mThis directory does not exist. You must create it first.\033[0m"
	exit 1
fi

echo "$path" > srcs/requirements/tools/path.txt
#stores the path in path.txt

cp srcs/requirements/tools/template.yml srcs/docker-compose.yml
#Replace the file docker-compose.yml with the template.yml file which contains the placeholders for the path to the data directory

cat srcs/docker-compose.yml | sed "s+pathtodata+$path+g" > srcs/docker-compose.yml.tmp
#Replace the placeholder "pathtodata" with the path given by the user in the file docker-compose.yml
#The result is stored in a temporary file docker-compose.yml.tmp
mv srcs/docker-compose.yml.tmp srcs/docker-compose.yml
#Replace the original file docker-compose.yml with the temporary file docker-compose.yml.tmp